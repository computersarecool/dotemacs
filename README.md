# My Emacs configuration
*My Emacs configuration*

> It's awesome

## What this repo does
This repo configures [Emacs](https://www.gnu.org/software/emacs/). This README also serves as a place to take notes on different mode usages and list modes that I am planning to explore more in the future.

## Tested on:
- Linux
- Windows

## How to use this repo
Clone the repo to a user's home directory. Then start Emacs.

### Notes on modes:
#### neotree
  - Toggle hidden file names `H` 
  - Maximize / minimize neotree `A` 
  - Change root `C-c C-c` 
  - Copy a file or directory `C-c C-p`

#### multiple-cursors
  - Toggle showing only lines with cursor `C-'`
  - Insert increasing numbers for each cursor `mc/insert-numbers`

#### yasnippet
  - Create a new snippet `yas-new-snippet` (`C-c C-c` to save)

#### nodejs-repl / toggle-repl
  - To send content to nodejs-repl `C-u` (1 - 3 times) followed by `C-c C-z`

#### skewer-mode
  - Open and attach a browser `M-x run-skewer`
  - Open the REPL `C-c C-z` 
  - Evaluate an expression `C-M-x`

### Modes to explore further:
- Buffer-move
- Hi-loc mode
- ac-capf
- ac-emoji
- markdown mode
- expand-region
- abbrev
- irony
- semantic
- global-ede
- CEDET
- ac-capf
- yasnippet
- flycheck
- tern
- jedi
- guess-style
- markdown-mode
- json-mode
- stylus (significant whitespace mode)
- mail
- editor config

#### Modes to add later:
- Whitespace mode:
    (This currently causes an issue with autocomplete which could be changed by changing the face in the popup)
- magit:
  (Unclear if this should be done from within Emacs, Causes issues with vertical frame splitting)

### License
:copyright: Willy Nolan 2017

[MIT License](LICENSE.txt)

