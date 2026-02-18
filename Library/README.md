# Library

macOS Library files managed via stow.

**Tracking policy:**

- This directory uses an allowlist `.gitignore`; only directories and files explicitly un-ignored are tracked
- To track new files, add entries for the full directory chain and contents to `.gitignore` (e.g., `!Application Support/app/` and `!Application Support/app/**`)
