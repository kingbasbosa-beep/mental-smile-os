class GhostRouteAuditProfile {
  const GhostRouteAuditProfile({
    required this.routeId,
    required this.routeName,
    required this.classification,
    required this.cleanupAction,
    required this.notes,
  });

  final String routeId;
  final String routeName;
  final String classification;
  final String cleanupAction;
  final String notes;
}
