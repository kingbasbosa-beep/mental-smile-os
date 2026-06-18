enum AccessibilitySignalType {
  hubOpened('accessibility_hub_opened'),
  categoryOpened('accessibility_category_opened'),
  resourceOpened('accessibility_resource_opened'),
  resourceSaved('accessibility_resource_saved'),
  resourceBrokenLinkReported('accessibility_resource_broken_link_reported'),
  modeSelected('accessibility_mode_selected');

  const AccessibilitySignalType(this.value);

  final String value;

  static AccessibilitySignalType fromValue(String value) {
    return AccessibilitySignalType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => AccessibilitySignalType.hubOpened,
    );
  }
}
