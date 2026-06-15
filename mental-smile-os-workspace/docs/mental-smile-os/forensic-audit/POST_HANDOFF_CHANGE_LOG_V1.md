# POST_HANDOFF_CHANGE_LOG_V1

## Timeline

| Commit / State | Change | Files | Classification | Introduced By | Rollback Consideration |
|---|---|---|---|---|---|
| `5cea0d1a` | STEP 038 production activation preparation; also contains large documentation additions, deletion of old docs, and active Flutter workbench route/page additions. | `docs/**`, `mental-smile-os-workspace/**`, `lib/app/router/*`, `lib/features/sovereign_construction/**`, `lib/features/s_owner/**` | ACCEPTABLE_WITH_WARNING | Codex/User execution before this audit | Review because runtime route/page changes are bundled into a production-command commit. |
| `91b75b44` | Added activation record. | `mental-smile-os-workspace/docs/mental-smile-os/activation-era/MENTAL_SMILE_OS_ACTIVATION_RECORD_V1.md` | EXPECTED | Codex/User execution | No rollback needed. |
| `e4785646` | Added Firebase Hosting GitHub Actions and hosting config, initially targeting `build/web_os_deploy`. | `.github/workflows/*`, `firebase.json`, `.firebaserc`, `firebase.json.backup-before-hosting` | ACCEPTABLE_WITH_WARNING | Codex/User execution | Review live deploy behavior. |
| `8f1ea18e` | Added Flutter setup action to Firebase Hosting workflows. | `.github/workflows/firebase-hosting-merge.yml`, `.github/workflows/firebase-hosting-pull-request.yml` | EXPECTED | Explicit user-approved patch | No rollback needed. |
| `00c2efe0` | Empty/no-file-change trigger commit. | None shown by name-status | ACCEPTABLE | User/Codex execution | No rollback needed. |
| `6dd5dbcb` | Changed Firebase Hosting public directory from `build/web_os_deploy` to `build/web`. | `firebase.json` | EXPECTED | User-approved hosting output correction | No rollback needed unless separate runtime output is required. |
| `91c201ba` | Clarified active OS display/memory label. | `mental-smile-os-workspace/app/runtime-shell/runtime-shell.js`, `os_memory_summary.json` | EXPECTED | Explicit user request | No rollback needed. |
| `685383e2` | Updated production identity metadata. | `pubspec.yaml`, `web/index.html`, `web/manifest.json` | EXPECTED | Explicit user request | No rollback needed. |
| `91904100` | Removed active English `Mental Key` localization residue. | `lib/l10n/app_en.arb`, `lib/l10n/app_localizations_en.dart` | EXPECTED_WITH_NOTE | Explicit user request | No rollback needed; generated localization file should be regenerated in a clean validation pass. |
| `e9bf61a3` | Removed legacy admin authority from Storage rules. | `storage.rules` | EXPECTED | Explicit user request | No rollback needed. |
| Current untracked | Firebase Hosting cache generated. | `.firebase/hosting.YnVpbGRcd2ViX29zX2RlcGxveQ.cache` | UNPLANNED | Firebase tooling/build artifact | Do not commit without owner decision. |
| Current untracked | New signal routing foundation. | `mental-smile-os-runtime/signal-routing/*.md` | ACCEPTABLE_WITH_WARNING | Explicit user request after handoff | Review pipe approval source before committing as doctrine. |

## Files Currently Untracked

- `.firebase/hosting.YnVpbGRcd2ViX29zX2RlcGxveQ.cache`
- `mental-smile-os-runtime/signal-routing/CONTINUITY_CAPSULE_REGISTRY_V1.md`
- `mental-smile-os-runtime/signal-routing/EMERGENCY_EXCHANGE_REGISTRY_V1.md`
- `mental-smile-os-runtime/signal-routing/FORBIDDEN_DIRECT_ROUTES_V1.md`
- `mental-smile-os-runtime/signal-routing/GATEWAY_REGISTRY_V1.md`
- `mental-smile-os-runtime/signal-routing/GENERATION_1_SIGNAL_ROUTING_BOOTSTRAP_REPORT.md`
- `mental-smile-os-runtime/signal-routing/PIPE_REGISTRY_V1.md`
- `mental-smile-os-runtime/signal-routing/ROUTE_OWNERSHIP_RULES_V1.md`
- `mental-smile-os-runtime/signal-routing/SIGNAL_ROUTING_NEURAL_NETWORK_V1.md`
- `mental-smile-os-runtime/signal-routing/ZONE_REGISTRY_V1.md`
