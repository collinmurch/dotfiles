# neovim config

Initially forked from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) (formerly tjdevries/kickstart.nvim); I moved to a separate repo to get rid of PR/rebase buttons showing on GitHub since this has diverged a ton.

**Requirements:**

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- Some nerd font (not needed if you're using [Ghostty](https://ghostty.org))

**Tracking policy:**

- This repo uses an allowlist `.gitignore`; only files explicitly un-ignored are tracked
- Put machine-specific settings in `lua/local.lua` (intentionally ignored)

**Installation example (macOS):**

```bash
brew install ripgrep
git clone https://github.com/collinmurch/nvim ~/.config/nvim
nvim
```
