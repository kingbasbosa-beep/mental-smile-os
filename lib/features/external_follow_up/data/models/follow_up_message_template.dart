import 'package:cloud_firestore/cloud_firestore.dart';

class FollowUpMessageTemplate {
  const FollowUpMessageTemplate({
    required this.id,
    required this.category,
    required this.topic,
    required this.title,
    required this.variants,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String category;
  final String topic;
  final String title;
  final Map<String, String> variants;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FollowUpMessageTemplate.fromMap(Map<String, dynamic> map) {
    return FollowUpMessageTemplate(
      id: _stringValue(map['id']),
      category: _stringValue(map['category']),
      topic: _stringValue(map['topic']),
      title: _stringValue(map['title']),
      variants: _stringMapValue(map['variants']),
      isActive: _boolValue(map['isActive'], fallback: true),
      createdAt: _nullableDateTimeValue(map['createdAt']),
      updatedAt: _nullableDateTimeValue(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'topic': topic,
      'title': title,
      'variants': variants,
      'isActive': isActive,
      'createdAt': _timestampOrNull(createdAt),
      'updatedAt': _timestampOrNull(updatedAt),
    };
  }

  FollowUpMessageTemplate copyWith({
    String? id,
    String? category,
    String? topic,
    String? title,
    Map<String, String>? variants,
    bool? isActive,
    DateTime? createdAt,
    bool clearCreatedAt = false,
    DateTime? updatedAt,
    bool clearUpdatedAt = false,
  }) {
    return FollowUpMessageTemplate(
      id: id ?? this.id,
      category: category ?? this.category,
      topic: topic ?? this.topic,
      title: title ?? this.title,
      variants: variants ?? this.variants,
      isActive: isActive ?? this.isActive,
      createdAt: clearCreatedAt ? null : (createdAt ?? this.createdAt),
      updatedAt: clearUpdatedAt ? null : (updatedAt ?? this.updatedAt),
    );
  }

  static String _stringValue(dynamic value) {
    return (value ?? '').toString().trim();
  }

  static Map<String, String> _stringMapValue(dynamic value) {
    if (value is Map) {
      return value.map(
        (key, item) => MapEntry(
          key.toString().trim(),
          (item ?? '').toString(),
        ),
      );
    }
    return const <String, String>{};
  }

  static DateTime? _nullableDateTimeValue(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static bool _boolValue(dynamic value, {required bool fallback}) {
    if (value is bool) return value;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized == 'true' || normalized == '1') return true;
      if (normalized == 'false' || normalized == '0') return false;
    }
    if (value is num) return value != 0;
    return fallback;
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    if (value == null) return null;
    return Timestamp.fromDate(value);
  }
}
