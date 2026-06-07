# Mental Smile Federation
# Project Snapshot After Cleanup Waves

Date: 2026-06-07  
State name: Signal Federation Alpha / Post Cleanup Snapshot  
Purpose: capture the whole project picture after Booking, Session, and Payment cleanup waves.

---

## 1. Executive Picture

Mental Smile is no longer shaped as a booking platform at the primary architecture level.

The current project now has two visible layers:

1. Signal Federation Foundations
   - Signal runtime language
   - Signal aggregation
   - Residential monitoring
   - Commercial monitoring
   - Operational monitoring
   - Observatory language
   - Reports schema
   - Archive export
   - Identity
   - Localization
   - Guidance and accessibility
   - Tool meter
   - Public reputation
   - Owner governance
   - Launch/readiness/roadmap planning
   - Surface construction planning

2. Legacy Island Residue
   - `booking_requests` remains as historical compatibility.
   - `bookingRequests` is archive-dead/denied.
   - `sessionRatings` is read-only legacy.
   - Some provider/center/admin compatibility pages still read or update old booking documents.
   - Legacy language still appears in comments, boundaries, and a few compatibility surfaces.

Architectural verdict: the core has shifted to federation foundations, but final freeze still needs verification and legacy island tightening.

---

## 2. Current Doctrine

Mental Smile now owns:

- Signals
- Discovery
- Support
- Tools
- Observability
- Intelligence
- Public reputation
- Archive memory
- Owner sovereignty documents

Mental Smile must not own:

- Booking lifecycle
- Session lifecycle
- Payment lifecycle
- Payout lifecycle
- Provider assignment lifecycle
- Treatment lifecycle
- Client case ownership
- Operational god-mode authority

The system direction is:

```text
Signals
↓
Aggregates
↓
Monitoring
↓
Analysis
↓
Reports
↓
Archive / Owner Strategy
```

---

## 3. Built Federation Foundations

### Signal Runtime

Status: Built foundation.

Evidence:

- `lib/features/signals/domain/models/signal_package.dart`
- `lib/features/signals/domain/models/signal_aggregate.dart`
- `lib/features/signals/domain/factories/signal_package_factory.dart`
- `lib/features/signals/domain/emitters/noop_signal_emitter.dart`
- `lib/features/signals/domain/guards/forbidden_signal_source_guard.dart`
- `lib/features/signals/domain/validators/signal_package_validator.dart`

Current behavior:

- Signal language exists.
- No Firebase signal writes.
- No gateway runtime.
- No monitoring UI.

### Signal Aggregation

Status: Built foundation.

Evidence:

- `lib/features/signals/domain/aggregation/`
- `lib/features/signals/domain/models/signal_aggregate.dart`
- `lib/features/signals/domain/registries/`

Current behavior:

- Aggregation models and registry language exist.
- Counting layer exists conceptually.
- No production storage/analytics dashboard.

### Residential Monitoring

Status: Built foundation.

Evidence:

- `lib/features/monitoring/residential/aggregates/`
- `lib/features/monitoring/residential/models/residential_monitoring_snapshot.dart`
- `lib/features/monitoring/residential/routing/`
- `RESIDENTIAL_MONITORING_FOUNDATION.md`

Coverage:

- Goals
- Interests
- Accessibility
- Library
- Support
- Saved destinations
- Tools

### Commercial Monitoring

Status: Built foundation.

Evidence:

- `lib/features/monitoring/commercial/`
- `lib/features/monitoring/commercial/models/commercial_monitoring_snapshot.dart`
- `COMMERCIAL_INTELLIGENCE_FOUNDATION.md`

Coverage:

- Provider demand
- Center demand
- Tool demand/adoption
- External apps/knowledge
- Commercial service signals
- Demand/supply/gap/opportunity language

### Operational Monitoring

Status: Built foundation.

Evidence:

- `lib/features/monitoring/operational/`
- `OPERATIONAL_MONITORING_FOUNDATION.md`

Purpose:

- Operational visibility without user tracking.
- Forbidden references remain as protective boundaries.

### Observatory

Status: Built foundation.

Evidence:

- `lib/features/observatory/`
- `OPERATIONAL_OBSERVATORY_FOUNDATION.md`

Purpose:

- Shared operational observation language across monitoring, storage, archive, tool meter, and readiness.

### Analysis

Status: Built foundation.

Evidence:

- `lib/features/analysis/`

Purpose:

- Observation layer above monitoring feeds.
- No decision authority.
- No real AI integration.

### Reports

Status: Built foundation.

Evidence:

- `lib/features/reports/federation/`
- `FEDERATION_REPORT_SCHEMA_FOUNDATION.md`

Purpose:

- Schema, categories, and contracts only.
- No rendered dashboard/PDF/Excel runtime.

### Archive Export

Status: Built foundation.

Evidence:

- `lib/features/archive/export/`
- `ARCHIVE_EXPORT_FOUNDATION.md`

Notes:

- Archive packaging policy forbids booking/assignment sources.
- Payment/payout packaging terms were removed during R-2D.

### Identity

Status: Built foundation.

Evidence:

- `lib/features/identity/federation/`
- `FEDERATION_VISUAL_IDENTITY_FOUNDATION.md`

Coverage:

- Department identity
- Color tokens
- Report identity
- Archive identity
- Accessibility visual profile
- Department labels

### Localization

Status: Built foundation.

Evidence:

- `lib/features/localization/federation/`
- `FEDERATION_LOCALIZATION_FOUNDATION.md`

Coverage:

- AR/EN language foundation.
- Easy reading and accessibility language profiles exist as foundation.

### Guidance and Accessibility

Status: Built foundation.

Evidence:

- `lib/features/guidance/federation/`
- `UNIVERSAL_GUIDANCE_ACCESSIBILITY_FOUNDATION.md`

Coverage:

- Universal guidance contracts
- Info card integration
- Easy reading / audio / screen reader foundation

### Public Reputation

Status: Built foundation.

Evidence:

- `lib/features/reputation/public/`
- `PUBLIC_REPUTATION_FOUNDATION.md`

Doctrine:

- Public reputation is not session rating.
- Comments are collapsed evidence, not page center.

### Tool Meter

Status: Built foundation.

Evidence:

- `lib/features/tool_meter/federation/`
- `TOOL_METER_FOUNDATION.md`

Purpose:

- Tool observability and demand/adoption language.
- No tool meter runtime UI yet.

### Owner Governance

Status: Built foundation.

Evidence:

- `lib/features/owner/capsule/`
- `OWNER_GOVERNANCE_DEPLOYMENT_READINESS.md`

Coverage:

- Owner capsule
- Claims provisioning map
- Deployment readiness
- Sovereign archive packages
- Owner identity/localization/guidance alignment

### Provider and Center Federation

Status: Built foundation.

Evidence:

- `lib/features/provider/federation/`
- `lib/features/center/federation/`
- `PROVIDER_CENTER_FEDERATION_REBUILD.md`

Purpose:

- Identity
- Visibility
- Trust
- Contact doctrine
- Reputation alignment
- Legacy containment

Runtime status:

- Foundation exists.
- Actual provider/center UI rebuild is not complete.

### Client and Residential Federation

Status: Built foundation.

Evidence:

- `lib/features/client/federation/`
- `REGISTRATION_RESIDENTIAL_FEDERATION_ALIGNMENT.md`

Purpose:

- Client federation profile
- Registration alignment
- Field parity
- Accessibility/guidance/archive/readiness alignment

Runtime status:

- Client dashboard was transformed earlier.
- Full residential freeze verification is still pending.

### Launch / Readiness / Roadmap

Status: Built foundation.

Evidence:

- `lib/features/launch/federation/`
- `lib/features/readiness/federation/`
- `lib/features/launch/roadmap/`
- `OPERATIONAL_LAUNCH_MAPPING_FOUNDATION.md`
- `OPERATIONAL_READINESS_AUDIT_FOUNDATION.md`
- `LAUNCH_ROADMAP_FOUNDATION.md`

Purpose:

- Define launch surfaces.
- Define readiness scores/gaps/recommendations.
- Define roadmap phases, priorities, dependencies, and milestones.

### Surface Planning and Clean Sweep

Status: Built foundation.

Evidence:

- `lib/features/surfaces/federation/`
- `lib/features/surfaces/launch/`
- `lib/features/surfaces/construction/`
- `FEDERATION_RUNTIME_SURFACES_AND_CLEAN_SWEEP.md`
- `LAUNCH_SURFACES_PLANNING_AND_DUPLICATE_FUNCTION_SWEEP.md`
- `SURFACE_CONSTRUCTION_PLANNING_AND_VISUAL_LEGACY_SWEEP.md`

Purpose:

- Runtime surface maps.
- Ghost route classification.
- Duplicate function sweep.
- Visual legacy sweep.
- Construction blueprints.

---

## 4. New Runtime That Exists

### Contact Requests

Status: Active runtime foundation.

Evidence:

- `lib/features/contact_requests/data/contact_request_repository.dart`
- `provider_contact_requests`
- `center_contact_requests`

Meaning:

- Client can contact provider or center without booking lifecycle.
- No admin approval.
- No payment/session lifecycle.

### Saved Destinations

Status: Active runtime foundation.

Evidence:

- `lib/features/saved_destinations/data/saved_destination_repository.dart`
- `saved_destinations`

Meaning:

- Client can save provider, center, library item, or tool.

### Client Dashboard / Client Room

Status: Reframed, but needs final UI freeze verification.

Evidence:

- `lib/features/client/presentation/pages/client_dashboard_page.dart`

Known direction:

- Signal workspace.
- Tools.
- Saved destinations.
- Support.
- Preferences.

Removed from prominence:

- Booking.
- Sessions.
- Payments.
- Ratings.

---

## 5. Firestore State

### Constitutional / Federation Collections

Current strategic collections:

- `provider_contact_requests`
- `center_contact_requests`
- `saved_destinations`
- `tool_registry`
- `support_requests`
- `chat_threads`
- `chat_escalations`
- `clients`
- `clinicians`
- `centers`
- `clinician_profile_change_requests`
- `center_profile_change_requests`
- `system_domains`
- `system_alerts`
- `analytics_summaries`
- `ai_policies`
- external follow-up registries/campaigns/templates

### Legacy Collections

Current legacy collections:

- `booking_requests`
- `bookingRequests`
- `sessionRatings`

Rules snapshot:

- `booking_requests`
  - create: denied
  - read: admin or own booking
  - update: admin or limited own booking update
  - delete: denied
  - purpose: historical compatibility only

- `bookingRequests`
  - read/write: denied
  - purpose: archive-dead mirror

- `sessionRatings`
  - get/list only via rating read rule
  - create/update/delete denied
  - purpose: historical read-only residue

### Authority Claims

Rules define:

- `admin`
- `owner`
- `monitoring_operator`
- `registry_steward`
- `declaration_reviewer`
- `support_observer`
- `client`
- `clinician`
- `center`

Independence status:

- Monitoring: independent from admin.
- Registry: independent from admin.
- Declaration review: independent from admin.
- Support observer: independent from admin.
- Owner: sovereign, not admin.
- Admin: still exists for legacy/admin compatibility.

---

## 6. Route State

### Federation Web Surfaces

Active route families:

- `/s`
- `/s/personal-space`
- `/s/city/*`
- `/s/capital/*`
- `/s/owner/*`

Meaning:

- These are the future separation surfaces.
- They are signal-first / observability / owner / city surfaces.

### Discovery / Support / Library Routes

Active app routes include:

- `/module/specialists`
- `/module/specialists/list`
- `/module/specialists/details`
- `/module/centers`
- `/module/centers/list`
- `/module/centers/details`
- `/module/library`
- `/module/support-issue-selector`
- `/chat`

### Registration Routes

Active routes include:

- `/register/client`
- `/register/clinician`
- `/register/center`
- `/web/clinician/register`
- `/web/center/register`
- profile/media/pricing/document web registration routes

### Admin / Legacy Routes Still Present

Still present:

- `/admin/hub`
- `/admin/operations`
- `/admin/communications`
- `/admin/clients`
- `/admin/clinician-requests`
- `/admin/clinician-workspace`
- `/admin/clinician-profile-requests`
- `/admin/centers`
- `/admin/archive`
- `/admin/archive/reports`
- `/admin/archive/clinicians`
- `/admin/archive/centers`
- `/admin/archive/support`
- multiple governance/workspace/control-room preview routes

Removed route families from L-A/B/C:

- Booking creation routes
- Booking request pages
- Client payment proof
- Admin payments
- Admin accounting
- Admin archive payments
- Admin archive accounting
- Client sessions
- Clinician sessions
- Center residencies
- Session review
- Admin sessions/report/archive sessions

---

## 7. Cleanup Waves Completed

### L-A / Booking Creation Chain

Removed:

- Booking request pages.
- Center booking request pages.
- Booking creation routes.
- Booking queue entry.
- Booking creation CTA chains.

Result:

- Discovery no longer feeds new booking records.

### L-B / Session Body Chain

Removed:

- Client sessions page.
- Clinician sessions page.
- Center residencies page.
- Session review page.
- Admin sessions page.
- Admin session reports/archive pages.
- Session assets.
- Session routes.

Rules:

- `sessionRatings` changed to read-only.

Result:

- Session lifecycle is no longer a visible primary residential chain.

### L-C / Payment Tail Chain

Removed:

- Client payment proof page.
- Admin payments page.
- Accounting workspace.
- Payment archive page.
- Accounting archive page.
- Admin payment decision adapter.
- Payment proof asset.
- Payment/accounting route constants and router cases.
- Payment counters/cards/shortcuts.
- Payment proof Firestore user update fields.
- Payment/payout l10n keys.
- Accounting assistant engine.

Result:

- No active modern route/page/asset/counter points to payment proof, payout, accounting, or admin payment authority.

---

## 8. Remaining Legacy Residue

### Booking Requests Still Read/Updated

Observed references:

- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/booking/presentation/pages/clinician_inbox_page.dart`
- `lib/features/booking/data/services/center_request_inbox_service.dart`
- `lib/features/booking/data/services/center_inbox_service.dart`
- `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart`
- archive support/clinician/center pages

Risk:

- `booking_requests` is still a legacy island data source.
- New creation is denied, but old records still drive some compatibility views.

### Admin Booking Decision Adapter

Status:

- Still exists.
- Payment methods removed.
- Session/payment fields reduced.
- Still carries legacy admin decision authority for old booking records.

Risk:

- Remaining adapter is the main legacy authority object.

### Provider / Center Old Operations

Status:

- Provider/center federation foundations exist.
- Full runtime rebuild is not complete.
- Some old operation pages remain and still read legacy booking documents.

Risk:

- Provider/center UI may still feel operational/lifecycle-oriented.

### Admin Surface

Status:

- Payment/session/booking routes were removed or reduced.
- Admin hub still exists as a broad operational shell.
- Some admin routes are governance/foundation previews.

Risk:

- Admin as a concept still exists physically, though authority split is underway.

### Legacy Language

Still appears mostly as:

- Comments that forbid coupling.
- Constitutional boundaries.
- Legacy containment registries.
- Launch blockers.

Interpretation:

- This is mostly protective `[S]` language, not live lifecycle language.

---

## 9. What Is Strong Now

1. The constitutional language is present across the codebase.
2. Booking creation has been cut.
3. Payment tail has been cut.
4. Session body routes were removed.
5. Contact runtime exists.
6. Saved destinations exist.
7. Signal runtime exists.
8. Monitoring foundations exist.
9. Reports/archive/identity/localization/guidance foundations exist.
10. Launch/readiness/roadmap/surface planning foundations exist.
11. Owner governance and deployment readiness language exists.
12. Provider/center/client federation rebuild foundations exist.

---

## 10. What Is Weak Or Incomplete

1. No formatter/analyzer/build verification has been run after the cleanup chain.
2. Many generated localization files were edited manually during cleanup.
3. Several old files contain mojibake text from earlier encoding state.
4. Provider Room runtime is not rebuilt yet.
5. Center Room runtime is not rebuilt yet.
6. Monitoring UI does not exist yet.
7. Archive UI is still mostly admin-era.
8. Owner Room runtime is not implemented.
9. Tool marketplace runtime is not active.
10. Signal Gateway is not implemented.
11. Claims provisioning is planned but not automated.
12. Firestore deployment strategy is foundation-only.
13. `booking_requests` remains as a legacy data source.
14. Admin concept still exists for legacy surfaces.
15. Route separation has foundation, but not final app/web split.

---

## 11. Build Verification Risk

Verification not run in this snapshot:

- `dart format`
- `flutter analyze`
- `flutter build`
- tests
- Firebase deploy

Reason:

- The cleanup waves were executed under user preference to avoid running validation commands manually from Codex.

Risk level:

- Medium-high until analyzer/build are run.

High-risk areas:

- `lib/features/admin_surface/pages/admin_archive_page.dart`
- `lib/features/admin_surface/pages/admin_hub_page.dart`
- `lib/features/booking/presentation/pages/clinician_inbox_page.dart`
- localization generated files
- deleted route imports/cases
- deleted assets referenced from widgets

---

## 12. Recommended Validation Commands

Run manually, in order:

```powershell
dart format lib firestore.rules
flutter analyze
flutter test
```

If `dart format firestore.rules` fails, do not format `firestore.rules` with Dart. Use:

```powershell
dart format lib
flutter analyze
flutter test
```

Then manually validate:

- Client dashboard.
- Specialist details contact action.
- Center details contact action.
- Saved destination action.
- Admin hub.
- Admin archive.
- Provider/clinician operations.
- Center operations.
- Registration flows.
- Firestore rules deployment dry review.

---

## 13. Strategic Scores

Architecture alignment: 78 / 100  
Constitutional language: 90 / 100  
Signal foundation: 82 / 100  
Monitoring foundation: 78 / 100  
Identity/localization/guidance foundation: 75 / 100  
Runtime readiness: 48 / 100  
UI readiness: 42 / 100  
Legacy containment: 72 / 100  
Launch readiness: 45 / 100  
Separation readiness: 52 / 100  

Overall federation score: 68 / 100

Interpretation:

- The architecture is much farther than the runtime.
- The doctrine is clear.
- The product is not launch-ready until validation, provider/center/client surface stabilization, and legacy island freeze verification are complete.

---

## 14. Shortest Safe Path From Here

### Step 1: Residential Freeze Verification

Goal:

- Confirm no visible booking/session/payment chain remains in residential app.

Output:

- Freeze verification report.
- Analyzer fixes.
- Missing asset fixes.
- Localization fixes.

### Step 2: Provider / Center Runtime Rebuild

Goal:

- Replace old operations feel with federation profiles:
  - visibility
  - trust
  - contact
  - capability
  - reputation

Output:

- Provider Room v1.
- Center Room v1.

### Step 3: Monitoring Room UI Foundation

Goal:

- First UI over aggregates/feeds.
- No user tracking.
- No case tracking.

Output:

- Residential monitoring view.
- Commercial monitoring view.
- Observatory summary.

### Step 4: Archive Room Rebuild

Goal:

- Replace admin-era archive with federation archive.

Output:

- Archive packages.
- Report archive.
- Sovereign archive alignment.

### Step 5: Owner Room Runtime

Goal:

- Sovereign owner capsule/readiness/deployment view.

Output:

- Owner governance runtime shell.
- Claims/deployment readiness surface.

---

## 15. Recommended Next Build

Next immediate action:

```text
Residential Freeze Verification + Analyzer Stabilization
```

Why:

- The cleanup waves changed many routes, l10n files, pages, assets, and rules.
- Before adding new surfaces, the app must prove it still compiles and that removed chains are not referenced.
- This is the safety gate before UI construction.

Do not build next:

- Signal Gateway.
- Owner Intelligence.
- Full reporting UI.
- Capsule Dock.
- Asset cards.
- AI analytics.

Reason:

- Those rely on a stable runtime surface and verified clean residential base.

---

## 16. Architect Verdict

Mental Smile is now best described as:

```text
Signal Federation Core
with contained Legacy Booking Island residue
and post-cleanup verification pending.
```

Booking Authority no longer appears to control the modern discovery/client path.

Session and payment chains have been cut from visible route/page/asset surfaces, but the project still needs analyzer/build verification to prove no hidden compile-time residue remains.

The most important next milestone is not another new foundation wave.

The next milestone is:

```text
Residential Freeze Verification
```

Once that passes, the project can safely move from cleanup/foundation into real federation surface construction.
