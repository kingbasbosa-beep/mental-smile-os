# clean_core Wave 2 Candidate Inventory

EX-25 inventories future Wave 2 extraction candidates. This is an architecture audit only. No files were moved, imports reconnected, adapters implemented, exports modified, dependencies added, or runtime systems activated.

## Remaining Core Areas Reviewed

| Area | Initial Inventory Classification | Notes |
| --- | --- | --- |
| `core/ai_safety/` | Deferred/manual-review | Mixed pure contracts and Firestore-coupled models. |
| `core/audit/` | Safe declarative candidate after review | Mostly audit contracts, snapshots, references, redaction, visibility. |
| `core/human_review/` | Safe declarative candidate after review | Escalation/review contracts; backend authority sensitive. |
| `core/legal/` | Safe declarative candidate after review | Likely contract-safe; verify imports before movement. |
| `core/conversation_session/` | Safe declarative candidate after review | Sanitized preview/audit references; privacy review required. |
| `core/response_composition/` | Safe declarative candidate after review | Response contracts; ensure no generation/runtime semantics. |
| `core/safety_memory/` | Deferred/manual-review | Privacy-sensitive memory concepts; export only sanitized boundaries. |
| `core/safety_registry/` | Safe declarative candidate after review | Registry contracts and markers. |
| `core/architecture_manifest/` | Deferred/manual-review | Manifest contracts plus policy/guard surfaces. |
| `core/system_topology/` | Deferred/manual-review | Topology/federation/runtime semantics require caution. |
| `core/runtime_*` | Runtime-deferred/manual-review | Governance placeholders; many should remain internal until runtime phase. |
| `core/provider_governance/` | Adapter-boundary/manual-review | Provider semantics are authority-sensitive. |
| `core/provider_onboarding/` | Adapter-boundary/manual-review | Onboarding semantics must not imply provider activation. |
| `core/secure_runtime_envelope/` | Runtime-owned/deferred | Runtime envelope concepts require activation review. |
| `core/ai_runtime/` | Blocked/high-risk | Runtime/provider semantics, even if disabled. |
| `core/auth/` | Host-owned | Flutter/Firebase/user access coupling. |
| `core/storage/` | Host-owned | `shared_preferences` runtime coupling. |

## Non-Core Areas Reviewed

| Area | Classification | Notes |
| --- | --- | --- |
| `features/**` | Host-owned | Flutter UI, routing, Firebase, assets, l10n, app flows. |
| `shared/ui_kit/**` | Host-owned | Flutter UI and asset coupling. |
| `shared/analytics/**` | Host-owned | Flutter/debug analytics runtime. |
| `app/**` | Host-owned | App shell, routing, locale provider. |
| `l10n/**` | Host-owned | Generated localization. |
| `firebase_options.dart` | Host-owned/blocked | Generated Firebase config. |

## Inventory Verdict

Wave 2 should not be executed yet. The safest next review areas are `audit`, `human_review`, `legal`, `conversation_session`, `response_composition`, and `safety_registry`, but each still needs file-by-file import and semantic review.
