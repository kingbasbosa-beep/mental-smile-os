import 'package:cloud_firestore/cloud_firestore.dart';

class ChatThreadModel {
  final String id;
  final String participantUid;
  final String participantType;
  final String threadType;
  final String displayName;
  final String sourceType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastMessageAt;
  final String lastMessagePreview;
  final int messageCount;
  final bool isTemporary;
  final bool needsHumanSupport;
  final String escalationLevel;
  final String language;
  final String identityState;
  final String safetyState;
  final int riskScore;
  final String riskLevel;
  final String strategyMode;
  final List<String> lastEmotionalStates;
  final String? lastDetectedRole;

  const ChatThreadModel({
    required this.id,
    required this.participantUid,
    required this.participantType,
    required this.threadType,
    required this.displayName,
    required this.sourceType,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessageAt,
    required this.lastMessagePreview,
    required this.messageCount,
    required this.isTemporary,
    required this.needsHumanSupport,
    required this.escalationLevel,
    required this.language,
    required this.identityState,
    required this.safetyState,
    required this.riskScore,
    required this.riskLevel,
    required this.strategyMode,
    required this.lastEmotionalStates,
    required this.lastDetectedRole,
  });

  factory ChatThreadModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    DateTime? asDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return null;
    }

    return ChatThreadModel(
      id: doc.id,
      participantUid: (data['participantUid'] ?? '').toString(),
      participantType:
          (data['participantType'] ?? 'anonymous_client').toString(),
      threadType: (data['threadType'] ?? 'ai_support').toString(),
      displayName: (data['displayName'] ?? 'User').toString(),
      sourceType: (data['sourceType'] ?? 'guest').toString(),
      createdAt: asDate(data['createdAt']),
      updatedAt: asDate(data['updatedAt']),
      lastMessageAt: asDate(data['lastMessageAt']),
      lastMessagePreview: (data['lastMessagePreview'] ?? '').toString(),
      messageCount: (data['messageCount'] ?? 0) is int
          ? data['messageCount'] as int
          : int.tryParse('${data['messageCount']}') ?? 0,
      isTemporary: (data['isTemporary'] ?? true) == true,
      needsHumanSupport: (data['needsHumanSupport'] ?? false) == true,
      escalationLevel: (data['escalationLevel'] ?? 'none').toString(),
      language: (data['language'] ?? 'ar').toString(),
      identityState: (data['identityState'] ?? 'guest').toString(),
      safetyState: (data['safetyState'] ?? 'safe').toString(),
      riskScore: (data['riskScore'] ?? 0) is int
          ? data['riskScore'] as int
          : int.tryParse('${data['riskScore']}') ?? 0,
      riskLevel: (data['riskLevel'] ?? 'low').toString(),
      strategyMode: (data['strategyMode'] ?? 'support_guidance').toString(),
      lastEmotionalStates: ((data['lastEmotionalStates'] ?? const []) as List)
          .map((item) => item.toString())
          .toList(growable: false),
      lastDetectedRole: data['lastDetectedRole']?.toString(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'participantUid': participantUid,
      'participantType': participantType,
      'threadType': threadType,
      'displayName': displayName,
      'sourceType': sourceType,
      'createdAt': createdAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(createdAt!),
      'updatedAt': updatedAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(updatedAt!),
      'lastMessageAt':
          lastMessageAt == null ? null : Timestamp.fromDate(lastMessageAt!),
      'lastMessagePreview': lastMessagePreview,
      'messageCount': messageCount,
      'isTemporary': isTemporary,
      'needsHumanSupport': needsHumanSupport,
      'escalationLevel': escalationLevel,
      'language': language,
      'identityState': identityState,
      'safetyState': safetyState,
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'strategyMode': strategyMode,
      'lastEmotionalStates': lastEmotionalStates,
      'lastDetectedRole': lastDetectedRole,
    };
  }
}
