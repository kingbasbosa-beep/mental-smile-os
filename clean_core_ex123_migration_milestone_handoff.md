# EX-123 Clean Core Migration Milestone Handoff

## Scope

Docs/handoff only. This document prepares a new chat/session to continue the
Clean Core migration safely. It does not modify source/runtime files, create
package contracts, create mappers, change imports/exports, run pub
get/analyze, reconnect consumers, or activate runtime/provider/Firebase/adapters.

## Current Workspace And Status

- Workspace: `C:\mental_smile_workspace\app\mental-smile-app-clean2`
- Branch at inspection: `main`
- `git status --short` at inspection before EX-123 docs: clean
- Package barrel inspected:
  `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

EX-123 itself adds documentation only.

## Completed Wave Timeline

The completed migration work now has four major lanes:

- Audit extraction/recovery wave
- Human Review extraction wave
- Queue/Boundary governance wave
- Runtime/Provider doctrine wave

The first two lanes established extracted package contracts plus host-side
Firestore mapper containment. The latter two lanes established doctrine for
dangerous semantics that must not become package-facing execution,
orchestration, emergency, backend enforcement, or provider causality promises.

## Audit Lane Achievements

The package now exposes passive audit vocabulary and records under
`mental_smile_clean_core/lib/src/audit/`, including actor type, event, event
type, hash placeholder, processing context, redaction, reference, retention
policy, severity, snapshot, trace, and visibility scope.

Host-side Firestore mapper logic remains in:

- `clean_core/lib/core/audit/firestore/audit_event_firestore_mapper.dart`
- `clean_core/lib/core/audit/firestore/audit_snapshot_firestore_mapper.dart`
- `clean_core/lib/core/audit/firestore/audit_trace_firestore_mapper.dart`

The package audit surface remains pure Dart. Firebase/Firestore mapping remains
host-owned.

## Human Review Lane Achievements

The package now exposes human-review request/review/resolution vocabulary under
`mental_smile_clean_core/lib/src/human_review/`, including assignment, audit
link, escalation level, policy reference, reason, request, resolution, review,
state, review priority, visibility scope, and the narrow passive review signal.

Host-side Firestore mapper logic remains in:

- `clean_core/lib/core/human_review/firestore/escalation_assignment_firestore_mapper.dart`
- `clean_core/lib/core/human_review/firestore/escalation_request_firestore_mapper.dart`
- `clean_core/lib/core/human_review/firestore/escalation_resolution_firestore_mapper.dart`
- `clean_core/lib/core/human_review/firestore/escalation_review_firestore_mapper.dart`

Queue admission, boundary governance, emergency handling, backend write
authority, and escalation ownership were deliberately not migrated as package
execution semantics.

## Queue/Boundary Governance Wave

EX-100 through EX-112 established that queue and boundary semantics are
dangerous because they can imply routing, admission, team ownership, backend
enforcement, emergency handling, provider causality, fallback recovery, or
client write authority.

Key outcomes:

- `EscalationQueue.accepts` is routing/policy/orchestration logic, not metadata.
- Queue exposure is blocked in its current form.
- Boundary marker exposure is blocked in its current form.
- `backendGoverned` is a backend-only contract.
- `clientOutcomeWritesAllowed` is host/backend-only.
- `emergencyGuarantee` must not become a package-facing promise.
- `providerFailure` and `fallbackLoop` are passive only if detoxed and remain
  held back from public export.
- The package may describe facts only; host/backend decides routing,
  enforcement, emergency handling, provider causality, and outcome writes.

The narrow public result was `PassiveReviewSignal`, not queue or boundary
execution exposure.

## Runtime/Provider Doctrine Wave

EX-113 through EX-122 established that runtime/provider concepts are uniquely
dangerous because they sit next to AI execution, provider trust, adapter
bridges, guard decisions, fallback behavior, retry/recovery, telemetry/privacy,
backend enforcement, moderation/safety ownership, and emergency handling.

Key outcomes:

- Runtime/provider diagnostics remain held back.
- Runtime/provider orchestration remains host/backend-owned.
- No new runtime/provider package contracts were created.
- No runtime/provider mappers were created.
- No runtime/provider exports were added.
- Existing safe overlap remains only reference presence via
  `PassiveReviewSignal.auditReferencePresent` and
  `PassiveReviewSignal.policyReferencePresent`.

## Current Package Surface

The package barrel currently exports surfaces for:

- audit
- backend boundaries
- governance capability/compliance/federation/kernel/lifecycle
- human review
- policy runtime
- safety decision
- trusted backend
- trusted pipeline

The current public human-review/audit surface is documented in
`clean_core_ex123_current_package_surface.md`.

## Host-Side Mapper Boundary

All Firestore/Firebase mapping remains host-side. Do not move mapper behavior
into the package without a new explicit wave.

Current host-side mapper groups:

- Audit Firestore mappers under `clean_core/lib/core/audit/firestore/`
- Human Review Firestore mappers under
  `clean_core/lib/core/human_review/firestore/`

## Preserved Compatibility Files

The host still contains compatibility and legacy-read/write controls in feature
areas, including clinician and booking pages. These are not part of the package
surface and should not be cleaned up opportunistically during governance work.

Known examples from inspection:

- `clean_core/lib/features/clinician/presentation/pages/clinician_sessions_page.dart`
- `clean_core/lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `clean_core/lib/features/booking/presentation/pages/booking_request_page.dart`
- `clean_core/lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `clean_core/lib/features/centers/data/models/center_model.dart`

## Blocked Concepts

Blocked concepts include:

- `EscalationQueue.accepts`
- routing/admission guarantees
- queue ownership guarantees
- moderation/safety ownership guarantees
- emergency guarantees
- backend enforcement claims
- client outcome write permissions
- provider causality claims
- provider trust proof
- adapter execution proof
- runtime execution guarantees
- retry/recovery guarantees
- fallback recovery claims
- telemetry/privacy proof
- governance/write mappers
- runtime/provider public mappers
- runtime/provider package contracts

## Holdbacks

Queue/boundary holdbacks:

- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`
- `providerIssueReported`
- `fallbackLoopObserved`

Runtime/provider holdbacks:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

## Doctrine Rules Now Established

- Pure Dart is not automatically package-safe.
- Package APIs may describe passive facts only.
- Host/backend decides routing, enforcement, write authority, emergency
  handling, provider causality, runtime execution, fallback, retry, and
  recovery.
- Public labels must not become commands, permissions, workflow states,
  enforcement signals, audit verification, policy compliance proof, backend
  proof, or emergency handling promises.
- Mappers stay host-side unless a new wave explicitly approves otherwise.

## Rollback Strategy

Rollback remains local by wave:

- Audit/human-review package contracts can be rolled back by removing their
  package exports and files, then restoring host imports if needed.
- Firestore mapper rollback remains host-local.
- Passive vocabulary rollback remains local to passive files and the single
  `PassiveReviewSignal` export.
- Runtime/provider doctrine introduced no runtime/provider package surface, so
  its rollback is documentary.

## Known Analyzer And Package-Context Lessons

- Do not run `pub get` or `analyze` unless explicitly requested.
- Package-safe means semantically safe, not merely import-clean.
- Firestore, Firebase, `Timestamp`, and `FieldValue` belong outside package
  contracts.
- Do not introduce `toMap`/`fromMap` persistence APIs into passive package
  vocabulary unless a mapper wave explicitly authorizes it.
- Adding a barrel export is public API exposure and must be treated as a
  governance event.

## What Not To Do Next

Do not:

- export queue or boundary marker files
- expose `EscalationQueue.accepts`
- introduce runtime/provider diagnostic contracts
- create runtime/provider mappers
- reconnect consumers casually
- migrate imports without an approved migration wave
- activate providers, adapters, Firebase, or runtime execution
- turn passive labels into routing, ownership, enforcement, emergency, or
  recovery signals

## Recommended Next Wave Options

Recommended safe options:

- EX-124 documentation index and doctrine registry
- Audit package surface verification and consumer-readiness review
- Human Review package surface verification and consumer-readiness review
- Host-side mapper containment verification
- Runtime/provider host/backend orchestration isolation mapping

Avoid execution waves until the next session explicitly selects one and repeats
the strict scope boundaries.
