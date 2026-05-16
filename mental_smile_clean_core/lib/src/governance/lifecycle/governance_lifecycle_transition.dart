import 'governance_lifecycle_audit_link.dart';
import 'governance_lifecycle_review_marker.dart';
import 'governance_lifecycle_runtime_marker.dart';
import 'governance_lifecycle_scope.dart';
import 'governance_lifecycle_state.dart';
import 'governance_lifecycle_visibility_scope.dart';

class GovernanceLifecycleTransition {
  const GovernanceLifecycleTransition({
    required this.transitionId,
    required this.fromState,
    required this.toState,
    required this.scope,
    required this.visibilityScope,
    required this.policyVersion,
    required this.auditLink,
    required this.runtimeMarker,
    required this.reviewMarker,
  });

  final String transitionId;
  final GovernanceLifecycleState fromState;
  final GovernanceLifecycleState toState;
  final GovernanceLifecycleScope scope;
  final GovernanceLifecycleVisibilityScope visibilityScope;
  final String policyVersion;
  final GovernanceLifecycleAuditLink auditLink;
  final GovernanceLifecycleRuntimeMarker runtimeMarker;
  final GovernanceLifecycleReviewMarker reviewMarker;
}
