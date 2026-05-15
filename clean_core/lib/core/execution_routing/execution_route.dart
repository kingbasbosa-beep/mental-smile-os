import 'execution_routing_scope.dart';

class ExecutionRoute {
  const ExecutionRoute({
    required this.routeId,
    required this.source,
    required this.target,
    required this.fallbackRoute,
    required this.reviewRoute,
    required this.escalationRoute,
    required this.sealed,
  });

  final String routeId;
  final ExecutionRoutingScope source;
  final ExecutionRoutingScope target;
  final bool fallbackRoute;
  final bool reviewRoute;
  final bool escalationRoute;
  final bool sealed;

  bool get isApprovedPlaceholder => routeId.trim().isNotEmpty && sealed;
}
