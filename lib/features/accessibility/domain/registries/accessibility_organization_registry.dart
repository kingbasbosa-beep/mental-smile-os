import '../models/accessibility_organization.dart';
import '../models/accessibility_organization_category.dart';

class AccessibilityOrganizationRegistry {
  const AccessibilityOrganizationRegistry._();

  static const List<AccessibilityOrganizationCategory> categories =
      AccessibilityOrganizationCategory.values;

  // Phase 11 creates the governed directory surface, not verified seed data.
  static const List<AccessibilityOrganization> organizations =
      <AccessibilityOrganization>[];

  static List<AccessibilityOrganization> byCategory(
    AccessibilityOrganizationCategory? category,
  ) {
    if (category == null) return organizations;
    return organizations
        .where((organization) => organization.category == category)
        .toList(growable: false);
  }
}
