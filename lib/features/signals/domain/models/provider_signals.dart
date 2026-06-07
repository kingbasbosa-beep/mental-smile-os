class ProviderSignals {
  const ProviderSignals({
    required this.capabilitySignals,
    required this.specialtySignals,
    required this.languageSignals,
    required this.accessibilitySignals,
    required this.updatedAt,
  });

  final List<String> capabilitySignals;
  final List<String> specialtySignals;
  final List<String> languageSignals;
  final List<String> accessibilitySignals;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'capabilitySignals': capabilitySignals,
      'specialtySignals': specialtySignals,
      'languageSignals': languageSignals,
      'accessibilitySignals': accessibilitySignals,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ProviderSignals.fromMap(Map<String, dynamic> map) {
    return ProviderSignals(
      capabilitySignals: _stringList(map['capabilitySignals']),
      specialtySignals: _stringList(map['specialtySignals']),
      languageSignals: _stringList(map['languageSignals']),
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
