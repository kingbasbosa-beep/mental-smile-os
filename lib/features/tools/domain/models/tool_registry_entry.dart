class ToolRegistryEntry {
  const ToolRegistryEntry({
    required this.toolId,
    required this.name,
    required this.category,
    required this.freeOrPaid,
    required this.targetAudienceSignals,
    required this.requiredSignals,
    required this.icon,
    required this.enabled,
    required this.createdAt,
  });

  static const String collectionName = 'tool_registry';

  final String toolId;
  final String name;
  final String category;
  final String freeOrPaid;
  final List<String> targetAudienceSignals;
  final List<String> requiredSignals;
  final String icon;
  final bool enabled;
  final DateTime? createdAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'toolId': toolId,
      'name': name,
      'category': category,
      'freeOrPaid': freeOrPaid,
      'targetAudienceSignals': targetAudienceSignals,
      'requiredSignals': requiredSignals,
      'icon': icon,
      'enabled': enabled,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory ToolRegistryEntry.fromMap(Map<String, dynamic> map) {
    return ToolRegistryEntry(
      toolId: (map['toolId'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      category: (map['category'] ?? '').toString(),
      freeOrPaid: (map['freeOrPaid'] ?? '').toString(),
      targetAudienceSignals: _stringList(map['targetAudienceSignals']),
      requiredSignals: _stringList(map['requiredSignals']),
      icon: (map['icon'] ?? '').toString(),
      enabled: map['enabled'] == true,
      createdAt: _dateTime(map['createdAt']),
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
