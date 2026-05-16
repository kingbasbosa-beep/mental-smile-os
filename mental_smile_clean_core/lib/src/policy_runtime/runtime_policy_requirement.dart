import 'runtime_policy_module.dart';

class RuntimePolicyRequirement {
  const RuntimePolicyRequirement({
    required this.requiredPolicyVersion,
    required this.requiredModules,
    required this.requiresBackendGovernance,
    required this.requiresHumanPriority,
  });

  final String requiredPolicyVersion;
  final Set<RuntimePolicyModule> requiredModules;
  final bool requiresBackendGovernance;
  final bool requiresHumanPriority;

  Map<String, Object?> toMap() {
    return {
      'requiredPolicyVersion': requiredPolicyVersion,
      'requiredModules':
          requiredModules.map((module) => module.key).toList(growable: false),
      'requiresBackendGovernance': requiresBackendGovernance,
      'requiresHumanPriority': requiresHumanPriority,
    };
  }
}
