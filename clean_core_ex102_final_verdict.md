# EX-102 Final Verdict

## Final Verdict

Future queue/boundary package exposure is redesign-first and metadata-only.

Current queue and boundary forms remain blocked from package exposure.

## Doctrine Decisions

- Passive package-safe queue labels may exist after detox.
- Queue admission predicates are prohibited.
- `EscalationQueue.accepts` must not become package-facing API.
- Passive boundary labels may exist after decomposition.
- `backendGoverned` is backend-only policy/contract.
- `clientOutcomeWritesAllowed` is host/backend-only write policy.
- `emergencyGuarantee` is prohibited as a package-facing promise.
- `providerFailure` requires provider/runtime causality detox.
- `fallbackLoop` requires orchestration/runtime detox.
- Package facts must remain separate from host/backend enforcement.

## Blocked Concepts

- queue admission
- queue acceptance
- routing predicates
- assignment authority
- review ownership
- resolution ownership
- outcome write authority
- emergency guarantees
- backend governance self-attestation
- provider failure causality
- fallback-loop recovery claims
- Firestore/package mapper exposure

## Future Package-Safe Candidates

Potential candidates after redesign:

- detoxed review reason labels
- detoxed review priority labels
- passive lifecycle labels
- passive visibility labels
- non-authoritative audit references
- non-authoritative policy references
- externally asserted governance labels
- negative emergency capability labels
- detoxed provider issue labels
- detoxed fallback observation labels

## Required Boundary

The package may describe facts only. The host/backend decides routing,
enforcement, emergency handling, provider causality, moderation ownership,
review/resolution ownership, and outcome writes.

## Recommended Next Phase

EX-103 should define a no-code candidate vocabulary review: names, allowed
meanings, prohibited meanings, and migration blockers for any future passive
metadata surface.
