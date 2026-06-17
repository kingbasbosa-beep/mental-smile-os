class ClientSignals {
  const ClientSignals({
    required this.goalSignals,
    required this.interestSignals,
    required this.accessibilitySignals,
    required this.communicationSignals,
    required this.savedDestinations,
    required this.enabledTools,
    required this.updatedAt,
  });

  final List<String> goalSignals;
  final List<String> interestSignals;
  final List<String> accessibilitySignals;
  final List<String> communicationSignals;
  final List<String> savedDestinations;
  final List<String> enabledTools;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'goalSignals': goalSignals,
      'interestSignals': interestSignals,
      'accessibilitySignals': accessibilitySignals,
      'communicationSignals': communicationSignals,
      'savedDestinations': savedDestinations,
      'enabledTools': enabledTools,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ClientSignals.fromMap(Map<String, dynamic> map) {
    return ClientSignals(
      goalSignals: _stringList(map['goalSignals']),
      interestSignals: _stringList(map['interestSignals']),
      accessibilitySignals: _stringList(map['accessibilitySignals']),
      communicationSignals: _stringList(map['communicationSignals']),
      savedDestinations: _stringList(map['savedDestinations']),
      enabledTools: _stringList(map['enabledTools']),
      updatedAt: _dateTime(map['updatedAt']),
    );
  }

  static List<String> _stringList(Object? value) {
    if (value is Iterable) {
      return value.map((item) => item.toString()).toList(growable: false);
    }
    return const <String>[];
  }

  static DateTime? _dateTime(Object? value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
