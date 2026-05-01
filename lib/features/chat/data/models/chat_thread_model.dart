import 'package:cloud_firestore/cloud_firestore.dart';

class ChatThreadModel {
  // Canonical chat classification contract:
  // - threadType is the primary classifier for active chat flows.
  // - sourceType, handoffState, and lifecycleState remain legacy fallback
  //   signals only for older threads and rollback-safe compatibility paths.
  // - New chat flows should not use sourceType as the primary classifier.
  final String id;
  final String ownerUid;
  final String ownerType;
  final String? threadType;
  final String displayName;
  final String status;
  final String sourceType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastMessageAt;
  final String lastMessagePreview;
  final int messageCount;
  final bool isTemporary;
  final bool convertedToOfficialClient;
  final String? officialClientUid;
  final bool bookingLinked;
  final String? bookingRequestId;
  final String? assignedClinicianUid;
  final String? assignedAdminUid;
  final bool needsHumanSupport;
  final String escalationLevel;
  final bool archived;
  final DateTime? closedAt;
  final String language;

  final String lifecycleState;
  final String identityState;
  final String safetyState;
  final String handoffState;

  final int riskScore;
  final String riskLevel;
  final String strategyMode;
  final List<String> lastEmotionalStates;
  final String? lastDetectedRole;

  const ChatThreadModel({
    required this.id,
    required this.ownerUid,
    required this.ownerType,
    required this.threadType,
    required this.displayName,
    required this.status,
    required this.sourceType,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessageAt,
    required this.lastMessagePreview,
    required this.messageCount,
    required this.isTemporary,
    required this.convertedToOfficialClient,
    required this.officialClientUid,
    required this.bookingLinked,
    required this.bookingRequestId,
    required this.assignedClinicianUid,
    required this.assignedAdminUid,
    required this.needsHumanSupport,
    required this.escalationLevel,
    required this.archived,
    required this.closedAt,
    required this.language,
    required this.lifecycleState,
    required this.identityState,
    required this.safetyState,
    required this.handoffState,
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
      ownerUid: (data['ownerUid'] ?? '').toString(),
      ownerType: (data['ownerType'] ?? 'anonymous_client').toString(),
      threadType: data['threadType']?.toString(),
      displayName: (data['displayName'] ?? 'مستخدم').toString(),
      status: (data['status'] ?? 'active').toString(),
      sourceType: (data['sourceType'] ?? 'guest').toString(),
      createdAt: asDate(data['createdAt']),
      updatedAt: asDate(data['updatedAt']),
      lastMessageAt: asDate(data['lastMessageAt']),
      lastMessagePreview: (data['lastMessagePreview'] ?? '').toString(),
      messageCount: (data['messageCount'] ?? 0) is int
          ? data['messageCount'] as int
          : int.tryParse('${data['messageCount']}') ?? 0,
      isTemporary: (data['isTemporary'] ?? true) == true,
      convertedToOfficialClient:
          (data['convertedToOfficialClient'] ?? false) == true,
      officialClientUid: data['officialClientUid']?.toString(),
      bookingLinked: (data['bookingLinked'] ?? false) == true,
      bookingRequestId: data['bookingRequestId']?.toString(),
      assignedClinicianUid: data['assignedClinicianUid']?.toString(),
      assignedAdminUid: data['assignedAdminUid']?.toString(),
      needsHumanSupport: (data['needsHumanSupport'] ?? false) == true,
      escalationLevel: (data['escalationLevel'] ?? 'none').toString(),
      archived: (data['archived'] ?? false) == true,
      closedAt: asDate(data['closedAt']),
      language: (data['language'] ?? 'ar').toString(),
      lifecycleState: (data['lifecycleState'] ?? 'new').toString(),
      identityState: (data['identityState'] ?? 'guest').toString(),
      safetyState: (data['safetyState'] ?? 'safe').toString(),
      handoffState: (data['handoffState'] ?? 'ai_only').toString(),
      riskScore: (data['riskScore'] ?? 0) is int
          ? data['riskScore'] as int
          : int.tryParse('${data['riskScore']}') ?? 0,
      riskLevel: (data['riskLevel'] ?? 'low').toString(),
      strategyMode: (data['strategyMode'] ?? 'containment').toString(),
      lastEmotionalStates: ((data['lastEmotionalStates'] ?? const []) as List)
          .map((e) => e.toString())
          .toList(),
      lastDetectedRole: data['lastDetectedRole']?.toString(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'ownerUid': ownerUid,
      'ownerType': ownerType,
      'threadType': threadType,
      'displayName': displayName,
      'status': status,
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
      'convertedToOfficialClient': convertedToOfficialClient,
      'officialClientUid': officialClientUid,
      'bookingLinked': bookingLinked,
      'bookingRequestId': bookingRequestId,
      'assignedClinicianUid': assignedClinicianUid,
      'assignedAdminUid': assignedAdminUid,
      'needsHumanSupport': needsHumanSupport,
      'escalationLevel': escalationLevel,
      'archived': archived,
      'closedAt': closedAt == null ? null : Timestamp.fromDate(closedAt!),
      'language': language,
      'lifecycleState': lifecycleState,
      'identityState': identityState,
      'safetyState': safetyState,
      'handoffState': handoffState,
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'strategyMode': strategyMode,
      'lastEmotionalStates': lastEmotionalStates,
      'lastDetectedRole': lastDetectedRole,
    };
  }

  ChatThreadModel copyWith({
    String? id,
    String? ownerUid,
    String? ownerType,
    String? threadType,
    String? displayName,
    String? status,
    String? sourceType,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastMessageAt,
    String? lastMessagePreview,
    int? messageCount,
    bool? isTemporary,
    bool? convertedToOfficialClient,
    String? officialClientUid,
    bool? bookingLinked,
    String? bookingRequestId,
    String? assignedClinicianUid,
    String? assignedAdminUid,
    bool? needsHumanSupport,
    String? escalationLevel,
    bool? archived,
    DateTime? closedAt,
    String? language,
    String? lifecycleState,
    String? identityState,
    String? safetyState,
    String? handoffState,
    int? riskScore,
    String? riskLevel,
    String? strategyMode,
    List<String>? lastEmotionalStates,
    String? lastDetectedRole,
  }) {
    return ChatThreadModel(
      id: id ?? this.id,
      ownerUid: ownerUid ?? this.ownerUid,
      ownerType: ownerType ?? this.ownerType,
      threadType: threadType ?? this.threadType,
      displayName: displayName ?? this.displayName,
      status: status ?? this.status,
      sourceType: sourceType ?? this.sourceType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      messageCount: messageCount ?? this.messageCount,
      isTemporary: isTemporary ?? this.isTemporary,
      convertedToOfficialClient:
          convertedToOfficialClient ?? this.convertedToOfficialClient,
      officialClientUid: officialClientUid ?? this.officialClientUid,
      bookingLinked: bookingLinked ?? this.bookingLinked,
      bookingRequestId: bookingRequestId ?? this.bookingRequestId,
      assignedClinicianUid: assignedClinicianUid ?? this.assignedClinicianUid,
      assignedAdminUid: assignedAdminUid ?? this.assignedAdminUid,
      needsHumanSupport: needsHumanSupport ?? this.needsHumanSupport,
      escalationLevel: escalationLevel ?? this.escalationLevel,
      archived: archived ?? this.archived,
      closedAt: closedAt ?? this.closedAt,
      language: language ?? this.language,
      lifecycleState: lifecycleState ?? this.lifecycleState,
      identityState: identityState ?? this.identityState,
      safetyState: safetyState ?? this.safetyState,
      handoffState: handoffState ?? this.handoffState,
      riskScore: riskScore ?? this.riskScore,
      riskLevel: riskLevel ?? this.riskLevel,
      strategyMode: strategyMode ?? this.strategyMode,
      lastEmotionalStates: lastEmotionalStates ?? this.lastEmotionalStates,
      lastDetectedRole: lastDetectedRole ?? this.lastDetectedRole,
    );
  }
}
