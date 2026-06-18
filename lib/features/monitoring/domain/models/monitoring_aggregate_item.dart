class MonitoringAggregateItem {
  const MonitoringAggregateItem({
    required this.monitoringKey,
    required this.signalType,
    required this.signalCategory,
    required this.count,
    required this.firstSeen,
    required this.lastSeen,
    required this.aggregationWindow,
  });

  final String monitoringKey;
  final String signalType;
  final String signalCategory;
  final int count;
  final DateTime firstSeen;
  final DateTime lastSeen;
  final String aggregationWindow;

  MonitoringAggregateItem mergedWith(MonitoringAggregateItem other) {
    return MonitoringAggregateItem(
      monitoringKey: monitoringKey,
      signalType: signalType,
      signalCategory: signalCategory,
      count: count + other.count,
      firstSeen:
          firstSeen.isBefore(other.firstSeen) ? firstSeen : other.firstSeen,
      lastSeen: lastSeen.isAfter(other.lastSeen) ? lastSeen : other.lastSeen,
      aggregationWindow: aggregationWindow,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'monitoringKey': monitoringKey,
      'signalType': signalType,
      'signalCategory': signalCategory,
      'count': count,
      'firstSeen': firstSeen.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
      'aggregationWindow': aggregationWindow,
    };
  }
}
