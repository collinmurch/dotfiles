# collinmurch dotfiles

## Requirements

1. `git`
2. `stow`

## Instructions

```bash
cd ~
git clone https://github.com/collinmurch/dotfiles && cd dotfiles
stow .
```

Might need to fix any conflicts by doing `mv [CONFLICT FILE] [CONFLICT FILE].bak` or `rm [CONFLICT FILE]` if you're feeling dangerous.

## MacOS Applications

The development apps configured by this repository can be found in `install_macos.sh`.
In general I try to keep it limited to just tools *that I actively use*.

```bash
/bin/zsh install_macos.sh
```

## MacOS Config

A list of defaults & functionality explanations I prefer can be found in `config_macos.sh`.
Compiled from [Murderlon](https://github.com/murderlon)'s list.

```bash
/bin/zsh config_macos.sh
```

## Additional Needed Config

### VS Code
- Remove previous ones with `rm -rf ~/.vscode/extensions`
- Install my extensions with `chmod +x install_vscode.sh && ./install_vscode.sh`

### Raycast
- Export settings under `Advanced` from previous machine and then import them under the same tab

### Zed
- Install `Catppuccin (Blur)` and other needed extensions
- I don't really use Zed
  - Doesn't support merge conflict resolution, custom YAML tags, and other things I need
