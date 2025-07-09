# macOS dotfiles

This repo is a little quirky at the moment; I'm half way between a Nix-style setup and a stow one.
Eventually this will be fully Nix-based but for now we do some non-reproducible stuff with bootstrap.

## Prerequisites

1. `git`
2. `nix`
3. Experimental features enabled:

```bash
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

## Installation Instructions

```bash
nix profile add github:collinmurch/dotfiles#pkg-set
nix run github:collinmurch/dotfiles#bootstrap   # expect stow conflicts the first time you run this
```

Then open a new terminal session

## Additional Optional Config

### Machine-Specific Config/Environment

For each respective shell, these files aren't comitted in the repository and will be sourced if they exist:

- Zsh: `~/.zprofile`
- Nushell: `$nu.default-config-dir/local.nu`

### MacOS System Settings

A list of defaults & functionality explanations I prefer can be set with `/bin/zsh config_macos.sh`, which I wouldn't recommend just running but you do you

- This is a subset of [Murderlon](https://github.com/murderlon)'s list
- Will probably migrate this to [nix-darwin](https://github.com/nix-darwin/nix-darwin) at some point

### Scripts

- All the scripts I use with Raycast and as CLI utilities can be found at: [scripts](https://github.com/collinmurch/scripts)

### Raycast

- Export settings under `Advanced` from previous machine and then import them under the same tab

### Orion

- Sometimes keybindings conflict with extensions, for example Bitwarden conflicting with "Search With DuckDuckGo"
  - System Preferences: Keyboards --> Keyboard Shortcuts --> App Shortcuts
  - Override “Search With DuckDuckGo" to a new keybinding for Orion
