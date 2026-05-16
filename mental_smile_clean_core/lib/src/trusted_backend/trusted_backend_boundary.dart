import 'trusted_backend_policy.dart';
import 'trusted_backend_runtime_marker.dart';
import 'trusted_backend_state.dart';

class TrustedBackendBoundary {
  const TrustedBackendBoundary({
    required this.state,
    required this.policy,
    required this.runtimeMarker,
    required this.backendRuntimeImplemented,
  });

  static const TrustedBackendBoundary disabled = TrustedBackendBoundary(
    state: TrustedBackendState.unavailable,
    policy: TrustedBackendPolicy.safeDefault,
    runtimeMarker: TrustedBackendRuntimeMarker.disabled,
    backendRuntimeImplemented: false,
  );

  final TrustedBackendState state;
  final TrustedBackendPolicy policy;
  final TrustedBackendRuntimeMarker runtimeMarker;
  final bool backendRuntimeImplemented;
}
