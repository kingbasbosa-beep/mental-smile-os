import 'safety_memory_retention.dart';
import 'safety_memory_scope.dart';
import 'safety_memory_visibility_scope.dart';

class SafetyMemoryPolicy {
  const SafetyMemoryPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.retention,
    required this.auditRequired,
    required this.reviewRequired,
    required this.failClosed,
  });

  static const SafetyMemoryPolicy safeDefault = SafetyMemoryPolicy(
    policyVersion: '2026-05-os4e',
    allowedScopes: <SafetyMemoryScope>{
      SafetyMemoryScope.sessionOnly,
      SafetyMemoryScope.auditReferenceOnly,
    },
    allowedVisibilityScopes: <SafetyMemoryVisibilityScope>{
      SafetyMemoryVisibilityScope.privateSession,
      SafetyMemoryVisibilityScope.auditOnly,
      SafetyMemoryVisibilityScope.backendOnly,
    },
    retention: SafetyMemoryRetention.noRetention,
    auditRequired: true,
    reviewRequired: false,
    failClosed: true,
  );

  final String policyVersion;
  final Set<SafetyMemoryScope> allowedScopes;
  final Set<SafetyMemoryVisibilityScope> allowedVisibilityScopes;
  final SafetyMemoryRetention retention;
  final bool auditRequired;
  final bool reviewRequired;
  final bool failClosed;
}
