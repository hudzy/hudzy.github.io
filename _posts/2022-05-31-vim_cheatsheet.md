---
title: "Vim Cheatsheet"
categories: [linux, vim]
tags: [editor, vim, cheatsheet]
---

# Vim Cheatsheet

## vim-folding

- `za` toggle current fold
- `zA` recursively toggle current fold
- `zo` open current fold
- `zO` recursively open current fold
- `zc` close current fold
- `zC` recursively close current fold
- `zR` open all folds
- `zM` close all folds
- `zr` decreases the foldlevel by one
- `zm` increases the foldlevel by one
- `[z` move to start of open fold
- `]z` move to end of open fold
- `zf#j` creates a fold from the cursor down # lines
- `zf/string` creates a fold from the cursor to string
- `zE` delete all folds
- `zd` delete the fold at the cursor
- `zi` switch folding on or off
- `zj` move down to top of next fold
- `zk` move up to bottom of previous fold
- `zv` expand folds to reveal cursor

---

## IndentWise

- `[-` : Move to _previous_ line of _lesser_ indent than the current line.
- `[+` : Move to _previous_ line of _greater_ indent than the current line.
- `[=` : Move to _previous_ line of _same_ indent as the current line that is separated from the current line by lines of different indents.
- `]-` : Move to _next_ line of _lesser_ indent than the current line.
- `]+` : Move to _next_ line of _greater_ indent than the current line.
- `]=` : Move to _next_ line of _same_ indent as the current line that is separated from the current line by lines of different indents.
- `{count}[_` : Move to _previous_ line with indent-level of `{count}`.
- `{count}]_` : Move to _next_ line with indent-level of `{count}`.

---

## NERD Commenter

- `[count]<leader>cc` **|NERDCommenterComment|**

  Comment out the current line or text selected in visual mode.

- `[count]<leader>cn` **|NERDCommenterNested|**

  Same as cc but forces nesting.

- `[count]<leader>c<space>` **|NERDCommenterToggle|**

  Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.

- `[count]<leader>cm` **|NERDCommenterMinimal|**

  Comments the given lines using only one set of multipart delimiters.

- `[count]<leader>ci` **|NERDCommenterInvert|**

  Toggles the comment state of the selected line(s) individually.

- `[count]<leader>cs` **|NERDCommenterSexy|**

  Comments out the selected lines with a pretty block formatted layout.

- `[count]<leader>cy` **|NERDCommenterYank|**

  Same as cc except that the commented line(s) are yanked first.

- `<leader>c$` **|NERDCommenterToEOL|**

  Comments the current line from the cursor to the end of line.

- `<leader>cA` **|NERDCommenterAppend|**

  Adds comment delimiters to the end of line and goes into insert mode between them.

- `<leader>ca` **|NERDCommenterAltDelims|**

  Switches to the alternative set of delimiters.

- `[count]<leader>cl` **|NERDCommenterAlignLeft** `[count]<leader>cb` **|NERDCommenterAlignBoth**

  Same as **|NERDCommenterComment|** except that the delimiters are aligned down the left side (`<leader>cl`) or both sides (`<leader>cb`).

- `[count]<leader>cu` **|NERDCommenterUncomment|**

  Uncomments the selected line(s).

---

## vim-easy-align

> An *alignment rule* is a predefined set of options for common alignment tasks, which is identified by a single character, such as `<Space>`, `=`, `:`, `.`, `|`, `&`, `#`, and `,`.

#### =

- `=` Around the 1st occurrences
- `2=` Around the 2nd occurrences
- `*=` Around all occurrences
- `**=` Left/Right alternating alignment around all occurrences
- `<Enter>` Switching between left/right/center alignment modes

#### \<space\>

- `<Space>` Around the 1st occurrences of whitespaces
- `2<Space>` Around the 2nd occurrences
- `-<Space>` Around the last occurrences
- `<Enter><Enter>2<Space>` Center-alignment around the 2nd occurrences

#### , \<comma\>

- The predefined comma-rule places a comma right next to the preceding token without margin (`{'stick_to_left': 1, 'left_margin': 0}`)
- You can change it with `<Right>` arrow

---

## vim-surround

`cs"'`

`cs'<q>`

`cst"`

`ds"`

use `}` instead of `{` for no space

`yss)`

---

## vim-peekaboo

`"` or `@` in normal mode

`<CTRL-R>` in insert mode

toggle fullscreen by pressing `<space>`

---

## vim-plug

- `PlugInstall [name ...] [#threads]`: Install plugins
- `PlugUpdate [name ...] [#threads]`: Install or update plugins
- `PlugClean[!]`: Remove unlisted plugins (bang version will clean without prompt)
- `PlugUpgrade`: Upgrade vim-plug itself
- `PlugStatus`: Check the status of plugins
- `PlugDiff`: Examine changes from the previous update and the pending changes
- `PlugSnapshot[!] [output path]`: Generate script for restoring the current snapshot of the plugins
