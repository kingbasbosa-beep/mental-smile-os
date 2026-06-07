import 'package:flutterprojects/features/localization/federation/models/federation_localized_text.dart';

class ComplaintGuidanceCard {
  const ComplaintGuidanceCard({
    required this.complaintType,
    required this.internalPlatformPath,
    required this.externalAuthorityName,
    required this.externalAuthorityContact,
    required this.externalAuthorityLink,
    required this.safetyNotice,
  });

  final String complaintType;
  final String internalPlatformPath;
  final FederationLocalizedText externalAuthorityName;
  final String externalAuthorityContact;
  final String externalAuthorityLink;
  final FederationLocalizedText safetyNotice;
}
