# Master Guide System V1

Status: GUIDE_DRAFT  
Source snapshot: `PROJECT_REALITY_SNAPSHOT.md`  
Scope: documentation and governance mapping only  
Runtime effect: none

## 1. Authority

The Master Guide System is the source of truth for guide-controlled Mental Smile objects:

| Domain | Master guide | Runtime reality status |
| --- | --- | --- |
| Cards | `MASTER_CARD_GUIDE_V1.md` | Cards are private widgets; no runtime card registry exists. |
| Signals | `MASTER_SIGNAL_GUIDE_V1.md` | Runtime signal registries exist; declaration option registries are incomplete. |
| Surfaces | `MASTER_SURFACE_GUIDE_V1.md` | Routes and screens exist; no runtime surface registry exists. |
| Tools | `MASTER_TOOL_GUIDE_V1.md` | Client tools are UI-local; old tool registry is deleted. |
| Routes | `MASTER_SURFACE_GUIDE_V1.md` | `Routes` and `AppRouter` are runtime source; guide records governance interpretation. |
| Roles | `MASTER_ROLE_AUTHORITY_GUIDE_V1.md` | Runtime roles exist in code and Firestore rules. |
| Assets | `MASTER_ASSET_GUIDE_V1.md` | Asset docs exist; runtime registry is minimal. |
| Localization and language | `MASTER_LANGUAGE_GUIDE_V1.md` | ARB exists; active hardcoded/mojibake strings remain. |
| Collections | `MASTER_COLLECTION_GUIDE_V1.md` | Firestore rules and string literals are runtime source. |
| Compliance process | `GUIDE_COMPLIANCE_LIFECYCLE_V1.md` | Documentation process only. |
| Snapshot/card pack doctrine | `GUIDE_SNAPSHOT_AND_CARD_PACK_DOCTRINE_V1.md` | Documentation process only. |

## 2. Master Guide Rules

| Rule ID | Rule | Required interpretation |
| --- | --- | --- |
| MGS-R01 | Master Guide is source of truth. | Any governance card must trace to the current guide snapshot. Runtime code remains the implementation source until intentionally changed in a separate implementation block. |
| MGS-R02 | Cards are generated from Guide snapshots. | A card pack is a derived artifact, not an independent authority. |
| MGS-R03 | No card is approved unless synced with system copy. | The card pack must match the guide snapshot and the observed runtime object it claims to describe. |
| MGS-R04 | Guide update creates new snapshot. | Every guide-level change creates a new snapshot ID and closes or supersedes the prior one. |
| MGS-R05 | Old cards are not patched silently. | Existing cards are suspended or archived, then replaced by a cloned card from the current snapshot. |
| MGS-R06 | Outdated system cards are suspended. | Mismatch between guide and card pack sets status `OLD_CARD_SUSPENDED` or `APPROVAL_BLOCKED`. |
| MGS-R07 | New cards are cloned from the current Guide snapshot. | Card lineage must include `snapshotId`, `sourceGuideId`, `sourceObjectId`, and `version`. |
| MGS-R08 | Process remains open until old card is removed, new card is installed, and validation passes. | A guide operation cannot close at deploy alone. |
| MGS-R09 | Legal & Governance interprets. | Policy meaning, language permission, and authority boundaries are interpreted by Legal & Governance. |
| MGS-R10 | Owner authorizes. | The Owner approves guide domain authority changes. |
| MGS-R11 | Technical executes. | Technical changes runtime only in future implementation blocks. |
| MGS-R12 | Monitoring verifies. | Monitoring checks drift, mismatch, and operational evidence. |
| MGS-R13 | Archive preserves previous versions. | Prior snapshots, card packs, and suspended cards remain discoverable. |

## 3. Card Status Model

| Status | Meaning | Allowed next statuses |
| --- | --- | --- |
| GUIDE_DRAFT | Guide text or object map is being drafted. | GUIDE_UPDATED, APPROVAL_BLOCKED |
| GUIDE_UPDATED | Guide has changed and requires a snapshot. | SYSTEM_SYNC_PENDING |
| SYSTEM_SYNC_PENDING | Card pack/system copy has not yet been synchronized to guide snapshot. | OLD_CARD_SUSPENDED, NEW_CARD_DEPLOYED, APPROVAL_BLOCKED |
| OLD_CARD_SUSPENDED | Existing card is outdated and must not be treated as approved. | NEW_CARD_DEPLOYED, ARCHIVED |
| NEW_CARD_DEPLOYED | New card exists in card pack. Runtime code is not implied. | VALIDATION_PENDING |
| VALIDATION_PENDING | Legal/governance/monitoring checks are pending. | APPROVED, APPROVAL_BLOCKED |
| APPROVED | Guide snapshot, registry references, card pack, ownership, and language checks pass. | ARCHIVED, GUIDE_UPDATED |
| APPROVAL_BLOCKED | Approval failed due to mismatch, missing owner, missing registry, or language/security issue. | GUIDE_DRAFT, SYSTEM_SYNC_PENDING |
| ARCHIVED | Previous version preserved and removed from active authority. | None except historical reference. |

## 4. Status Transitions

| Transition ID | From | To | Required evidence |
| --- | --- | --- | --- |
| T01 | GUIDE_DRAFT | GUIDE_UPDATED | Guide domain owner identifies change. |
| T02 | GUIDE_UPDATED | SYSTEM_SYNC_PENDING | Snapshot generated. |
| T03 | SYSTEM_SYNC_PENDING | OLD_CARD_SUSPENDED | Existing card no longer matches snapshot. |
| T04 | SYSTEM_SYNC_PENDING | NEW_CARD_DEPLOYED | New card cloned from snapshot. |
| T05 | OLD_CARD_SUSPENDED | NEW_CARD_DEPLOYED | Replacement card generated. |
| T06 | NEW_CARD_DEPLOYED | VALIDATION_PENDING | Card pack installed in docs/card pack artifact. |
| T07 | VALIDATION_PENDING | APPROVED | Legal & Governance, Owner, Technical, and Monitoring checks pass. |
| T08 | Any non-archived status | APPROVAL_BLOCKED | Mismatch, missing ownership, language violation, or runtime contradiction found. |
| T09 | APPROVED | ARCHIVED | New approved snapshot supersedes old version. |

## 5. Compliance Agent Doctrine

Guide Compliance Officer / Compliance Agent is read-only.

| Responsibility | Required behavior | Forbidden behavior |
| --- | --- | --- |
| Read Master Guide | Read current guide system, snapshot, and card pack. | Do not rewrite guide automatically. |
| Find unclosed operations | Identify statuses not APPROVED or ARCHIVED. | Do not close operations. |
| Compare snapshot vs card pack | Detect missing, stale, or extra cards. | Do not approve cards. |
| Detect mismatch | Compare object IDs, owners, classifications, and registry references. | Do not modify runtime code. |
| Detect outdated cards | Mark report finding with expected status. | Do not suspend directly unless producing a report artifact says suspension is required. |
| Detect missing ownership | Raise missing owner finding. | Do not invent owner as implemented. |
| Raise alert | Notify Legal & Governance in report. | Do not execute technical changes. |

Escalation:

| Condition | Escalation |
| --- | --- |
| Mismatch detected | Alert Legal & Governance. |
| No report within 15 minutes | Escalate to Owner. |
| Card suspension affects active process | Mark CRITICAL. |
| Runtime registry missing | Mark GOVERNANCE GAP, not runtime failure. |
| Future system referenced | Mark FUTURE unless runtime evidence exists. |

## 6. Relationship Map

| Domain | Guide | Registry | Card | Signal/Tool/Surface | Consumer | Report | Action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Residential | Card, Signal, Surface, Tool, Language, Collection | client signal docs, runtime signal registries, missing card/tool registries | client dashboard cards, personal space cards, signal lane cards | client signals, saved destinations, personal space, library/support tools | client dashboard, personal space | guide snapshot, card pack, localization debt reports | validate language, sync cards, preserve missing registry gaps |
| Commercial | Signal, Surface, Role, Collection, Language, Asset | commercial monitoring registry, center/provider docs, asset docs | specialist cards, center cards, registration signal cards | provider/center discovery, registration, contact requests | specialists, centers, declaration review | commercial language policy report, guide report | ensure provider/center attribution and no booking authority |
| Administrative | Surface, Role, Collection, Language | domain registry, Firestore rules, docs registries | support request cards, declaration record cards, registry domain cards | support room, registry room, declaration review room | support observer, declaration reviewer, registry steward | compliance lifecycle report | detect authority drift and missing ownership |
| Owner | Surface, Role, Card, Asset | owner docs/asset registries, no runtime owner capsule registry | owner district cards, capsule cards | owner room/routes | owner | guide block report | authorize guide domains and archive versions |
| Monitoring | Signal, Surface, Tool, Collection | monitoring registries, signal registries | signal monitoring cards, analytics summary card future | signal_events, signal_aggregates, analytics_summaries | monitoring room, Cloud Function | monitoring verification report | verify mismatch and drift |
| Legal & Governance | Language, Role, Compliance | language registry docs, term matrix, validation rules | language compliance cards | policies and surface permissions | all guide domains | compliance findings | interpret, block, approve doctrine |
| Technical | Collection, Route, Asset, Tool | runtime code registries where present | implementation cards future | routes, Firestore, assets, runtime tools | app codebase | implementation readiness report | execute only after authorization in future block |

## 7. Current Review Readiness

| Check | Result |
| --- | --- |
| Guide documents created | YES |
| Runtime code changed | NO |
| Firebase changed | NO |
| ARB changed | NO |
| Routes changed | NO |
| Missing runtime registries identified | YES |
| Ready for governance review | YES, with runtime gaps clearly marked |

