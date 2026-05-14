import 'governance_kernel_audit_link.dart';
import 'governance_kernel_reference.dart';
import 'governance_kernel_review_marker.dart';
import 'governance_kernel_runtime_marker.dart';
import 'governance_kernel_scope.dart';
import 'governance_kernel_visibility_scope.dart';

class GovernanceKernelRequest {
  const GovernanceKernelRequest({
    required this.requestId,
    required this.scope,
    required this.visibilityScope,
    required this.policyVersion,
    required this.auditLink,
    required this.runtimeMarker,
    required this.reviewMarker,
    this.memoryReference,
    this.conversationReference,
  });

  final String requestId;
  final GovernanceKernelScope scope;
  final GovernanceKernelVisibilityScope visibilityScope;
  final String policyVersion;
  final GovernanceKernelAuditLink auditLink;
  final GovernanceKernelRuntimeMarker runtimeMarker;
  final GovernanceKernelReviewMarker reviewMarker;
  final GovernanceKernelReference? memoryReference;
  final GovernanceKernelReference? conversationReference;
}
