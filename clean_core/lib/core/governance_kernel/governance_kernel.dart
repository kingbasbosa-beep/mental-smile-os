import 'governance_kernel_boundary.dart';
import 'governance_kernel_block_reason.dart';
import 'governance_kernel_fallback.dart';
import 'governance_kernel_guard.dart';
import 'governance_kernel_request.dart';
import 'governance_kernel_state.dart';

class GovernanceKernelResult {
  const GovernanceKernelResult({
    required this.allowed,
    required this.state,
    required this.fallback,
  });

  final bool allowed;
  final GovernanceKernelState state;
  final GovernanceKernelFallback? fallback;
}

class GovernanceKernel {
  const GovernanceKernel({
    this.guard = const GovernanceKernelGuard(),
  });

  final GovernanceKernelGuard guard;

  GovernanceKernelResult check({
    GovernanceKernelBoundary boundary = GovernanceKernelBoundary.disabled,
    required GovernanceKernelRequest request,
  }) {
    final reason = guard.blockReason(boundary: boundary, request: request);
    if (reason != null) {
      return GovernanceKernelResult(
        allowed: false,
        state: GovernanceKernelState.fallbackOnly,
        fallback: GovernanceKernelFallback(
          reason: reason,
          state: GovernanceKernelState.fallbackOnly,
          messageKey: reason.key,
        ),
      );
    }
    return GovernanceKernelResult(
      allowed: true,
      state: boundary.state,
      fallback: null,
    );
  }
}
