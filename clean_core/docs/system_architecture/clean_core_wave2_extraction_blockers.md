# clean_core Wave 2 Extraction Blockers

This document records blockers that prevent immediate Wave 2 execution.

## Blockers

| Blocker | Impact |
| --- | --- |
| Firestore imports in `core/ai_safety/` files | Prevents direct pure package extraction without splitting contracts from Firebase models. |
| Flutter/Firebase imports in host-owned areas | Blocks feature/shared/app/auth movement. |
| Runtime folder semantics | Requires runtime authority and activation review before movement. |
| Provider governance semantics | Requires adapter and authority review before public exposure. |
| Topology/federation semantics | Requires distributed authority review. |
| Hidden guard/policy surfaces | Must not be publicly exported without semantic approval. |
| Local path dependency resolution uncertainty | Package import validation should be stabilized before more movement. |

## Stop Conditions

Stop Wave 2 if:

- broad movement is proposed
- imports are rewritten repo-wide
- Firebase/provider/routing/l10n/assets are reconnected
- runtime is activated
- provider execution is enabled
- package exports are expanded without review
- app-owned files are pulled into package

## Blocker Verdict

Wave 2 execution is blocked until candidate-specific review is completed and extraction batches are approved.
