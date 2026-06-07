class ClientRoomBlueprint {
  const ClientRoomBlueprint({
    required this.roomId,
    required this.sections,
    required this.cards,
    required this.counters,
    required this.guidanceAreas,
    required this.signalConsumptionAreas,
  });

  final String roomId;
  final List<ClientSectionBlueprint> sections;
  final List<ClientCardBlueprint> cards;
  final List<ClientCounterBlueprint> counters;
  final List<ClientGuidanceBlueprint> guidanceAreas;
  final List<String> signalConsumptionAreas;
}

class ClientSectionBlueprint {
  const ClientSectionBlueprint({
    required this.sectionId,
    required this.title,
    required this.constructionRole,
  });

  final String sectionId;
  final String title;
  final String constructionRole;
}

class ClientCardBlueprint {
  const ClientCardBlueprint({
    required this.cardId,
    required this.title,
    required this.visualRole,
    required this.dataSource,
  });

  final String cardId;
  final String title;
  final String visualRole;
  final String dataSource;
}

class ClientCounterBlueprint {
  const ClientCounterBlueprint({
    required this.counterId,
    required this.label,
    required this.source,
  });

  final String counterId;
  final String label;
  final String source;
}

class ClientGuidanceBlueprint {
  const ClientGuidanceBlueprint({
    required this.guidanceId,
    required this.title,
    required this.accessibilityMode,
  });

  final String guidanceId;
  final String title;
  final String accessibilityMode;
}
