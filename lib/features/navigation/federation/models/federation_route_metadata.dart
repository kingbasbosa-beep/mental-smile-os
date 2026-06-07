class FederationRouteMetadata {
  const FederationRouteMetadata({
    required this.routeId,
    required this.routeName,
    required this.classification,
    required this.department,
    required this.createdEra,
    required this.notes,
  });

  final String routeId;
  final String routeName;
  final String classification;
  final String department;
  final String createdEra;
  final String notes;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'routeId': routeId,
      'routeName': routeName,
      'classification': classification,
      'department': department,
      'createdEra': createdEra,
      'notes': notes,
    };
  }
}
