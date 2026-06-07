import '../models/ghost_route_models.dart';

class GhostRouteClassification {
  const GhostRouteClassification._();

  static const String ghost = 'ghost';
  static const String contained = 'contained';
  static const String replaceLater = 'replace_later';
  static const String safeToRemove = 'safe_to_remove';
  static const String needsReview = 'needs_review';

  static const Set<String> values = <String>{
    ghost,
    contained,
    replaceLater,
    safeToRemove,
    needsReview,
  };
}

class GhostRouteRegistry {
  const GhostRouteRegistry._();

  static const List<GhostRouteAuditProfile> routes =
      <GhostRouteAuditProfile>[
  ];
}
