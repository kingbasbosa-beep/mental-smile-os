enum AccessibilityResourceType {
  government('government'),
  ngo('ngo'),
  association('association'),
  library('library'),
  international('international'),
  educational('educational'),
  complaintChannel('complaint_channel'),
  emergency('emergency'),
  accessibilityTool('accessibility_tool');

  const AccessibilityResourceType(this.value);

  final String value;

  static AccessibilityResourceType fromValue(String value) {
    return AccessibilityResourceType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => AccessibilityResourceType.educational,
    );
  }
}
