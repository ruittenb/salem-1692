
export PATH:=$(PATH):$(shell npm bin)

JS_COLOR=10 # bold green
CSS_COLOR=15 # bold yellow

SRC=src
DIST=dist
BUNDLE=$(DIST)/js/bundle.js
JS_FILES=$(shell find $(SRC) -name *.js)
CSS_FILES=$(DIST)/css/salem.css $(DIST)/css/normalize.css
MIN_CSS_FILES=$(CSS_FILES:.css=.min.css)
VERSION_FILES=bsconfig.json $(SRC)/app.js

.DEFAULT_GOAL:=help

.PHONY: help # See https://tinyurl.com/makefile-autohelp
help: ## Print help for each target
	@awk -v tab=14 'BEGIN{FS="(:.*## |##@ )";c="\033[36m";m="\033[0m";y="  ";a=2;h()}function t(s){gsub(/[ \t]+$$/,"",s);gsub(/^[ \t]+/,"",s);return s}function u(g,d){split(t(g),f," ");for(j in f)printf"%s%s%-"tab"s%s%s\n",y,c,t(f[j]),m,d}function h(){printf"\nUsage:\n%smake %s<target>%s\n\nRecognized targets:\n",y,c,m}/\\$$/{gsub(/\\$$/,"");b=b$$0;next}b{$$0=b$$0;b=""}/^[-a-zA-Z0-9*\/%_. ]+:.*## /{p=sprintf("\n%"(tab+a)"s"y,"");gsub(/\\n/,p);if($$1~/%/&&$$2~/^%:/){n=split($$2,q,/%:|:% */);for(i=2;i<n;i+=2){g=$$1;sub(/%/,q[i],g);u(g,q[i+1])}}else if($$1~/%/&&$$2~/%:[^%]+:[^%]+:%/){d=$$2;sub(/^.*%:/,"",d);sub(/:%.*/,"",d);n=split(d,q,/:/);for(i=1;i<=n;i++){g=$$1;d=$$2;sub(/%/,q[i],g);sub(/%:[^%]+:%/,q[i],d);u(g,d)}}else u($$1,$$2)}/^##@ /{gsub(/\\n/,"\n");if(NF==3)tab=$$2;printf"\n%s\n",$$NF}END{print""}' $(MAKEFILE_LIST) # v1.61

.PHONY: mark
mark: # Put asterisk in corner of terminal, to signal "done"
	@echo
	@tput cup $$((`tput lines` - 1)) $$((`tput cols` - 1))
	@printf "*"
	@tput cuu1 && tput cuu1 && echo

.PHONY: build-css
build-css: $(MIN_CSS_FILES) ## Minify the css files

.PHONY: watch-css
watch-css: ## Minify the css files; watch for changes
	fswatch -o $(CSS_FILES) | while read f; do \
		tput setaf $(CSS_COLOR);               \
		echo '>>>> Minifying';                 \
		tput sgr0;                             \
		$(MAKE) build-css;                     \
	done &

%.min.css: %.css
	@# descend into the directory in order to prevent corrupting URLs in CSS
	cd $(<D); cleancss $(<F) > $(@F)

.PHONY: build-res
build-res: ## Compile the res files
	npm run re:build

.PHONY: bundle
bundle: ## Bundle the js files
	browserify $(JS_FILES) -p esmify -o $(BUNDLE)

.PHONY: build
build: ## Compile the res files to js and bundle them
	$(MAKE) build-res bundle

.PHONY: watch
watch: ## Compile the res files to js and bundle them; watch for changes
	fswatch -o $(JS_FILES) | while read f; do \
		tput setaf $(JS_COLOR);               \
		echo '>>>> Bundling';                 \
		tput sgr0;                            \
		$(MAKE) bundle mark;                  \
	done &
	npm run re:watch

.PHONY: watch-stop
watch-stop: ## Stop watching for changes
	ps -fu `whoami` | awk '/[f]swatch/ { print $$2 }' | tee /dev/tty | xargs kill
	rm .bsb.lock 2>/dev/null || true

.PHONY: serve
serve: ## Serve the page over http
	serve $(DIST) &

.PHONY: serve-stop
serve-stop: ## Stop serving the page
	ps -fu `whoami` | awk '/[s]erve $(DIST)/ { print $$2 }' | tee /dev/tty | xargs kill

.PHONY: tag-%
tag-%: ## Update the %:major:minor:patch:% version number and create git tag
	which rpl 2>/dev/null
	which jq
	VERSION_FROM=$$(jq .version package.json) && \
	npm version patch && \
	VERSION_TO=$$(jq .version package.json) && \
	rpl $$VERSION_FROM $$VERSION_TO $(VERSION_FILES)

