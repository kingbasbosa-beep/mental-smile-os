import 'federation_localized_text.dart';

class InfoCardLocalizationProfile {
  const InfoCardLocalizationProfile({
    required this.titleLocalized,
    required this.shortDescriptionLocalized,
    required this.learnMoreLabelLocalized,
    required this.audioLabelLocalized,
    required this.screenReaderLabelLocalized,
  });

  final FederationLocalizedText titleLocalized;
  final FederationLocalizedText shortDescriptionLocalized;
  final FederationLocalizedText learnMoreLabelLocalized;
  final FederationLocalizedText audioLabelLocalized;
  final FederationLocalizedText screenReaderLabelLocalized;
}
