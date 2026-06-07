class ClaimsProvisioningMap {
  const ClaimsProvisioningMap({
    required this.mapId,
    required this.profiles,
    required this.dependencies,
    required this.readinessStatus,
  });

  final String mapId;
  final List<RoleProvisioningProfile> profiles;
  final List<ProvisioningDependency> dependencies;
  final String readinessStatus;
}

class RoleProvisioningProfile {
  const RoleProvisioningProfile({
    required this.role,
    required this.purpose,
    required this.claimKey,
    required this.allowedAuthority,
  });

  final String role;
  final String purpose;
  final String claimKey;
  final String allowedAuthority;
}

class ProvisioningDependency {
  const ProvisioningDependency({
    required this.dependencyId,
    required this.description,
    required this.required,
  });

  final String dependencyId;
  final String description;
  final bool required;
}

class ClaimsReadinessSnapshot {
  const ClaimsReadinessSnapshot({
    required this.roles,
    required this.missingProfiles,
    required this.complianceStatus,
  });

  final Set<String> roles;
  final Set<String> missingProfiles;
  final String complianceStatus;
}
