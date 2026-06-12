# LOCALIZATION AUDIT REPORT

Discovery-only audit. No ARB, generated localization, Dart, or pubspec files were modified.

## Localization Files

- `lib/l10n/app_ar.arb`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_localizations.dart`
- `lib/l10n/app_localizations_ar.dart`
- `lib/l10n/app_localizations_en.dart`

## Localization Wrappers / Helpers / Services

- `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/lib/app/locale_provider.dart`
- `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/lib/core/storage/locale_storage.dart`
- `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/lib/l10n/app_localizations.dart`
- `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/lib/l10n/app_localizations_ar.dart`
- `_archive/clean_core_legacy_flutterprojects_snapshot_2026-05-25/lib/l10n/app_localizations_en.dart`
- `lib/app/locale_provider.dart`
- `lib/core/storage/locale_storage.dart`
- `lib/features/localization/federation/contracts/guidance_text_contract.dart`
- `lib/features/localization/federation/models/accessibility_text_profile.dart`
- `lib/features/localization/federation/models/department_localization_profile.dart`
- `lib/features/localization/federation/models/federation_localized_text.dart`
- `lib/features/localization/federation/models/info_card_localization_profile.dart`
- `lib/features/localization/federation/registry/contact_language_standard.dart`
- `lib/features/localization/federation/registry/report_localization_map.dart`
- `lib/l10n/app_localizations.dart`
- `lib/l10n/app_localizations_ar.dart`
- `lib/l10n/app_localizations_en.dart`

## Summary

- Total Keys: **205**
- Active Keys: **95**
- Unused Keys: **106**
- Missing Keys: **1**
- Hardcoded Strings: **7003**
- Mojibake Count: **0 key entries**
- Duplicate Meanings: **22 groups**
- Old Doctrine Findings: **771 combined key/hardcoded findings**

## Registry Distribution

| Registry | Keys |
|---|---:|
| AUTH_SYSTEM | 34 |
| BRANDING_SYSTEM | 1 |
| CENTER_ROOM | 64 |
| CITY_SYSTEM | 23 |
| CLIENT_ROOM | 9 |
| LIBRARY_SYSTEM | 1 |
| PROVIDER_ROOM | 49 |
| SAFETY_SYSTEM | 24 |

## Top Risks

1. ARB mojibake findings: 0 key entries detected by UTF-8 scan; PowerShell console may display Arabic incorrectly but file content parsed as valid Unicode.
2. Old doctrine vocabulary remains in 771 key/hardcoded findings.
3. 106 keys have no direct current Dart reference outside generated localization files.
4. 7003 hardcoded human-facing string candidates were found across current and archived Dart files.
5. 22 duplicate-meaning groups require semantic consolidation decisions.
6. Generated localization files mirror ARB content; they should not be treated as proof that a key is actively consumed.
7. Mixed terminology appears across request/review/support/status wording and needs constitutional vocabulary decisions.
8. One or more key parity gaps block a clean governance freeze until resolved.

## Final Question

Is the localization system ready for constitutional governance?

**NO**

Blockers:

- Hardcoded text inventory must be carded or moved into localization keys in a later implementation phase.
- Old doctrine language must be constitutionally reviewed before final terminology freeze.
- Unused and missing keys need ownership decisions before key retirement or migration.
- Duplicate meanings require semantic consolidation decisions.
- Key usage must be validated after excluding generated localization getters.