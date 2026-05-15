import 'runtime_rollback_audit_link.dart';
import 'runtime_rollback_candidate.dart';
import 'runtime_rollback_reference.dart';
import 'runtime_rollback_requirement.dart';
import 'runtime_rollback_review_marker.dart';
import 'runtime_rollback_runtime_marker.dart';
import 'runtime_rollback_stage.dart';
import 'runtime_rollback_visibility_scope.dart';

class RuntimeRollbackPlan {
  const RuntimeRollbackPlan({
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
  final RuntimeRollbackStage stage;
  final RuntimeRollbackVisibilityScope visibilityScope;
  final String policyVersion;
  final List<RuntimeRollbackReference> references;
  final RuntimeRollbackCandidate candidate;
  final RuntimeRollbackRuntimeMarker runtimeMarker;
  final RuntimeRollbackAuditLink auditLink;
  final RuntimeRollbackReviewMarker reviewMarker;
  final RuntimeRollbackRequirement requirement;
  final String? signedAuthorityPlaceholder;

  bool get hasSignedAuthority =>
      signedAuthorityPlaceholder != null &&
      signedAuthorityPlaceholder!.trim().isNotEmpty;
}
