import '../models/accessibility_signal_type.dart';

class AccessibilitySignalRegistry {
  const AccessibilitySignalRegistry._();

  static const String sourceSurface = 'accessibility';
  static const String signalDomain = 'residential';
  static const String targetHub = 'accessibility_hub';
  static const String targetCategory = 'accessibility_category';
  static const String targetResource = 'accessibility_resource';
  static const String targetMode = 'accessibility_mode';

  static const List<AccessibilitySignalType> values =
      AccessibilitySignalType.values;
}
