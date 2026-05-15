import 'runtime_activation_audit_link.dart';
import 'runtime_activation_reference.dart';
import 'runtime_activation_requirement.dart';
import 'runtime_activation_review_marker.dart';
import 'runtime_activation_runtime_marker.dart';
import 'runtime_activation_stage.dart';
import 'runtime_activation_visibility_scope.dart';

class RuntimeActivationRequest {
  const RuntimeActivationRequest({
    required this.requestId,
    required this.stage,
    required this.visibilityScope,
    required this.policyVersion,
    required this.references,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.requirement,
    this.signedAuthorityPlaceholder,
    this.readinessVerified = false,
    this.secureEnvelopeVerified = false,
    this.providerGovernanceVerified = false,
  });

  final String requestId;
  final RuntimeActivationStage stage;
  final RuntimeActivationVisibilityScope visibilityScope;
  final String policyVersion;
  final List<RuntimeActivationReference> references;
  final RuntimeActivationRuntimeMarker runtimeMarker;
  final RuntimeActivationAuditLink auditLink;
  final RuntimeActivationReviewMarker reviewMarker;
  final RuntimeActivationRequirement requirement;
  final String? signedAuthorityPlaceholder;
  final bool readinessVerified;
  final bool secureEnvelopeVerified;
  final bool providerGovernanceVerified;

  bool get hasSignedAuthority =>
      signedAuthorityPlaceholder != null &&
      signedAuthorityPlaceholder!.trim().isNotEmpty;
}
