import 'runtime_enablement_audit_link.dart';
import 'runtime_enablement_candidate.dart';
import 'runtime_enablement_reference.dart';
import 'runtime_enablement_requirement.dart';
import 'runtime_enablement_review_marker.dart';
import 'runtime_enablement_runtime_marker.dart';
import 'runtime_enablement_stage.dart';
import 'runtime_enablement_visibility_scope.dart';

class RuntimeEnablementPlan {
  const RuntimeEnablementPlan({
    required this.planId,
    required this.stage,
    required this.visibilityScope,
    required this.policyVersion,
    required this.references,
    required this.candidate,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.requirement,
    this.signedAuthorityPlaceholder,
    this.readinessVerified = false,
  });

  final String planId;
  final RuntimeEnablementStage stage;
  final RuntimeEnablementVisibilityScope visibilityScope;
  final String policyVersion;
  final List<RuntimeEnablementReference> references;
  final RuntimeEnablementCandidate candidate;
  final RuntimeEnablementRuntimeMarker runtimeMarker;
  final RuntimeEnablementAuditLink auditLink;
  final RuntimeEnablementReviewMarker reviewMarker;
  final RuntimeEnablementRequirement requirement;
  final String? signedAuthorityPlaceholder;
  final bool readinessVerified;

  bool get hasSignedAuthority =>
      signedAuthorityPlaceholder != null &&
      signedAuthorityPlaceholder!.trim().isNotEmpty;
}
