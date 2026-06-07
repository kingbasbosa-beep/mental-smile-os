import 'route_classification.dart';

class RouteMetadata {
  const RouteMetadata({
    required this.routeName,
    required this.classification,
    required this.department,
    required this.isLegacy,
    required this.isFederationReady,
  });

  final String routeName;
  final String classification;
  final String department;
  final bool isLegacy;
  final bool isFederationReady;

  bool get isValidClassification {
    return RouteClassification.values.contains(classification);
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'routeName': routeName,
      'classification': classification,
      'department': department,
      'isLegacy': isLegacy,
      'isFederationReady': isFederationReady,
    };
  }
}
