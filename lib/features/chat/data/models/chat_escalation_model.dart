import 'package:cloud_firestore/cloud_firestore.dart';

class ChatEscalationModel {
  final String id;
  final String threadId;
  final String participantUid;
  final String participantDisplayName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String riskLevel;
  final int riskScore;
  final List<String> reasonCodes;
  final String summaryText;
  final String status;
  final List<String> recommendedProviders;
  final List<String> recommendedSignals;
  final List<String> recommendedActions;
  final List<String> routingSignals;
  final String safetyEscalationLevel;
  final DateTime? resolvedAt;
  final String? resolvedByUid;

  const ChatEscalationModel({
    required this.id,
    required this.threadId,
    required this.participantUid,
    required this.participantDisplayName,
    required this.createdAt,
    required this.updatedAt,
    required this.riskLevel,
    required this.riskScore,
    required this.reasonCodes,
    required this.summaryText,
    required this.status,
    required this.recommendedProviders,
    required this.recommendedSignals,
    required this.recommendedActions,
    required this.routingSignals,
    required this.safetyEscalationLevel,
    required this.resolvedAt,
    required this.resolvedByUid,
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

    List<String> asStringList(dynamic value) {
      if (value is! List) return const <String>[];
      return value.map((item) => item.toString()).toList(growable: false);
    }

    return ChatEscalationModel(
      id: doc.id,
      threadId: (data['threadId'] ?? '').toString(),
      participantUid: (data['participantUid'] ?? '').toString(),
      participantDisplayName:
          (data['participantDisplayName'] ?? 'User').toString(),
      createdAt: asDate(data['createdAt']),
      updatedAt: asDate(data['updatedAt']),
      riskLevel: (data['riskLevel'] ?? 'low').toString(),
      riskScore: (data['riskScore'] ?? 0) is int
          ? data['riskScore'] as int
          : int.tryParse('${data['riskScore']}') ?? 0,
      reasonCodes: asStringList(data['reasonCodes']),
      summaryText: (data['summaryText'] ?? '').toString(),
      status: (data['status'] ?? 'open').toString(),
      recommendedProviders: asStringList(data['recommendedProviders']),
      recommendedSignals: asStringList(data['recommendedSignals']),
      recommendedActions: asStringList(data['recommendedActions']),
      routingSignals: asStringList(data['routingSignals']),
      safetyEscalationLevel:
          (data['safetyEscalationLevel'] ?? data['riskLevel'] ?? 'low')
              .toString(),
      resolvedAt: asDate(data['resolvedAt']),
      resolvedByUid: data['resolvedByUid']?.toString(),
    );
  }
}
