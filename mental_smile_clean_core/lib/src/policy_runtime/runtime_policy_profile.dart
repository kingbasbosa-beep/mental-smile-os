import 'runtime_policy_mode.dart';
import 'runtime_policy_module.dart';
import 'runtime_policy_requirement.dart';
import 'runtime_policy_restriction.dart';
import 'runtime_policy_scope.dart';
import 'runtime_policy_snapshot_reference.dart';

class RuntimePolicyProfile {
  const RuntimePolicyProfile({
    required this.profileId,
    required this.mode,
    required this.scope,
    required this.enabledModules,
    required this.requirement,
    required this.restriction,
    required this.snapshotReference,
    required this.failClosed,
  });

  static const RuntimePolicyProfile disabledFallback = RuntimePolicyProfile(
    profileId: 'disabled_fallback',
    mode: RuntimePolicyMode.disabled,
    scope: RuntimePolicyScope.global,
    enabledModules: <RuntimePolicyModule>{
      RuntimePolicyModule.auditTracing,
      RuntimePolicyModule.providerIsolation,
    },
    requirement: RuntimePolicyRequirement(
      requiredPolicyVersion: '2026-05-os3d',
      requiredModules: <RuntimePolicyModule>{
        RuntimePolicyModule.auditTracing,
        RuntimePolicyModule.providerIsolation,
      },
      requiresBackendGovernance: true,
      requiresHumanPriority: true,
    ),
    restriction: RuntimePolicyRestriction.safeDefault,
    snapshotReference: RuntimePolicySnapshotReference(
      snapshotId: 'disabled_fallback_snapshot',
      policyVersion: '2026-05-os3d',
      hashPlaceholder: 'policy_hash_placeholder_disabled',
    ),
    failClosed: true,
  );

  final String profileId;
  final RuntimePolicyMode mode;
  final RuntimePolicyScope scope;
  final Set<RuntimePolicyModule> enabledModules;
  final RuntimePolicyRequirement requirement;
  final RuntimePolicyRestriction restriction;
  final RuntimePolicySnapshotReference snapshotReference;
  final bool failClosed;

  bool hasRequiredModules() {
    return enabledModules.containsAll(requirement.requiredModules);
  }
}
