# ADMINISTRATIVE_ARCHITECTURE_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7C
Runtime effect: none

## Scope

Administrative Domain includes Web Registration, Clinician Registration, Center Registration, Declaration Review, and Profile Change Requests.

## Active Architecture

| System | Primary Files | Classification | Health |
| --- | --- | --- | --- |
| Client registration | `lib/features/auth/presentation/pages/client_register_page.dart` | ACTIVE | PASS |
| Login and role routing | `lib/features/auth/presentation/pages/login_page.dart` | ACTIVE | PASS |
| Web registration background | `lib/features/web_registration/presentation/web_registration_background.dart` | ACTIVE | PASS |
| Clinician web registration | `web_clinician_register_portal_page.dart` | ACTIVE | PASS |
| Clinician profile declaration | `web_clinician_profile_page.dart` | ACTIVE | PASS |
| Clinician documents declaration | `web_clinician_documents_page.dart` | ACTIVE | PASS |
| Center web registration | `web_center_register_portal_page.dart` | ACTIVE | PASS |
| Center profile declaration | `web_center_profile_page.dart` | ACTIVE | PASS |
| Center media declaration | `web_center_media_page.dart` | ACTIVE | PASS |
| Center pricing declaration | `web_center_pricing_page.dart` | ACTIVE | PASS |
| Center documents declaration | `web_center_documents_page.dart` | ACTIVE | PASS |
| Registration success | `web_registration_success_page.dart` | ACTIVE | PASS |
| Declaration readiness | `lib/features/web_registration/domain/declaration_readiness.dart` | ACTIVE | PASS |
| Declaration Review Room | `s_declaration_review_room_page.dart` | ACTIVE_READ_ONLY | PASS |
| Clinician profile change request | `clinician_room_page.dart` | ACTIVE | PASS |
| Center profile change request | `center_room_page.dart` | ACTIVE | PASS |

## Responsibilities

- Register client accounts.
- Register clinician accounts and declaration data.
- Register center accounts and declaration data.
- Compute readiness/visibility signals.
- Observe declarations through Declaration Review Room.
- Store clinician and center profile change declarations.

## Dependencies

| Dependency | Purpose | Classification |
| --- | --- | --- |
| Firebase Auth | account creation/login/session state | ACTIVE |
| Cloud Firestore | clients, clinicians, centers, profile change request collections | ACTIVE |
| Declaration readiness domain | readiness and visibility signal derivation | ACTIVE |
| Role access gateway/router | declaration reviewer authority and role routing | ACTIVE |
| Web registration assets | responsive registration background | ACTIVE |
| App localization | login/client registration generated labels | PARTIAL |

## Measures

| Classification | Items |
| --- | --- |
| Active | client/clinician/center registration, declaration readiness, declaration review, profile change requests |
| Legacy | `/register/provider` and provider terminology |
| Dead | none confirmed |
| Duplicate | native aliases and web routes for clinician/center registration |
| Unknown | full declaration decision workflow beyond read-only review |

## Architecture Health

Administrative architecture is active and aligned with Admin Zero intent: review is named Declaration Review and observed read-only. The biggest gaps are authority registry hardening and the distinction between observation, approval, and profile mutation.
