class ClientLaunchSurfaceProfile {
  const ClientLaunchSurfaceProfile({
    required this.surfaceId,
    required this.sections,
    required this.tabs,
    required this.cards,
    required this.counters,
    required this.notes,
  });

  final String surfaceId;
  final List<ClientLaunchSection> sections;
  final List<ClientLaunchTab> tabs;
  final List<ClientLaunchCard> cards;
  final List<ClientLaunchCounter> counters;
  final String notes;
}

class ClientLaunchSection {
  const ClientLaunchSection({
    required this.sectionId,
    required this.title,
    required this.purpose,
  });

  final String sectionId;
  final String title;
  final String purpose;
}

class ClientLaunchCard {
  const ClientLaunchCard({
    required this.cardId,
    required this.title,
    required this.surfaceRole,
  });

  final String cardId;
  final String title;
  final String surfaceRole;
}

class ClientLaunchTab {
  const ClientLaunchTab({
    required this.tabId,
    required this.title,
    required this.targetSection,
  });

  final String tabId;
  final String title;
  final String targetSection;
}

class ClientLaunchCounter {
  const ClientLaunchCounter({
    required this.counterId,
    required this.label,
    required this.countSource,
  });

  final String counterId;
  final String label;
  final String countSource;
}
