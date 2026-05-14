import 'runtime_execution_reason.dart';
import 'runtime_execution_state.dart';

class RuntimeExecutionFallback {
  const RuntimeExecutionFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const RuntimeExecutionFallback runtimeDisabled =
      RuntimeExecutionFallback(
    reason: RuntimeExecutionReason.runtimeDisabled,
    state: RuntimeExecutionState.fallbackOnly,
    messageKey: 'runtime_execution_disabled',
  );

  final RuntimeExecutionReason reason;
  final RuntimeExecutionState state;
  final String messageKey;
}
