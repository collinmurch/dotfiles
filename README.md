# macOS dotfiles

## Requirements

1. `git`
2. `stow`

## Installation Instructions

Open a new terminal session after running:

```bash
git clone --recurse-submodules https://github.com/collinmurch/dotfiles ~
cd ~/dotfiles
/bin/zsh install_macos.sh               # dependency installation & setup
```

**Notes**

- You may need to fix any conflicts from the above by doing `mv [CONFLICT FILE] [CONFLICT FILE].bak`
  - Then re-run `stow -d ~/dotfiles -t ~ .`

## Additional Optional Config

### MacOS System Settings

A list of defaults & functionality explanations I prefer can be set with `/bin/zsh config_macos.sh`, which I wouldn't recommend just running but you do you

- _This is a subset of [Murderlon](https://github.com/murderlon)'s list_

### Zsh

- Any additional config you need for work or whatever (`AWS_REGION, AWS_PROFILE, GOPROXY, GOSUMDB`, etc.) can be set in `~/.zprofile`

### Raycast

- Export settings under `Advanced` from previous machine and then import them under the same tab

### Scripts

- All the scripts I use with Raycast and as CLI utilities can be found at [scripts](https://github.com/collinmurch/scripts)
