# Rules

## Project
- No emojis in logs, comments, commit messages, or code unless explicitly requested.
- When showing shell commands to the user, use **Nushell** syntax.
  - If you need to show or reason about shell commands, load the `nushell` skill first.
  - Internal execution may use bash, but do not present bash commands to the user.
- Tests: prefer many small, distinct tests (e.g., Go `t.Run(...)` blocks) over giant table-driven structs.
- Comments: only for exported/public function docs or genuinely complex logic; no “organizational” comments.
- Always request escalaton when commands fail due to sandbox permissions. Never create temporary cache directories unless explicitely requested.
