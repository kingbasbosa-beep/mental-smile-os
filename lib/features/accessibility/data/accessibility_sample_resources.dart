import '../domain/models/accessibility_category.dart';
import '../domain/models/accessibility_disability_type.dart';
import '../domain/models/accessibility_resource.dart';
import '../domain/models/accessibility_resource_type.dart';

class AccessibilitySampleResources {
  const AccessibilitySampleResources._();

  static final DateTime _seededAt = DateTime.utc(2026, 1, 1);

  static final List<AccessibilityResource> values = <AccessibilityResource>[
    AccessibilityResource(
      id: 'who-disability',
      titleAr: 'منظمة الصحة العالمية: الإعاقة',
      titleEn: 'WHO: Disability',
      descriptionAr: 'معلومات عالمية عامة عن الإعاقة وإتاحة الخدمات.',
      descriptionEn: 'General global information about disability and access.',
      category: AccessibilityCategory.globalLibraries,
      disabilityType: AccessibilityDisabilityType.generalAccessibility,
      country: 'Global',
      language: 'en',
      resourceType: AccessibilityResourceType.international,
      url: 'https://www.who.int/health-topics/disability',
      tags: const <String>['global', 'rights', 'accessibility'],
      isVerified: true,
      isActive: true,
      createdAt: _seededAt,
      updatedAt: _seededAt,
    ),
    AccessibilityResource(
      id: 'un-crpd',
      titleAr: 'اتفاقية حقوق الأشخاص ذوي الإعاقة',
      titleEn: 'UN Convention on the Rights of Persons with Disabilities',
      descriptionAr: 'مرجع دولي لحقوق الأشخاص ذوي الإعاقة.',
      descriptionEn: 'International reference for disability rights.',
      category: AccessibilityCategory.rightsComplaints,
      disabilityType: AccessibilityDisabilityType.rightsComplaints,
      country: 'Global',
      language: 'ar,en',
      resourceType: AccessibilityResourceType.international,
      url:
          'https://www.ohchr.org/en/instruments-mechanisms/instruments/convention-rights-persons-disabilities',
      tags: const <String>['rights', 'complaints', 'policy'],
      isVerified: true,
      isActive: true,
      createdAt: _seededAt,
      updatedAt: _seededAt,
    ),
    AccessibilityResource(
      id: 'w3c-wai',
      titleAr: 'مبادرة إتاحة الويب',
      titleEn: 'W3C Web Accessibility Initiative',
      descriptionAr: 'أدلة وأدوات عامة لإتاحة المواقع والتطبيقات.',
      descriptionEn: 'Guidance and tools for web and app accessibility.',
      category: AccessibilityCategory.blindLowVision,
      disabilityType: AccessibilityDisabilityType.blindLowVision,
      country: 'Global',
      language: 'en',
      resourceType: AccessibilityResourceType.accessibilityTool,
      url: 'https://www.w3.org/WAI/',
      tags: const <String>['screen-reader', 'web', 'tools'],
      isVerified: true,
      isActive: true,
      createdAt: _seededAt,
      updatedAt: _seededAt,
    ),
  ];

  static List<AccessibilityResource> byCategory(
    AccessibilityCategory category,
  ) {
    return values
        .where((resource) => resource.category == category && resource.isActive)
        .toList(growable: false);
  }
}
