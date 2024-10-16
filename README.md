# macOS dotfiles

## Requirements

1. `git`
2. `stow`

## Installation Instructions

Run the below script then open a new terminal session

```bash
git clone https://github.com/collinmurch/dotfiles ~
/bin/zsh ~/dotfiles/install_macos.sh # Optional, but highly recommended
stow -d ~/dotfiles -t ~ . # Can also run `stow .` from ~/dotfiles
```

**Note 1:** You may need to fix any conflicts from the above by doing `mv [CONFLICT FILE] [CONFLICT FILE].bak`

**Note 2:** `install_macos.sh` specifies the expected zsh plugins that should be installed; you'll get errors from sourcing `~/.zshrc` if you don't run that script

## Additional Optional Config

### Zsh

- Any additional config you need for work or whatever (`AWS_REGION, AWS_PROFILE, GOPROXY, GOSUMDB`, etc.) can be set in `~/.zprofile`

### NeoVim
*Note: I mostly use [Helix](https://helix-editor.com)*

- For NeoVim use [NvChad](https://nvchad.com) with pretty light customization
- Install with `git clone https://github.com/NvChad/starter ~/.config/nvim && nvim`
- Get my settings with `echo "return require('custom.chadrc')" > ~/.config/nvim/lua/chadrc.lua && stow -d ~/dotfiles -t ~ . && nvim ~/.config/nvim/lua/chadrc.lua -c "sleep 1" -c "wq"`
  - You may need to fix any file conflicts similar to in [Installation Instructions](#installation-instructions)

### Git
- I use [Helix](https://helix-editor.com) for editing, set as the global editor with `git config --global core.editor hx`

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
