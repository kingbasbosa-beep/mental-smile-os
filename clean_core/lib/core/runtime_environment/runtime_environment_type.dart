enum RuntimeEnvironmentType {
  localDev,
  staging,
  production,
  restrictedReview,
  fallbackOnly,
}

extension RuntimeEnvironmentTypeKey on RuntimeEnvironmentType {
  String get key {
    switch (this) {
      case RuntimeEnvironmentType.localDev:
        return 'local_dev';
      case RuntimeEnvironmentType.staging:
        return 'staging';
      case RuntimeEnvironmentType.production:
        return 'production';
      case RuntimeEnvironmentType.restrictedReview:
        return 'restricted_review';
      case RuntimeEnvironmentType.fallbackOnly:
        return 'fallback_only';
    }
  }
}
