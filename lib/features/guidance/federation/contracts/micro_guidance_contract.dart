import 'package:flutterprojects/features/localization/federation/models/federation_localized_text.dart';

class MicroGuidanceContract {
  const MicroGuidanceContract({
    required this.targetType,
    required this.targetId,
    required this.microText,
    required this.easyMicroText,
    required this.iconKey,
    required this.audioLabel,
    required this.screenReaderLabel,
  });

  final String targetType;
  final String targetId;
  final FederationLocalizedText microText;
  final FederationLocalizedText easyMicroText;
  final String iconKey;
  final FederationLocalizedText audioLabel;
  final FederationLocalizedText screenReaderLabel;
}
