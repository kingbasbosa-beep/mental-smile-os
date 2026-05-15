# Clean Core Separation Risk Register

Draft risk register for future extraction. No package extraction, runtime activation, provider integration, or deployment work was performed.

| Risk | Severity | Status | Mitigation |
| --- | --- | --- | --- |
| Legacy imports escape clean_core | High | Needs review | Run manual import audit before extraction. |
| App package name embedded in code/docs | Medium | Needs review | Replace only after package identity is approved. |
| Firebase initialization leaks into exported code | High | Not safe yet | Keep Firebase setup app-owned; expose only boundary contracts. |
| Firestore collection assumptions become package API | High | Needs review | Document server-owned boundaries and avoid exporting app data flows prematurely. |
| Router coupling blocks extraction | High | Not safe yet | Define route adapter/interface before moving feature UI. |
| Generated localization coupling | Medium | Needs review | Create l10n strategy for package vs app ownership. |
| Asset path coupling | Medium | Needs review | Create asset manifest and ownership plan. |
| Platform-specific coupling | High | Not safe yet | Keep Android/iOS/web setup in app shell. |
| Generated file dependencies | Medium | Needs review | Avoid exporting generated files until generation workflow is stable. |
| Test/emulator assumptions fail outside app | Medium | Needs review | Create standalone emulator/test plan before extraction. |
| Placeholder runtime contracts mistaken for active systems | High | Open | Keep explicit docs stating runtime AI/provider/backend orchestration are disabled. |
| Deferred admin/chat/payment/AI/legal/crisis flows exported too early | High | Open | Keep deferred routes and runtime flows app-bound until separately implemented. |

## Files That Should Not Be Exported Yet

- App shell and route orchestration files.
- Firebase options and app initialization files.
- Feature pages that directly read/write Firestore.
- Generated localization and generated plugin/config files.
- Platform-specific Android/iOS/web setup.
- Deferred placeholder route implementations that represent unfinished app behavior.
- Any legacy migration bridge or adapter still depending on current app structure.

## Recommended Separation Order

1. Export documentation and pure Dart contracts first.
2. Add explicit public API files only after import graph verification.
3. Keep Firebase, routing, localization, assets, and platform setup app-owned.
4. Split tests into pure contract tests and app/emulator tests.
5. Review feature modules one by one for dependency inversion.
6. Only then plan package extraction, pubspec changes, and app integration updates.

## Non-Action Confirmation

This risk register documents future separation risks only. No extraction, file movement, pubspec change, Firebase setup, provider integration, runtime activation, or deployment was performed.
