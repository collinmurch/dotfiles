# config

Application configuration managed via stow.

**Tracking policy:**

- This directory uses an allowlist `.gitignore`; only directories and files explicitly un-ignored are tracked
- To track a new config directory, add entries for both the directory and its contents to `.gitignore` (e.g., `!app/` and `!app/**`)
- To track a standalone config file, add it to `.gitignore` (e.g., `!file.conf`)
