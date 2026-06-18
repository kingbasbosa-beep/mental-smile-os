import 'package:flutter/material.dart';

import '../models/accessibility_category.dart';
import 'accessibility_category_registry.dart';

class AccessibilityIconRegistry {
  const AccessibilityIconRegistry._();

  static IconData iconFor(AccessibilityCategory category) {
    return AccessibilityCategoryRegistry.entryFor(category)?.icon ??
        Icons.accessibility_new_outlined;
  }
}
