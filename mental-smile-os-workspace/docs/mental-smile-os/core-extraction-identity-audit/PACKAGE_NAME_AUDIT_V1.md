# PACKAGE_NAME_AUDIT_V1

## Purpose

Record exact package-name residue.

## Root Package

| File | Exact Text | Classification | Action |
| --- | --- | --- | --- |
| `pubspec.yaml:1` | `name: flutterprojects` | RENAME | Replace with OS-owned package name in package identity phase. |

## Active Dart Imports

74 files contain `package:flutterprojects`.

Classification: RENAME.

Action: bulk import rewrite only after package name decision.

## Exact Files

- `lib/main.dart`
- `lib/shared/branding/mental_smile_logo.dart`
- `lib/dev/domain_status_seeder.dart`
- `lib/dev/ai_policy_seeder.dart`
- `lib/shared/gateways/role_access_gateway.dart`
- `lib/shared/ui_kit/app_shell_actions.dart`
- `lib/shared/ui_kit/app_widgets.dart`
- `lib/shared/ui_kit/asset_fallback_widgets.dart`
- `lib/core/system/domain_status_service.dart`
- `lib/core/system/domain_governance_capability.dart`
- `lib/core/auth/presentation/pages/account_blocked_page.dart`
- `lib/core/auth/account_access_service.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/features/home/presentation/pages/home_page.dart`
- `lib/app/router/app_router.dart`
- `lib/features/auth/presentation/pages/login_page.dart`
- `lib/features/auth/presentation/pages/client_register_page.dart`
- `lib/app/app.dart`
- `lib/features/clinician/presentation/pages/clinician_room_page.dart`
- `lib/features/chat/presentation/pages/clinician_chat_inbox_page.dart`
- `lib/features/chat/presentation/pages/chat_page.dart`
- `lib/features/contact_requests/data/contact_request_repository.dart`
- `lib/features/chat/presentation/pages/chat_escalation_report_page.dart`
- `lib/features/library/presentation/pages/library_policy_page.dart`
- `lib/features/library/presentation/pages/library_page.dart`
- `lib/features/assistant/presentation/widgets/bounded_assistant_panel.dart`
- `lib/features/chat/data/services/chat_firestore_service.dart`
- `lib/features/chat/data/services/chat_ai_service.dart`
- `lib/features/chat/controller/chat_controller.dart`
- `lib/features/language/presentation/pages/language_page.dart`
- `lib/features/saved_destinations/data/saved_destination_repository.dart`
- `lib/features/centers/presentation/pages/center_room_page.dart`
- `lib/features/centers/presentation/pages/center_details_page.dart`
- `lib/features/centers/presentation/pages/center_dashboard_page.dart`
- `lib/features/centers/presentation/pages/centers_list_page.dart`
- `lib/features/centers/presentation/pages/centers_landing_page.dart`
- `lib/features/safety/presentation/pages/chat_escalations_page.dart`
- `lib/features/s_capital/presentation/pages/s_capital_operations_office_page.dart`
- `lib/features/centers/data/services/centers_firestore_service.dart`
- `lib/features/s_declaration_review_room/presentation/pages/s_declaration_review_room_page.dart`
- `lib/features/centers/data/models/center_model.dart`
- `lib/features/splash/presentation/pages/splash_page.dart`
- `lib/features/s_city/presentation/pages/s_city_district_page.dart`
- `lib/features/monitoring/domain/validators/monitoring_aggregate_validator.dart`
- `lib/features/specialists/presentation/specialist_details_page.dart`
- `lib/features/specialists/presentation/specialists_list_page.dart`
- `lib/features/specialists/presentation/specialists_categories_page.dart`
- `lib/features/s_owner/presentation/pages/s_owner_district_page.dart`
- `lib/features/modules/presentation/pages/support_entry_page.dart`
- `lib/features/monitoring/domain/builders/monitoring_snapshot_builder.dart`
- `lib/features/monitoring/domain/adapters/monitoring_aggregation_adapter.dart`
- `lib/features/sovereign_construction/presentation/pages/sovereign_construction_workbench_page.dart`
- `lib/features/monitoring/residential/domain/residential_monitoring_router.dart`
- `lib/features/monitoring/residential/domain/residential_monitoring_registry.dart`
- `lib/features/monitoring/residential/domain/residential_monitoring_boundary.dart`
- `lib/features/monitoring/commercial/routing/commercial_monitoring_router.dart`
- `lib/features/monitoring/residential/aggregates/residential_signal_aggregate.dart`
- `lib/features/s_registry_room/presentation/pages/s_registry_room_page.dart`
- `lib/features/monitoring/commercial/registry/commercial_monitoring_registry.dart`
- `lib/features/monitoring/commercial/models/universal_info_card_contract.dart`
- `lib/features/monitoring/commercial/aggregates/commercial_signal_aggregate.dart`
- `lib/features/monitoring/commercial/domain/commercial_monitoring_boundary.dart`
- `lib/features/modules/presentation/pages/support_issue_selector_page.dart`
- `lib/features/s_personal_space/presentation/widgets/signal_communication_board.dart`
- `lib/features/web_registration/presentation/pages/web_center_documents_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_media_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_documents_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_registration_success_page.dart`

## Risk

Risk Level: HIGH.

Renaming the package requires coordinated updates to `pubspec.yaml`, imports, tests, generated references, and validation commands.
