import 'runtime_isolation_audit_link.dart';
import 'runtime_isolation_boundary.dart';
import 'runtime_isolation_reference.dart';
import 'runtime_isolation_requirement.dart';
import 'runtime_isolation_review_marker.dart';
import 'runtime_isolation_runtime_marker.dart';
import 'runtime_isolation_stage.dart';
import 'runtime_isolation_visibility_scope.dart';

class RuntimeIsolationProfile {
  const RuntimeIsolationProfile({
    required this.profileId,
    required this.stage,
    required this.visibilityScope,
    required this.policyVersion,
    required this.references,
    required this.boundary,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.requirement,
    this.signedAuthorityPlaceholder,
  });

  final String profileId;
  final RuntimeIsolationStage stage;
  final RuntimeIsolationVisibilityScope visibilityScope;
  final String policyVersion;
  final List<RuntimeIsolationReference> references;
  final RuntimeIsolationBoundary boundary;
  final RuntimeIsolationRuntimeMarker runtimeMarker;
  final RuntimeIsolationAuditLink auditLink;
  final RuntimeIsolationReviewMarker reviewMarker;
  final RuntimeIsolationRequirement requirement;
  final String? signedAuthorityPlaceholder;

  bool get hasSignedAuthority =>
      signedAuthorityPlaceholder != null &&
      signedAuthorityPlaceholder!.trim().isNotEmpty;
}
