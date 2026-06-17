# Archive Card Pack V1

Result: ARCHIVE_CARD_PACK_CREATED

Mode: Cards only. No files deleted, moved, deployed, pushed, committed, or renamed.

## Archive Card Format

Each archive card uses:

- Archive ID
- Title
- Era
- Purpose
- Why It Existed
- What Happened
- Why It Ended
- Replacement
- Educational Signals
- Lessons Learned
- Historical Importance
- Reuse Value
- Status

---

## ARCHIVE-ERA-001

Archive ID: ARCHIVE-ERA-001

Title: Admin Era

Era: Admin Era

Purpose: Provide broad operational control while the early project needed centralized management.

Why It Existed: The project originally needed a simple way to grant elevated control over data, surfaces, review, and operational flows.

What Happened: Admin authority language and concepts appeared across historical docs, rules, and governance references. It later conflicted with the Owner-governed OS model.

Why It Ended: Admin authority was too broad, too ambiguous, and incompatible with Admin Zero and Owner Authority.

Replacement: Owner Authority, Monitoring Separation, explicit role-gated routes, and no god-mode admin.

Educational Signals:
- `admin`
- `admins`
- admin collection fallback
- super admin
- wildcard authority
- hidden operator roles

Lessons Learned:
- Admin is not a harmless word.
- Authority vocabulary becomes security architecture.
- Elevated access must be auditable, bounded, and named correctly.

Historical Importance: Shows why Mental Smile OS rejected general admin power.

Reuse Value: Useful as a warning model for future authority design.

Status: ARCHIVED_AS_LEGACY_AUTHORITY

---

## ARCHIVE-ERA-002

Archive ID: ARCHIVE-ERA-002

Title: Booking Era

Era: Booking / Marketplace Era

Purpose: Support older assumptions around appointments, sessions, payment, and service transactions.

Why It Existed: Earlier product thinking treated Mental Smile as closer to a service marketplace or operational booking platform.

What Happened: Booking, payment, session, and proof-of-payment language became residue in docs, rules planning, and forbidden component registries.

Why It Ended: Generation 1 became a discovery and support ecosystem, not a booking/payment/session authority.

Replacement: Discovery pathways, support signals, provider visibility, center visibility, and non-transactional contact paths.

Educational Signals:
- booking
- booking_requests
- session
- sessions
- payment
- payments
- proof_of_payment
- marketplace promises

Lessons Learned:
- Business model residue must be removed from active product language.
- Discovery and transaction authority cannot be mixed accidentally.

Historical Importance: Explains why Generation 1 repeatedly states what it is not.

Reuse Value: Useful when evaluating future commercial features.

Status: ARCHIVED_AS_FORBIDDEN_GENERATION_1_SCOPE

---

## ARCHIVE-ERA-003

Archive ID: ARCHIVE-ERA-003

Title: Clean Core Era

Era: Clean Core / Source Repository Era

Purpose: Preserve reusable source material, legacy logic, and earlier runtime work.

Why It Existed: `mental_smile_clean_core` and the clean/core source repository contained useful old implementation material.

What Happened: The source repository became both source evidence and an active dependency risk. It required usage audits and extraction waves.

Why It Ended: Mental Smile OS needed independent runtime ownership and could not remain dependent on clean/core identity.

Replacement: Mental Smile OS runtime modules, source candidate cards, extraction audits, and source evidence preservation.

Educational Signals:
- `mental_smile_clean_core`
- `clean2`
- `clean core`
- source package dependency
- test imports from source core

Lessons Learned:
- A source mine is not a runtime dependency.
- Extraction requires symbol-level proof.
- Source repositories can be preserved without being active.

Historical Importance: Records the bridge from old runtime material to OS-owned runtime.

Reuse Value: High as extraction precedent.

Status: ARCHIVED_AS_SOURCE_REPOSITORY_ERA

---

## ARCHIVE-ERA-004

Archive ID: ARCHIVE-ERA-004

Title: Constitutional Federation Era

Era: Constitution Era / Federation Formation

Purpose: Define Mental Smile OS as a federation of zones, gateways, cards, registries, routes, and owner-governed authority.

Why It Existed: The project needed a clean replacement for mixed app architecture and legacy operational sprawl.

What Happened: Generation 1 produced city, zone, gateway, authority, card, signal, route, and operating models. The constitution was later frozen.

Why It Ended: The constitutional layer reached completion and was frozen to prevent endless architecture expansion.

Replacement: Execution-only era: Firebase, YAML, runtime, Android, web, GitHub, validation, activation, and deployment.

Educational Signals:
- Continuous doctrine expansion
- new architecture after freeze
- registry growth without runtime
- cards treated as implementation

Lessons Learned:
- Architecture must end so execution can start.
- Federation explains operation, but runtime must prove it.

Historical Importance: Foundational identity of Mental Smile OS Generation 1.

Reuse Value: Very high for future Generation 2 authorization.

Status: FROZEN_FOUNDATIONAL_ARCHIVE

---

## ARCHIVE-ERA-005

Archive ID: ARCHIVE-ERA-005

Title: Signal Federation Era

Era: Signal Federation / Gateway Doctrine

Purpose: Define how zones communicate without direct cross-zone mutation.

Why It Existed: The OS needed safe movement between app, library, commercial, owner, monitoring, strategic, and archive zones.

What Happened: Signal packages, zone gateways, signal pipes, emergency buffers, continuity capsules, and ownership doctrine were defined.

Why It Ended: The doctrine became complete enough for execution planning; the remaining work is runtime validation.

Replacement: Signal runtime implementation and validation sequences.

Educational Signals:
- direct zone-to-zone routing
- tool-to-provider direct access
- content-to-client mutation
- unregistered signal family
- gateway bypass

Lessons Learned:
- Signals belong to source zones.
- Forwarding does not transfer ownership.
- Gateway doctrine must be validated in runtime.

Historical Importance: Defines the OS nervous system.

Reuse Value: High for every future zone and gateway.

Status: ARCHIVED_AS_RUNTIME_DOCTRINE_READY_FOR_VALIDATION

---

## ARCHIVE-ERA-006

Archive ID: ARCHIVE-ERA-006

Title: Identity Purification Era

Era: Identity Cleanup / OS-Only Purification

Purpose: Remove active misleading identity residue and align runtime-visible identity with Mental Smile OS.

Why It Existed: Flutter template names, Mental Key labels, clean/core references, namespace residue, and legacy host names survived into active work.

What Happened: Dart package identity was migrated to `mental_smile_os`; visible Mental Key labels were removed; Android namespace migrated to `com.mentalsmile.os`; applicationId was preserved by design.

Why It Ended: The first safe identity cleanup waves completed, but strict OS-only certification still requires final technical identity decisions.

Replacement: OS identity matrix, staged migrations, rollback notes, and Owner-gated applicationId/Firebase decisions.

Educational Signals:
- `flutterprojects`
- `Mental Key`
- `mentalkey`
- `com.mentalkey.app.flutterprojects`
- old visible labels
- package/import mismatch

Lessons Learned:
- Identity is layered.
- Package name, namespace, applicationId, Firebase project, repository name, and public brand must not be changed blindly together.

Historical Importance: Shows how the OS separated public identity from legacy technical identity.

Reuse Value: High for any future technical rename.

Status: PARTIALLY_ARCHIVED_WITH_ACTIVE_CERTIFICATION_BLOCKERS

---

## ARCHIVE-ERA-007

Archive ID: ARCHIVE-ERA-007

Title: Admin Zero Era

Era: Admin Zero / Firebase Authority Cleanup

Purpose: Remove legacy admin authority from active Firebase rules and prepare owner-compatible security posture.

Why It Existed: Admin residue had to be actively removed and audited before release candidate validation.

What Happened: Storage admin authority was replaced with owner authority; Firestore authority was audited; Firebase warning cleanup reviewed monitoring/helper duplication and fallback risks.

Why It Ended: Admin Zero became the active authority doctrine and release gate requirement.

Replacement: Owner claim authority, monitoring separation, explicit Firebase activation sequences, and forbidden Firebase component registry.

Educational Signals:
- `isAdmin()`
- admins collection fallback
- `role == admin`
- `super admin`
- wildcard rule access
- unbounded elevated writes

Lessons Learned:
- Security cleanup must be done with narrow patches.
- Firestore and Storage rules need separate audits.
- No deploy should happen during authority cleanup.

Historical Importance: Defines the security break from old admin models.

Reuse Value: Very high for Firebase activation.

Status: ACTIVE_DOCTRINE_WITH_ARCHIVED_CLEANUP_EVIDENCE

---

## ARCHIVE-ERA-008

Archive ID: ARCHIVE-ERA-008

Title: Generation 1 Release Candidate Era

Era: Release Candidate / First Release Gate

Purpose: Consolidate identity, Firebase, runtime, GitHub, Android, web, docs, and release governance into a release candidate.

Why It Existed: The project needed a stable pre-release state after constitution freeze and execution waves.

What Happened: Release candidate packages, governance gates, public showcase, public landing, runtime audits, archive audits, and human journey audits were created.

Why It Ended: It has not fully ended; it is the current controlled state before final Owner commit/tag/deploy decisions.

Replacement: First official commit, tag, staged activation, and production release only after Owner confirmation.

Educational Signals:
- untracked release artifacts
- `.firebase/` in working tree
- commit scope undecided
- tag undecided
- public story stronger than runtime journey
- Tool Center not release-ready

Lessons Learned:
- Release candidate is not production.
- Build success does not authorize release.
- Owner decisions remain part of release governance.

Historical Importance: Marks the first OS release candidate state.

Reuse Value: High as future release gate template.

Status: CURRENT_ACTIVE_RELEASE_CANDIDATE_ARCHIVE_CARD
