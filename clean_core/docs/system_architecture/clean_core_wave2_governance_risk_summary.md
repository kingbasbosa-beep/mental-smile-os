# clean_core Wave 2 Governance Risk Summary

This summary captures governance risks for future Wave 2 extraction.

## Risk Summary

| Risk | Severity | Control |
| --- | --- | --- |
| Runtime activation by naming/semantics | High | Defer runtime folders. |
| Provider activation leakage | High | Keep provider candidates adapter-boundary only. |
| Firebase execution leakage | High | Exclude Firebase-coupled files or split models first. |
| Host UI contamination | High | Keep `features`, `shared/ui_kit`, `app`, and `l10n` host-owned. |
| Backend authority leakage | High | Keep trusted execution backend-owned. |
| Privacy leakage | High | Review safety/conversation/memory/audit contracts before export. |
| Broad export creep | Medium-high | Keep file-by-file exports and hidden contract review. |
| Analyzer/package instability | Medium | Stabilize path dependency and tests before Wave 2. |

## Governance Controls

- Contracts before movement.
- Manual import scan before each batch.
- Semantic export decision before barrel change.
- Runtime remains disabled.
- Provider execution remains blocked.
- Backend authority remains external.
- Host app remains runtime owner.

## Final Risk Verdict

Wave 2 is architecturally possible only as staged, review-led contract extraction. It is not ready for execution yet.
