class ProviderToolMeterProfile {
  const ProviderToolMeterProfile({
    required this.providerId,
    required this.meterAssetType,
    required this.visibleDimensions,
  });

  final String providerId;
  final String meterAssetType;
  final Set<String> visibleDimensions;
}

class ProviderGuidanceProfile {
  const ProviderGuidanceProfile({
    required this.providerId,
    required this.easyReadingLabel,
    required this.screenReaderLabel,
    required this.audioLabel,
    required this.learnMoreReference,
  });

  final String providerId;
  final String easyReadingLabel;
  final String screenReaderLabel;
  final String audioLabel;
  final String learnMoreReference;
}

class ProviderInfoCardAlignment {
  const ProviderInfoCardAlignment({
    required this.providerId,
    required this.infoCardType,
    required this.guidanceProfileId,
  });

  final String providerId;
  final String infoCardType;
  final String guidanceProfileId;
}

class ProviderIdentityProfile {
  const ProviderIdentityProfile({
    required this.providerId,
    required this.identityCode,
    required this.localizationKey,
    required this.reportPrefix,
    required this.guidanceKey,
  });

  final String providerId;
  final String identityCode;
  final String localizationKey;
  final String reportPrefix;
  final String guidanceKey;
}

class ProviderArchiveProfile {
  const ProviderArchiveProfile({
    required this.providerId,
    required this.archiveCode,
    required this.archiveClassification,
    required this.retentionMarker,
  });

  final String providerId;
  final String archiveCode;
  final String archiveClassification;
  final String retentionMarker;
}

class ProviderArchiveAlignment {
  const ProviderArchiveAlignment({
    required this.providerProfileReference,
    required this.archiveReference,
    required this.reportReference,
  });

  final String providerProfileReference;
  final String archiveReference;
  final String reportReference;
}

class ProviderReadinessAlignment {
  const ProviderReadinessAlignment({
    required this.readinessReference,
    required this.roadmapReference,
    required this.providerReference,
  });

  final String readinessReference;
  final String roadmapReference;
  final String providerReference;
}
