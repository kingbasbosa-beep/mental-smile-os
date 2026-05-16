import 'trusted_pipeline_audit_link.dart';
import 'trusted_pipeline_reference.dart';
import 'trusted_pipeline_review_marker.dart';
import 'trusted_pipeline_runtime_marker.dart';
import 'trusted_pipeline_stage.dart';
import 'trusted_pipeline_visibility_scope.dart';

class TrustedPipelineRequest {
  const TrustedPipelineRequest({
    required this.requestId,
    required this.stage,
    required this.visibilityScope,
    required this.policyVersion,
    required this.reference,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.signedAuthorityPlaceholder,
  });

  final String requestId;
  final TrustedPipelineStage stage;
  final TrustedPipelineVisibilityScope visibilityScope;
  final String policyVersion;
  final TrustedPipelineReference reference;
  final TrustedPipelineRuntimeMarker runtimeMarker;
  final TrustedPipelineAuditLink auditLink;
  final TrustedPipelineReviewMarker reviewMarker;
  final String signedAuthorityPlaceholder;

  bool get hasSignedAuthority {
    return signedAuthorityPlaceholder.trim().isNotEmpty;
  }
}
