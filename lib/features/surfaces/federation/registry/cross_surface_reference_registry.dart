import '../models/cross_surface_reference_models.dart';

class CrossSurfaceReferenceRegistry {
  const CrossSurfaceReferenceRegistry._();

  static const String routeReference = 'route_reference';
  static const String tabReference = 'tab_reference';
  static const String badgeReference = 'badge_reference';
  static const String counterReference = 'counter_reference';
  static const String quickAction = 'quick_action';
  static const String sectionMap = 'section_map';

  static const Set<String> referenceTypes = <String>{
    routeReference,
    tabReference,
    badgeReference,
    counterReference,
    quickAction,
    sectionMap,
  };

  static const List<CrossSurfaceReference> references =
      <CrossSurfaceReference>[
  ];
}
