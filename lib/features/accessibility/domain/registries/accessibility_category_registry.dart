import 'package:flutter/material.dart';

import '../models/accessibility_category.dart';
import '../models/accessibility_disability_type.dart';

class AccessibilityCategoryRegistry {
  const AccessibilityCategoryRegistry._();

  static const List<AccessibilityCategoryEntry> entries =
      <AccessibilityCategoryEntry>[
    AccessibilityCategoryEntry(
      category: AccessibilityCategory.deafHardOfHearing,
      disabilityType: AccessibilityDisabilityType.deafHardOfHearing,
      titleAr: 'الصم وضعاف السمع',
      titleEn: 'Deaf & Hard of Hearing',
      descriptionAr: 'روابط موثوقة للتواصل، الحقوق، والتعليم الداعم.',
      descriptionEn: 'Trusted links for communication, rights, and learning.',
      icon: Icons.hearing_disabled_outlined,
      resourceCountPlaceholder: '0',
    ),
    AccessibilityCategoryEntry(
      category: AccessibilityCategory.blindLowVision,
      disabilityType: AccessibilityDisabilityType.blindLowVision,
      titleAr: 'المكفوفون وضعاف البصر',
      titleEn: 'Blind & Low Vision',
      descriptionAr: 'موارد قراءة، أدوات وصول، وجهات مساندة.',
      descriptionEn: 'Reading, access tools, and support destinations.',
      icon: Icons.visibility_outlined,
      resourceCountPlaceholder: '0',
    ),
    AccessibilityCategoryEntry(
      category: AccessibilityCategory.mobilityDisability,
      disabilityType: AccessibilityDisabilityType.mobilityDisability,
      titleAr: 'دعم الحركة والتنقل',
      titleEn: 'Mobility Support',
      descriptionAr: 'مداخل للحقوق والخدمات وأدوات الوصول الحركي.',
      descriptionEn: 'Rights, services, and mobility access resources.',
      icon: Icons.accessible_forward_outlined,
      resourceCountPlaceholder: '0',
    ),
    AccessibilityCategoryEntry(
      category: AccessibilityCategory.intellectualDisability,
      disabilityType: AccessibilityDisabilityType.intellectualDisability,
      titleAr: 'الدعم التعليمي والمعرفي',
      titleEn: 'Learning & Cognitive Support',
      descriptionAr: 'مصادر مبسطة وتعليمية للأسر والمستخدمين.',
      descriptionEn: 'Simplified and educational resources for users.',
      icon: Icons.school_outlined,
      resourceCountPlaceholder: '0',
    ),
    AccessibilityCategoryEntry(
      category: AccessibilityCategory.autismNeurodiversity,
      disabilityType: AccessibilityDisabilityType.autismNeurodiversity,
      titleAr: 'التوحد والتنوع العصبي',
      titleEn: 'Autism & Neurodiversity',
      descriptionAr: 'روابط إرشادية ومجتمعية غير تشخيصية.',
      descriptionEn: 'Non-diagnostic guidance and community links.',
      icon: Icons.diversity_1_outlined,
      resourceCountPlaceholder: '0',
    ),
    AccessibilityCategoryEntry(
      category: AccessibilityCategory.mentalHealthAddiction,
      disabilityType: AccessibilityDisabilityType.mentalHealthAddiction,
      titleAr: 'دعم الصحة النفسية والتعافي',
      titleEn: 'Mental Health & Addiction Support',
      descriptionAr: 'مسارات معلومات عامة وروابط مساندة موثوقة.',
      descriptionEn: 'General information paths and trusted support links.',
      icon: Icons.volunteer_activism_outlined,
      resourceCountPlaceholder: '0',
    ),
    AccessibilityCategoryEntry(
      category: AccessibilityCategory.rightsComplaints,
      disabilityType: AccessibilityDisabilityType.rightsComplaints,
      titleAr: 'الحقوق والشكاوى',
      titleEn: 'Rights & Complaints',
      descriptionAr: 'قنوات معرفة الحقوق وتقديم الشكاوى.',
      descriptionEn: 'Rights awareness and complaint channel links.',
      icon: Icons.gavel_outlined,
      resourceCountPlaceholder: '0',
    ),
    AccessibilityCategoryEntry(
      category: AccessibilityCategory.globalLibraries,
      disabilityType: AccessibilityDisabilityType.generalAccessibility,
      titleAr: 'مكتبات عالمية',
      titleEn: 'Global Libraries',
      descriptionAr: 'مكتبات وأدلة دولية لإتاحة المعرفة.',
      descriptionEn: 'International libraries and knowledge directories.',
      icon: Icons.public_outlined,
      resourceCountPlaceholder: '0',
    ),
  ];

  static AccessibilityCategoryEntry? entryFor(AccessibilityCategory category) {
    for (final entry in entries) {
      if (entry.category == category) return entry;
    }
    return null;
  }
}

class AccessibilityCategoryEntry {
  const AccessibilityCategoryEntry({
    required this.category,
    required this.disabilityType,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.icon,
    required this.resourceCountPlaceholder,
  });

  final AccessibilityCategory category;
  final AccessibilityDisabilityType disabilityType;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final IconData icon;
  final String resourceCountPlaceholder;
}
