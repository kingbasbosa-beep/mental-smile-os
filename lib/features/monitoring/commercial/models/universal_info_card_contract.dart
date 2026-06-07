import 'package:flutterprojects/features/localization/federation/models/federation_localized_text.dart';

class UniversalInfoCardContract {
  const UniversalInfoCardContract({
    required this.title,
    required this.icon,
    required this.shortDescription,
    required this.learnMoreReference,
    this.audioReference,
    this.cardIdentityProfile,
    this.accessibilityProfile,
    this.contentType,
    this.titleLocalized,
    this.shortDescriptionLocalized,
    this.learnMoreLabelLocalized,
    this.audioLabelLocalized,
    this.screenReaderLabelLocalized,
  });

  final String title;
  final String icon;
  final String shortDescription;
  final String learnMoreReference;
  final String? audioReference;
  final String? cardIdentityProfile;
  final String? accessibilityProfile;
  final String? contentType;
  final FederationLocalizedText? titleLocalized;
  final FederationLocalizedText? shortDescriptionLocalized;
  final FederationLocalizedText? learnMoreLabelLocalized;
  final FederationLocalizedText? audioLabelLocalized;
  final FederationLocalizedText? screenReaderLabelLocalized;
}
