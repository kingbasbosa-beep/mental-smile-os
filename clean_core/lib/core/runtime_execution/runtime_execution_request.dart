import 'runtime_execution_audit_link.dart';
import 'runtime_execution_runtime_marker.dart';
import 'runtime_execution_scope.dart';
import 'runtime_execution_visibility_scope.dart';

class RuntimeExecutionRequest {
  const RuntimeExecutionRequest({
    required this.requestId,
    required this.uid,
    required this.scope,
    required this.visibilityScope,
    required this.policyVersion,
    required this.escalationSuggested,
    required this.auditLink,
    required this.runtimeMarker,
  });

  final String requestId;
  final String uid;
  final RuntimeExecutionScope scope;
  final RuntimeExecutionVisibilityScope visibilityScope;
  final String policyVersion;
  final bool escalationSuggested;
  final RuntimeExecutionAuditLink auditLink;
  final RuntimeExecutionRuntimeMarker runtimeMarker;
}
