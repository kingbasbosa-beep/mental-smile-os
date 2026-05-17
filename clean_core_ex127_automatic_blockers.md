# EX-127 Automatic Blockers

## Scope

Docs/rubric only. Any blocker in this document overrides the numeric score and
forces the proposal to `BLOCKED` unless a later doctrine wave explicitly
reopens the concept.

## Semantic Blockers

Automatically block if the candidate:

- implies execution
- implies routing or admission
- implies backend enforcement
- implies emergency handling
- implies provider causality
- implies provider trust proof
- implies adapter execution proof
- implies runtime execution guarantee
- implies retry or fallback recovery
- implies telemetry/privacy proof
- implies audit verification proof
- implies policy compliance proof
- implies moderation/safety ownership
- implies client outcome write authority
- implies operational/admin authority

## Naming Blockers

Automatically block if the name creates a fake guarantee through words or
patterns such as:

- `accepts`
- `approved`
- `assigned`
- `routed`
- `enforced`
- `verified`
- `guaranteed`
- `recovered`
- `fallback`
- `runtime`
- `provider`
- `emergency`
- `admin`
- `permission`
- `owner`
- `capability`
- `available`

These words are not always forbidden in all contexts, but any authoritative or
operational reading blocks package exposure until doctrine review.

## Package Surface Blockers

Automatically block package exposure if the candidate:

- is not passive
- is not pure Dart
- requires package-owned mapper behavior
- requires Firestore/Firebase/Timestamp/FieldValue in package contracts
- requires wildcard export
- requires directory export
- exposes internal holdback vocabulary without doctrine reopening
- breaks compatibility without an explicit plan
- lacks rollback-local containment
- lacks public export justification

## Mapper Blockers

Automatically block mapper approval if the candidate:

- creates a package mapper
- moves host Firestore ownership into `mental_smile_clean_core`
- exposes mapper APIs through the package barrel
- treats persistence success as audit verification
- treats persistence success as backend enforcement proof
- requires consumer migration before mapper ownership is approved

## Consumer Migration Blockers

Automatically block consumer migration if the proposal:

- lacks explicit migration approval
- does not name exact consumers/imports
- reconnects consumers to unexported internals
- migrates imports before export approval
- activates runtime/provider/Firebase/adapters
- adopts queue/boundary holdbacks
- adopts runtime/provider diagnostic holdbacks
- moves mapper ownership by usage

## Runtime/Provider Blockers

Automatically block if the proposal exposes:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`
- runtime/provider public mappers
- runtime/provider package contracts

## Queue/Boundary Blockers

Automatically block if the proposal exposes:

- `EscalationQueue.accepts`
- routing/admission guarantees
- team or moderation ownership guarantees
- boundary enforcement claims
- emergency guarantees
- backend enforcement claims
- client outcome write permissions
- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`

## Automatic Blocker Verdict

Pass. Automatic blockers remain fail-closed and override scoring.
