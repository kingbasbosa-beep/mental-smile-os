import 'runtime_policy_profile.dart';

class RuntimePolicyPack {
  const RuntimePolicyPack({
    required this.packId,
    required this.policyVersion,
    required this.defaultProfile,
    required this.profiles,
  });

  static const RuntimePolicyPack safeDefault = RuntimePolicyPack(
    packId: 'mental_smile_safe_default',
    policyVersion: '2026-05-os3d',
    defaultProfile: RuntimePolicyProfile.disabledFallback,
    profiles: <RuntimePolicyProfile>[
      RuntimePolicyProfile.disabledFallback,
    ],
  );

  final String packId;
  final String policyVersion;
  final RuntimePolicyProfile defaultProfile;
  final List<RuntimePolicyProfile> profiles;

  RuntimePolicyProfile profileById(String profileId) {
    return profiles.firstWhere(
      (profile) => profile.profileId == profileId.trim(),
      orElse: () => defaultProfile,
    );
  }
}
