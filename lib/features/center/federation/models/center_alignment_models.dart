class CenterToolMeterProfile {
  const CenterToolMeterProfile({
    required this.centerId,
    required this.meterAssetType,
    required this.visibleDimensions,
  });

  final String centerId;
  final String meterAssetType;
  final Set<String> visibleDimensions;
}

class CenterGuidanceProfile {
  const CenterGuidanceProfile({
    required this.centerId,
    required this.easyReadingLabel,
    required this.screenReaderLabel,
    required this.audioLabel,
    required this.learnMoreReference,
  });

  final String centerId;
  final String easyReadingLabel;
  final String screenReaderLabel;
  final String audioLabel;
  final String learnMoreReference;
}

class CenterInfoCardAlignment {
  const CenterInfoCardAlignment({
    required this.centerId,
    required this.infoCardType,
    required this.guidanceProfileId,
  });

  final String centerId;
  final String infoCardType;
  final String guidanceProfileId;
}

class CenterIdentityProfile {
  const CenterIdentityProfile({
    required this.centerId,
    required this.identityCode,
    required this.localizationKey,
    required this.reportPrefix,
    required this.guidanceKey,
  });

  final String centerId;
  final String identityCode;
  final String localizationKey;
  final String reportPrefix;
  final String guidanceKey;
}

class CenterArchiveProfile {
  const CenterArchiveProfile({
    required this.centerId,
    required this.archiveCode,
    required this.archiveClassification,
    required this.retentionMarker,
  });

  final String centerId;
  final String archiveCode;
  final String archiveClassification;
  final String retentionMarker;
}

class CenterArchiveAlignment {
  const CenterArchiveAlignment({
    required this.centerProfileReference,
    required this.archiveReference,
    required this.reportReference,
  });

  final String centerProfileReference;
  final String archiveReference;
  final String reportReference;
}

class CenterReadinessAlignment {
  const CenterReadinessAlignment({
    required this.readinessReference,
    required this.roadmapReference,
    required this.centerReference,
  });

  final String readinessReference;
  final String roadmapReference;
  final String centerReference;
}
