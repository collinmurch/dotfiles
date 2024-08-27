# dotfiles

## Requirements

1. `git`
2. `stow`

## Instructions

```bash
cd ~
git clone https://github.com/collinmurch/dotfiles && cd dotfiles
stow .
```

You may need to fix any conflicts from the above by doing `mv [CONFLICT FILE] [CONFLICT FILE].bak`

## Additional Needed Config

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