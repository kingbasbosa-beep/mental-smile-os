import 'runtime_environment_type.dart';

class RuntimeEnvironmentState {
  const RuntimeEnvironmentState({
    required this.environmentType,
    required this.runtimeMode,
    required this.providerId,
    required this.policyVersion,
    required this.enabledSafetyModules,
    required this.backendGoverned,
    required this.auditLinked,
  });

  static const RuntimeEnvironmentState safeDefault = RuntimeEnvironmentState(
    environmentType: RuntimeEnvironmentType.fallbackOnly,
    runtimeMode: 'disabled_placeholder',
    providerId: '',
    policyVersion: '2026-05-os3f',
    enabledSafetyModules: <String>{},
    backendGoverned: true,
    auditLinked: false,
  );

  final RuntimeEnvironmentType environmentType;
  final String runtimeMode;
  final String providerId;
  final String policyVersion;
  final Set<String> enabledSafetyModules;
  final bool backendGoverned;
  final bool auditLinked;
}
