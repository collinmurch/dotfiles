# Best Practices

- Use explicit type signatures for exported commands to catch errors early.
- Prefer pipelines to keep transformations composable.
- Add comments only for public commands or genuinely complex logic.
- Export selectively to avoid polluting namespaces.
- Use `default` for null handling and avoid mixed output types.
- Validate inputs and ranges at the start of commands.
- Return consistent output shapes across all paths.
- Use modules to group related commands.
- Build pipelines incrementally and inspect intermediate shapes.
- Prefix external commands with `^`; Nushell commands take precedence.
- Use external tools when they are materially faster (for example `rg` and `jq`).
- Use `complete` for external commands when you need exit codes and stderr.
