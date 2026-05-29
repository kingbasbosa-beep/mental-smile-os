# GROUNDING-W2 Legacy Freezer Registry

Mental Smile - Grounding Era

Source of truth: `docs/GROUNDING_W1_RUNTIME_INVENTORY_AUTHORITY_MAP.md`

Status: documentation-only freezer registry. No runtime behavior, routes, Firestore rules, custom claims, migrations, command runtime, audit runtime, or production code were changed.

## 1. Executive Summary

This registry converts the GROUNDING-W1 runtime inventory into a controlled legacy freezer. Its purpose is to prevent accidental expansion of legacy admin authority while preserving the current stable runtime.

Freeze does not mean delete.
Freeze means no expansion without review.

The current runtime still depends on `/admin/*`, broad `admin` custom-claim authority, direct Firestore writes, and compatibility aliases. These surfaces must remain stable while the project prepares future command wrappers, audit artifacts, registry grounding, and room separation.

The freezer registry does three things:

- Names legacy and dangerous surfaces explicitly.
- Defines what changes are allowed and forbidden.
- Sets future treatment and verification gates before wrapping, migration, or burial.

## 2. Freezer Label Definitions

| Label | Meaning | Allowed Changes | Forbidden Changes | Exit Condition |
| ----- | ------- | --------------- | ----------------- | -------------- |
| ACTIVE_STABLE | Current runtime surface that is part of the stable operational nucleus. | Bug fixes, documentation, localization, small non-authority UX fixes, observability notes. | Authority expansion, new broad writes, unreviewed lifecycle changes, route rewrites. | Remains active unless a future inventory proves it should be wrapped, split, or deprecated. |
| LEGACY_COMPATIBILITY | Compatibility surface kept for old links, fallback behavior, or existing users. | Documentation, warning labels, compatibility tests, reference tracking. | New dependencies, new deep links, new features, new mutation paths. | No active references, no production data dependency, no deep-link dependency, safe fallback exists. |
| FROZEN_NO_EXPANSION | Surface may keep working but must not grow. | Bug fixes that preserve existing behavior, freeze labels, read-only inventory. | New capabilities, new writes, new routes, new authority semantics, new cross-domain coupling. | Reclassified after wrapper, room split, or replacement plan is approved. |
| DANGEROUS_SHARED_AUTHORITY | Surface mixes observe, mutate, approve, finance, owner, or system powers under generic admin. | Documentation, risk labeling, wrapper planning, emergency bug fixes. | Any new generic admin mutation, finance power, trust power, system power, or hidden authority. | Split into command-backed, owner, sovereign, control, or tenant-scoped surfaces. |
| OWNER_ROOM_CANDIDATE | Surface belongs to future sovereign evolution, infrastructure, AI, registry, marketing governance, or platform strategy. | Documentation, passive owner-target labels, non-runtime planning. | Treating it as Control Room, giving it daily operations power, making owner room super-admin. | Passive Owner Room shell and claim/registry/command plan exist. |
| CONTROL_ROOM_CANDIDATE | Surface should become observe, case, report, continuity, audit, or escalation oriented. | Read-only improvements, case/report planning, audit visibility planning. | Direct operational mutation, finance/legal access, deployment/system authority, owner decisions. | Control Room shell exists with observe/case/report boundaries. |
| SOVEREIGN_ROOM_CANDIDATE | Surface handles finance, accounting, payout, settlement, tax, legal, contracts, or corporate records. | Documentation, sovereign isolation planning, read-only summaries. | Generic admin expansion, Control Room mutation, tenant workflow execution, unsupervised payout/legal mutation. | Sovereign command/audit design exists with isolated visibility. |
| PREVIEW_ONLY | Placeholder, preview, scaffold, or non-operational route/surface. | Copy/label fixes, passive screenshots, documentation, no-op previews. | Treating preview as runtime truth, adding mutation authority, using it as production control. | Converted through a formal passive shell plan and reviewed before runtime connection. |
| BURIAL_CANDIDATE | Legacy item that may be removed later after verification. | Reference tracking, compatibility warnings, dependency audit. | Immediate deletion, hidden replacement, new dependencies, new writes. | All burial verification gates pass and fallback is proven. |
| COMMAND_REQUIRED_FUTURE | Current action writes operational truth and should eventually be wrapped by command + backend + audit. | Inventory, wrapper spec, audit field planning, no behavior change. | New direct writes, new unwrapped transitions, broad admin shortcuts. | Command contract, backend validator, audit append, rollback posture, and compatibility wrapper exist. |
| AUDIT_REQUIRED_FUTURE | Current action creates meaningful governance/operational history and needs future append-only audit. | Add documentation of required audit events, map actor/target/policy links. | Silent mutations, mutable audit substitutes, untracked archive/finalization behavior. | Audit schema and append wrapper exist for that action. |
| SYSTEM_WRITER_CANDIDATE | Current app/service path writes system or health/status truth and should become backend/system-owned. | Inventory, backend-only writer planning, read-only display work. | Client-side authority expansion, admin-authored system truth without audit, hidden health mutation. | Backend/system writer boundary and audit policy exist. |

## 3. Route Freezer Registry

| Route / Route Family | Current Label | Why Frozen / Classified | Allowed Changes | Forbidden Changes | Future Target |
| -------------------- | ------------- | ----------------------- | --------------- | ----------------- | ------------- |
| `/admin/*` | FROZEN_NO_EXPANSION | Legacy compatibility shell containing mixed control, owner, finance, AI, system, and operational authority. | Documentation, labels, bug fixes that do not expand authority. | New broad admin powers, new finance/system/trust mutation, room renaming by route only. | Gradual split into Control, Owner, Sovereign, and command-backed flows. |
| `/admin/hub` | FROZEN_NO_EXPANSION | Admin landing page and compatibility navigation. | Read-only summaries, warnings, navigation labels. | New mutation shortcuts or generic super-admin controls. | Legacy entry until passive room shells exist. |
| `/admin/operations` | DANGEROUS_SHARED_AUTHORITY | Mixed operational cockpit posture. | Observability cleanup, documentation, route labels. | New direct operations mutation or sovereign access. | Control Room observe/case/report surface plus command wrappers. |
| `/admin/booking-queue` | DANGEROUS_SHARED_AUTHORITY | Direct booking lifecycle authority through admin adapters. | Bug fixes, wrapper spec references, freeze labels. | New lifecycle actions or direct Firestore transitions. | Trusted Backend booking lifecycle commands. |
| `/admin/payments` | SOVEREIGN_ROOM_CANDIDATE | Payment and payout authority is sovereign-grade. | Read-only summaries and freeze labels. | New payout/payment authority under generic admin. | Sovereign Finance/Legal command-backed review. |
| `/admin/sessions` | COMMAND_REQUIRED_FUTURE | Direct session lifecycle decisions. | Documentation, wrapper planning. | New unwrapped session status transitions. | Session lifecycle command wrapper. |
| `/admin/accounting` | SOVEREIGN_ROOM_CANDIDATE | Accounting belongs outside generic admin/Control Room. | Read-only summary and sovereign-target labels. | New finance mutation, payout release, settlement authority. | Sovereign Finance/Legal room. |
| `/admin/clinician-requests` | COMMAND_REQUIRED_FUTURE | Professional approval/rejection affects trust and access. | Freeze labels, wrapper planning. | New direct approval/blocking powers without command plan. | Professional trust command. |
| `/admin/clinician-profile-requests` | COMMAND_REQUIRED_FUTURE | Admin applies profile changes into source profile docs. | Preserve request flow, document audit needs. | Silent apply logic expansion. | Profile-change command + audit. |
| `/admin/centers` | COMMAND_REQUIRED_FUTURE | Center approval/block/document status can affect tenant/professional trust. | Read improvements and wrapper planning. | New direct trust mutations. | Center trust command. |
| `/admin/clients` | CONTROL_ROOM_CANDIDATE | Client visibility belongs to observe/case posture. | Read-only UX and support/case labels. | New client mutation or broad data export authority. | Control Room observe/case only. |
| `/admin/support-chats` | CONTROL_ROOM_CANDIDATE | Support oversight should become case/audit oriented. | Read-only/case planning. | Direct lifecycle or clinical continuation controls. | Control Room support continuity. |
| `/chat/escalations` | CONTROL_ROOM_CANDIDATE | Escalation queue currently can mutate through service methods. | Case labels, audit planning, bug fixes. | New direct escalation finalization without command/audit. | Case-linked command surface. |
| `/admin/ai-policies` | OWNER_ROOM_CANDIDATE | AI policy publish belongs to owner governance, not generic admin. | Documentation, draft/read UX fixes. | New policy authority under generic admin. | Owner Room AI policy registry command. |
| `/admin/system-domains` | OWNER_ROOM_CANDIDATE | System domain truth belongs to owner/system registry, not admin cockpit. | Read-only observability and labels. | New generic admin system writer. | Owner/system registry with backend writer. |
| `/admin/control-room/*` | PREVIEW_ONLY | Placeholder under admin, not real separated Control Room. | Passive preview text/labels only. | Mutation authority, treating as actual room separation, operational writes. | Future passive Control Room shell. |
| `/admin/gateways/*` | PREVIEW_ONLY | Gateway preview pages without trusted runtime. | Passive documentation and screenshots. | Connecting to real mutation/execution paths. | Future wrapper/gateway design. |
| `/workspace/external-follow-up*` | OWNER_ROOM_CANDIDATE | Follow-up registry/templates/campaigns mix continuity and growth governance. | Freeze labels, registry planning, safe read fixes. | New campaign authority without audit/continuity review. | Owner/continuity governed registry commands. |
| `/workspace/marketing` | OWNER_ROOM_CANDIDATE | Marketing governance should not live in Control Room. | Content planning and labels. | New daily operations or customer support authority. | Owner Room marketing governance. |
| `/workspace/content` | OWNER_ROOM_CANDIDATE | Content governance belongs to owner/content management. | Passive content governance docs. | Clinical/support authority expansion. | Owner Room content governance. |
| `/home` | LEGACY_COMPATIBILITY | Compatibility alias to menu. | Keep redirect/alias stable; document references. | New deep links or new runtime meaning. | Burial candidate after link verification. |
| `/register/clinician` | LEGACY_COMPATIBILITY | Legacy clinician registration route beside web portal. | Keep stable; fix blocking bugs only. | New registration architecture under legacy route. | Burial or redirect after migration proof. |
| `/register/center` | LEGACY_COMPATIBILITY | Legacy center registration route beside web portal. | Keep stable; fix blocking bugs only. | New registration architecture under legacy route. | Burial or redirect after migration proof. |
| `/chat/clinician/inbox` | LEGACY_COMPATIBILITY | Legacy alias for clinician chat inbox. | Keep alias stable; track deep links. | New features targeting alias instead of canonical route. | Burial after deep-link verification. |

## 4. Service / Adapter Freezer Registry

| Service / Adapter | Current Role | Current Risk | Label | Allowed Changes | Forbidden Changes | Future Treatment |
| ----------------- | ------------ | ------------ | ----- | --------------- | ----------------- | ---------------- |
| `AdminBookingDecisionAdapter` | Admin booking lifecycle mutation adapter. | Critical | COMMAND_REQUIRED_FUTURE | Bug fixes, transition inventory, wrapper spec. | New direct lifecycle transitions, new admin shortcuts. | First command wrapper target. |
| `AdminPaymentDecisionAdapter` | Admin payment approval/payout/archive adapter. | Critical | SOVEREIGN_ROOM_CANDIDATE | Freeze labels, bug fixes that preserve behavior. | New payout, settlement, or payment authority. | Sovereign command + immutable audit. |
| `AdminSessionDecisionAdapter` | Admin session scheduling/completion adapter. | Critical | COMMAND_REQUIRED_FUTURE | Transition inventory and wrapper planning. | New unwrapped session transitions. | Session lifecycle command wrapper. |
| `AccountBlockingService` | Dynamic block/unblock writes to supplied collection/doc. | Critical | COMMAND_REQUIRED_FUTURE | Document callers, target validation planning. | New dynamic target categories or silent blocking. | Scoped authority command. |
| `AdminClinicianRequests` approval logic | Admin updates clinician approval state. | Critical | COMMAND_REQUIRED_FUTURE | Approval state inventory. | New trust states without command/audit plan. | Professional approval command. |
| `AdminCenters` approval/blocking logic | Admin updates center approval, follow-up, document, block state. | Critical | COMMAND_REQUIRED_FUTURE | Freeze labels and state inventory. | New center trust mutations. | Center trust command. |
| `AdminClinicianProfileRequestsPage` apply logic | Applies requested profile changes into clinician/center source docs. | High | AUDIT_REQUIRED_FUTURE | Request/application mapping and audit planning. | Silent field application expansion. | Profile apply command + audit. |
| `ChatFirestoreService` escalation mutation methods | Assign, forward, resolve, report escalations and update threads. | High | COMMAND_REQUIRED_FUTURE | Case lifecycle inventory, audit planning. | New escalation final states without audit. | Case-linked command wrapper. |
| `BookingLegacyChatAdapter` | Booking-chat bridge and legacy messaging adapter. | Medium | LEGACY_COMPATIBILITY | Compatibility bug fixes, dependency tracking. | New writes or new consumers. | Burial/wrapper after chat flow verification. |
| AI policy page/services | Draft and publish AI policies. | High | OWNER_ROOM_CANDIDATE | Documentation, passive owner-target labels. | New AI governance authority under generic admin. | Owner policy registry command. |
| AI policy health service | Writes AI policy health into `system_domains`. | High | SYSTEM_WRITER_CANDIDATE | Inventory and backend writer planning. | Client/admin-side system truth expansion. | Backend-only writer + audit. |
| Booking health service | Writes booking health into `system_domains`. | High | SYSTEM_WRITER_CANDIDATE | Inventory and backend writer planning. | New app-side system health mutation. | Backend-only writer + audit. |
| Chat health service | Writes chat health into `system_domains`. | High | SYSTEM_WRITER_CANDIDATE | Inventory and backend writer planning. | New app-side system health mutation. | Backend-only writer + audit. |
| External follow-up registry service | Creates/updates/archive follow-up registry entries. | High | OWNER_ROOM_CANDIDATE | Registry planning and labels. | New campaign/continuity powers without audit. | Owner/continuity registry command. |
| External follow-up template service | Creates/updates/archive message templates. | High | OWNER_ROOM_CANDIDATE | Template inventory and audit planning. | New unreviewed outbound message authority. | Registry command + audit. |
| External follow-up campaign service | Creates/updates campaigns. | High | OWNER_ROOM_CANDIDATE | Campaign lifecycle inventory. | New campaign execution authority under generic admin. | Continuity/marketing command wrapper. |
| Centers firestore service | Creates/updates/block centers through service caller. | High | COMMAND_REQUIRED_FUTURE | Caller inventory and target validation plan. | New trust-state writers. | Center trust scoped command. |

## 5. Collection Freezer Registry

| Collection | Current Use | Risk | Label | Allowed Changes | Forbidden Changes | Future Target |
| ---------- | ----------- | ---- | ----- | --------------- | ----------------- | ------------- |
| `booking_requests` | Primary booking, payment, payout, session, intake, center, clinician lifecycle. | Critical | COMMAND_REQUIRED_FUTURE | Existing stable writes, inventory, audit field planning. | New direct lifecycle transitions or admin shortcuts. | Command-backed lifecycle with audit. |
| `bookingRequests` | Legacy booking fallback; denied by rules but referenced in code paths. | High | BURIAL_CANDIDATE | Reference tracking only. | New dependencies, writes, or reads. | Burial after no-dependency proof. |
| `clients` | Client profiles and app-side role docs. | Medium | ACTIVE_STABLE | Scoped profile fixes and documentation. | Broad admin profile mutation expansion. | Tenant-scoped profile domain. |
| `clinicians` | Clinician profiles, approval, block, trust state. | Critical | COMMAND_REQUIRED_FUTURE | Existing registration/profile fixes; approval inventory. | New direct trust mutations. | Professional trust command domain. |
| `centers` | Center profiles, approval, block, trust state. | Critical | COMMAND_REQUIRED_FUTURE | Existing registration/profile fixes; approval inventory. | New direct trust mutations. | Center trust command domain. |
| `admins` | Admin role docs and admin metadata. | Critical | DANGEROUS_SHARED_AUTHORITY | Read/inventory only unless emergency bug fix. | New generic admin authority or self-expanding admin writes. | Owner/system identity registry. |
| `ai_policies` | AI policy drafts and published configs. | High | OWNER_ROOM_CANDIDATE | Draft inventory, policy schema planning. | New generic admin AI authority. | Owner policy registry command. |
| `system_domains` | System/domain health and status. | High | SYSTEM_WRITER_CANDIDATE | Read/status inventory, backend writer planning. | New app-side or generic admin system truth writes. | Backend/system registry status writer. |
| `chat_threads` | Chat threads, lifecycle/risk metadata, messages parent. | High | AUDIT_REQUIRED_FUTURE | Scoped messaging fixes, case/audit planning. | New broad lifecycle mutation. | Chat domain with audit/case wrappers. |
| `chat_escalations` | Escalation case records and resolution state. | High | COMMAND_REQUIRED_FUTURE | Case lifecycle inventory. | New unwrapped escalation mutation. | Case-linked command + audit. |
| `external_follow_up_registry` | Follow-up registry entries. | High | OWNER_ROOM_CANDIDATE | Registry docs and freeze labels. | New unreviewed continuity authority. | Owner/continuity registry command. |
| `external_follow_up_message_templates` | Follow-up message templates. | High | OWNER_ROOM_CANDIDATE | Template inventory. | New unreviewed outbound messaging authority. | Registry command + audit. |
| `external_follow_up_campaigns` | Follow-up campaigns. | High | OWNER_ROOM_CANDIDATE | Campaign inventory. | New campaign execution authority. | Continuity/marketing command wrapper. |
| `analytics_summaries` | Admin analytics summaries. | Medium | CONTROL_ROOM_CANDIDATE | Read-only observability improvements. | Client/admin direct writes. | Backend/system observability artifact. |
| `system_alerts` | System alerts visible to admin. | Medium | CONTROL_ROOM_CANDIDATE | Read-only alert review. | Client/admin direct writes. | Backend/system alert artifact. |
| `system_health` | System health docs. | Medium | SYSTEM_WRITER_CANDIDATE | Read-only display. | Client/admin direct writes. | Backend/system health artifact. |
| `support_requests` | User support requests. | Medium | CONTROL_ROOM_CANDIDATE | Existing create flow, case mapping. | Turning support into clinical continuation or admin mutation cockpit. | Support case/continuity domain. |
| `sessionRatings` | Session reviews and rating artifacts. | Medium | AUDIT_REQUIRED_FUTURE | Existing review submissions and audit mapping. | Hidden edits or untracked moderation. | Audit-linked review artifact. |
| `clinician_profile_change_requests` | Clinician profile change queue. | High | AUDIT_REQUIRED_FUTURE | Existing request flow, apply audit planning. | Silent apply or broad direct profile overwrite. | Command request + audit. |
| `center_profile_change_requests` | Center profile change queue. | High | AUDIT_REQUIRED_FUTURE | Existing request flow, apply audit planning. | Silent apply or broad direct profile overwrite. | Command request + audit. |
| `resources` | Resource/content collection. | Medium | OWNER_ROOM_CANDIDATE | Content inventory and governance planning. | New unreviewed clinical/AI authority. | Owner content governance. |

## 6. No-Expansion Rules

### Admin No-Expansion Rules

- No new generic admin mutation powers.
- No new finance/payout power under generic admin.
- No new AI policy authority under generic admin.
- No new system health/domain writer under generic admin.
- No new direct booking lifecycle writes from admin pages.
- No new trust approval/blocking writes without future command wrapper plan.

### Legacy No-Expansion Rules

- No new dependency on `bookingRequests`.
- No new deep links to legacy aliases.
- No new writes through legacy chat adapters.
- No new preview route treated as real runtime.
- No new route that increases `/admin/*` authority.

### Sovereign No-Expansion Rules

- No payout, accounting, settlement, tax, or legal authority expansion under admin.
- Finance-related paths must remain frozen until sovereign command/audit design.
- No Control Room candidate may gain finance/legal truth access.
- No archive finalization should imply legal or financial finality without audit planning.

### Owner/Control Separation Rules

- Control Room candidates must remain observe/case/report oriented.
- Owner Room candidates must not become super-admin.
- Preview Control Room pages must not gain mutation authority.
- Owner-target surfaces must not perform daily tenant operations.
- Marketing/content/growth surfaces must not inherit support or finance powers.

## 7. Burial Conditions

| Burial Candidate | Why Candidate | Required Verification Before Burial | Safe Burial Condition |
| ---------------- | ------------- | ----------------------------------- | --------------------- |
| `bookingRequests` | Legacy fallback collection; rules deny access, but code still references it. | `rg bookingRequests`; runtime route tests; confirm no production data dependency; confirm all fallback reads/writes removed or safely bypassed; verify no rules dependency. | No imports/references, no production docs needed, no deep links, no active fallback behavior. |
| `/home` | Compatibility alias to menu. | Check deep links, bookmarks, web hosting redirects, analytics, QA navigation, public docs. | All inbound references redirect through canonical route or are retired. |
| `/register/clinician` | Legacy clinician registration route beside web portal. | Confirm web portal fully replaces flow; verify no onboarding docs/email links use legacy path; verify account creation parity. | Canonical portal proven, users migrated, fallback/redirect tested. |
| `/register/center` | Legacy center registration route beside web portal. | Confirm web portal fully replaces flow; verify no onboarding docs/email links use legacy path; verify account creation parity. | Canonical portal proven, users migrated, fallback/redirect tested. |
| `/chat/clinician/inbox` | Legacy alias for clinician chat inbox. | Check route references, notifications, deep links, clinician docs, analytics. | All links use canonical route and legacy alias has zero observed traffic. |
| `BookingLegacyChatAdapter` | Compatibility bridge between booking and chat threads. | Map callers; verify chat thread creation/linking has a non-legacy replacement; check existing booking-linked threads; QA message/history continuity. | Replacement wrapper exists, old thread data remains readable, no caller imports remain. |
| Disabled legacy inbox paths around `bookingRequests` fallbacks | Code attempts fallback to legacy collection in clinician/center inbox paths. | Search all fallback references; verify primary `booking_requests` supports all active cases; confirm rules deny legacy collection intentionally. | Fallback code has no active production need and can be removed in a later approved cleanup. |

## 8. Wrapper Priority Queue

| Priority | Target | Why First | Future Wrapper Type | Audit Required |
| -------- | ------ | --------- | ------------------- | -------------- |
| 1 | `AdminBookingDecisionAdapter` | Central booking lifecycle mutation surface; largest operational blast radius. | Booking lifecycle command wrapper. | Yes |
| 2 | `AdminPaymentDecisionAdapter` | Handles payment approval, payout confirmation, and archive states. | Sovereign payment/payout command wrapper. | Yes, sovereign-grade |
| 3 | `AdminSessionDecisionAdapter` | Owns direct session scheduling/completion/reschedule transitions. | Session lifecycle command wrapper. | Yes |
| 4 | `AccountBlockingService` | Dynamic target blocking/unblocking is high-authority and easy to misuse. | Scoped authority command wrapper. | Yes |
| 5 | Clinician/center approval and blocking logic | Professional/center trust state controls access and visibility. | Professional trust command wrapper. | Yes |
| 6 | Profile request apply logic | Applies requested changes into source truth documents. | Profile apply command wrapper. | Yes |
| 7 | Chat escalation mutation methods | Safety/case lifecycle changes need traceability. | Case-linked command wrapper. | Yes |
| 8 | AI policy publish/save | AI governance belongs to Owner Room/policy registry, not generic admin. | Owner policy registry command wrapper. | Yes |
| 9 | System domain health writers | System truth should be backend-owned and audit-linked. | Backend/system writer wrapper. | Yes |
| 10 | External follow-up services | Continuity/growth/campaign authority needs owner/control boundary. | Continuity registry/campaign command wrapper. | Yes |

## 9. Verification Checklist

- [ ] Confirm no production behavior changed.
- [ ] Confirm no route removed.
- [ ] Confirm no Firebase rules changed.
- [ ] Confirm no claims changed.
- [ ] Confirm W2 references W1.
- [ ] Confirm all top dangerous write paths from W1 have freezer labels.
- [ ] Confirm all burial candidates have verification conditions.
- [ ] Confirm W3 wrapper candidates are clearly prioritized.

## 10. Final Verdict

W2 achieved:

- Converted W1 findings into a freezer registry.
- Defined freezer labels with allowed changes, forbidden changes, and exit conditions.
- Classified route families, services/adapters, and collections.
- Preserved `/admin/*` as legacy compatibility rather than renaming it into new rooms.
- Marked `/admin/control-room/*` and `/admin/gateways/*` as PREVIEW_ONLY.
- Established no-expansion rules and burial gates.
- Prioritized W3 wrapper targets.

What remains unsafe:

- Broad `admin` custom-claim authority.
- Direct admin booking/payment/session writes.
- Direct clinician/center approval and blocking writes.
- AI policy and system domain writes under admin surfaces.
- Legacy `bookingRequests` fallback references.
- Chat escalation mutation without command/audit wrapper.

What must happen in W3:

- Produce command wrapper specifications for the highest-risk direct mutation paths, starting with `AdminBookingDecisionAdapter`.
- Define command envelope fields, audit event requirements, actor/target metadata, rollback posture, and compatibility behavior.
- Keep W3 as specification/planning unless explicitly authorized otherwise.

What is still forbidden:

- Route deletion or migration.
- Firebase rule changes.
- Custom claim changes.
- Runtime command/audit implementation.
- Backend authority activation.
- Treating preview room/gateway routes as real runtime.
- Expanding generic admin authority.

