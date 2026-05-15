# Clean Core Generated File Boundary Plan

Draft generated-file boundary plan. No generated files were created, moved, or exported.

## Generated File Ownership

Generated files remain host-app owned unless a future package build strategy explicitly changes this.

Host app owns:

- Generated localization.
- Firebase options/generated config.
- Plugin registrants.
- Generated routing files.
- Generated asset references.
- Platform-generated configuration.

## Boundary Rules

- No generated config exports.
- No generated Firebase exports.
- No generated router exports.
- No generated localization exports.
- No generated plugin exports.
- clean_core public API must remain generation-independent.

## Contamination Risks

Generated-file coupling can enter through:

- Imports of generated l10n classes.
- Firebase options imports.
- Generated route imports.
- Generated asset classes.
- Plugin registrant assumptions.
- Build runner outputs treated as stable API.

## Prevention Rules

- Use contract types instead of generated implementation types.
- Keep generated files app-owned.
- Add adapters only after generation ownership is defined.
- Avoid package public APIs that depend on generated output.

## Explicit Non-Action

No generated-file boundary was implemented in code.
