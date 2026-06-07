class MonitoringRoomBlueprint {
  const MonitoringRoomBlueprint({
    required this.roomId,
    required this.sections,
    required this.cards,
    required this.counters,
    required this.reports,
  });

  final String roomId;
  final List<MonitoringSectionBlueprint> sections;
  final List<MonitoringCardBlueprint> cards;
  final List<MonitoringCounterBlueprint> counters;
  final List<MonitoringReportBlueprint> reports;
}

class MonitoringSectionBlueprint {
  const MonitoringSectionBlueprint({
    required this.sectionId,
    required this.title,
    required this.monitoringSource,
  });

  final String sectionId;
  final String title;
  final String monitoringSource;
}

class MonitoringCardBlueprint {
  const MonitoringCardBlueprint({
    required this.cardId,
    required this.title,
    required this.aggregateSource,
  });

  final String cardId;
  final String title;
  final String aggregateSource;
}

class MonitoringCounterBlueprint {
  const MonitoringCounterBlueprint({
    required this.counterId,
    required this.label,
    required this.aggregateSource,
  });

  final String counterId;
  final String label;
  final String aggregateSource;
}

class MonitoringReportBlueprint {
  const MonitoringReportBlueprint({
    required this.reportId,
    required this.title,
    required this.reportSource,
  });

  final String reportId;
  final String title;
  final String reportSource;
}
