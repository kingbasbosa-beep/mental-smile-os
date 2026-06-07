import '../models/accessibility_visual_profile.dart';

class AccessibilityVisualRegistry {
  const AccessibilityVisualRegistry._();

  static const List<AccessibilityVisualProfile> profiles =
      <AccessibilityVisualProfile>[
    AccessibilityVisualProfile(
      profileKey: AccessibilityVisualProfileKey.standard,
      labelAr: 'قياسي',
      labelEn: 'Standard',
      descriptionAr: 'هوية قراءة قياسية.',
      descriptionEn: 'Standard reading identity.',
    ),
    AccessibilityVisualProfile(
      profileKey: AccessibilityVisualProfileKey.easyReading,
      labelAr: 'قراءة سهلة',
      labelEn: 'Easy Reading',
      descriptionAr: 'هوية معدة للنصوص السهلة.',
      descriptionEn: 'Identity prepared for easier reading.',
    ),
    AccessibilityVisualProfile(
      profileKey: AccessibilityVisualProfileKey.highVisibility,
      labelAr: 'وضوح عال',
      labelEn: 'High Visibility',
      descriptionAr: 'هوية معدة للتباين العالي.',
      descriptionEn: 'Identity prepared for high visibility.',
    ),
    AccessibilityVisualProfile(
      profileKey: AccessibilityVisualProfileKey.audioAssisted,
      labelAr: 'مساندة صوتية',
      labelEn: 'Audio Assisted',
      descriptionAr: 'هوية معدة للمحتوى الصوتي المساند.',
      descriptionEn: 'Identity prepared for audio assisted content.',
    ),
    AccessibilityVisualProfile(
      profileKey: AccessibilityVisualProfileKey.visualAssisted,
      labelAr: 'مساندة بصرية',
      labelEn: 'Visual Assisted',
      descriptionAr: 'هوية معدة للمساندة البصرية.',
      descriptionEn: 'Identity prepared for visual assisted content.',
    ),
  ];
}
