
export PATH:=$(PATH):$(shell npm bin)

JS_COLOR=10 # bold green
CSS_COLOR=15 # bold yellow

SRC=src
DIST=dist
BUNDLE=$(DIST)/js/bundle.js
JS_FILES=$(shell find $(SRC) -name *.js)
CSS_FILES=$(DIST)/css/salem.css $(DIST)/css/normalize.css
MIN_CSS_FILES=$(CSS_FILES:.css=.min.css)
VERSION_FILES=bsconfig.json $(SRC)/app.js $(DIST)/serviceworker.js

.DEFAULT_GOAL:=help

.PHONY: help # See https://tinyurl.com/makefile-autohelp
help: ## Print help for each target
	@awk -v tab=16 'BEGIN{FS="(:.*## |##@ )";c="\033[36m";m="\033[0m";y="  ";a=2;h()}function t(s){gsub(/[ \t]+$$/,"",s);gsub(/^[ \t]+/,"",s);return s}function u(g,d){split(t(g),f," ");for(j in f)printf"%s%s%-"tab"s%s%s\n",y,c,t(f[j]),m,d}function h(){printf"\nUsage:\n%smake %s<target>%s\n\nRecognized targets:\n",y,c,m}/\\$$/{gsub(/\\$$/,"");b=b$$0;next}b{$$0=b$$0;b=""}/^[-a-zA-Z0-9*\/%_. ]+:.*## /{p=sprintf("\n%"(tab+a)"s"y,"");gsub(/\\n/,p);if($$1~/%/&&$$2~/^%:/){n=split($$2,q,/%:|:% */);for(i=2;i<n;i+=2){g=$$1;sub(/%/,q[i],g);u(g,q[i+1])}}else if($$1~/%/&&$$2~/%:[^%]+:[^%]+:%/){d=$$2;sub(/^.*%:/,"",d);sub(/:%.*/,"",d);n=split(d,q,/:/);for(i=1;i<=n;i++){g=$$1;d=$$2;sub(/%/,q[i],g);sub(/%:[^%]+:%/,q[i],d);u(g,d)}}else u($$1,$$2)}/^##@ /{gsub(/\\n/,"\n");if(NF==3)tab=$$2;printf"\n%s\n",$$NF}END{print""}' $(MAKEFILE_LIST) # v1.61

.PHONY: all
all: build-minify ## Compile, bundle and minify everything. Identical to 'make build-minify'

.PHONY: mark
mark: # Put "ready" in corner of terminal
	@echo
	@tput cup $$((`tput lines` - 1)) $$((`tput cols` - 5))
	@printf `tput bold`ready`tput sgr0`
	@tput cuu1 && tput cuu1 && echo

%.min.css: %.css
	@# descend into the directory in order to prevent corrupting URLs in CSS
	cd $(<D); cleancss $(<F) > $(@F)

##@ Build process:

.PHONY: build-css
build-css: $(MIN_CSS_FILES) ## Compile the css files

.PHONY: build-res
build-res: ## Compile the res files to js
	rescript

.PHONY: bundle
bundle: ## Bundle the js files
	browserify $(JS_FILES) -p esmify -o $(BUNDLE)

.PHONY: bundle-minify
bundle-minify: ## Bundle and minify the js files
	browserify -g uglifyify $(JS_FILES) -p esmify | uglifyjs > $(BUNDLE)

.PHONY: build
build: build-css build-res ## Compile the res and css files; bundle the js files
	$(MAKE) bundle

.PHONY: build-minify
build-minify: build-css build-res ## Compile the res and css files; bundle and minify the js files
	$(MAKE) bundle-minify

##@ Building during development:

.PHONY: watch-css
watch-css: ## Compile the css files; watch for changes
	fswatch -o $(CSS_FILES) | while read f; do \
		tput setaf $(CSS_COLOR);               \
		echo '>>>> Minifying';                 \
		tput sgr0;                             \
		$(MAKE) compile-css mark;              \
	done &

.PHONY: watch-res
watch-res: ## Compile the res files; bundle the js files; watch for changes
	fswatch -o $(JS_FILES) | while read f; do \
		tput setaf $(JS_COLOR);               \
		echo '>>>> Bundling';                 \
		tput sgr0;                            \
		$(MAKE) bundle mark;                  \
	done &
	rescript build -w

.PHONY: watch
watch: watch-css watch-res ## Compile the res and css files; bundle the js files; watch for changes

.PHONY: watch-stop
watch-stop: ## Stop watching for changes
	ps -fu `whoami` | awk '/[f]swatch/ { print $$2 }' | tee /dev/tty | xargs kill
	rm .bsb.lock 2>/dev/null || true

##@ Serving the page:

.PHONY: serve
serve: ## Serve the page over http
	serve $(DIST) &

.PHONY: serve-stop
serve-stop: ## Stop serving the page
	ps -fu `whoami` | awk '/[s]erve $(DIST)/ { print $$2 }' | tee /dev/tty | xargs kill

##@ Source code control:

.PHONY: tag-%
tag-%: ## Update the %:major:minor:patch:% version number and create git tag
	which rpl 2>/dev/null
	which jq
	VERSION_FROM=$$(jq .version package.json) && \
	npm version $* && \
	VERSION_TO=$$(jq .version package.json) && \
	rpl $$VERSION_FROM $$VERSION_TO $(VERSION_FILES)
	@read -p $$'\nPress ENTER to recompile to integrate the new version number:' ans
	$(MAKE) build-minify && git commit -a --amend && $(MAKE) move-tag && git push

.PHONY: move-tag
move-tag: ## Move the tag for the current package.json version to this branch
	VERSION=v$$(jq .version package.json | tr -d '"') && \
	git tag -d $$VERSION && \
	git tag $$VERSION


