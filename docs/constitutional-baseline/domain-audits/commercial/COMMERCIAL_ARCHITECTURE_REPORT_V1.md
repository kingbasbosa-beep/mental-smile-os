# COMMERCIAL_ARCHITECTURE_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7B
Runtime effect: none

## Scope

Commercial Domain includes Specialists, Centers, Tools, Commercial Discovery, Provider Contact Requests, and Center Contact Requests.

## Active Architecture

| System | Primary Files | Classification | Status |
| --- | --- | --- | --- |
| Specialists categories | `lib/features/specialists/presentation/specialists_categories_page.dart` | ACTIVE | PASS |
| Specialists list | `lib/features/specialists/presentation/specialists_list_page.dart` | ACTIVE | PASS |
| Specialist details | `lib/features/specialists/presentation/specialist_details_page.dart` | ACTIVE | PASS |
| Clinician specialty catalog | `lib/features/specialists/data/clinician_specialty_catalog.dart` | ACTIVE | PASS |
| Centers landing | `lib/features/centers/presentation/pages/centers_landing_page.dart` | ACTIVE | PASS |
| Centers list | `lib/features/centers/presentation/pages/centers_list_page.dart` | ACTIVE | PASS |
| Center details | `lib/features/centers/presentation/pages/center_details_page.dart` | ACTIVE | PASS |
| Centers Firestore service | `lib/features/centers/data/services/centers_firestore_service.dart` | ACTIVE | PASS |
| Contact requests | `lib/features/contact_requests/**` | ACTIVE | PASS |
| City commercial surfaces | `lib/features/s_city/presentation/pages/s_city_district_page.dart` | ACTIVE/FUTURE | PARTIAL |
| Tools | `Routes.sCityTools` placeholder city surface | UNKNOWN | PARTIAL |
| Marketplace | `Routes.sCityMarketplace` placeholder city surface | UNKNOWN | PARTIAL |

## Responsibilities

- Specialists: provider/clinician discovery, specialty categories, provider signals, detail view, contact request creation.
- Centers: center discovery, center categories, visible center streams, detail view, contact request creation.
- Tools: future public tool catalog.
- Commercial Discovery: city surfaces, module discovery, public portal paths.
- Contact Requests: non-booking request capture for provider and center contact.

## Dependencies

| Dependency | Purpose | Classification |
| --- | --- | --- |
| Firestore `clinicians` | specialists discovery | ACTIVE |
| Firestore `centers` | centers discovery | ACTIVE |
| ContactRequestRepository | provider/center contact request writes | ACTIVE |
| SavedDestinationRepository | save provider/center paths with signal tags | ACTIVE |
| Signals package | provider/center signal tags and support handoff | ACTIVE |
| AppAnalytics | discovery path telemetry | ACTIVE |
| VisibilityReadinessStreams | visible center documents | ACTIVE |
| App Router | route topology | ACTIVE |

## Measures

| Classification | Items |
| --- | --- |
| Active | specialists, centers, contact requests, commercial discovery routes |
| Legacy | provider naming as commercial umbrella while runtime identity is clinician |
| Dead | none confirmed |
| Duplicate | provider vs clinician naming; support/discovery entry overlap |
| Unknown | tools registry, marketplace implementation, organizations/programs surfaces |

## Architecture Health

Commercial architecture is active for specialists and centers, with contact request flows replacing booking behavior. Tools and marketplace exist mostly as future surfaces and need registry hardening before expansion.
