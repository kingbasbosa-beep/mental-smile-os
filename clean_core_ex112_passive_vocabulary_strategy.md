# EX-112 Passive Vocabulary Strategy

## Passive Vocabulary Doctrine

Labels are facts, not powers.

Every public label must remain:

- inert
- descriptive
- caveated
- non-authoritative
- independent from mappers
- independent from runtime/provider/Firebase/adapters
- disconnected from consumers unless separately reviewed

## Approved Exported Low-Risk Labels

The exported `PassiveReviewSignal` surface contains:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

## Public Caveat Strategy

The public surface states that labels are not:

- commands
- permissions
- workflow states
- enforcement signals
- routing decisions
- admission decisions
- audit verification
- policy compliance proof
- emergency handling
- write authority

Consumer warning:

- do not route
- do not admit
- do not assign
- do not enforce
- do not verify backend governance
- do not guarantee emergency handling
- do not infer provider/runtime causality
- do not recover fallback loops
- do not grant outcome write permission

## Internal-Only Doctrine

Higher-risk labels remain internal until separate public doctrine exists.

Internal holdbacks:

- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`
- `providerIssueReported`
- `fallbackLoopObserved`

## Strategy Verdict

The strategy is narrow public vocabulary plus broad internal containment.
