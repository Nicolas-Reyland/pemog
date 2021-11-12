# Makefile for the https://github.com/Nicolas-Reyland/pemog project
ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

SHELL := /bin/sh
HC := ghc
FLAGS :=

.PHONY: all
all:
	$(HC) $(FLAGS) src/Main.hs src/Pemog.hs src/TemplateFormat.hs -o pemog

install:
	@echo "/!\\ please do not yet use the install rule"
	false
	#install -d $(DESTDIR)$(PREFIX)/bin/
	#install -m 711 pemog $(DESTDIR)$(PREFIX)/bin/

uninstall:
	@echo "/!\\ please do not yet use the (un)install rule"
	false
	#if [ -e $(PREFIX)/bin/ ]; then rm -f $(PREFIX)/bin/pemog; else echo "Not installed"; fi

.PHONY: clean
clean:
	rm -f src/*.o
	rm -f src/*.hi
	if [ -e "pemog" ]; then rm -f pemog; fi
