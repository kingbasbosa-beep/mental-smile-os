import 'runtime_execution_policy.dart';
import 'runtime_execution_runtime_marker.dart';
import 'runtime_execution_state.dart';

class RuntimeExecutionBoundary {
  const RuntimeExecutionBoundary({
    required this.state,
    required this.policy,
    required this.runtimeMarker,
    required this.executionEnabled,
  });

  static const RuntimeExecutionBoundary disabled = RuntimeExecutionBoundary(
    state: RuntimeExecutionState.disabled,
    policy: RuntimeExecutionPolicy.safeDefault,
    runtimeMarker: RuntimeExecutionRuntimeMarker.disabled,
    executionEnabled: false,
  );

  final RuntimeExecutionState state;
  final RuntimeExecutionPolicy policy;
  final RuntimeExecutionRuntimeMarker runtimeMarker;
  final bool executionEnabled;
}
