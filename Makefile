
COLOR=10 # bold green
BUNDLE=dist/bundle.js
SRC_JS=$(shell find src -name *.js)

.DEFAULT_GOAL:=help

.PHONY: help # See https://tinyurl.com/makefile-autohelp
help: ## Print help for each target
	@awk -v tab=12 'BEGIN{FS="(:.*## |##@ )";c="\033[36m";m="\033[0m";y="  ";a=2;h()}function t(s){gsub(/[ \t]+$$/,"",s);gsub(/^[ \t]+/,"",s);return s}function u(g,d){split(t(g),f," ");for(j in f)printf"%s%s%-"tab"s%s%s\n",y,c,t(f[j]),m,d}function h(){printf"\nUsage:\n%smake %s<target>%s\n\nRecognized targets:\n",y,c,m}/\\$$/{gsub(/\\$$/,"");b=b$$0;next}b{$$0=b$$0;b=""}/^[-a-zA-Z0-9*\/%_. ]+:.*## /{p=sprintf("\n%"(tab+a)"s"y,"");gsub(/\\n/,p);if($$1~/%/&&$$2~/^%:/){n=split($$2,q,/%:|:% */);for(i=2;i<n;i+=2){g=$$1;sub(/%/,q[i],g);u(g,q[i+1])}}else if($$1~/%/&&$$2~/%:[^%]+:[^%]+:%/){d=$$2;sub(/^.*%:/,"",d);sub(/:%.*/,"",d);n=split(d,q,/:/);for(i=1;i<=n;i++){g=$$1;d=$$2;sub(/%/,q[i],g);sub(/%:[^%]+:%/,q[i],d);u(g,d)}}else u($$1,$$2)}/^##@ /{gsub(/\\n/,"\n");if(NF==3)tab=$$2;printf"\n%s\n",$$NF}END{print""}' $(MAKEFILE_LIST) # v1.61

.PHONY: mark
mark: # Put asterisk in corner of terminal, to signal "done"
	@echo
	@tput cup $$((`tput lines` - 1)) $$((`tput cols` - 1))
	@printf "*"
	@tput cuu1 && tput cuu1 && echo

.PHONY: browserify
browserify: ## Bundle the js files
	browserify $(SRC_JS) -p esmify -o $(BUNDLE)

.PHONY: compile
compile: ## Compile the res files
	npm run re:build

.PHONY: build
build: ## Compile res files to js and bundle the js files
	$(MAKE) compile && \
	$(MAKE) browserify

.PHONY: serve
serve: ## Serve the page over http
	serve dist &

.PHONY: serve-stop
serve-stop: ## Stop serving the page
	ps -fu `whoami` | awk '/[s]erve dist/ { print $$2 }' | xargs kill

.PHONY: watch
watch: ## Compile res files to js and bundle the js files; watch for changes
	fswatch $(SRC_JS) | while read f; do \
		tput setaf $(COLOR);             \
		echo '>>>> Browserifying';       \
		tput sgr0;                       \
		sleep 1;                         \
		$(MAKE) browserify mark;         \
	done &
	npm run re:watch

.PHONY: watch-stop
watch-stop: ## Stop watching for changes
	ps -fu `whoami` | awk '/[f]swatch/ { print $$2 }' | xargs kill


