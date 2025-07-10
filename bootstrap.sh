#!/usr/bin/env bash
set -euo pipefail

read -p "Clone dotfiles repository? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! -d "$HOME/dotfiles/.git" ]; then
    echo "→ Cloning git repository..."
    git clone --recurse-submodules https://github.com/collinmurch/dotfiles "$HOME/dotfiles"
  else
    echo "✓ Dotfiles repo already exists – skipping clone."
  fi
else
  echo "✓ Nothing to do."
  exit 0
fi

read -p "Link dot-files with stow? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "→ Linking dot-files with stow…"
  stow --no-folding -d ~/dotfiles -t ~ .
else
  echo "✓ Skipping stow linking."
fi

echo "→ Rebuilding bat cache…"
bat cache --build

read -p "Set Git global defaults? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "→ Setting Git defaults…"
  git config --global core.editor nvim 2>/dev/null || true
  git config --global pull.rebase true 2>/dev/null || true
  git config --global push.autoSetupRemote true 2>/dev/null || true
  git config --global include.path ~/.config/delta-themes.gitconfig 2>/dev/null || true
  git config --global core.pager delta 2>/dev/null || true
  git config --global interactive.diffFilter 'delta --color-only' 2>/dev/null || true
  git config --global delta.features poimandres 2>/dev/null || true
  git config --global delta.navigate true 2>/dev/null || true
  git config --global merge.conflictStyle zdiff3 2>/dev/null || true
  git config --global delta.hyperlinks true 2>/dev/null || true
  git config --global delta.hyperlinks-file-link-format 'zed://file/{path}:{line}' 2>/dev/null || true
  git config --global delta.colorMoved default 2>/dev/null || true
else
  echo "✓ Skipping Git configuration."
fi

read -p "Open a new (nu) shell? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "✓ All done – opening a new (nu) shell..."

  # Check if nu is available in PATH first
  if command -v nu >/dev/null 2>&1; then
    exec nu -l
  # Fallback to nix profile location
  elif [ -x "$HOME/.nix-profile/bin/nu" ]; then
    exec "$HOME/.nix-profile/bin/nu" -l
  else
    echo "Error: nushell (nu) not found in PATH or at ~/.nix-profile/bin/nu"
    echo "Please ensure nushell is installed and available."
    exit 1
  fi
else
  echo "✓ All done!"
fi
