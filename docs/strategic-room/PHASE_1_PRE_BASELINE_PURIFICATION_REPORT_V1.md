# Mental Smile OS
# Phase 1 Pre-Baseline Purification Report V1

Status: REPORT_ONLY
Phase: PHASE_1_PRE_BASELINE_PURIFICATION
Runtime effect: none
Code changes: none
File movement: none
Deletion: none

## 1. Purpose

This report defines the pre-baseline purification map required before the first Pure DNA Baseline. It does not perform purification. It classifies what must be kept, archived, removed later, or investigated under governance.

## 2. Asset Purification

| Asset Area | Current State | Required Order | Classification |
| --- | --- | --- | --- |
| C5 | Booking-era pack remains bundled; `avatar_client.png` is still runtime survivor. | Archive Card first, then migrate survivor, then remove bundle residue. | ARCHIVE_FIRST |
| C6 | Library-era pack mixes active category cards/wordmark with ghost UI/state/hero files. | Archive Card first, split survivors, then purify bundle. | ARCHIVE_FIRST |
| Duplicate branding | `assets/branding/web_registration/**` duplicates active `assets/branding/web/registration/**`, except client mobile image. | Archive duplicate lineage before removal. | ARCHIVE_FIRST |
| Ghost assets | C5 icons/status, C6 states/UI, C7 splash, placeholders. | Confirm no dynamic refs, then archive/remove by class. | INVESTIGATE |
| Legacy survivors | C5 avatar, C6 wordmark/categories, client mobile registration image. | Migrate only after cards and registry entries exist. | KEEP_UNTIL_MIGRATED |

## 3. Naming Purification

| Drift | Current State | Risk | Classification |
| --- | --- | --- | --- |
| Provider / Clinician | Both used across routes, copy, collections, and room names. | User and governance ambiguity. | TRANSITIONAL_CARD_REQUIRED |
| Admin / Owner | Admin Zero is doctrine, but admin residue exists in text and Firebase Admin technical layer. | Authority regression risk. | ARCHIVE_AND_GUIDE_REQUIRED |
| Control / Monitoring | S Capital and monitoring language coexist. | Governance meaning drift. | GUIDE_REQUIRED |
| Booking / Contact Request | Booking core is forbidden, but C5 booking evidence remains. | Booking regression risk. | ARCHIVE_REQUIRED |
| Session / Service Coordination | Session words remain in registration/localization context. | Product promise and lifecycle risk. | PURIFICATION_REQUIRED |

## 4. Analyzer Purification Classification

No analyzer run was performed in this phase. Classification below is governance intent only.

| Item Type | Action Class | Notes |
| --- | --- | --- |
| Dead Code | INVESTIGATE | Must be detected by analyzer after archive cards exist. |
| Unused Imports | REMOVE_AFTER_AUDIT | Safe only after analyzer verification. |
| Unused Variables | REMOVE_AFTER_AUDIT | Must not remove evidence-bearing code blindly. |
| Unused Widgets | ARCHIVE_OR_REMOVE | Archive if they represent era/design decisions. Remove if pure junk. |
| Unused Assets | ARCHIVE_FIRST | Evidence assets differ from junk assets. |

## 5. Governance Residue Purification

| Term | Current Class | Purification Need |
| --- | --- | --- |
| admin | LEGACY_TEXT / SAFE_TECHNICAL_USE | Distinguish Firebase Admin SDK from authority residue. |
| booking | LEGACY_EVIDENCE | Archive as Booking Era, prevent runtime revival. |
| session | DANGEROUS_DRIFT | Replace only after guide/card decision. |
| payment | FORBIDDEN_CORE | Keep only negative doctrine or archive evidence. |
| approve/reject | LEGACY_STATUS_LANGUAGE | Prefer readiness/incomplete language if Owner confirms. |
| case | TRANSITIONAL | Prevent clinical ownership interpretation. |

## 6. Required Before Actual Purification

1. Archive cards for C5, C6, Admin Zero, Booking Extraction, Duplicate Registration.
2. Asset Registry with active/survivor/ghost/evidence classification.
3. Naming Boundary Guide.
4. Finding Registry entries for each residue family.
5. Owner decision on Provider vs Clinician canonical language.

## 7. Phase 1 Verdict

PHASE_1_READY_FOR_ARCHIVE_CARD_PREPARATION

Purification must not start by deleting files. The correct order is:

```text
Archive Card
↓
Registry Entry
↓
Owner Review
↓
Purification
↓
Audit
↓
Memory
```

