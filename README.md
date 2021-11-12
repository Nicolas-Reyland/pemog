# pemog
**P**ython **E**xtension-**Mo**dule **G**enerator

⚠️ This is still under developpment (please do not use yet) ⚠️

The goal of **pemog** is to generate big portions of code based on python code, when rewriting a python module in another language. For now, the only supported language for extension modules is C.

For now, only empty functions can be generated, based on a very simply formatted input file.

## Installation
You need [ghc](https://www.haskell.org/ghc/) to be installed on your system.

```bash
git clone https://github.com/Nicolas-Reyland/pemog
cd pemog
make
# sudo make install # do not yet do this
```

## Usage
```bash
./pemog module-name input-file output-file
```

An input file could look like this :
```
system(str) int
test ()
example(int, str, ?)
twoplustwo (?,?) ?
```

It basically describes the functions you want to implement. This step should be automated in the future, based on the python code you would provide.

For example :
```bash
./pemog spam src/templates/spam.sketch spammodule.c
```
