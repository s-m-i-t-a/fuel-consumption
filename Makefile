#!/bin/bash
.PHONY: build watch
.SUFFIXES: .elm .js

build:
	elm-make --warn src/Main.elm --output=build/main.js


watch:
	elm-live --output=build/main.js src/Main.elm --pushstate --open --debug
