class CenterSignals {
  const CenterSignals({
    required this.serviceSignals,
    required this.capabilitySignals,
    required this.accessibilitySignals,
    required this.updatedAt,
  });

  final List<String> serviceSignals;
  final List<String> capabilitySignals;
  final List<String> accessibilitySignals;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceSignals': serviceSignals,
      'capabilitySignals': capabilitySignals,
      'accessibilitySignals': accessibilitySignals,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory CenterSignals.fromMap(Map<String, dynamic> map) {
    return CenterSignals(
      serviceSignals: _stringList(map['serviceSignals']),
      capabilitySignals: _stringList(map['capabilitySignals']),
      accessibilitySignals: _stringList(map['accessibilitySignals']),
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
