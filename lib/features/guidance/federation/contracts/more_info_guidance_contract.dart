import 'package:flutterprojects/features/localization/federation/models/federation_localized_text.dart';

class MoreInfoGuidanceContract {
  const MoreInfoGuidanceContract({
    required this.whatIsIt,
    required this.whoMayBenefit,
    required this.whatItDoes,
    required this.whatItDoesNotDo,
    required this.limits,
    required this.learnMoreReference,
  });

  final FederationLocalizedText whatIsIt;
  final FederationLocalizedText whoMayBenefit;
  final FederationLocalizedText whatItDoes;
  final FederationLocalizedText whatItDoesNotDo;
  final FederationLocalizedText limits;
  final String learnMoreReference;
}
