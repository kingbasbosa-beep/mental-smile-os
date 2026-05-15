import 'execution_route.dart';
import 'execution_route_owner.dart';
import 'execution_routing_audit_link.dart';
import 'execution_routing_reference.dart';
import 'execution_routing_requirement.dart';
import 'execution_routing_review_marker.dart';
import 'execution_routing_runtime_marker.dart';
import 'execution_routing_visibility_scope.dart';

class ExecutionRoutingMap {
  const ExecutionRoutingMap({
    required this.mapId,
    required this.visibilityScope,
    required this.policyVersion,
    required this.references,
    required this.routes,
    required this.owners,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.requirement,
  });

  final String mapId;
  final ExecutionRoutingVisibilityScope visibilityScope;
  final String policyVersion;
  final List<ExecutionRoutingReference> references;
  final List<ExecutionRoute> routes;
  final List<ExecutionRouteOwner> owners;
  final ExecutionRoutingRuntimeMarker runtimeMarker;
  final ExecutionRoutingAuditLink auditLink;
  final ExecutionRoutingReviewMarker reviewMarker;
  final ExecutionRoutingRequirement requirement;

  bool get hasTrustedOwner => owners.any((owner) => owner.isTrusted);
}
