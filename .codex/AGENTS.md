# Rules

## Projects
- No emojis in logs, comments, commit messages, or code unless explicitly requested
- Tests: prefer many small, distinct tests (e.g., Go `t.Run(...)` blocks) over giant table-driven structs
- Comments: only for exported/public function docs or genuinely complex logic; no “organizational” comments

## Process
- Prefer parallel tool calls and subagents for indendent, read-only work (research, scans, lookups)
- Always request escalaton when commands fail due to sandbox permissions
  - No temporary cache directories or other workarounds unless explicitely requested
- Never try to start the local/dev server for any project unless explicitely requested
