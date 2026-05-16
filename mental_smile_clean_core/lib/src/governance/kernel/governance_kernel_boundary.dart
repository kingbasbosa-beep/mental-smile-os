import 'governance_kernel_policy.dart';
import 'governance_kernel_runtime_marker.dart';
import 'governance_kernel_state.dart';

class GovernanceKernelBoundary {
  const GovernanceKernelBoundary({
    required this.state,
    required this.policy,
    required this.runtimeMarker,
    required this.coordinationEnabled,
  });

  static const GovernanceKernelBoundary disabled =
      GovernanceKernelBoundary(
    state: GovernanceKernelState.inactive,
    policy: GovernanceKernelPolicy.safeDefault,
    runtimeMarker: GovernanceKernelRuntimeMarker.disabled,
    coordinationEnabled: false,
  );

  final GovernanceKernelState state;
  final GovernanceKernelPolicy policy;
  final GovernanceKernelRuntimeMarker runtimeMarker;
  final bool coordinationEnabled;
}
