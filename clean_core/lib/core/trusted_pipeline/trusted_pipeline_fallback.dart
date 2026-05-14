import 'trusted_pipeline_block_reason.dart';
import 'trusted_pipeline_state.dart';

class TrustedPipelineFallback {
  const TrustedPipelineFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const TrustedPipelineFallback blocked = TrustedPipelineFallback(
    reason: TrustedPipelineBlockReason.pipelineBlocked,
    state: TrustedPipelineState.locked,
    messageKey: 'trusted_pipeline_blocked',
  );

  final TrustedPipelineBlockReason reason;
  final TrustedPipelineState state;
  final String messageKey;
}
