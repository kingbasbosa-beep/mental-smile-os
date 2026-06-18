import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_smile_os/features/chat/data/models/chat_escalation_model.dart';
import 'package:mental_smile_os/features/chat/data/models/chat_message_model.dart';
import 'package:mental_smile_os/features/chat/data/models/chat_signal_routing_model.dart';
import 'package:mental_smile_os/features/chat/data/models/chat_thread_model.dart';

class ChatFirestoreService {
  ChatFirestoreService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _threads =>
      _firestore.collection('chat_threads');

  CollectionReference<Map<String, dynamic>> get _escalations =>
      _firestore.collection('chat_escalations');

  Future<ChatThreadModel> createThread({
    required String participantUid,
    required String participantType,
    required String displayName,
    required String threadType,
    String sourceType = 'guest',
    String language = 'ar',
    bool isTemporary = true,
    String identityState = 'guest',
  }) async {
    final doc = _threads.doc();

    final model = ChatThreadModel(
      id: doc.id,
      participantUid: participantUid,
      participantType: participantType,
      threadType: threadType,
      displayName: displayName,
      sourceType: sourceType,
      createdAt: null,
      updatedAt: null,
      lastMessageAt: null,
      lastMessagePreview: '',
      messageCount: 0,
      isTemporary: isTemporary,
      needsHumanSupport: false,
      escalationLevel: 'none',
      language: language,
      identityState: identityState,
      safetyState: 'safe',
      riskScore: 0,
      riskLevel: 'low',
      strategyMode: 'support_guidance',
      lastEmotionalStates: const [],
      lastDetectedRole: null,
    );

    await doc.set(model.toFirestore());
    final created = await doc.get();
    return ChatThreadModel.fromFirestore(created);
  }

  Future<ChatThreadModel?> getThread(String threadId) async {
    final doc = await _threads.doc(threadId).get();
    if (!doc.exists) return null;
    return ChatThreadModel.fromFirestore(doc);
  }

  Future<ChatThreadModel?> getAiSupportThreadForParticipant(
    String participantUid,
  ) async {
    final query =
        await _threads.where('participantUid', isEqualTo: participantUid).get();

    final threads = query.docs.map(ChatThreadModel.fromFirestore).toList()
      ..sort(_compareNewestThreadFirst);

    for (final thread in threads) {
      if (thread.threadType == 'ai_support') {
        return thread;
      }
    }

    return null;
  }

  int _compareNewestThreadFirst(ChatThreadModel a, ChatThreadModel b) {
    final aTime = a.updatedAt ?? a.createdAt;
    final bTime = b.updatedAt ?? b.createdAt;

    if (aTime == null && bTime == null) return 0;
    if (aTime == null) return 1;
    if (bTime == null) return -1;
    return bTime.compareTo(aTime);
  }

  Future<List<ChatThreadModel>> getThreadsForParticipant(
    String participantUid,
  ) async {
    final query =
        await _threads.where('participantUid', isEqualTo: participantUid).get();

    return query.docs.map(ChatThreadModel.fromFirestore).toList();
  }

  Stream<ChatThreadModel?> streamThread(String threadId) {
    return _threads.doc(threadId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return ChatThreadModel.fromFirestore(doc);
    });
  }

  Stream<List<ChatMessageModel>> streamMessages(String threadId) {
    return _threads
        .doc(threadId)
        .collection('messages')
        .orderBy('sequenceNumber')
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => ChatMessageModel.fromFirestore(doc))
            .toList();
      },
    );
  }

  Stream<List<ChatEscalationModel>> streamEscalations() {
    return _escalations
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final items = <ChatEscalationModel>[];

      for (final doc in snapshot.docs) {
        final escalation = ChatEscalationModel.fromFirestore(doc);
        final thread = await getThread(escalation.threadId);
        if (thread == null) continue;
        if (_isEscalationSourceThread(thread)) {
          items.add(escalation);
        }
      }

      return items;
    });
  }

  bool _isEscalationSourceThread(ChatThreadModel thread) {
    return thread.threadType == 'ai_support';
  }

  /// Streams safety escalations where the clinician is a recommendation.
  Stream<List<ChatEscalationModel>> streamRecommendedEscalations(
    String clinicianUid,
  ) {
    return _escalations
        .where('recommendedProviders', arrayContains: clinicianUid)
        .snapshots()
        .map((snapshot) {
      final items =
          snapshot.docs.map(ChatEscalationModel.fromFirestore).toList();
      items.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });
      return items;
    });
  }

  Future<int> _nextSequence(String threadId) async {
    final latest = await _threads
        .doc(threadId)
        .collection('messages')
        .orderBy('sequenceNumber', descending: true)
        .limit(1)
        .get();

    if (latest.docs.isEmpty) return 1;
    final data = latest.docs.first.data();
    final current = (data['sequenceNumber'] ?? 0) is int
        ? data['sequenceNumber'] as int
        : int.tryParse('${data['sequenceNumber']}') ?? 0;
    return current + 1;
  }

  Future<void> sendMessage({
    required String threadId,
    required String senderType,
    required String text,
    String? senderUid,
    bool visibleToUser = true,
    String messageKind = 'normal',
    String? roleDetected,
    List<String> statesDetected = const [],
    int riskScore = 0,
    String riskLevel = 'low',
    String strategyMode = 'containment',
    bool safetyTriggered = false,
    bool containsEscalationSignal = false,
    String? aiModelVersion,
    String? systemVersion,
    Map<String, dynamic> metadata = const {},
  }) async {
    final threadRef = _threads.doc(threadId);
    final seq = await _nextSequence(threadId);
    final msgRef = threadRef.collection('messages').doc();

    final message = ChatMessageModel(
      id: msgRef.id,
      threadId: threadId,
      senderType: senderType,
      senderUid: senderUid,
      text: text,
      createdAt: null,
      sequenceNumber: seq,
      visibleToUser: visibleToUser,
      messageKind: messageKind,
      roleDetected: roleDetected,
      statesDetected: statesDetected,
      riskScore: riskScore,
      riskLevel: riskLevel,
      strategyMode: strategyMode,
      safetyTriggered: safetyTriggered,
      containsEscalationSignal: containsEscalationSignal,
      aiModelVersion: aiModelVersion,
      systemVersion: systemVersion,
      metadata: metadata,
    );

    await _firestore.runTransaction((tx) async {
      tx.set(msgRef, message.toFirestore());

      tx.update(threadRef, {
        'updatedAt': FieldValue.serverTimestamp(),
        'lastMessageAt': FieldValue.serverTimestamp(),
        'lastMessagePreview': text.length > 120 ? text.substring(0, 120) : text,
        'messageCount': FieldValue.increment(1),
        'riskScore': riskScore,
        'riskLevel': riskLevel,
        'strategyMode': strategyMode,
        'lastEmotionalStates': statesDetected,
        'lastDetectedRole': roleDetected,
        'needsHumanSupport': safetyTriggered || containsEscalationSignal,
        'escalationLevel': safetyTriggered
            ? 'urgent'
            : (containsEscalationSignal ? 'recommended' : 'none'),
        'safetyState': safetyTriggered
            ? 'critical'
            : (riskLevel == 'high'
                ? 'high_risk'
                : (riskLevel == 'medium' ? 'monitor' : 'safe')),
      });
    });
  }

  Future<void> updateThreadState({
    required String threadId,
    required Map<String, dynamic> updates,
  }) async {
    await _threads.doc(threadId).update({
      ...updates,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> resolveEscalation({
    required String escalationId,
    required String resolverUid,
  }) async {
    await _firestore.runTransaction((tx) async {
      tx.update(_escalations.doc(escalationId), {
        'status': 'resolved',
        'resolvedByUid': resolverUid,
        'resolvedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<String> createEscalation({
    required String threadId,
    required String participantUid,
    required String participantDisplayName,
    required int riskScore,
    required String riskLevel,
    required List<String> reasonCodes,
    required String summaryText,
    ChatSignalRoutingModel? signalRouting,
  }) async {
    final routing = signalRouting ??
        ChatSignalRoutingModel(
          recommendedProviders: const <String>[],
          recommendedSignals: reasonCodes,
          recommendedActions: const <String>[
            'observe_safety_signals',
            'offer_support_choices',
          ],
          routingSignals: <String>[
            'risk_level:$riskLevel',
            ...reasonCodes,
          ],
          safetyEscalationLevel: riskLevel,
        );
    final doc = await _escalations.add({
      'threadId': threadId,
      'participantUid': participantUid,
      'participantDisplayName': participantDisplayName,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'riskLevel': riskLevel,
      'riskScore': riskScore,
      'reasonCodes': reasonCodes,
      'summaryText': summaryText,
      'status': 'open',
      ...routing.toFirestore(),
      'resolvedAt': null,
      'resolvedByUid': null,
    });
    return doc.id;
  }

  /// Fetches the latest safety escalation report for the given [escalationId].
  /// Returns the document data or null if none exists.
  Future<Map<String, dynamic>?> getLatestReportForEscalation(
    String escalationId,
  ) async {
    final snapshot = await _escalations
        .doc(escalationId)
        .collection('reports')
        .orderBy('generatedAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;
    final doc = snapshot.docs.first;
    final data = doc.data();
    data['reportId'] = doc.id;
    return data;
  }

  Future<void> createSafetyReport({
    required String escalationId,
    required String threadId,
    required String participantUid,
    required String participantDisplayName,
    required String roleDetected,
    required String roleConfidence,
    required DateTime? startedAt,
    required DateTime? lastMessageAt,
    required int durationSeconds,
    required int messageCount,
    required List<Map<String, dynamic>> emotionalTimeline,
    required String initialLevel,
    required String finalLevel,
    required int finalScore,
    required String strategyMode,
    required String safetyState,
    required List<String> keySafetyIndicators,
    required bool criticalScoreReached,
    required bool selfHarmIntentDetected,
    required bool harmToOthersDetected,
    required bool minorAbuseDisclosureDetected,
    required bool severeLossOfControlDetected,
    required List<String> aiActionsTaken,
    required String assessmentSummary,
    required String recommendedSafetyRouting,
    required List<String> confidentialityOverrideBasis,
  }) async {
    await _escalations.doc(escalationId).collection('reports').add({
      'reportType': 'safety_escalation_report',
      'reportVersion': 'v1.0',
      'generatedAt': FieldValue.serverTimestamp(),
      'threadId': threadId,
      'escalationId': escalationId,
      'participantUid': participantUid,
      'participantDisplayName': participantDisplayName,
      'roleDetected': roleDetected,
      'roleConfidence': roleConfidence,
      'conversationOverview': {
        'startedAt': startedAt == null ? null : Timestamp.fromDate(startedAt),
        'lastMessageAt':
            lastMessageAt == null ? null : Timestamp.fromDate(lastMessageAt),
        'durationSeconds': durationSeconds,
        'messageCount': messageCount,
      },
      'emotionalTimeline': emotionalTimeline,
      'riskEscalationPath': {
        'initialLevel': initialLevel,
        'finalLevel': finalLevel,
        'finalScore': finalScore,
        'strategyMode': strategyMode,
        'safetyState': safetyState,
      },
      'keySafetyIndicators': keySafetyIndicators,
      'triggerFlags': {
        'criticalScoreReached': criticalScoreReached,
        'selfHarmIntentDetected': selfHarmIntentDetected,
        'harmToOthersDetected': harmToOthersDetected,
        'minorAbuseDisclosureDetected': minorAbuseDisclosureDetected,
        'severeLossOfControlDetected': severeLossOfControlDetected,
      },
      'aiActionsTaken': aiActionsTaken,
      'currentSafetyAssessment': {
        'level': finalLevel,
        'summary': assessmentSummary,
        'nonDiagnostic': true,
      },
      'recommendedSafetyRouting': recommendedSafetyRouting,
      'confidentialityOverrideBasis': confidentialityOverrideBasis,
      'policyMode': 'exception_limited_disclosure',
      'visibleToSupport': true,
      'visibleToRecommendedProviders': true,
    });
  }
}
