# clean_core Wave 2 Adapter Boundary Candidates

This document identifies future adapter-boundary candidates for Wave 2 planning only.

## Adapter Candidates

| Candidate | Current Area | Future Boundary |
| --- | --- | --- |
| Provider capability bridge | `core/provider_governance/` | Contract-only provider capability and blocked-result shapes. |
| Provider onboarding bridge | `core/provider_onboarding/` | Candidate/profile/onboarding state contracts without SDK execution. |
| Firebase data bridge | future adapter layer | Safe read/write intent contracts, no Firebase SDK in clean_core. |
| Auth/session bridge | future adapter layer | User/session reference contracts, no active auth runtime. |
| Print/PDF/export bridge | future adapter layer | Export intent and visibility contract, host-owned implementation. |
| Routing bridge | future adapter layer | Route intent contract, host-owned navigation. |
| Localization bridge | future adapter layer | Text key/fallback contract, host-owned generated l10n. |
| Audit/review bridge | `core/audit/`, `core/human_review/` | Audit/review references and queue markers. |

## Adapter Extraction Rules

- Extract contracts only after import review.
- Do not extract SDK/runtime implementation.
- Do not expose authority-sensitive guards as public API without semantic review.
- Keep bridge failure fail-closed.
- Keep provider/Firebase execution outside clean_core.

## Adapter Candidate Verdict

Adapter candidates are not Wave 2 movement approvals. They are review lanes for future staged contract extraction.
