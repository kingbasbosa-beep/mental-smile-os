import 'trusted_pipeline_block_reason.dart';
import 'trusted_pipeline_fallback.dart';
import 'trusted_pipeline_guard.dart';
import 'trusted_pipeline_policy.dart';
import 'trusted_pipeline_request.dart';
import 'trusted_pipeline_result.dart';
import 'trusted_pipeline_state.dart';

class TrustedPipeline {
  const TrustedPipeline({
    this.policy = TrustedPipelinePolicy.safeDefault,
    this.guard = const TrustedPipelineGuard(),
  });

  final TrustedPipelinePolicy policy;
  final TrustedPipelineGuard guard;

  TrustedPipelineResult check(TrustedPipelineRequest request) {
    final reason = guard.blockReason(policy: policy, request: request);
    if (reason != null) {
      return TrustedPipelineResult(
        allowed: false,
        state: TrustedPipelineState.locked,
        fallback: TrustedPipelineFallback(
          reason: reason,
          state: TrustedPipelineState.locked,
          messageKey: reason.key,
        ),
      );
    }
    return const TrustedPipelineResult(
      allowed: true,
      state: TrustedPipelineState.restricted,
      fallback: null,
    );
  }
}
