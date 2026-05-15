enum EnvironmentActivationEnvironmentType {
  localDev,
  staging,
  restrictedReview,
  fallbackOnly,
  production,
  secureReview,
}

extension EnvironmentActivationEnvironmentTypeKey
    on EnvironmentActivationEnvironmentType {
  String get key {
    switch (this) {
      case EnvironmentActivationEnvironmentType.localDev:
        return 'local_dev';
      case EnvironmentActivationEnvironmentType.staging:
        return 'staging';
      case EnvironmentActivationEnvironmentType.restrictedReview:
        return 'restricted_review';
      case EnvironmentActivationEnvironmentType.fallbackOnly:
        return 'fallback_only';
      case EnvironmentActivationEnvironmentType.production:
        return 'production';
      case EnvironmentActivationEnvironmentType.secureReview:
        return 'secure_review';
    }
  }
}

class EnvironmentActivationEnvironment {
  const EnvironmentActivationEnvironment({
    required this.environmentId,
    required this.environmentType,
    required this.ownerId,
    required this.signedAuthorityPlaceholder,
  });

  final String environmentId;
  final EnvironmentActivationEnvironmentType environmentType;
  final String ownerId;
  final String signedAuthorityPlaceholder;

  bool get hasTrustedOwner =>
      environmentId.trim().isNotEmpty &&
      ownerId.trim().isNotEmpty &&
      signedAuthorityPlaceholder.trim().isNotEmpty;
}
