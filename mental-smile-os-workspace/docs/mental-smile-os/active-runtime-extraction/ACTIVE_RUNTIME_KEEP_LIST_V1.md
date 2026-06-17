# ACTIVE_RUNTIME_KEEP_LIST_V1

## Purpose

List runtime areas that stay active for Generation 1 host execution.

## KEEP

| Item | Reason |
| --- | --- |
| Flutter project root | Current executable host. |
| `lib/main.dart` | Startup and Firebase initialization. |
| `lib/app/` | App shell, locale provider, router. |
| `lib/features/splash/` | Active splash implementation. |
| `lib/features/language/` | Active language screen. |
| `lib/features/auth/` | Active login and client registration. |
| `lib/features/home/` | Active menu/home hub. |
| `lib/features/library/` | Active library and policy pages. |
| `lib/features/signals/` | Active signal domain models, validators, emitters, storage. |
| `lib/features/monitoring/` | Active monitoring domain scaffolds and models. |
| `lib/features/sovereign_construction/` | Active construction workbench route and registry. |
| `lib/core/auth/` | Active account access and role resolution. |
| `lib/shared/` | Shared UI, branding, contracts, gateways, analytics. |
| `lib/l10n/` | Active localization. |
| `web/` | Active web title/manifest. |
| `firebase.json` | Active hosting/rules/functions configuration. |
| `firestore.rules` | Active Firestore rules. |
| `storage.rules` | Active Storage rules. |

## KEEP WITH REVIEW

| Item | Reason |
| --- | --- |
| `lib/features/client/` | Active but not OS-pure Client Room; legacy dashboard survives temporarily. |
| `lib/features/clinician/` | Active provider room runtime; needs OS-room purity review. |
| `lib/features/centers/` | Active center runtime; needs OS-room purity review. |
| `lib/features/chat/` | Active chat and escalation runtime; authority and signal routing review required. |
| `lib/features/web_registration/` | Active provider/center registration; field parity and rules alignment required. |
| `lib/features/s_*` | Active sovereign/city/capital placeholders; many are scaffolds. |
| `functions/` | Active Firebase Functions source; production authority review required. |
| `android/` | Active Android host; legacy package identity remains. |
