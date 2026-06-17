# RESIDENTIAL_LOCALIZATION_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7A
Runtime effect: none

## Localization Files

| File | Status |
| --- | --- |
| `lib/l10n/app_ar.arb` | ACTIVE |
| `lib/l10n/app_en.arb` | ACTIVE |
| `lib/l10n/app_localizations.dart` | ACTIVE |
| `lib/l10n/app_localizations_ar.dart` | ACTIVE |
| `lib/l10n/app_localizations_en.dart` | ACTIVE |

## Residential Localization Pattern

| Area | Pattern | Classification |
| --- | --- | --- |
| Router fallback | `AppLocalizations.of(context)` for route-not-found strings | ACTIVE |
| Client Room | direct `Localizations.localeOf(context)` and inline Arabic/English strings | ACTIVE_PARTIAL |
| Personal Space | direct locale checks and inline Arabic/English strings | ACTIVE_PARTIAL |
| Chat | direct locale checks and inline Arabic/English strings | ACTIVE_PARTIAL |
| Support flows | direct locale checks and inline Arabic/English strings | ACTIVE_PARTIAL |
| Support Room | English-heavy static text | UNKNOWN |

## Measures

| Classification | Items |
| --- | --- |
| Active | generated l10n files, route fallback localization |
| Legacy | none confirmed |
| Dead | none confirmed |
| Unknown | complete key coverage for residential text |
| Duplicate | repeated inline bilingual strings across residential surfaces |
| Missing | Residential localization key registry |

## Localization Health

Residential localization is functional but not fully centralized. Runtime surfaces frequently use direct locale checks and inline bilingual text instead of generated ARB keys.
