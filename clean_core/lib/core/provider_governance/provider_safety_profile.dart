import 'provider_audit_reference.dart';
import 'provider_policy_link.dart';
import 'provider_restriction.dart';
import 'provider_trust_level.dart';

class ProviderSafetyProfile {
  const ProviderSafetyProfile({
    required this.providerId,
    required this.trustLevel,
    required this.restriction,
    required this.policyLink,
    this.auditReference,
  });

  static const ProviderSafetyProfile blockedDefault = ProviderSafetyProfile(
    providerId: 'unknown_provider',
    trustLevel: ProviderTrustLevel.blocked,
    restriction: ProviderRestriction.denyByDefault,
    policyLink: ProviderPolicyLink(
      policyPackId: '',
      policyVersion: '',
      snapshotId: '',
      hashPlaceholder: 'provider_policy_hash_missing',
    ),
  );

  final String providerId;
  final ProviderTrustLevel trustLevel;
  final ProviderRestriction restriction;
  final ProviderPolicyLink policyLink;
  final ProviderAuditReference? auditReference;

  bool get isUsable {
    return trustLevel == ProviderTrustLevel.approved && policyLink.isLinked;
  }
}
