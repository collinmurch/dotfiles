# Rules

## Projects
- No emojis in logs, comments, commit messages, or code unless explicitly requested
- Tests: prefer many small, distinct tests (e.g., Go `t.Run(...)` blocks) over giant table-driven structs
- Comments: only for exported/public function docs or genuinely complex logic; no “organizational” comments

## Process
- When commands fail due to sandbox permissions, either request escalation or pause there
  - No temporary cache directories or other workarounds unless explicitely requested
- Never try to start the local/dev server for any project
