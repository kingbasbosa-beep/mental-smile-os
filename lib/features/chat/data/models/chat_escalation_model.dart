import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEscalationModel {
  final String id;
  final String threadId;
  final String ownerUid;
  final String ownerDisplayName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String riskLevel;
  final int riskScore;
  final List<String> reasonCodes;
  final String summaryText;
  final String status;
  final String? assignedToType;
  final String? assignedToUid;
  final DateTime? resolvedAt;
  final String? resolvedByUid;
  final String? bookingRequestId;

  const ChatEscalationModel({
    required this.id,
    required this.threadId,
    required this.ownerUid,
    required this.ownerDisplayName,
    required this.createdAt,
    required this.updatedAt,
    required this.riskLevel,
    required this.riskScore,
    required this.reasonCodes,
    required this.summaryText,
    required this.status,
    required this.assignedToType,
    required this.assignedToUid,
    required this.resolvedAt,
    required this.resolvedByUid,
    required this.bookingRequestId,
  });

  factory ChatEscalationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    DateTime? asDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return null;
    }

    return ChatEscalationModel(
      id: doc.id,
      threadId: (data['threadId'] ?? '').toString(),
      ownerUid: (data['ownerUid'] ?? '').toString(),
      ownerDisplayName: (data['ownerDisplayName'] ?? 'مستخدم').toString(),
      createdAt: asDate(data['createdAt']),
      updatedAt: asDate(data['updatedAt']),
      riskLevel: (data['riskLevel'] ?? 'low').toString(),
      riskScore: (data['riskScore'] ?? 0) is int
          ? data['riskScore'] as int
          : int.tryParse('${data['riskScore']}') ?? 0,
      reasonCodes: ((data['reasonCodes'] ?? const []) as List)
          .map((e) => e.toString())
          .toList(),
      summaryText: (data['summaryText'] ?? '').toString(),
      status: (data['status'] ?? 'open').toString(),
      assignedToType: data['assignedToType']?.toString(),
      assignedToUid: data['assignedToUid']?.toString(),
      resolvedAt: asDate(data['resolvedAt']),
      resolvedByUid: data['resolvedByUid']?.toString(),
      bookingRequestId: data['bookingRequestId']?.toString(),
    );
  }
}
