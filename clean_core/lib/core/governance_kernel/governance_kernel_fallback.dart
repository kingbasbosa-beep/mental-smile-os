import 'governance_kernel_block_reason.dart';
import 'governance_kernel_state.dart';

class GovernanceKernelFallback {
  const GovernanceKernelFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const GovernanceKernelFallback runtimeDisabled =
      GovernanceKernelFallback(
    reason: GovernanceKernelBlockReason.runtimeDisabled,
    state: GovernanceKernelState.fallbackOnly,
    messageKey: 'governance_kernel_disabled',
  );

  final GovernanceKernelBlockReason reason;
  final GovernanceKernelState state;
  final String messageKey;
}
