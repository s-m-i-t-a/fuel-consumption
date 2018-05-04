#!/bin/bash
.PHONY: build watch gh-pages
.SUFFIXES: .elm .js

build:
	elm-make --warn src/Main.elm --output=build/main.js


watch:
	elm-live --dir=build --output=build/main.js src/Main.elm --pushstate --open --debug


gh-pages: build
	git branch -D gh-pages 2>/dev/null || true
	git branch -D draft 2>/dev/null || true
	git push origin :gh-pages
	git checkout -b draft
	git add -f build/main.js
	git add -f build/index.html
	git commit -am "Deploy on gh-pages"
	git subtree push --prefix build origin gh-pages
