import 'provider_boundary_scope.dart';
import 'provider_capability.dart';

class ProviderRestriction {
  const ProviderRestriction({
    required this.blockedRuntimeModes,
    required this.blockedCapabilities,
    required this.blockedEnvironments,
    required this.restrictedAuditScopes,
    required this.escalationAccessAllowed,
    required this.crisisHandlingAllowed,
  });

  static const ProviderRestriction denyByDefault = ProviderRestriction(
    blockedRuntimeModes: <String>{'server_governed', 'restricted_provider'},
    blockedCapabilities: <ProviderCapability>{
      ProviderCapability.textGeneration,
      ProviderCapability.safeSupport,
      ProviderCapability.translation,
      ProviderCapability.moderationAssist,
      ProviderCapability.crisisDetection,
      ProviderCapability.escalationAssist,
      ProviderCapability.auditTracing,
    },
    blockedEnvironments: <String>{'production', 'staging', 'local_dev'},
    restrictedAuditScopes: <ProviderBoundaryScope>{
      ProviderBoundaryScope.crisisSupport,
      ProviderBoundaryScope.safetyReview,
      ProviderBoundaryScope.aiRuntime,
    },
    escalationAccessAllowed: false,
    crisisHandlingAllowed: false,
  );

  final Set<String> blockedRuntimeModes;
  final Set<ProviderCapability> blockedCapabilities;
  final Set<String> blockedEnvironments;
  final Set<ProviderBoundaryScope> restrictedAuditScopes;
  final bool escalationAccessAllowed;
  final bool crisisHandlingAllowed;

  bool blocksCapability(ProviderCapability capability) {
    return blockedCapabilities.contains(capability);
  }
}
