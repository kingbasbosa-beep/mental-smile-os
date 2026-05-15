import 'runtime_bootstrap_audit_link.dart';
import 'runtime_bootstrap_candidate.dart';
import 'runtime_bootstrap_reference.dart';
import 'runtime_bootstrap_requirement.dart';
import 'runtime_bootstrap_review_marker.dart';
import 'runtime_bootstrap_runtime_marker.dart';
import 'runtime_bootstrap_stage.dart';
import 'runtime_bootstrap_visibility_scope.dart';

class RuntimeBootstrapPlan {
  const RuntimeBootstrapPlan({
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
  });

  final String planId;
  final RuntimeBootstrapStage stage;
  final RuntimeBootstrapVisibilityScope visibilityScope;
  final String policyVersion;
  final List<RuntimeBootstrapReference> references;
  final RuntimeBootstrapCandidate candidate;
  final RuntimeBootstrapRuntimeMarker runtimeMarker;
  final RuntimeBootstrapAuditLink auditLink;
  final RuntimeBootstrapReviewMarker reviewMarker;
  final RuntimeBootstrapRequirement requirement;
  final String? signedAuthorityPlaceholder;

  bool get hasSignedAuthority =>
      signedAuthorityPlaceholder != null &&
      signedAuthorityPlaceholder!.trim().isNotEmpty;
}
