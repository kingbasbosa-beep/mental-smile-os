# Legacy Runtime Residue Report V1

Status: RUNTIME_RESIDUE_REPORTED
Prompt Asset: PROMPT_ASSET_059

## Identified Runtime Residue

| Residue Type | Location | Disposition |
| --- | --- | --- |
| Legacy runtime source | lib | KEEP_AS_HISTORICAL_EVIDENCE |
| App router and route surfaces | lib/app | KEEP_AS_HISTORICAL_EVIDENCE |
| Feature screens and flows | lib/features | KEEP_AS_HISTORICAL_EVIDENCE |
| Shared runtime code | lib/shared | KEEP_AS_HISTORICAL_EVIDENCE |
| Core services/models | lib/core | KEEP_AS_HISTORICAL_EVIDENCE |
| Localization runtime files | lib/l10n | KEEP_AS_HISTORICAL_EVIDENCE |
| Android runtime shell | android | KEEP_AS_HISTORICAL_EVIDENCE |
| Web runtime shell | web | KEEP_AS_HISTORICAL_EVIDENCE |
| Windows runtime shell | windows | KEEP_AS_HISTORICAL_EVIDENCE |
| Functions folder | functions | UNKNOWN |

## Legacy Route Risk

Legacy routes may exist in lib/app/router and must not be migrated directly.

## Legacy Screen Risk

Legacy screens may exist in lib/features and must be treated as source evidence only.

## Legacy Service Risk

Legacy services, models, and collections must be extracted and rebuilt only if approved by Generation 1 execution packages.

