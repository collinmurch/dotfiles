---
name: nushell
description: Provides essential patterns, idioms, and gotchas for Nushell code. Triggers when writing Nushell scripts, functions, modules, pipelines, or working with Nushell's type system and data structures. Complements plugin-development knowledge with practical usage patterns.
---

# Nushell

## Focus
- Write idiomatic pipelines over structured data.
- Declare command input and output types explicitly for public commands.
- Handle nullability and errors explicitly.
- Prefer Nushell built-ins; use external tools only when they are clearly faster or required.

## Workflow
1. Identify the input type and expected output type.
2. Choose pipeline input vs parameters intentionally.
3. Build the pipeline in small steps and validate intermediate output types.
4. Add null handling and error paths before finalizing output shape.

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
