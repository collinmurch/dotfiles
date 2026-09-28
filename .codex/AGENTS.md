# Rules

## Projects
- No emojis in logs, comments, commit messages, or code unless explicitly requested
- Tests: prefer many small, distinct tests (e.g., Go `t.Run(...)` blocks) over giant table-driven structs
- Comments: only for exported/public function docs or genuinely complex logic; no “organizational” comments

## Process
- Always run `make` commands as their own line; combining with other commands with `&&` or `;` will cause execution inside the sandbox.
- When commands fail due to sandbox permissions, either request escalation or pause there
- Always stop for the user to commit and push code; rebasing is fine when asked though
- When communicating to the user or writing in text-based files, write in ASD-STE100 (a.k.a. Simplified Technical English); additionally follow the principles of quality writing:
  1. Simplicity
  2. Brevity
  3. Clarity
  4. Humanity
