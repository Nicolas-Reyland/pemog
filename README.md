# pemog
**P**ython **E**xtension-**Mo**dule **G**enerator

⚠️ This is still under developpment (please do not use yet) ⚠️

The goal of **pemog** is to generate portions of code in another language based on python code, when rewriting a python module. For now, the only supported language for extension modules is C.

For now, only empty functions are generated.

## Installation
You need [ghc](https://www.haskell.org/ghc/) to be installed on your system.

```bash
git clone https://github.com/Nicolas-Reyland/pemog
cd pemog
make
# sudo make install # do not yet do this
```

## Usage

### With python files :
```bash
./pemog name input-file.py namemodule.c
```

The `name` should be the name of the module

### With sketch files :
```bash
./pemog name input-file.sketch namemodule.c
```

The *sketch* files describe one function of your extension module per line. Each line should be formatted like this :
```
function_name (arg-1-type-hint, arg2-type-hint, ...) return-type-hint
```
If a type is not a *known* (int, src, bool, etc.) type, you can replace it with the `?` character. If your function does not have any return-type, you can use `?` as a return type or simply not give one (the line can stop after the `)`).

A sketch input file could look like this :
```
system(str) int
test ()
example(int, str, ?)
twoplustwo (?,?) ?
```

It basically describes the functions you want to implement. If you do not wish to write sketch files, just give your python code (must end with `.py`) !

## TODO :
 * Use [language-python](https://github.com/bjpop/language-python) or [hpython](https://github.com/qfpl/hpython) for python parsing
 * Documentation generation based on argument types, function return-type etc.
 * Split generated code into multiple files
 * Testing
