import 'provider_boundary_scope.dart';
import 'provider_capability.dart';

class ProviderRuntimePermission {
  const ProviderRuntimePermission({
    required this.providerId,
    required this.runtimeMode,
    required this.environment,
    required this.requestedCapability,
    required this.boundaryScope,
    required this.backendGoverned,
  });

  final String providerId;
  final String runtimeMode;
  final String environment;
  final ProviderCapability requestedCapability;
  final ProviderBoundaryScope boundaryScope;
  final bool backendGoverned;
}
