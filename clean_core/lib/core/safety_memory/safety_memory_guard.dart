import 'safety_memory_block_reason.dart';
import 'safety_memory_boundary.dart';
import 'safety_memory_context.dart';
import 'safety_memory_retention.dart';

class SafetyMemoryGuard {
  const SafetyMemoryGuard();

  SafetyMemoryBlockReason? blockReason({
    required SafetyMemoryBoundary boundary,
    required SafetyMemoryContext context,
  }) {
    if (!boundary.rawPersistenceAllowed &&
        boundary.policy.retention.mode != SafetyMemoryRetentionMode.noRetention) {
      return SafetyMemoryBlockReason.retentionNotAllowed;
    }
    if (!boundary.policy.allowedScopes.contains(context.scope) ||
        !boundary.policy.allowedVisibilityScopes.contains(
          context.visibilityScope,
        )) {
      return SafetyMemoryBlockReason.unsafeContext;
    }
    if (boundary.policy.auditRequired && !context.auditLink.isLinked) {
      return SafetyMemoryBlockReason.missingAuditLink;
    }
    if (boundary.policy.policyVersion != context.policyVersion) {
      return SafetyMemoryBlockReason.policyRestricted;
    }
    if (context.reviewRequired || boundary.policy.reviewRequired) {
      return SafetyMemoryBlockReason.reviewRequired;
    }
    if (!boundary.runtimeMarker.memoryRuntimeEnabled) {
      return SafetyMemoryBlockReason.runtimeDisabled;
    }
    if (boundary.policy.failClosed) return SafetyMemoryBlockReason.failClosed;
    return null;
  }
}
