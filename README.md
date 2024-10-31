# macOS dotfiles

## Requirements

1. `git`
2. `stow`

## Installation Instructions

Run the below script then open a new terminal session

```bash
git clone --recurse-submodules https://github.com/collinmurch/dotfiles ~
/bin/zsh install_macos.sh # dependency installation -- highly recommended
mkdir ~/.config &>/dev/null; stow -d ~/dotfiles -t ~ .
bat cache --build # force bat to load the custom theme
```

**Notes**
- You may need to fix any conflicts from the above by doing `mv [CONFLICT FILE] [CONFLICT FILE].bak`
  - Then re-run `stow -d ~/dotfiles -t ~ .`

## Additional Optional Config

### MacOS System Settings

A list of defaults & functionality explanations I prefer can be set with `/bin/zsh config_macos.sh`, which I wouldn't recommend just running but you do you
- *This is a subset of [Murderlon](https://github.com/murderlon)'s list*

### Zsh

- Any additional config you need for work or whatever (`AWS_REGION, AWS_PROFILE, GOPROXY, GOSUMDB`, etc.) can be set in `~/.zprofile`

### VS Code

- Remove previous extensions with `rm -rf ~/.vscode/extensions`
- Install my extensions with `/bin/zsh install_vscode.sh`

### Raycast

- Export settings under `Advanced` from previous machine and then import them under the same tab
