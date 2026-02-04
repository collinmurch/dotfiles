# Rules

## Projects
- No emojis in logs, comments, commit messages, or code unless explicitly requested.
- Tests: prefer many small, distinct tests (e.g., Go `t.Run(...)` blocks) over giant table-driven structs.
- Comments: only for exported/public function docs or genuinely complex logic; no “organizational” comments.

## Process
- When showing shell commands to the user, use **Nushell** syntax.
  - If you need to show or reason about shell commands, load the `nushell` skill first.
  - Internal execution may use bash, but do not present bash commands to the user.
- Always request escalaton when commands fail due to sandbox permissions; no temporary cache directories unless explicitely requested.
- Always use `python3` as the Python interpreter binary unless directed otherwise.