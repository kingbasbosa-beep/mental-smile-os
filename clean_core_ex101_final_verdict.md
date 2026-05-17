# EX-101 Final Verdict

## Final Verdict

Queue and boundary exposure is blocked in current form.

`EscalationQueue.accepts` is routing, policy, and orchestration logic, not
metadata. It must not be exported as a package-safe admission rule.

`EscalationBoundaryMarker` is blocked in current form because its flags imply
backend enforcement, client write authority, and emergency capability.

## Required Doctrine

- Package may describe facts only.
- Host/backend decides routing.
- Host/backend decides enforcement.
- Host/backend decides emergency handling.
- Host/backend decides provider causality.
- Host/backend decides moderation ownership.
- Host/backend decides review and resolution ownership.
- Host/backend decides outcome writes.

## Specific Conclusions

- `backendGoverned` is a backend-only contract.
- `clientOutcomeWritesAllowed` is host/backend-only.
- `emergencyGuarantee` must not become a package-facing promise.
- `providerFailure` is passive metadata only if detoxed.
- `fallbackLoop` is passive metadata only if detoxed.
- Queue concepts require redesign before any package exposure.
- Boundary concepts require decomposition before any package exposure.
- Firestore mappers and write semantics remain host-only.

## Recommended EX-102 Phase

EX-102 should be a redesign-only doctrine phase:

- Define detoxed passive metadata vocabulary.
- Separate labels from enforcement contracts.
- Split boundary markers into passive package labels and backend-only policies.
- Prohibit package-facing queue admission predicates.
- Prohibit emergency guarantees in package APIs.
- Define host/backend ownership rules for routing, review, resolution, and
  outcome writes.
