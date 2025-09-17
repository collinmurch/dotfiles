#!/usr/bin/env bash
set -euo pipefail

if [ ! -d "$HOME/dotfiles/.git" ]; then
  read -p "Clone dotfiles repository? (y/N): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "→ Cloning git repository..."
    git clone --recurse-submodules https://github.com/collinmurch/dotfiles "$HOME/dotfiles"
  else
    echo "✓ Nothing to do."
    exit 0
  fi
else
  echo "✓ Dotfiles repo already exists – skipping clone."
fi

echo
read -p "Link dot-files with stow? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "→ Linking dot-files with stow…"
  stow --no-folding -d ~/dotfiles -t ~ .
else
  echo "✓ Skipping stow linking."
fi

echo
echo "→ Rebuilding bat cache…"
bat cache --build

echo
read -p "Install TX-02 fonts? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "→ Installing TX-02 fonts…"

  # Create fonts directory
  FONT_DIR="$HOME/.local/share/fonts/tx02"
  mkdir -p "$FONT_DIR"

  # Check if fonts already installed
  if [ -f "$FONT_DIR/TX-02-Regular.otf" ]; then
    echo "✓ TX-02 fonts already installed"
  else
  # Check if Bitwarden is available and handle authentication
  if command -v bw >/dev/null 2>&1; then
    BW_STATUS=$(bw status | nu -c 'from json | get status' 2>/dev/null || echo "unknown")

    case "$BW_STATUS" in
    "unauthenticated")
      echo "  Bitwarden CLI is not logged in."
      read -r -p "  Enter your Bitwarden email: " BW_EMAIL
      echo "  Logging in to Bitwarden..."
      if bw login "$BW_EMAIL"; then
        echo "  Login successful. Now unlocking vault..."
        if SESSION_KEY=$(bw unlock --raw); then
          export BW_SESSION="$SESSION_KEY"
          BW_CMD="bw"
        else
          echo "✗ Failed to unlock bw vault after login"
          exit 1
        fi
      else
        echo "✗ Failed to login to Bitwarden"
        exit 1
      fi
      ;;
    "locked")
      echo "  Bitwarden vault is locked. Attempting to unlock..."
      if SESSION_KEY=$(bw unlock --raw); then
        export BW_SESSION="$SESSION_KEY"
        BW_CMD="bw"
      else
        echo "✗ Failed to unlock bw vault"
        exit 1
      fi
      ;;
    "unlocked")
      BW_CMD="bw"
      ;;
    *)
      echo "✗ Unknown Bitwarden status: $BW_STATUS"
      exit 1
      ;;
    esac
  else
    echo "✗ bw command not found"
    exit 1
  fi

  # Decrypt and install fonts if Bitwarden is available and unlocked
  if [ -n "${BW_CMD:-}" ]; then
    echo "  Decrypting TX-02 fonts using Bitwarden SSH key..."

    # Create temporary key file from Bitwarden
    TEMP_KEY=$(mktemp)
    trap 'rm -f "$TEMP_KEY"' EXIT

    # Get SSH key from Bitwarden
    bw get item "GitHub Encryption Secret" | nu -c 'from json | get sshKey.privateKey' >"$TEMP_KEY"

    # Convert SSH private key to age format
    AGE_KEY_FILE=$(mktemp)
    trap 'rm -f "$AGE_KEY_FILE"' EXIT
    ssh-to-age -private-key -i "$TEMP_KEY" >"$AGE_KEY_FILE"

    # Decrypt fonts using age with converted key
    age -d -i "$AGE_KEY_FILE" ~/dotfiles/fonts/TX-02-Regular.otf.age >"$FONT_DIR/TX-02-Regular.otf"
    age -d -i "$AGE_KEY_FILE" ~/dotfiles/fonts/TX-02-Bold.otf.age >"$FONT_DIR/TX-02-Bold.otf"
    age -d -i "$AGE_KEY_FILE" ~/dotfiles/fonts/TX-02-Oblique.otf.age >"$FONT_DIR/TX-02-Oblique.otf"
    age -d -i "$AGE_KEY_FILE" ~/dotfiles/fonts/TX-02-Bold-Oblique.otf.age >"$FONT_DIR/TX-02-Bold-Oblique.otf"

    echo "✓ TX-02 fonts installed to $FONT_DIR"

    # Refresh font cache on Linux
    if [[ "$OSTYPE" == "linux-gnu"* ]] && command -v fc-cache >/dev/null 2>&1; then
      fc-cache -f "$FONT_DIR"
    fi
  fi
  fi
else
  echo "✓ Skipping TX-02 font installation."
fi

echo
read -p "Set Git global defaults? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "→ Setting Git defaults…"
  git config --global core.editor hx 2>/dev/null || true
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

echo
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
