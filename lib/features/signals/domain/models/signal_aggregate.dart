class SignalAggregate {
  const SignalAggregate({
    required this.aggregateKey,
    required this.signalType,
    required this.signalCategory,
    required this.count,
    required this.firstSeen,
    required this.lastSeen,
    required this.aggregationWindow,
  });

  final String aggregateKey;
  final String signalType;
  final String signalCategory;
  final int count;
  final DateTime firstSeen;
  final DateTime lastSeen;
  final String aggregationWindow;

  SignalAggregate incremented(DateTime seenAt) {
    final normalizedSeenAt = seenAt.toUtc();
    return SignalAggregate(
      aggregateKey: aggregateKey,
      signalType: signalType,
      signalCategory: signalCategory,
      count: count + 1,
      firstSeen:
          firstSeen.isBefore(normalizedSeenAt) ? firstSeen : normalizedSeenAt,
      lastSeen:
          lastSeen.isAfter(normalizedSeenAt) ? lastSeen : normalizedSeenAt,
      aggregationWindow: aggregationWindow,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aggregateKey': aggregateKey,
      'signalType': signalType,
      'signalCategory': signalCategory,
      'count': count,
      'firstSeen': firstSeen.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
      'aggregationWindow': aggregationWindow,
    };
  }

  factory SignalAggregate.fromMap(Map<String, dynamic> map) {
    return SignalAggregate(
      aggregateKey: (map['aggregateKey'] ?? '').toString(),
      signalType: (map['signalType'] ?? '').toString(),
      signalCategory: (map['signalCategory'] ?? '').toString(),
      count: map['count'] is int
          ? map['count'] as int
          : int.tryParse((map['count'] ?? '0').toString()) ?? 0,
      firstSeen:
          _dateTime(map['firstSeen']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      lastSeen:
          _dateTime(map['lastSeen']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      aggregationWindow: (map['aggregationWindow'] ?? '').toString(),
    );
  }

  static DateTime? _dateTime(Object? value) {
    if (value is DateTime) return value.toUtc();
    if (value is String) return DateTime.tryParse(value)?.toUtc();
    return null;
  }
}
