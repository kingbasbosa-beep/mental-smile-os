import 'trusted_pipeline_fallback.dart';
import 'trusted_pipeline_state.dart';

class TrustedPipelineResult {
  const TrustedPipelineResult({
    required this.allowed,
    required this.state,
    required this.fallback,
  });

  final bool allowed;
  final TrustedPipelineState state;
  final TrustedPipelineFallback? fallback;
}
