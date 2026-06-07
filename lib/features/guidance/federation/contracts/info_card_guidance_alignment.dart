import 'package:flutterprojects/features/identity/federation/models/accessibility_visual_profile.dart';
import 'package:flutterprojects/features/localization/federation/models/federation_localized_text.dart';
import 'package:flutterprojects/features/reports/federation/models/department_visual_identity.dart';

class InfoCardGuidanceAlignment {
  const InfoCardGuidanceAlignment({
    required this.cardContractId,
    required this.title,
    required this.departmentIdentity,
    required this.accessibilityProfile,
    required this.guidanceReference,
  });

  final String cardContractId;
  final FederationLocalizedText title;
  final DepartmentVisualIdentity departmentIdentity;
  final AccessibilityVisualProfile accessibilityProfile;
  final String guidanceReference;
}
