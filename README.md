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

If either of these files are present, they will be sourced by the respective shell:

- **Zsh:** `~/.zprofile`
- **Nushell:** `$nu.default-config-dir/local.nu` ([overlay](https://www.nushell.sh/book/overlays.html))

Additional sandbox permissions for Codex and Claude Code:

- **Codex:** `~/.codex/rules/*.rules` (any name but `base.rules`)
- **Claude Code:** `./.claude/settings.local.json` (must be project-level)

### MacOS System Settings

A list of defaults & functionality explanations I prefer can be set with `/bin/zsh config_macos.sh`, which I wouldn't recommend just running. I'll probably migrate this to [nix-darwin](https://github.com/nix-darwin/nix-darwin) at some point.

### Raycast

1. Export settings under **Advanced** from previous machine
2. Import them under the same tab on a new machine
3. Check to make sure scripts are loaded from `~/Developer/scripts`
