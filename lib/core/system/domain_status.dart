import 'package:cloud_firestore/cloud_firestore.dart';

class DomainStatus {
  const DomainStatus({
    required this.status,
    required this.updatedAt,
    this.updatedBy,
    this.note,
    this.degradedFeatures = const <String>[],
    this.statusSource = 'observed',
    this.statusReason,
    this.statusSetAt,
    this.statusSetBy,
    this.metadata = const <String, dynamic>{},
  });

  final String status;
  final DateTime updatedAt;
  final String? updatedBy;
  final String? note;
  final List<String> degradedFeatures;
  final String statusSource;
  final String? statusReason;
  final DateTime? statusSetAt;
  final String? statusSetBy;
  final Map<String, dynamic> metadata;

  factory DomainStatus.fromMap(Map<String, dynamic> map) {
    final metadata = Map<String, dynamic>.from(map)
      ..remove('status')
      ..remove('updatedAt')
      ..remove('updatedBy')
      ..remove('note')
      ..remove('degradedFeatures');
      ..remove('statusSource')
      ..remove('statusReason')
      ..remove('statusSetAt')
      ..remove('statusSetBy');

    return DomainStatus(
      status: (map['status'] ?? 'unknown').toString(),
      updatedAt: _dateTimeFromValue(map['updatedAt']),
      updatedBy: _stringOrNull(map['updatedBy']),
      note: _stringOrNull(map['note']),
      degradedFeatures: _stringListFromValue(map['degradedFeatures']),
      statusSource: _statusSourceFromValue(map['statusSource']),
      statusReason: _stringOrNull(map['statusReason']),
      statusSetAt: _optionalDateTimeFromValue(map['statusSetAt']),
      statusSetBy: _stringOrNull(map['statusSetBy']),
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
      'statusSource': statusSource,
      'statusReason': statusReason,
      'statusSetAt':
          statusSetAt == null ? null : Timestamp.fromDate(statusSetAt!),
      'statusSetBy': statusSetBy,
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

  static DateTime? _optionalDateTimeFromValue(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static String? _stringOrNull(dynamic value) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? null : text;
  }

  static String _statusSourceFromValue(dynamic value) {
    final text = (value ?? '').toString().trim();
    switch (text) {
      case 'admin_set':
      case 'mixed':
      case 'observed':
        return text;
      default:
        return 'observed';
    }
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
