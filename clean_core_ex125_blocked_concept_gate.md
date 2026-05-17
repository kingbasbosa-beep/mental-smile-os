# EX-125 Blocked Concept Gate

## Scope

Docs/review only. This gate covers concepts that remain blocked or held back
after EX-99 through EX-124.

## Default Result

Blocked concepts fail closed. A future wave must start with doctrine/review,
not implementation, and must prove that the concept cannot be mistaken for
execution, authority, ownership, enforcement, emergency handling, provider
causality, or recovery.

## Required Answers

- Is it passive? Required yes, but not sufficient.
- Is it pure Dart? Required yes for package exposure, but not sufficient.
- Does the name imply authority? Required no.
- Does it imply execution? Required no.
- Does it imply routing/admission? Required no.
- Does it imply backend enforcement? Required no.
- Does it imply emergency handling? Required no.
- Does it imply provider causality? Required no.
- Does it imply retry/fallback recovery? Required no.
- Does it require mapper ownership? Required no package mapper ownership.
- Is rollback local? Required yes.
- Is compatibility preserved? Required yes.
- Is public export justified? Required special approval.
- Is consumer migration explicitly approved? Required separate approval.

## Queue/Boundary Exposure Gate

Default result: blocked.

Blocked or high-risk concepts include:

- `EscalationQueue.accepts`
- routing/admission guarantees
- team or moderation ownership guarantees
- emergency guarantees
- backend enforcement claims
- client outcome write permissions
- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`

Approval requirement: a future wave must prove the proposal is passive
metadata only and cannot be read as admission, routing, boundary enforcement,
reviewer ownership, emergency response, backend enforcement, or write
authority.

## Runtime/Provider Diagnostic Exposure Gate

Default result: blocked.

Blocked or held-back concepts include:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`
- provider causality claims
- provider trust proof
- adapter execution proof
- runtime execution guarantees
- retry/recovery guarantees
- fallback recovery claims
- telemetry/privacy proof
- backend enforcement proof
- runtime/provider public mappers
- runtime/provider package contracts

Approval requirement: a future wave must prove the proposal cannot be read as
provider causality, trust proof, adapter execution, runtime execution,
fallback/retry recovery, backend availability, telemetry/privacy proof,
moderation ownership, emergency handling, or enforcement proof.

## Passive Vocabulary Exposure Gate

Default result: blocked until the candidate passes special review.

Public passive vocabulary must:

- be narrow
- include caveats where misuse risk exists
- avoid operational names
- avoid workflow-state names
- avoid authority names
- avoid provider/runtime causality
- avoid fallback/recovery semantics
- remain rollback-local before export
- require explicit export approval
- require explicit consumer migration approval

## Firestore/Firebase-Related Code Gate

Default result: host-side only.

Blocked from package exposure by default:

- `cloud_firestore`
- `FirebaseFirestore`
- `Timestamp`
- `FieldValue`
- Firestore document snapshots
- collection/document write ownership
- persistence success proof
- audit verification proof through persistence

## AI/Safety-Related Label Gate

Default result: blocked until special review.

AI/safety labels must not imply:

- safety ownership
- moderation ownership
- backend enforcement
- emergency response
- provider selection or causality
- guard execution
- fallback recovery
- policy compliance proof
- guaranteed user outcome

## Operational/Admin Surface Change Gate

Default result: host-owned and blocked from package exposure.

Operational/admin proposals must not imply:

- permission grants
- staff/team ownership
- reviewer assignment
- routing authority
- backend write authority
- enforcement authority
- emergency handling
- runtime/provider operation

## Blocked Gate Verdict

Pass. EX-125 keeps blocked and held-back concepts fail-closed. No blocked
concept is reopened or implemented.
