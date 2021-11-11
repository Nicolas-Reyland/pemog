# pemog
**P**ython **E**xtension-**Mo**dule **G**enerator

⚠️ This is still under developpment ⚠️

The only supported language is C, for now.

## Installation
You need [ghc](https://www.haskell.org/ghc/) to be installed on your system.

```bash
git clone https://github.com/Nicolas-Reyland/pemog
cd pemog
make
sudo make install
```

## Usage
```bash
pemog module-name input-file output-file
```

For example :
```bash
pemog spam spam.sketch spammodule.c
```
