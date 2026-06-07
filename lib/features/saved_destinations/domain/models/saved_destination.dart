enum SavedDestinationType {
  provider,
  center,
  libraryItem,
  tool,
}

class SavedDestination {
  const SavedDestination({
    required this.savedId,
    required this.clientId,
    required this.destinationType,
    required this.destinationId,
    required this.title,
    required this.route,
    required this.signalTags,
    required this.createdAt,
    required this.updatedAt,
  });

  static const String collectionName = 'saved_destinations';

  final String savedId;
  final String clientId;
  final SavedDestinationType destinationType;
  final String destinationId;
  final String title;
  final String route;
  final List<String> signalTags;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'savedId': savedId,
      'clientId': clientId,
      'destinationType': destinationType.name,
      'destinationId': destinationId,
      'title': title,
      'route': route,
      'signalTags': signalTags,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory SavedDestination.fromMap(Map<String, dynamic> map) {
    return SavedDestination(
      savedId: (map['savedId'] ?? '').toString(),
      clientId: (map['clientId'] ?? '').toString(),
      destinationType: _typeFromValue(map['destinationType']),
      destinationId: (map['destinationId'] ?? '').toString(),
      title: (map['title'] ?? '').toString(),
      route: (map['route'] ?? '').toString(),
      signalTags: _stringList(map['signalTags']),
      createdAt: _dateTime(map['createdAt']),
      updatedAt: _dateTime(map['updatedAt']),
    );
  }

  static SavedDestinationType _typeFromValue(Object? value) {
    final raw = value?.toString() ?? '';
    return SavedDestinationType.values.firstWhere(
      (type) => type.name == raw,
      orElse: () => SavedDestinationType.provider,
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
