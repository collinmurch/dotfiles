# macOS dotfiles

This repo is a little quirky at the moment; I'm half way between a [Nix](https://nixos.org)-style setup and a stow-based one.
Eventually this will be fully Nix-based but for now we do some non-reproducible stuff with bootstrap.

## Prerequisites

1. `git`
2. `nix`
3. Nix experimental features enabled:

```bash
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

## Installation Instructions

```bash
nix profile add github:collinmurch/dotfiles#pkg-set

# expect stow conflicts on first run
nix run github:collinmurch/dotfiles#bootstrap 
```

### Fonts

This setup includes encrypted **TX-02 (Berkely Mono)** fonts that are optionally decrypted during `bootstrap.sh` using my Bitwarden SSH key.
**JetBrains Mono** is installed and is a fallback font for all configs if **TX-02** isn't found.

## Additional Optional Config

### Custom Environments

If either of these files are present, they will be sourced for the respective shell (not comitted):

- **Zsh:** `~/.zprofile`
- **Nushell:** `$nu.default-config-dir/local.nu`

### MacOS System Settings

A list of defaults & functionality explanations I prefer can be set with `/bin/zsh config_macos.sh`, which I wouldn't recommend just running. I'll probably migrate this to [nix-darwin](https://github.com/nix-darwin/nix-darwin) at some point.

### Scripts

All the scripts I use with Raycast and as CLI utilities can be found at: [scripts](https://github.com/collinmurch/scripts).

### Raycast

Export settings under **Advanced** from previous machine and then import them under the same tab.
