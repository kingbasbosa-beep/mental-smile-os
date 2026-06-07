import '../models/field_parity_models.dart';

class FieldParityRegistry {
  const FieldParityRegistry._();

  static const List<FieldParityProfile> parityProfiles = <FieldParityProfile>[
    FieldParityProfile(
      parityId: 'display_name_parity',
      registrationField: 'display_name',
      profileField: 'display_name',
      publicPageField: 'display_name',
      dashboardField: 'display_name',
    ),
    FieldParityProfile(
      parityId: 'capability_signals_parity',
      registrationField: 'capability_signals',
      profileField: 'capability_signals',
      publicPageField: 'capability_signals',
      dashboardField: 'capability_summary',
    ),
    FieldParityProfile(
      parityId: 'accessibility_signals_parity',
      registrationField: 'accessibility_signals',
      profileField: 'accessibility_signals',
      publicPageField: 'accessibility_summary',
      dashboardField: 'accessibility_preferences',
    ),
  ];
}
