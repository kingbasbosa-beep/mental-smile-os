import 'runtime_release_audit_link.dart';
import 'runtime_release_candidate.dart';
import 'runtime_release_reference.dart';
import 'runtime_release_requirement.dart';
import 'runtime_release_review_marker.dart';
import 'runtime_release_runtime_marker.dart';
import 'runtime_release_stage.dart';
import 'runtime_release_visibility_scope.dart';

class RuntimeReleasePlan {
  const RuntimeReleasePlan({
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
  final RuntimeReleaseStage stage;
  final RuntimeReleaseVisibilityScope visibilityScope;
  final String policyVersion;
  final List<RuntimeReleaseReference> references;
  final RuntimeReleaseCandidate candidate;
  final RuntimeReleaseRuntimeMarker runtimeMarker;
  final RuntimeReleaseAuditLink auditLink;
  final RuntimeReleaseReviewMarker reviewMarker;
  final RuntimeReleaseRequirement requirement;
  final String? signedAuthorityPlaceholder;

  bool get hasSignedAuthority =>
      signedAuthorityPlaceholder != null &&
      signedAuthorityPlaceholder!.trim().isNotEmpty;
}
