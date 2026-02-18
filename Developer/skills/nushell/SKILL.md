---
name: nushell
description: Idiomatic Nushell usage for pipelines, scripts, modules, data transforms, HTTP, and type signatures. Use when the user asks for Nushell/nu commands or pipelines, or when writing Nushell code.
---

# Nushell

## Scope and Output
- Prefer idiomatic Nushell pipelines over external tools.
- Do only what the user asked; avoid extra features or extra commands.
- Keep responses concise and task-focused.
- If the user asks for a command, return a single Nushell command by default.
- When multiple approaches exist, present one default and add one alternative only if it materially changes the outcome.
- If requirements are ambiguous, ask up to 3 clarifying questions or state assumptions explicitly.

## Rules
- Treat pipeline input (`$in`) as data, not a positional parameter; declare input and output types for public commands.
- Use row conditions only for simple comparisons; use closures for complex predicates.
- Use `describe` to confirm shapes when unsure.
- Handle nulls explicitly with `default`, `is-empty`, `is-not-empty`, or `if`.
- Use `try`/`catch` when commands can fail; return a clear error or fallback.
- Do not assume external tools are installed; state requirements or provide a Nushell-native fallback.
- Prefix external tools with `^` and explain why they are required.

# Built-ins First
- HTTP: use `http get|post|put|patch|delete` instead of `curl`.
- Files: use `open`, `save`, `ls`, `rm`, `mv`, `cp`, `glob`.
- Structured data: use `from json|yaml|toml` and `to json|yaml|toml` plus `get`, `select`, `where`, `update`, `merge`.
- Strings: use `str` subcommands and `parse` before `sed`/`awk`.

## Gotchas
- Wrap multiline commands in `()` or keep them on one line to avoid argument splitting.
- Replace `let-env` with `$env.VAR = "value"` or `with-env`.
- Serialize record bodies with `to json` before `http post|put|patch` (these accept string/binary).

## Workflow
1. Identify expected input and output types.
2. Choose pipeline input vs parameters and define signatures.
3. Build in small steps and validate with `describe`.
4. Add null and error handling.
5. Provide the minimal final pipeline.

## References
- [references/pipeline-and-signatures.md](references/pipeline-and-signatures.md) - Pipeline input vs parameters, type signatures, row conditions, closures.
- [references/data-structures.md](references/data-structures.md) - List, record, and table patterns.
- [references/control-flow-and-errors.md](references/control-flow-and-errors.md) - Conditionals, null safety, and error handling.
- [references/iteration-and-streaming.md](references/iteration-and-streaming.md) - each/reduce/for/par-each, streaming, flattening.
- [references/strings-and-files.md](references/strings-and-files.md) - Strings, regex, and glob patterns.
- [references/modules-and-imports.md](references/modules-and-imports.md) - Modules and imports.
- [references/pitfalls.md](references/pitfalls.md) - Common mistakes and safer alternatives.
- [references/debugging.md](references/debugging.md) - Inspecting values and timing.
- [references/best-practices.md](references/best-practices.md) - General guidelines and external command usage.
- [references/advanced-patterns.md](references/advanced-patterns.md) - Performance and advanced techniques.
- [references/type-system.md](references/type-system.md) - Detailed type system reference.
- [references/resources.md](references/resources.md) - External documentation.
