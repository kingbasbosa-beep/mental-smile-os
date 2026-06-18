import '../models/accessibility_resource_type.dart';

class AccessibilityResourceTypeRegistry {
  const AccessibilityResourceTypeRegistry._();

  static const List<AccessibilityResourceType> values =
      AccessibilityResourceType.values;

  static String label(
    AccessibilityResourceType type, {
    required bool isArabic,
  }) {
    switch (type) {
      case AccessibilityResourceType.government:
        return isArabic ? 'حكومي' : 'Government';
      case AccessibilityResourceType.ngo:
        return isArabic ? 'منظمة أهلية' : 'NGO';
      case AccessibilityResourceType.association:
        return isArabic ? 'جمعية' : 'Association';
      case AccessibilityResourceType.library:
        return isArabic ? 'مكتبة' : 'Library';
      case AccessibilityResourceType.international:
        return isArabic ? 'دولي' : 'International';
      case AccessibilityResourceType.educational:
        return isArabic ? 'تعليمي' : 'Educational';
      case AccessibilityResourceType.complaintChannel:
        return isArabic ? 'قناة شكاوى' : 'Complaint channel';
      case AccessibilityResourceType.emergency:
        return isArabic ? 'طوارئ' : 'Emergency';
      case AccessibilityResourceType.accessibilityTool:
        return isArabic ? 'أداة وصول' : 'Accessibility tool';
    }
  }
}
