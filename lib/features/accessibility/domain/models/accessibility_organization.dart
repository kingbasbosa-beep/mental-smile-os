import 'accessibility_organization_category.dart';

class AccessibilityOrganization {
  const AccessibilityOrganization({
    required this.name,
    required this.country,
    required this.category,
    required this.website,
    required this.email,
    required this.whatsapp,
    this.isVerified = false,
  });

  final String name;
  final String country;
  final AccessibilityOrganizationCategory category;
  final String website;
  final String email;
  final String whatsapp;
  final bool isVerified;
}
