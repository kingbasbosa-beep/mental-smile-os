import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final String id;
  final String threadId;
  final String senderType;
  final String? senderUid;
  final String text;
  final DateTime? createdAt;
  final int sequenceNumber;
  final bool visibleToUser;
  final String messageKind;

  final String? roleDetected;
  final List<String> statesDetected;
  final int riskScore;
  final String riskLevel;
  final String strategyMode;
  final bool safetyTriggered;
  final bool containsEscalationSignal;

  final String? aiModelVersion;
  final String? systemVersion;
  final Map<String, dynamic> metadata;

  const ChatMessageModel({
    required this.id,
    required this.threadId,
    required this.senderType,
    required this.senderUid,
    required this.text,
    required this.createdAt,
    required this.sequenceNumber,
    required this.visibleToUser,
    required this.messageKind,
    required this.roleDetected,
    required this.statesDetected,
    required this.riskScore,
    required this.riskLevel,
    required this.strategyMode,
    required this.safetyTriggered,
    required this.containsEscalationSignal,
    required this.aiModelVersion,
    required this.systemVersion,
    required this.metadata,
  });

  factory ChatMessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    DateTime? asDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return null;
    }

    List<String> asStringList(dynamic value) {
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
      if (value == null) return const [];
      final text = value.toString().trim();
      if (text.isEmpty) return const [];
      return [text];
    }

    Map<String, dynamic> asStringMap(dynamic value) {
      if (value is Map<String, dynamic>) return value;
      if (value is Map) {
        return value.map(
          (key, item) => MapEntry(key.toString(), item),
        );
      }
      return const {};
    }

    return ChatMessageModel(
      id: doc.id,
      threadId: (data['threadId'] ?? '').toString(),
      senderType: (data['senderType'] ?? 'user').toString(),
      senderUid: data['senderUid']?.toString(),
      text: (data['text'] ?? '').toString(),
      createdAt: asDate(data['createdAt']),
      sequenceNumber: (data['sequenceNumber'] ?? 0) is int
          ? data['sequenceNumber'] as int
          : int.tryParse('${data['sequenceNumber']}') ?? 0,
      visibleToUser: (data['visibleToUser'] ?? true) == true,
      messageKind: (data['messageKind'] ?? 'normal').toString(),
      roleDetected: data['roleDetected']?.toString(),
      statesDetected: asStringList(data['statesDetected']),
      riskScore: (data['riskScore'] ?? 0) is int
          ? data['riskScore'] as int
          : int.tryParse('${data['riskScore']}') ?? 0,
      riskLevel: (data['riskLevel'] ?? 'low').toString(),
      strategyMode: (data['strategyMode'] ?? 'containment').toString(),
      safetyTriggered: (data['safetyTriggered'] ?? false) == true,
      containsEscalationSignal:
          (data['containsEscalationSignal'] ?? false) == true,
      aiModelVersion: data['aiModelVersion']?.toString(),
      systemVersion: data['systemVersion']?.toString(),
      metadata: asStringMap(data['metadata']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'threadId': threadId,
      'senderType': senderType,
      'senderUid': senderUid,
      'text': text,
      'createdAt': createdAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(createdAt!),
      'sequenceNumber': sequenceNumber,
      'visibleToUser': visibleToUser,
      'messageKind': messageKind,
      'roleDetected': roleDetected,
      'statesDetected': statesDetected,
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'strategyMode': strategyMode,
      'safetyTriggered': safetyTriggered,
      'containsEscalationSignal': containsEscalationSignal,
      'aiModelVersion': aiModelVersion,
      'systemVersion': systemVersion,
      'metadata': metadata,
    };
  }
}
