import '../models/federation_localized_text.dart';

class GuidanceTextContract {
  const GuidanceTextContract({
    required this.guidanceId,
    required this.title,
    required this.shortText,
    required this.easyText,
    required this.audioLabel,
    required this.screenReaderLabel,
    required this.category,
  });

  final String guidanceId;
  final FederationLocalizedText title;
  final FederationLocalizedText shortText;
  final FederationLocalizedText easyText;
  final FederationLocalizedText audioLabel;
  final FederationLocalizedText screenReaderLabel;
  final String category;
}
