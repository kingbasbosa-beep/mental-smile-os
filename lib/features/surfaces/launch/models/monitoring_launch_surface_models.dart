class MonitoringLaunchSurfaceProfile {
  const MonitoringLaunchSurfaceProfile({
    required this.surfaceId,
    required this.sections,
    required this.tabs,
    required this.cards,
    required this.counters,
    required this.notes,
  });

  final String surfaceId;
  final List<MonitoringLaunchSection> sections;
  final List<MonitoringLaunchTab> tabs;
  final List<MonitoringLaunchCard> cards;
  final List<MonitoringLaunchCounter> counters;
  final String notes;
}

class MonitoringLaunchSection {
  const MonitoringLaunchSection({
    required this.sectionId,
    required this.title,
    required this.purpose,
  });

  final String sectionId;
  final String title;
  final String purpose;
}

class MonitoringLaunchCard {
  const MonitoringLaunchCard({
    required this.cardId,
    required this.title,
    required this.surfaceRole,
  });

  final String cardId;
  final String title;
  final String surfaceRole;
}

class MonitoringLaunchTab {
  const MonitoringLaunchTab({
    required this.tabId,
    required this.title,
    required this.targetSection,
  });

  final String tabId;
  final String title;
  final String targetSection;
}

class MonitoringLaunchCounter {
  const MonitoringLaunchCounter({
    required this.counterId,
    required this.label,
    required this.countSource,
  });

  final String counterId;
  final String label;
  final String countSource;
}
