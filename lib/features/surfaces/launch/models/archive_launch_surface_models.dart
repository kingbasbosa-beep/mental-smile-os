class ArchiveLaunchSurfaceProfile {
  const ArchiveLaunchSurfaceProfile({
    required this.surfaceId,
    required this.sections,
    required this.tabs,
    required this.cards,
    required this.counters,
    required this.notes,
  });

  final String surfaceId;
  final List<ArchiveLaunchSection> sections;
  final List<ArchiveLaunchTab> tabs;
  final List<ArchiveLaunchCard> cards;
  final List<ArchiveLaunchCounter> counters;
  final String notes;
}

class ArchiveLaunchSection {
  const ArchiveLaunchSection({
    required this.sectionId,
    required this.title,
    required this.purpose,
  });

  final String sectionId;
  final String title;
  final String purpose;
}

class ArchiveLaunchCard {
  const ArchiveLaunchCard({
    required this.cardId,
    required this.title,
    required this.surfaceRole,
  });

  final String cardId;
  final String title;
  final String surfaceRole;
}

class ArchiveLaunchTab {
  const ArchiveLaunchTab({
    required this.tabId,
    required this.title,
    required this.targetSection,
  });

  final String tabId;
  final String title;
  final String targetSection;
}

class ArchiveLaunchCounter {
  const ArchiveLaunchCounter({
    required this.counterId,
    required this.label,
    required this.countSource,
  });

  final String counterId;
  final String label;
  final String countSource;
}
