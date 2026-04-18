import 'package:cloud_firestore/cloud_firestore.dart';

class DomainStatus {
  const DomainStatus({
    required this.status,
    required this.updatedAt,
    this.updatedBy,
    this.note,
    this.degradedFeatures = const <String>[],
    this.metadata = const <String, dynamic>{},
  });

  final String status;
  final DateTime updatedAt;
  final String? updatedBy;
  final String? note;
  final List<String> degradedFeatures;
  final Map<String, dynamic> metadata;

  factory DomainStatus.fromMap(Map<String, dynamic> map) {
    final metadata = Map<String, dynamic>.from(map)
      ..remove('status')
      ..remove('updatedAt')
      ..remove('updatedBy')
      ..remove('note')
      ..remove('degradedFeatures');

    return DomainStatus(
      status: (map['status'] ?? 'unknown').toString(),
      updatedAt: _dateTimeFromValue(map['updatedAt']),
      updatedBy: _stringOrNull(map['updatedBy']),
      note: _stringOrNull(map['note']),
      degradedFeatures: _stringListFromValue(map['degradedFeatures']),
      metadata: metadata,
    );
  }

  factory DomainStatus.unknown() {
    return DomainStatus(
      status: 'unknown',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'updatedBy': updatedBy,
      'note': note,
      'degradedFeatures': degradedFeatures,
      ...metadata,
    };
  }

  bool get isUnknown => status == 'unknown';

  static DateTime _dateTimeFromValue(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  static String? _stringOrNull(dynamic value) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? null : text;
  }

  static List<String> _stringListFromValue(dynamic value) {
    if (value is Iterable) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList();
    }
    return const <String>[];
  }
}
