# Licensed under the Apache License, Version 2.0. See footer for details

.PHONY: all build vendor test

COFFEEC         = @node_modules/.bin/coffee -c
BROWSERIFY      = @node_modules/.bin/browserify
JASMINE         = @node_modules/.bin/jasmine-node
JASMINE_VERSION = 1.1.0

#-------------------------------------------------------------------------------
all: build

#-------------------------------------------------------------------------------
# you'll need to run the vendor task by hand at least once before build
#-------------------------------------------------------------------------------
build:

#   compile /lib-src/ CoffeeScript to /lib/ JavaScript
	@-chmod -R +w    lib/* 
	@rm -rf          lib/*
	$(COFFEEC) -b -o lib         lib-src/*.coffee
	@chmod -R -w     lib/*

#   compile /spec-src/ CoffeeScript to /spec/ JavaScript
	@-chmod -R +w             spec/* 
	@rm -rf                   spec/*
#	$(COFFEEC) -b -o          spec           spec-src/*.coffee
	$(COFFEEC) -o             spec           spec-src/*.coffee
	@chmod -R -w              spec/*

#   browserify the browerable bits
	@rm -rf tmp
	@mkdir  tmp
	$(BROWSERIFY) \
	    --outfile tmp/console-table.js \
	    --debug \
	    lib-src/console-table.coffee

#   compile browserify'd bits into /lib-browser/console-table.js
	@-chmod -R +w                            lib-browser/* 
	@rm -rf                                  lib-browser/*
	@cat etc/source-license-js-before.txt >  lib-browser/console-table.js
	@echo ";(function(){"                 >> lib-browser/console-table.js
	@cat tmp/console-table.js             >> lib-browser/console-table.js
	@echo "})();"                         >> lib-browser/console-table.js
	@cat etc/source-license-js-after.txt  >> lib-browser/console-table.js
	@chmod -R -w                             lib-browser/* 

#-------------------------------------------------------------------------------
test: build

#   run command-line Jasmine tests
	@-$(JASMINE) spec
	@echo 
	@echo also open browser tests at spec-src/spec-runner.html

#-------------------------------------------------------------------------------
vendor:

#   get npm modules
	@-chmod -R +w node_modules/* 
	@rm -rf       node_modules/*
	@npm install
	@chmod -R -w  node_modules/* 

#   get jasmine browserable bits
	@rm -rf tmp
	@mkdir  tmp
	@curl --progress-bar \
	   --output tmp/jasmine.zip \
	   http://pivotal.github.com/jasmine/downloads/jasmine-standalone-$(JASMINE_VERSION).zip
	@unzip tmp/jasmine.zip -d tmp

#   copy jasmine browserable bits to /vendor/jasmine
	@-chmod -R +w    vendor/* 
	@rm -rf          vendor
	@mkdir           vendor
	@mv tmp/jasmine-standalone-$(JASMINE_VERSION) vendor/jasmine
	@mv    vendor/jasmine/lib/jasmine-$(JASMINE_VERSION)/* vendor/jasmine/lib
	@rmdir vendor/jasmine/lib/jasmine-$(JASMINE_VERSION)

#-------------------------------------------------------------------------------
# Copyright 2012 Patrick Mueller
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#-------------------------------------------------------------------------------
