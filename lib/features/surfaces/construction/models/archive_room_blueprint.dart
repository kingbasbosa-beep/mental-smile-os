class ArchiveRoomBlueprint {
  const ArchiveRoomBlueprint({
    required this.roomId,
    required this.packages,
    required this.cards,
    required this.reports,
    required this.sovereignArchive,
  });

  final String roomId;
  final List<ArchivePackageBlueprint> packages;
  final List<ArchiveCardBlueprint> cards;
  final List<ArchiveReportBlueprint> reports;
  final SovereignArchiveBlueprint sovereignArchive;
}

class ArchivePackageBlueprint {
  const ArchivePackageBlueprint({
    required this.packageId,
    required this.title,
    required this.packageType,
  });

  final String packageId;
  final String title;
  final String packageType;
}

class ArchiveCardBlueprint {
  const ArchiveCardBlueprint({
    required this.cardId,
    required this.title,
    required this.archiveRole,
  });

  final String cardId;
  final String title;
  final String archiveRole;
}

class ArchiveReportBlueprint {
  const ArchiveReportBlueprint({
    required this.reportId,
    required this.title,
    required this.reportCategory,
  });

  final String reportId;
  final String title;
  final String reportCategory;
}

class SovereignArchiveBlueprint {
  const SovereignArchiveBlueprint({
    required this.blueprintId,
    required this.allowedPackageTypes,
    required this.visibilityScope,
  });

  final String blueprintId;
  final List<String> allowedPackageTypes;
  final String visibilityScope;
}
