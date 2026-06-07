class ConstructionSignalRegistry {
  const ConstructionSignalRegistry._();

  static const String roomBlueprintDefined = 'room_blueprint_defined';
  static const String crossSurfaceDuplicateDetected =
      'cross_surface_duplicate_detected';
  static const String visualAssetDetected = 'visual_asset_detected';
  static const String visualLegacyDetected = 'visual_legacy_detected';
  static const String replacementVisualNeeded = 'replacement_visual_needed';
  static const String missingVisualDetected = 'missing_visual_detected';

  static const Set<String> values = <String>{
    roomBlueprintDefined,
    crossSurfaceDuplicateDetected,
    visualAssetDetected,
    visualLegacyDetected,
    replacementVisualNeeded,
    missingVisualDetected,
  };
}
