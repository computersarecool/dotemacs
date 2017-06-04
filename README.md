# My Emacs configuration
*My Emacs configuration, in a repo*

> It's awesome

These are the files that I use to configure Emacs.  This README also serves as a place for me to list the modes that I am planning to explore more in the future

# Mode Usage Notes:
### neotree
  - `H` Toggle hidden file names
  - `A` Maximize / minimize neotree
  - `C-c C-c` Change root
  - `C-c C-p` Copy a file or directory

### multiple-cursors
  - `C-'` Toggle showing only lines with cursor
  - `mc/insert-numbers` Insert increasing numbers for each cursor
  - `C-'` Toggle showing only lines with cursor
  - 
### nodejs-repl
  - To send content to nodejs-repl C-u (1 - 3 times) followed by C-c C-z

### skewer-mode
  - M-x run-skewer to attach to a browser
  - C-c C-z to open the REPL
  - C-M-x to evaluate an expression

#### Things to do:
 - Confirm that files are not saved when using `sudo` and `tramp`
 - python-mode, jedi:(show-doc, complete and goto-definition)
 - Make more snippets
 - Check to see if we can install `yasnippet` without all the extra snippets that come with it
 - Explore more modes

#### Modes to explore further:
- expand-region-
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
  (Unclear if this should be done from within emacs, caused issues with vertical frame splitting)

### License
:copyright: Willy Nolan 2017 
[MIT](http://en.wikipedia.org/wiki/MIT_License)
