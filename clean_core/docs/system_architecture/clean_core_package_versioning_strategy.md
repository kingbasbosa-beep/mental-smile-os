# clean_core Package Versioning Strategy

## Versioning Posture

The package should begin as internal and pre-release.

Recommended early version shape:

- `0.1.0` for first private package identity
- pre-`1.0.0` until public API stability is proven

## Semantic Versioning Rules

Patch changes:

- documentation corrections
- non-breaking contract comments
- additive private/internal changes

Minor changes:

- additive public contracts
- new enums when backwards compatible
- new adapter contract surfaces

Major changes:

- breaking public contract changes
- renamed exported types
- changed fail-closed semantics
- changed authority or backend-governance expectations

## Hidden Contract Versioning

Hidden contracts should not be treated as stable API.

Any future promotion to public API requires:

- semantic review
- migration notes
- authority review
- fail-closed review

## Deprecation Strategy

Deprecation should be explicit and slow for public contracts. Runtime/provider-facing changes require extra review even if technically non-breaking.

## Versioning Verdict

The package should remain pre-`1.0.0` until adapter boundaries, host reconnect, and public contract stability are verified.
