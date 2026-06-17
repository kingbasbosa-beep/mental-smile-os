# LIBRARY_ARCHITECTURE_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7D
Runtime effect: none

## Scope

Library Domain includes Library, Knowledge, Categories, Web Library, Library Assets, and Library Routes.

## Active Architecture

| System | Primary Files | Classification | Health |
| --- | --- | --- | --- |
| Library page | `lib/features/library/presentation/pages/library_page.dart` | ACTIVE | PASS |
| Library policy page | `lib/features/library/presentation/pages/library_policy_page.dart` | ACTIVE | PASS |
| Library signal metadata | `lib/features/library/data/library_signal_metadata.dart` | ACTIVE | PASS |
| City library surface | `lib/features/s_city/presentation/pages/s_city_district_page.dart` | ACTIVE/FUTURE | PARTIAL |
| Library route integration | `lib/app/router/app_router.dart` | ACTIVE | PASS |

## Routes

| Route | Surface | Classification |
| --- | --- | --- |
| `/module/library` | App Library | ACTIVE |
| `/web/library` | Web Library | ACTIVE |
| `/web/library/policy` | Web Library Policy | ACTIVE |
| `/library` | Portal Library alias/surface | ACTIVE |
| `/s/city/library` | City Library future public knowledge surface | ACTIVE/FUTURE |

## Responsibilities

- Present knowledge categories.
- Present featured web library entries.
- Emit library category opened signal.
- Show educational/support policy.
- Provide app, web, and city library access surfaces.
- Preserve C6 visual lineage as archive evidence while using purified runtime assets.

## Dependencies

| Dependency | Purpose | Classification |
| --- | --- | --- |
| Signals package | library category opened event | ACTIVE |
| Library signal metadata | category and featured metadata labels | ACTIVE |
| App router | app/web/portal/city route entry | ACTIVE |
| AppAnalytics | path selection logging | ACTIVE |
| Runtime image assets | category cards and web cards | ACTIVE |
| Web branding assets | background and featured cards | ACTIVE |

## Measures

| Classification | Items |
| --- | --- |
| Active | library page, policy page, metadata, app/web routes, category assets |
| Legacy | C6 comments/lineage and C6 archive evidence |
| Dead | none confirmed |
| Duplicate | `/library`, `/web/library`, `/module/library` all enter LibraryPage with different return contexts |
| Unknown | real content collections, policy acceptance tracking, recommendation registry |

## Architecture Health

Library architecture is active and stable after C6 purification. Its main risk is that content, recommendations, and policy acceptance are not yet backed by dedicated registries or collections.
