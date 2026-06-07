class OwnerIdentityProfile {
  const OwnerIdentityProfile({
    required this.ownerDepartmentId,
    required this.identityCode,
    required this.reportPrefix,
    required this.archivePrefix,
    required this.capsulePrefix,
  });

  final String ownerDepartmentId;
  final String identityCode;
  final String reportPrefix;
  final String archivePrefix;
  final String capsulePrefix;
}

class OwnerVisualProfile {
  const OwnerVisualProfile({
    required this.primaryColorToken,
    required this.secondaryColorToken,
    required this.iconKey,
    required this.stripeColor,
  });

  final String primaryColorToken;
  final String secondaryColorToken;
  final String iconKey;
  final String stripeColor;
}

class OwnerReportProfile {
  const OwnerReportProfile({
    required this.reportPrefix,
    required this.reportLabel,
    required this.archiveStamp,
    required this.classification,
  });

  final String reportPrefix;
  final String reportLabel;
  final String archiveStamp;
  final String classification;
}
