import 'package:flutterprojects/features/localization/federation/models/federation_localized_text.dart';

class UniversalGuidanceCard {
  const UniversalGuidanceCard({
    required this.guidanceId,
    required this.targetType,
    required this.targetId,
    required this.title,
    required this.shortText,
    required this.easyText,
    required this.visualIconKey,
    required this.audioLabel,
    required this.screenReaderLabel,
    required this.learnMoreReference,
    required this.accessibilityProfile,
    required this.identityProfile,
    required this.guidanceCategory,
  });

  final String guidanceId;
  final String targetType;
  final String targetId;
  final FederationLocalizedText title;
  final FederationLocalizedText shortText;
  final FederationLocalizedText easyText;
  final String visualIconKey;
  final FederationLocalizedText audioLabel;
  final FederationLocalizedText screenReaderLabel;
  final String learnMoreReference;
  final String accessibilityProfile;
  final String identityProfile;
  final String guidanceCategory;
}
