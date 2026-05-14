import 'audit_reference.dart';
import 'audit_runtime_marker.dart';

class SafetyObservabilityContract {
  const SafetyObservabilityContract({
    required this.auditReference,
    required this.incidentReference,
    required this.runtimeMarker,
    required this.providerId,
    required this.policyVersion,
    required this.fallbackReason,
  });

  final AuditReference auditReference;
  final AuditReference? incidentReference;
  final AuditRuntimeMarker runtimeMarker;
  final String providerId;
  final String policyVersion;
  final String fallbackReason;

  Map<String, Object?> toMap() {
    return {
      'auditReference': auditReference.toMap(),
      'incidentReference': incidentReference?.toMap(),
      'runtimeMarker': runtimeMarker.toMap(),
      'providerId': providerId,
      'policyVersion': policyVersion,
      'fallbackReason': fallbackReason,
    };
  }
}
