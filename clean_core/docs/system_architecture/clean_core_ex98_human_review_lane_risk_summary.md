# EX-98 Human Review Lane Risk Summary

## Major Risks Encountered

- Firestore coupling in record models.
- Authority leakage from assignment, review, resolution, and request naming.
- Workflow progression implications from `EscalationState`.
- Routing and scheduling implications from level and priority.
- Provider/runtime causality implications from `providerFailure` and fallback labels.
- Access-control implications from visibility labels.
- Boundary marker semantics implying backend governance, client write policy, and emergency guarantees.
- Queue acceptance logic tempting package exposure.

## Risk Responses

- Used additive splits instead of moving host files.
- Kept compatibility files in place.
- Kept Firestore mappers host-side.
- Added explicit metadata-only caveats to package contracts.
- Excluded queue and boundary concepts from package exposure.
- Preserved explicit file-by-file exports.
- Preserved local rollback scope.

## Remaining Blocked Concepts

- `EscalationBoundaryMarker`
- `EscalationQueue`
- queue acceptance/routing
- backend governance flags
- client outcome write policy
- emergency guarantee semantics
- any future runtime/provider adapter behavior

## Risk Verdict

Current package surface is stable under the additive-split doctrine. Blocked concepts require separate governance before exposure.
