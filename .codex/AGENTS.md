# Rules

## Projects
- No emojis in logs, comments, commit messages, or code unless explicitly requested.
- After every comment you write, ask yourself, "Is this information the next agent would spend multiple calls trying to understand?". If the answer isn't clearly yes, the comment is noise - delete it.

## Process
- When commands fail due to sandbox permissions, either request escalation or pause there.
- Always stop for the user to commit and push code; rebasing is fine when asked though.
- Always run `make` and `docker` commands alone; no piping or `&&` chaining as either of those will cause sandbox restrictions to be triggered.
