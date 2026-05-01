import 'package:cloud_firestore/cloud_firestore.dart';

class FollowUpCampaign {
  const FollowUpCampaign({
    required this.id,
    required this.category,
    required this.topic,
    required this.templateId,
    required this.message,
    required this.recipientCount,
    required this.recipientSample,
    required this.status,
    this.createdAt,
    required this.createdByUid,
  });

  final String id;
  final String category;
  final String topic;
  final String templateId;
  final String message;
  final int recipientCount;
  final List<String> recipientSample;
  final String status;
  final DateTime? createdAt;
  final String createdByUid;

  factory FollowUpCampaign.fromMap(Map<String, dynamic> map) {
    return FollowUpCampaign(
      id: _stringValue(map['id']),
      category: _stringValue(map['category']),
      topic: _stringValue(map['topic']),
      templateId: _stringValue(map['templateId']),
      message: _stringValue(map['message']),
      recipientCount: _intValue(map['recipientCount']),
      recipientSample: _stringListValue(map['recipientSample']),
      status: _stringValue(map['status']),
      createdAt: _nullableDateTimeValue(map['createdAt']),
      createdByUid: _stringValue(map['createdByUid']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'topic': topic,
      'templateId': templateId,
      'message': message,
      'recipientCount': recipientCount,
      'recipientSample': recipientSample,
      'status': status,
      'createdAt': _timestampOrNull(createdAt),
      'createdByUid': createdByUid,
    };
  }

  FollowUpCampaign copyWith({
    String? id,
    String? category,
    String? topic,
    String? templateId,
    String? message,
    int? recipientCount,
    List<String>? recipientSample,
    String? status,
    DateTime? createdAt,
    bool clearCreatedAt = false,
    String? createdByUid,
  }) {
    return FollowUpCampaign(
      id: id ?? this.id,
      category: category ?? this.category,
      topic: topic ?? this.topic,
      templateId: templateId ?? this.templateId,
      message: message ?? this.message,
      recipientCount: recipientCount ?? this.recipientCount,
      recipientSample: recipientSample ?? this.recipientSample,
      status: status ?? this.status,
      createdAt: clearCreatedAt ? null : (createdAt ?? this.createdAt),
      createdByUid: createdByUid ?? this.createdByUid,
    );
  }

  static String _stringValue(dynamic value) {
    return (value ?? '').toString().trim();
  }

  static int _intValue(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value.trim()) ?? 0;
    return 0;
  }

  static List<String> _stringListValue(dynamic value) {
    if (value is Iterable) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList();
    }
    return const <String>[];
  }

  static DateTime? _nullableDateTimeValue(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    if (value == null) return null;
    return Timestamp.fromDate(value);
  }
}
