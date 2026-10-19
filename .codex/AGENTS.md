# Rules

## Projects
- No emojis in logs, comments, commit messages, or code unless explicitly requested
- Comments: only for exported/public function docs or genuinely complex logic; no “organizational” comments

## Process
- Always run `make` commands as their own line; combining with other commands with `&&` or `;` will cause execution inside the sandbox.
- When commands fail due to sandbox permissions, either request escalation or pause there
- Always stop for the user to commit and push code; rebasing is fine when asked though
- Always run `make` and `docker` commands alone; no piping or `&&` chaining as either of those will cause sandbox restrictions to be triggered 
