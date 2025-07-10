#!/usr/bin/env bash
set -euo pipefail

# Check if we're in an interactive terminal
if [[ -t 0 ]]; then
  read -p "Clone dotfiles repository? (y/N): " -n 1 -r
  echo
else
  REPLY="y"
  echo "Clone dotfiles repository? (y/N): y (non-interactive mode)"
fi

if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! -d "$HOME/dotfiles/.git" ]; then
    echo "→ Cloning git repository..."
    git clone --recurse-submodules https://github.com/collinmurch/dotfiles "$HOME/dotfiles"
  else
    echo "✓ Dotfiles repo already exists – skipping clone."
  fi
else
  echo "✓ Skipping repository clone."
fi

if [[ -t 0 ]]; then
  read -p "Link dot-files with stow? (y/N): " -n 1 -r
  echo
else
  REPLY="y"
  echo "Link dot-files with stow? (y/N): y (non-interactive mode)"
fi

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "→ Linking dot-files with stow…"
  stow --no-folding -d ~/dotfiles -t ~ .
else
  echo "✓ Skipping stow linking."
fi

if [[ -t 0 ]]; then
  read -p "Rebuild bat cache? (y/N): " -n 1 -r
  echo
else
  REPLY="y"
  echo "Rebuild bat cache? (y/N): y (non-interactive mode)"
fi

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "→ Rebuilding bat cache…"
  bat cache --build
else
  echo "✓ Skipping bat cache rebuild."
fi

if [[ -t 0 ]]; then
  read -p "Set Git global defaults? (y/N): " -n 1 -r
  echo
else
  REPLY="y"
  echo "Set Git global defaults? (y/N): y (non-interactive mode)"
fi

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "→ Setting Git defaults…"
  git config --global core.editor nvim                         2>/dev/null || true
  git config --global pull.rebase true                         2>/dev/null || true
  git config --global push.autoSetupRemote true                2>/dev/null || true
  git config --global include.path ~/.config/delta-themes.gitconfig 2>/dev/null || true
  git config --global core.pager delta                         2>/dev/null || true
  git config --global interactive.diffFilter 'delta --color-only' 2>/dev/null || true
  git config --global delta.features poimandres                2>/dev/null || true
  git config --global delta.navigate true                      2>/dev/null || true
  git config --global merge.conflictStyle zdiff3               2>/dev/null || true
  git config --global delta.hyperlinks true                    2>/dev/null || true
  git config --global delta.hyperlinks-file-link-format 'zed://file/{path}:{line}' 2>/dev/null || true
  git config --global delta.colorMoved default                 2>/dev/null || true
else
  echo "✓ Skipping Git configuration."
fi

if [[ -t 0 ]]; then
  read -p "Open a new (nu) shell? (y/N): " -n 1 -r
  echo
else
  REPLY="y"
  echo "Open a new (nu) shell? (y/N): y (non-interactive mode)"
fi

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "✓ All done – opening a new (nu) shell..."
  exec ~/.nix-profile/bin/nu -l
else
  echo "✓ All done!"
fi