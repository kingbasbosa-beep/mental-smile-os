import 'runtime_policy_mode.dart';

class RuntimePolicyState {
  const RuntimePolicyState({
    required this.mode,
    required this.policyVersion,
    required this.providerId,
    required this.backendGoverned,
    required this.humanPriority,
  });

  static const RuntimePolicyState disabled = RuntimePolicyState(
    mode: RuntimePolicyMode.disabled,
    policyVersion: '2026-05-os3d',
    providerId: '',
    backendGoverned: true,
    humanPriority: true,
  );

  final RuntimePolicyMode mode;
  final String policyVersion;
  final String providerId;
  final bool backendGoverned;
  final bool humanPriority;
}
