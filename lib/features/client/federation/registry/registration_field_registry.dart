import '../models/registration_alignment_models.dart';
import 'registration_field_classification.dart';

class RegistrationFieldRegistry {
  const RegistrationFieldRegistry._();

  static const List<RegistrationFieldProfile> fields =
      <RegistrationFieldProfile>[
    RegistrationFieldProfile(
      fieldId: 'display_name',
      displayName: 'Display Name',
      classification: RegistrationFieldClassification.publicVisible,
      ownerSurface: 'profile',
    ),
    RegistrationFieldProfile(
      fieldId: 'goal_signals',
      displayName: 'Goal Signals',
      classification: RegistrationFieldClassification.signalSource,
      ownerSurface: 'client',
    ),
    RegistrationFieldProfile(
      fieldId: 'accessibility_signals',
      displayName: 'Accessibility Signals',
      classification: RegistrationFieldClassification.guidanceSource,
      ownerSurface: 'client',
    ),
    RegistrationFieldProfile(
      fieldId: 'capability_signals',
      displayName: 'Capability Signals',
      classification: RegistrationFieldClassification.publicVisible,
      ownerSurface: 'provider_center',
    ),
    RegistrationFieldProfile(
      fieldId: 'documents',
      displayName: 'Documents',
      classification: RegistrationFieldClassification.reviewOnly,
      ownerSurface: 'declaration_review',
    ),
  ];
}
