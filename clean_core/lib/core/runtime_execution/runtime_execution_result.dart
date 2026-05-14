import 'runtime_execution_fallback.dart';
import 'runtime_execution_state.dart';

class RuntimeExecutionResult {
  const RuntimeExecutionResult({
    required this.allowed,
    required this.state,
    required this.fallback,
  });

  static const RuntimeExecutionResult blockedDefault = RuntimeExecutionResult(
    allowed: false,
    state: RuntimeExecutionState.fallbackOnly,
    fallback: RuntimeExecutionFallback.runtimeDisabled,
  );

  final bool allowed;
  final RuntimeExecutionState state;
  final RuntimeExecutionFallback? fallback;
}
