# clean_core Runtime Marker Export Safety

Phase: EX-32 - Runtime Marker Isolation Review

## Export Principle

Runtime-related files must not be exported merely because they are pure Dart.

Export safety requires:

- declarative-only semantics
- no runtime activation implication
- no provider execution implication
- no backend authority implication
- no telemetry runtime implication
- no broad barrel exposure
- explicit file-by-file approval

## Possible Future Export Candidates

The following categories may be future candidates only after semantic review:

- simple runtime marker labels with disabled/fallback-only defaults
- simple runtime state enum vocabulary
- simple audit/runtime references
- simple visibility scopes
- simple fallback labels

These must be documented as labels only.

## Hidden or Internal-Only by Default

The following categories should remain hidden/internal by default:

- guards
- policies
- locks
- resolvers
- profiles with signed authority placeholders
- boundary evaluators
- runtime execution state surfaces that imply activation
- AI runtime state labels
- observability evaluation surfaces
- escalation boundary markers

## Adapter-Only Surfaces

The following surfaces should be treated as adapter-boundary candidates rather than public package authority:

- observability bridge contracts
- telemetry labeling contracts
- backend-governance verification references
- safety observability contracts
- provider/runtime labeling contracts

## Public Barrel Rule

If any runtime marker is ever exported, it must be exported explicitly:

- no wildcard exports
- no directory exports
- no guard/policy/profile exports without approval
- no runtime activation surfaces
- no hidden authority surfaces

## Export Verdict

Runtime marker and observability surfaces are not approved for broad export. File-by-file review is required before any future barrel change.

