# Mental Smile P0 Firebase Purification Plan - Pre Phase 11

Plan Mode: `NO_IMPLEMENTATION`
Scope: `PRE_PHASE_11_FIREBASE_PURIFICATION`
Rules Changes: `NONE`
Code Changes: `NONE`
Deployment: `NONE`
Runtime Registries Created: `NONE`
Migration Scripts Created: `NONE`
Booking Revival: `FORBIDDEN`
Final Verdict: `READY_WITH_P0_ACTIONS`

---

## 1. P0 Firebase Purification Report

P0 is a preparation layer before the Runtime Governance Bridge. Its purpose is to make Firebase constitutionally readable, bounded, and safe for later grounding work.

Current Firebase state:

| Firebase Area | Current Classification | Purification Direction |
| --- | --- | --- |
| `firestore.rules` | Active / Transitional | Keep current restrictive posture; map future splits before edits. |
| `storage.rules` | Transitional / Frozen Debt | Freeze hidden Admin Era authority before any runtime bridge. |
| `firestore.indexes.json` | Active | Keep; align future indexes with registry/signal grounding later. |
| `firebase.json` | Active | Keep; no deployment changes in P0. |
| `functions/index.js` | Active / Future Runtime Cache | Keep analytics writer classified as monitoring cache writer. |
| Active Flutter Firestore references | Active / Transitional | Inventory as runtime consumers; do not mutate. |
| Legacy `firebase_rules/*` files | Frozen Debt / Remove Candidate | Mark do-not-deploy; quarantine as historical evidence. |
| Booking-era docs/rules | Frozen Debt / Archive Candidate | Freeze, archive, remove later. |
| `signal_events` | Active / Future Signal | Treat as canonical signal stream candidate. |
| `system_domains` | Active / Future Registry | Treat as first registry grounding candidate. |
| `signal_aggregates` | Transitional / Future Runtime Cache | Keep read model; future writer governance required. |
| `analytics_summaries` | Future Runtime Cache | Keep server-produced analytics cache; future rules/consumer review required. |
| `ai_policies` | Unknown / Future Registry | Freeze until governance assigns owner and rules. |
| Storage sensitive documents | Active / Custody Gap | Classify custody before authority changes. |
| Storage public assets | Transitional / Admin Debt | Split admin write authority later. |

State classes:

| Class | Items |
| --- | --- |
| Active | `clients`, `clinicians`, `centers`, `support_requests`, contact requests, `saved_destinations`, chat collections, `signal_events`, current rules/config/functions. |
| Transitional | `clinician_profile_change_requests`, `center_profile_change_requests`, `signal_aggregates`, `analytics_summaries`, Storage public asset write model. |
| Frozen Debt | `admin` storage authority, `/admins/{uid}` fallback, legacy rule files, booking-era collections/rules/docs. |
| Remove Candidate | `bookingRequests`, `debug`, old dev-open rule patterns, stale admin-era permissions. |
| Archive Candidate | `booking_requests`, `sessionRatings`, payment proof/accounting artifacts, legacy rule sets, legacy admin queue evidence. |
| Future Registry | Ownership, collection, route, card, signal, localization, tool, archive, snapshot, pack, distribution, activation, domain, AI policy. |
| Future Signal | Support lifecycle, profile change lifecycle, contact lifecycle, saved destination lifecycle, chat safety, chat escalation, analytics summary, client signal declaration. |
| Future Runtime Cache | `signal_aggregates`, `analytics_summaries`. |

---

## 2. Authority Purification Map

Authority purification focus:

| Authority Path | Current State | Risk | Replacement Direction | P0 Action |
| --- | --- | --- | --- | --- |
| `admin` custom claim in Storage | Present in `storage.rules` only | Hidden Admin Era authority | Split into Owner, Legal Governance, Compliance, Technical Verifier, Monitoring, Archive Steward | Freeze and mark not valid for future constitutional authority. |
| `/admins/{uid}` Storage fallback | Present in `storage.rules` through Firestore lookup | Hidden authority path outside active Firestore rules | Replace with explicit constitutional authority claims/registries later | Quarantine; require no-redeploy guard. |
| Storage admin write access to public assets | Present for branding/gallery/public/marketing paths | Admin can mutate public identity assets | Future asset ownership + Legal/Owner authorization + Technical verification | Classify as transitional admin debt. |
| Firestore old admin-era permissions | Not active in current root `firestore.rules`; present in legacy docs/rules | Redeploy/resurrection risk | Owner/Legal/Compliance/Monitoring role split | Quarantine legacy rules. |
| App-side role documents | Used for UI/UX access fallback | Not Firestore authority | Keep as runtime UX only | Document boundary; no authority promotion. |
| Custom claims for constitutional roles | `owner`, `monitoring_operator`, `registry_steward`, `declaration_reviewer`, `support_observer` | Need future attestation | Keep and later attest | P0 maps to Phase 11 bridge requirements. |

Replacement direction:

| Future Authority | Replaces Admin-Era Function | Boundary |
| --- | --- | --- |
| Owner | Final authorization, emergency hold, sovereign decisions | Authorizes; does not silently execute. |
| Legal Governance | Interpretation, legal block, language/authority meaning | Interprets and blocks; does not deploy. |
| Compliance | Validation, audit, evidence, block recommendation | Validates and records; does not replace or activate. |
| Technical Verifier | Technical verification after governed incident or flow | Verifies only; does not authorize. |
| Monitoring | Flow observation, delay/failure escalation, analytics review | Observes and escalates; does not mutate. |
| Archive Steward | Custody, retention, access, evidence preservation | Preserves and controls access; does not create active authority. |

P0 authority rule:

```text
No admin replacement may be introduced until the replacement role is mapped to Owner, Legal Governance, Compliance, Technical Verifier, Monitoring, or Archive Steward.
```

---

## 3. Storage Custody Map

| Storage Class | Owner | Sensitivity | Access Class | Future Custody Rule | Remove/Admin-Debt Risk |
| --- | --- | --- | --- | --- | --- |
| `/identity/{uid}/...` | Account subject + Archive/Compliance future custody | High | Private identity evidence | Owner-subject access, custody registry, evidence retention rule | Admin read fallback is high-risk debt. |
| `/national_ids/{uid}/...` | Account subject + Legal/Archive custody | Critical | Sovereign identity evidence | Legal/custody registry required before bridge | Admin read fallback is critical debt. |
| `/certificates/{uid}/...` | Clinician/provider subject + Declaration governance | High | Credential evidence | Declaration evidence registry and retention class | Admin read fallback is high-risk debt. |
| `/licenses/{uid}/...` | Center/provider subject + Legal/Declaration governance | High | License evidence | License custody registry and legal evidence class | Admin read fallback is high-risk debt. |
| `/verification_docs/{uid}/...` | Subject + Compliance/Archive custody | High | Verification evidence | Verification evidence class and access log | Admin read fallback is high-risk debt. |
| `/medical_docs/{uid}/...` | Subject + Legal/Archive custody | Critical | Sensitive health document | Requires privacy/data custody constitution before any runtime bridge | Critical; may need freeze until custody defined. |
| `/clients/{uid}/...` | Client subject | Medium/High | Private client file | Client custody and support boundary | Admin read fallback through `canReadPrivateOwnerFile` applies. |
| `/clinicians/{uid}/...` | Clinician subject | Medium/High | Provider documents/media | Declaration custody and public/private split | Admin read fallback applies. |
| `/centers/{uid}/...` | Center subject | Medium/High | Center documents/media | Center custody and public/private split | Admin read fallback applies. |
| `/branding/...` | Owner + Legal + Asset governance | Public | Public asset | Asset registry ownership and technical verifier write path | Admin write is transitional debt. |
| `/public_gallery/...` | Asset owner / Commercial or Public surface | Public | Public asset | Asset registry + source owner + language/visual governance | Admin write is transitional debt. |
| `/public_images/...` | Asset owner / Public surface | Public | Public asset | Asset registry and provenance evidence | Admin write is transitional debt. |
| `/marketing_assets/...` | Commercial/Owner/Legal | Public | Public marketing asset | Marketing asset registry + legal approval evidence | Admin write is transitional debt. |

P0 storage rule:

```text
Storage custody must be classified before any admin fallback is replaced or removed.
```

---

## 4. Legacy Rules Quarantine Map

| Legacy Rule File | Class | Risk | P0 Mark | Reason |
| --- | --- | --- | --- | --- |
| `firebase_rules/firestore.rules.DEV` | DEV | Fully open read/write | DO NOT DEPLOY | Dev-only open rule violates constitutional authority. |
| `firebase_rules/firestore.rules.DEV_BOOKING` | DEV_BOOKING | Booking read/create/update for signed-in users | DO NOT DEPLOY | Revives booking-era workflows. |
| `firebase_rules/firestore.rules.MIN_SAFE` | MIN_SAFE | Public `resources`, open debug | DO NOT DEPLOY | Debug/resource model not constitutionally mapped. |
| `firebase_rules/firestore.rules.MIN_SAFE_STAGE2` | MIN_SAFE_STAGE2 | Contains booking_requests lifecycle | DO NOT DEPLOY | Transitional booking authority. |
| `firebase_rules/firestore.rules.PROD` | PROD legacy | Old resources/users/debug shape | DO NOT DEPLOY | Superseded by current root `firestore.rules`. |

No-redeploy guard doctrine:

| Guard ID | Doctrine |
| --- | --- |
| `p0.guard.legacy_rules_do_not_deploy` | Files under `firebase_rules/` are historical reference only unless a future constitutional review explicitly promotes one. |
| `p0.guard.no_dev_open_rules` | Any rule allowing broad read/write is forbidden for production deployment. |
| `p0.guard.no_booking_rule_revival` | Any rule matching `booking_requests` or `bookingRequests` cannot be deployed into active core platform. |
| `p0.guard.no_debug_resurrection` | `debug` write/read rules cannot be revived without explicit technical incident or dev-only constitution. |
| `p0.guard.current_rules_are_source` | Root `firestore.rules` remains the active observed rules source until a governed replacement exists. |

---

## 5. Booking Era Quarantine Map

Decision for all booking-era debt:

```text
FREEZE -> ARCHIVE -> REMOVE
```

| Item | Current State | Decision | Revival Boundary |
| --- | --- | --- | --- |
| `booking_requests` | Frozen legacy debt in docs/rules | FREEZE -> ARCHIVE -> REMOVE | No revival inside core platform. |
| `bookingRequests` | Duplicate legacy spelling | FREEZE -> ARCHIVE IF DATA EXISTS -> REMOVE | No compatibility resurrection. |
| `sessionRatings` | Booking/session bridge | FREEZE -> ARCHIVE -> REMOVE OR OPTIONAL FUTURE MODULE | No active session lifecycle. |
| Payment proof | Legacy financial workflow | FREEZE -> ARCHIVE -> REMOVE | No platform payment authority. |
| Accounting flow | Legacy financial/admin workflow | FREEZE -> ARCHIVE -> OPTIONAL FUTURE MODULE ONLY | No core accounting authority. |
| Old queues | Admin/booking queue doctrine | FREEZE -> ARCHIVE -> REMOVE | No queue ownership revival. |
| Approval chains | Admin/approval doctrine | FREEZE -> ARCHIVE -> REMOVE | Use declaration/readiness language only. |

P0 booking rule:

```text
Booking-era concepts may be archived as historical evidence but may not re-enter the active core platform by rename, adapter, route, claim, rule, collection, or asset.
```

---

## 6. Signal Purification Map

Canonical current signal stream: `signal_events`.

Status-to-signal preparation:

| Source | Current Status / Field | Future Signal Direction | Priority |
| --- | --- | --- | --- |
| `support_requests` | `status = new` | `support_request_created` | Critical |
| `support_requests` | future close/escalation states | `support_request_closed`, `support_request_escalated` | Critical |
| `clinician_profile_change_requests` | `status = submitted` | `clinician_profile_change_submitted` | Important |
| `clinician_profile_change_requests` | future review status | `clinician_profile_change_reviewed`, `clinician_profile_change_blocked` | Important |
| `center_profile_change_requests` | `status = submitted` | `center_profile_change_submitted` | Important |
| `center_profile_change_requests` | future review status | `center_profile_change_reviewed`, `center_profile_change_blocked` | Important |
| `provider_contact_requests` | create | `provider_contact_requested` | Important |
| `center_contact_requests` | create | `center_contact_requested` | Important |
| `saved_destinations` | create | `destination_saved` | Important |
| `saved_destinations` | update | `destination_updated` | Medium |
| `chat_threads` | `needsHumanSupport` | `chat_support_need_detected` | Critical |
| `chat_threads` | `escalationLevel` | `chat_escalation_level_changed` | Critical |
| `chat_threads` | `safetyState` | `chat_safety_state_changed` | Critical |
| `chat_threads` | `riskScore` / `riskLevel` | `chat_risk_level_changed` | Critical |
| `chat_escalations` | `status = open` | `chat_escalation_opened` | Critical |
| `chat_escalations` | `status = resolved` | `chat_escalation_resolved` | Critical |
| `analytics_summaries` | scheduled write | `analytics_summary_generated` | Important |
| `clients` | `clientSignals` | `client_signal_declared`, `client_signal_updated` | Critical |
| `clients` | `privacyPreferences` | `client_privacy_preference_updated` | Important |
| `clinicians` | `visibilityReadiness` | `clinician_visibility_readiness_changed` | Important |
| `centers` | `visibilityReadiness` | `center_visibility_readiness_changed` | Important |

P0 signal rule:

```text
P0 defines signal candidates only. It does not create signal emitters, Cloud Functions, triggers, migrations, or new Firestore rules.
```

---

## 7. Registry Grounding Preparation Map

Future registry list:

| Future Registry | Source Evidence | Purpose | P0 Readiness |
| --- | --- | --- | --- |
| Ownership Registry | Custom claims, role docs, Phase 2 | Bind owners/stewards/consumers to objects | REQUIRED |
| Collection Registry | Firestore rules, Master Collection Guide | Govern collections and lifecycle ownership | REQUIRED |
| Route Registry | Flutter routes, Phase 1 route registry card | Bind routes to surfaces/owners | REQUIRED |
| Card Registry | Phase 3, Master Card Guide | Govern active constitutional cards | REQUIRED |
| Signal Registry | Dart signal registries, `signal_events` | Govern signal IDs/producers/consumers | REQUIRED |
| Localization Registry | Language policies, localization docs | Govern terms/copy/surface ownership | REQUIRED |
| Tool Registry | Master Tool Guide, deleted runtime tool registry | Govern tool ownership and surface mapping | REQUIRED |
| Archive Registry | Phase 6A | Govern archive classes/access/retention/evidence | REQUIRED |
| Snapshot Registry | Phase 7 | Govern snapshot lifecycle and evidence | REQUIRED |
| Pack Registry | Phase 8 | Govern card pack generation/replacement | REQUIRED |
| Distribution Registry | Phase 9 | Govern receivers/confirmation/failures | REQUIRED |
| Activation Registry | Phase 10 | Govern single-active replacement/activation | REQUIRED |
| Domain Registry | `system_domains` | Existing limited registry-like collection | FIRST CANDIDATE |
| AI Policy Registry | `ai_policies` dev seeder target | Govern assistant/AI policy docs if retained | FREEZE UNTIL OWNER ASSIGNED |

P0 registry rule:

```text
No registry collection is created in P0. P0 only prepares the registry list and grounding order.
```

---

## 8. Firestore Rules Purification Map

| Rule Area | Current Rule Area | Classification | Future Direction |
| --- | --- | --- | --- |
| Role claim helpers | `hasRole`, `isOwner`, `isMonitoringOperator`, `isRegistrySteward`, `isDeclarationReviewer`, `isSupportObserver` | Keep | Later split authority by attested role registry. |
| Duplicate monitoring helper | Duplicate `isMonitoringOperator()` | Tighten later | Clean during future rules hygiene, not P0. |
| Client account rules | `clients` own get/create/update | Keep | Later signalize preference/clientSignals updates. |
| Clinician account rules | `clinicians` create/update while not visibility ready | Keep / Tighten later | Ground declaration readiness in registry/signals. |
| Center account rules | `centers` create/update while not visibility ready | Keep / Tighten later | Ground center capabilities/pricing/readiness. |
| Profile change requests | Create only, read by reviewer/owner | Keep | Signalize lifecycle and archive closed records. |
| Support requests | Create only, read by support observer/creator | Keep / Tighten later | Signalize status and closure. |
| Provider contact requests | Create only, limited read | Keep | Signalize contact request lifecycle. |
| Center contact requests | Create only, limited read | Keep | Signalize contact request lifecycle. |
| Saved destinations | Client create/update | Tighten later | Add signal/evidence boundary later. |
| Chat threads | Participant/support read and update | Split authority | Separate participant message behavior from support safety mutation. |
| Chat messages | Signed-in create under thread | Tighten later | Add participant validation and evidence guard later. |
| Chat escalations | Support/recommended clinician read/resolve | Split authority | Prevent recommended provider from becoming assignment authority. |
| Escalation reports | Signed-in create | Tighten later | Require report owner/source and signal evidence later. |
| `system_domains` | Owner/registry steward read, write false | Keep | Candidate for registry grounding. |
| `signal_events` | Append-only actor-created signal docs | Keep | Expand producer coverage later. |
| `signal_aggregates` | Owner/monitoring read, write false | Keep / Runtime cache | Future aggregate writer governance required. |
| Catch-all deny | Deny all unspecified | Keep | Required constitutional safety posture. |
| Booking rules | Not active in root rules | Freeze | Do not reintroduce. |
| Admin rules | Not active in root Firestore rules | Freeze | Do not reintroduce. |

---

## 9. Risk Register

### Critical Risks

| Risk | Impact | P0 Response |
| --- | --- | --- |
| Hidden admin authority in Storage | Admin Era can bypass constitutional role split for files/assets. | Freeze and map replacement authority before Phase 11. |
| `/admins/{uid}` fallback | Hidden Firestore authority source not governed by active rules. | Quarantine; mark as do-not-expand. |
| Legacy rules redeploy | Old permissive or booking rules could resurrect debt. | No-redeploy guard doctrine. |
| Booking resurrection | Booking/payment/admin queue could return through rules, code, docs, assets, or language. | Freeze -> archive -> remove doctrine. |
| Missing runtime registries | Phase 11 bridge cannot safely ground governance. | Registry preparation map. |
| Sensitive storage custody gap | Identity/medical/legal docs lack constitutional custody model. | Storage custody classification. |

### High Risks

| Risk | Impact | P0 Response |
| --- | --- | --- |
| Incomplete signals | Status fields remain non-auditable lifecycle mutations. | Status-to-signal map. |
| Chat safety authority blur | Support/participant/recommended clinician boundaries may blur. | Split authority later. |
| Analytics cache ungoverned consumers | `analytics_summaries` writer exists without explicit consumer rule path. | Runtime cache classification. |
| Declaration readiness as mutable field | Readiness may become approval semantics. | Signal/registry grounding later. |

### Medium Risks

| Risk | Impact | P0 Response |
| --- | --- | --- |
| Duplicate Firestore helper | Hygiene issue in rules. | Tighten later. |
| `ai_policies` unknown governance | Dev seeder target without active rule match. | Freeze until owner assigned. |
| Public asset admin writes | Public-facing identity can be changed through admin claim. | Asset custody and authority split later. |
| `resources` legacy ambiguity | Old public content path uncertain. | Quarantine legacy rules. |

### Low Risks

| Risk | Impact | P0 Response |
| --- | --- | --- |
| Current index set is narrow | Future queries may need governed indexes. | Keep; revisit after registry/signal design. |
| Current Firebase config is stable | No immediate issue. | No action. |

---

## 10. P0 Execution Waves

These waves are safe planning waves. They do not authorize implementation.

| Wave | Name | Purpose | Required Output | Exit Gate |
| --- | --- | --- | --- | --- |
| P0-A | Authority Freeze | Freeze admin-era authority and define replacement authority directions. | Authority freeze ledger and admin debt map. | No hidden admin path remains unclassified. |
| P0-B | Legacy Rules Quarantine | Mark legacy rules as do-not-deploy. | Legacy rules quarantine map and no-redeploy guard. | Every legacy rules file classified. |
| P0-C | Storage Custody Classification | Classify sensitive/private/public storage paths. | Storage custody map. | Every storage path has sensitivity and owner class. |
| P0-D | Booking Era Quarantine | Freeze booking/payment/accounting/approval/queue debt. | Booking quarantine map. | Every booking-era item has freeze/archive/remove decision. |
| P0-E | Signal/Registry Readiness Map | Prepare future signal and registry grounding lists. | Signal purification map and registry preparation map. | Phase 11 has complete dependency list. |
| P0-F | Phase 11 Readiness Gate | Decide whether Runtime Governance Bridge may begin. | Phase 11 readiness verdict. | Critical P0 actions are acknowledged as blockers or prerequisites. |

---

## 11. Phase 11 Readiness Verdict

Verdict: `READY_WITH_P0_ACTIONS`

Reason:

Firebase is ready for Phase 11 planning, but not ready for runtime bridge implementation. P0 must be treated as a purification checkpoint before any Runtime Governance Bridge work.

Required P0 actions before Phase 11 can safely design runtime bridge behavior:

| Required Action | Priority |
| --- | --- |
| Freeze `admin` claim and `/admins/{uid}` fallback as Admin Era debt. | Critical |
| Mark every legacy rules file as `DO_NOT_DEPLOY`. | Critical |
| Classify storage custody for identity, national ID, certificates, licenses, verification, and medical docs. | Critical |
| Confirm booking-era debt remains frozen and cannot revive in core platform. | Critical |
| Prepare registry grounding order without creating registries. | Critical |
| Prepare status-to-signal map without creating emitters. | High |
| Treat `system_domains` as first registry candidate only, not a complete registry system. | High |
| Treat `signal_events` as canonical signal stream candidate only, not complete signal governance. | High |

Final P0 rule:

```text
Phase 11 may begin as a governance design phase only after P0 acknowledges all critical purification actions. No runtime implementation may begin from this plan.
```
