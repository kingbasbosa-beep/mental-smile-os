# Saved Destinations Extraction Report V1

Operation ID: OP-SAVED-DESTINATIONS-EXTRACTION-V1
Date: 2026-06-18
Execution Mode: SURGICAL_REMOVAL
Final Verdict: SAVED_DESTINATIONS_REMOVED_PENDING_OWNER_VERIFICATION

## Summary

Saved destinations were removed from active runtime because stored destination memory conflicts with Fresh Signals doctrine and session-first client access.

The extraction removed the Firestore collection rule, repository/model/barrel, provider and center save actions, and `destination_saved` signal producer/registry/validator/monitoring references.

## Files Deleted

- `lib/features/saved_destinations/data/saved_destination_repository.dart`
- `lib/features/saved_destinations/domain/models/saved_destination.dart`
- `lib/features/saved_destinations/saved_destinations.dart`

## Files Modified

- `firestore.rules`
- `lib/app/router/app_router.dart`
- `lib/features/centers/presentation/pages/center_details_page.dart`
- `lib/features/specialists/presentation/specialist_details_page.dart`
- `lib/features/library/data/library_signal_metadata.dart`
- `lib/features/signals/domain/factories/signal_package_factory.dart`
- `lib/features/signals/domain/registries/signal_type_registry.dart`
- `lib/features/signals/domain/validators/signal_aggregation_validator.dart`
- `lib/features/signals/domain/models/signal_aggregate_read_models.dart`
- `lib/features/monitoring/domain/adapters/monitoring_aggregation_adapter.dart`
- `lib/features/monitoring/domain/validators/monitoring_aggregate_validator.dart`
- `lib/features/monitoring/domain/registries/residential_monitoring_category_registry.dart`
- `lib/features/monitoring/residential/aggregates/residential_signal_aggregate.dart`
- `lib/features/monitoring/residential/application/residential_monitoring_snapshot_builder.dart`
- `lib/features/monitoring/residential/domain/residential_monitoring_registry.dart`
- `lib/features/monitoring/residential/models/residential_monitoring_snapshot.dart`
- `docs/constitutional-baseline/cards/decision/SAVED_DESTINATIONS_EXTRACTION_DECISION_V1.md`
- `docs/constitutional-baseline/cards/archive/ARCHIVE_CARD_SAVED_DESTINATIONS_V1.md`
- `docs/constitutional-baseline/findings/FINDING_SAVED_DESTINATIONS_CONFLICTS_WITH_FRESH_SIGNALS_V1.md`
- `docs/constitutional-baseline/operations/SAVED_DESTINATIONS_EXTRACTION_REPORT_V1.md`
- `docs/constitutional-baseline/operations/EXECUTED_OPERATIONS_REGISTRY_V1.md`
- `docs/constitutional-baseline/operations/EXECUTED_OPERATIONS_INDEX_V1.md`
- affected constitutional registries listed below

## Collection Rules Removed

- Removed Firestore rule block: `/saved_destinations/{savedId}`.

No Firebase deploy was performed.

## Signals Removed

- Removed `destination_saved` from active runtime signal registry.
- Removed `SignalPackageFactory.destinationSaved`.
- Removed `destination_saved` from aggregation eligibility and monitoring readable signal types.
- Removed saved destination residential monitoring aggregate kind and summary path.

## UI Buttons Removed / Rewired

- Removed provider details save button.
- Removed center details save button.
- Removed saved destination language from provider and center contact success snackbars.
- Removed S City Library placeholder item `Saved destination targets`.

The active contact and accessible contact paths remain preserved.

## Registries Updated

- Operations Registry
- Operations Index
- Governance Decision Registry
- Finding Registry
- Finding Memory Registry
- Memory Registry
- Archive Registry
- Collection Registry
- Signal Governance Registry
- Signal Ownership Registry
- Residential Signal Ownership Registry
- Residential Collection Ownership Registry
- Commercial Collection Ownership Registry
- Commercial Route Ownership Registry

## Active Replacements Preserved

- provider profile opened signal;
- center profile opened signal;
- provider contact requested signal;
- center contact requested signal;
- accessible contact requested signal;
- accessible contact completed signal;
- accessible provider selected signal;
- accessible center selected signal;
- accessibility resource opened signals;
- session/visitor signal capability.

## Verification

Active code search was performed for:

- `saved_destinations`
- `SavedDestination`
- `destination_saved`
- `saveDestination`
- `watchSessionDestinations`

Result: no active references remained in `lib`, `firestore.rules`, `firestore.indexes.json`, `pubspec.yaml`, or `lib/l10n`.

Historical documentation and registries preserve archive references intentionally.

## Blockers

No blockers found for saved destinations extraction.

Generic `destination_aggregates` and aggregate lifecycle governance remain outside this surgical removal scope and should be handled only by a separate Owner-approved audit or removal operation.

## Manual Commands Required

```text
dart format lib/app/router/app_router.dart lib/features/centers/presentation/pages/center_details_page.dart lib/features/specialists/presentation/specialist_details_page.dart lib/features/library/data/library_signal_metadata.dart lib/features/signals/domain/factories/signal_package_factory.dart lib/features/signals/domain/registries/signal_type_registry.dart lib/features/signals/domain/validators/signal_aggregation_validator.dart lib/features/signals/domain/models/signal_aggregate_read_models.dart lib/features/monitoring/domain/adapters/monitoring_aggregation_adapter.dart lib/features/monitoring/domain/validators/monitoring_aggregate_validator.dart lib/features/monitoring/domain/registries/residential_monitoring_category_registry.dart lib/features/monitoring/residential/aggregates/residential_signal_aggregate.dart lib/features/monitoring/residential/application/residential_monitoring_snapshot_builder.dart lib/features/monitoring/residential/domain/residential_monitoring_registry.dart lib/features/monitoring/residential/models/residential_monitoring_snapshot.dart
flutter analyze
flutter build apk --debug
flutter build web
```

## Final Verdict

SAVED_DESTINATIONS_REMOVED_PENDING_OWNER_VERIFICATION
