# Asset Registry V1

Status: ACTIVE_BASELINE_REGISTRY
Classification: EXISTING_HISTORICAL_PROMOTE
Runtime effect: none

## Historical References

- `mental-smile-os-workspace/docs/mental-smile-os/pure-runtime/ACTIVE_RUNTIME_ASSET_REGISTRY_V1.md`
- `mental-smile-os-workspace/docs/mental-smile-os/constitutional-freeze/GENERATION_1_CONSTITUTIONAL_ASSET_REGISTRY_V1.md`

## Baseline Registry Scope

| Family | Status | Notes |
| --- | --- | --- |
| `assets/images/**` | ACTIVE_RUNTIME | active runtime visuals |
| `assets/branding/**` | ACTIVE_BRANDING / MIXED | contains active, duplicate, and archive candidates |
| `assets/branding/web/**` | ACTIVE_WEB | active web registration/library |
| `assets/branding/web_registration/**` | ACTIVE_PROVIDER_CENTER / CLIENT_REGISTER_UNBUNDLED | client registration image unbundled after pure client identity hard removal |
| `assets/c5/**` | LEGACY_EVIDENCE | C5 booking era; avatar survivor active |
| `assets/c6_library/**` | LEGACY_EVIDENCE / ACTIVE_SURVIVORS | wordmark/category cards active |
| `assets/c7_branding/**` | ACTIVE_BRANDING / ARCHIVE_CANDIDATE | splash branch likely archive |
| `web/**` | ACTIVE_WEB | Flutter web shell |
| `public-landing/**` | ACTIVE_WEB | static public landing |

## Hard Removal Notes

| Asset Family | Status | Source Operation | Note |
| --- | --- | --- | --- |
| `assets/branding/client_dashboard/**` | UNBUNDLED_HARD_REMOVED | OP-PURE-CLIENT-IDENTITY-HARD-REMOVAL-V1 | Removed from `pubspec.yaml`; provider/center/clinician rooms now use neutral C7 home background asset. |
| `assets/images/client_dashboard/actions/**` | UNBUNDLED_HARD_REMOVED | OP-PURE-CLIENT-IDENTITY-HARD-REMOVAL-V1 | Removed from `pubspec.yaml` because old client dashboard runtime is removed. |
| `assets/branding/web_registration/clients/mobile/client_register.png` | UNBUNDLED_HARD_REMOVED | OP-PURE-CLIENT-IDENTITY-HARD-REMOVAL-V1 | Removed from `pubspec.yaml` because no active client registration route uses it. |

## Ghost Infrastructure Archival Guide Asset Notes

| Asset Family | Status | Source Operation | Related Guide | Note |
| --- | --- | --- | --- | --- |
| `assets/branding/client_dashboard/**` | REMOVED_FROM_DISK | OP-PACKAGE-B-GHOST-ASSET-YAML-PURGE-V1 | `GHOST_ASSET_YAML_PURGE_REPORT_V1.md` | Removed after confirming no active refs and no `pubspec.yaml` bundle entry. |
| `assets/branding/web_registration/clients/**` | REMOVED_FROM_DISK | OP-PACKAGE-B-GHOST-ASSET-YAML-PURGE-V1 | `GHOST_ASSET_YAML_PURGE_REPORT_V1.md` | Removed after confirming no active refs and no `pubspec.yaml` bundle entry. |
| `assets/images/client_dashboard/actions/**` | REMOVED_FROM_DISK | OP-PACKAGE-B-GHOST-ASSET-YAML-PURGE-V1 | `GHOST_ASSET_YAML_PURGE_REPORT_V1.md` | Removed after confirming no active refs and no `pubspec.yaml` bundle entry. |
| `.github/workflows/firebase-hosting-*.yml` | OWNER_DECISION_REQUIRED | OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | Workflow activation decision required before commit or deployment. |
| Firebase hosting target `public-landing` | OWNER_DECISION_REQUIRED | OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | Hosting target requires Firebase sweep before deploy. |

## Rule

No asset deletion before archive card and owner-reviewed purification.
