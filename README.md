# dotfiles

## Requirements

1. `git`
2. `stow`

## Instructions

```bash
git clone https://github.com/collinmurch/dotfiles ~ && stow -d ~/dotfiles -t ~ .
```
*Or run `stow .` from `~/dotfiles`*

**Note:** You may need to fix any conflicts from the above by doing `mv [CONFLICT FILE] [CONFLICT FILE].bak`

## Additional Optional Config

### Zsh

- Any additional config you need for work or whatever (for my job I need to specify `GOPROXY, GOSUMDB`, etc.) can be set in `~/.zprofile`

### Vim

- I use [LazyVim](https://www.lazyvim.org) with pretty light customization
- Install with `git clone https://github.com/LazyVim/starter ~/.config/nvim && stow -d ~/dotfiles -t ~ . && nvim`

### VS Code
- Remove previous extensions with `rm -rf ~/.vscode/extensions`
- Install my extensions with `/bin/zsh install_vscode.sh`

### Raycast
- Export settings under `Advanced` from previous machine and then import them under the same tab

## MacOS Applications

The development apps configured by this repository can be installed with `/bin/zsh install_macos.sh`

In general I try to keep it limited to just tools *that I actively use*

## MacOS Config

A list of defaults & functionality explanations I prefer can be set with `/bin/zsh config_macos.sh`, which I wouldn't recommend just running but you do you

Compiled from [Murderlon](https://github.com/murderlon)'s list I think