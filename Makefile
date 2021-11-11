# Makefile for the https://github.com/Nicolas-Reyland/OCR-Sudoku-Solver project

SHELL := /bin/sh
HC := ghc
FLAGS :=

.PHONY: all
all:
	$(HC) $(FLAGS) src/Main.hs src/Pemog.hs -o pemog

.PHONY: clean
clean:
	rm -f src/*.o
	rm -f src/*.hi
	if [ -e "pemog" ]; then rm -f pemog; fi
