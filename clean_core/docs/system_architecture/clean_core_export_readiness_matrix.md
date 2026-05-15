# Clean Core Export Readiness Matrix

Draft matrix for future clean_core separation. No extraction was performed.

| Area | Status | Export Readiness | Notes |
| --- | --- | --- | --- |
| Pure governance contracts | Safe to export later | High | Must verify imports remain internal and package-safe. |
| Legal consent foundation | Safe to export later | High | Suitable if it stays model/helper oriented and excludes final legal runtime. |
| AI safety placeholders | Safe to export later | High | Runtime remains disabled; no provider calls. |
| Runtime governance foundations | Safe to export later | High | Contract-only layers added through OS-7/OS-8A. |
| Documentation | Safe to export later | High | Draft docs should travel with extracted package or adjacent compliance docs. |
| Contract tests and fixtures | Needs review | Medium | Must confirm no live Firebase, emulator startup, or app package assumptions. |
| Feature UI pages | Not safe yet | Low | Likely coupled to app router, Firebase, localization, assets, or global app state. |
| Registration/booking/dashboard flows | Needs review | Medium | Clean-core migrated, but Firestore and app rules posture are still app-bound. |
| Router definitions | Not safe yet | Low | Current app navigation and placeholder routes should remain app-owned. |
| Firebase options/init | Not safe yet | Low | Must not become exported package responsibility without a boundary contract. |
| Assets | Needs review | Medium | Requires standalone asset strategy and pubspec mapping. |
| Localization/l10n | Needs review | Medium | Generated localization must be separated from reusable contracts. |
| Platform-specific setup | Not safe yet | Low | Android/iOS/web setup should remain app-owned. |
| Generated files | Not safe yet | Low | Generated outputs should not define stable package API without a generation strategy. |
| Legacy feature dependencies | Needs review | Medium | Must identify any remaining imports or runtime assumptions. |
| Environment/config assumptions | Needs review | Medium | Runtime environment foundations exist, but no extracted config contract is active. |

## Readiness Labels

- Safe to export later: structurally suitable, pending import verification and public API decision.
- Needs review: may be exportable after boundary cleanup and manual verification.
- Not safe yet: should remain app-owned until blockers are resolved.

## Separation Recommendation

Start with pure Dart contracts and documentation only. Leave UI, router, Firebase, generated files, platform setup, assets, localization, and feature flows inside the app until dedicated boundaries are reviewed.
