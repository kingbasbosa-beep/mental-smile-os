import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterprojects/features/chat/data/models/chat_escalation_model.dart';
import 'package:flutterprojects/features/chat/data/models/chat_message_model.dart';
import 'package:flutterprojects/features/chat/data/models/chat_thread_model.dart';
import 'package:flutterprojects/features/chat/data/models/clinician_option_model.dart';

class ChatFirestoreService {
  ChatFirestoreService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _threads =>
      _firestore.collection('chat_threads');

  CollectionReference<Map<String, dynamic>> get _escalations =>
      _firestore.collection('chat_escalations');

  CollectionReference<Map<String, dynamic>> get _clinicians =>
      _firestore.collection('clinicians');

  Future<ChatThreadModel> createThread({
    required String ownerUid,
    required String ownerType,
    required String displayName,
    String? threadType,
    String sourceType = 'guest',
    String language = 'ar',
    bool isTemporary = true,
    String identityState = 'guest',
  }) async {
    final doc = _threads.doc();

    final model = ChatThreadModel(
      id: doc.id,
      ownerUid: ownerUid,
      ownerType: ownerType,
      threadType: threadType,
      displayName: displayName,
      status: 'active',
      sourceType: sourceType,
      createdAt: null,
      updatedAt: null,
      lastMessageAt: null,
      lastMessagePreview: '',
      messageCount: 0,
      isTemporary: isTemporary,
      convertedToOfficialClient: false,
      officialClientUid: null,
      bookingLinked: false,
      bookingRequestId: null,
      assignedClinicianUid: null,
      assignedAdminUid: null,
      needsHumanSupport: false,
      escalationLevel: 'none',
      archived: false,
      closedAt: null,
      language: language,
      lifecycleState: 'new',
      identityState: identityState,
      safetyState: 'safe',
      handoffState: 'ai_only',
      riskScore: 0,
      riskLevel: 'low',
      strategyMode: 'containment',
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

  Future<ChatThreadModel?> getActiveThreadForUser(String ownerUid) async {
    final query = await _threads
        .where('ownerUid', isEqualTo: ownerUid)
        .where('archived', isEqualTo: false)
        .orderBy('updatedAt', descending: true)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return ChatThreadModel.fromFirestore(query.docs.first);
  }

  Future<List<ChatThreadModel>> getThreadsForOwner(String ownerUid) async {
    final query = await _threads
        .where('ownerUid', isEqualTo: ownerUid)
        .where('archived', isEqualTo: false)
        .get();

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

  bool _isLegacyAiSupportThread(ChatThreadModel thread) {
    final threadType = thread.threadType?.trim() ?? '';
    if (threadType.isNotEmpty) return false;
    return thread.sourceType == 'client' || thread.sourceType == 'guest';
  }

  bool _isEscalationSourceThread(ChatThreadModel thread) {
    if (thread.threadType == 'ai_support') return true;
    return _isLegacyAiSupportThread(thread);
  }

  bool _isLegacyAdminSupportThread(ChatThreadModel thread) {
    final threadType = thread.threadType?.trim() ?? '';
    if (threadType.isNotEmpty) return false;
    return thread.sourceType == 'admin_support';
  }

  bool _isMissingThreadType(ChatThreadModel thread) {
    final threadType = thread.threadType?.trim() ?? '';
    return threadType.isEmpty;
  }

  bool _isLegacyClinicianCaseFallbackThread(ChatThreadModel thread) {
    if (!_isMissingThreadType(thread)) return false;
    return thread.handoffState == 'clinician_review' ||
        thread.lifecycleState == 'assigned_clinician';
  }

  bool _isTypedClinicianCaseThread(ChatThreadModel thread) {
    return thread.threadType == 'clinician_case';
  }

  /// Clinician inbox source-of-truth:
  /// - Prefer explicit threadType == 'clinician_case'
  /// - Use legacy fallback only when threadType is missing
  bool _matchesClinicianInboxThread(ChatThreadModel thread) {
    if (_isTypedClinicianCaseThread(thread)) return true;
    return _isLegacyClinicianCaseFallbackThread(thread);
  }

  void _debugMeasureLegacyClinicianFallbackThreads(
    String clinicianUid,
    List<ChatThreadModel> threads,
  ) {
    if (!kDebugMode) return;

    final legacyFallbackThreads = threads
        .where(_isLegacyClinicianCaseFallbackThread)
        .toList();

    if (legacyFallbackThreads.isEmpty) return;

    debugPrint(
      'CHAT_CLINICIAN_FALLBACK_MEASURE '
      'clinicianUid=$clinicianUid '
      'legacyClinicianFallbackCount=${legacyFallbackThreads.length} '
      'sampleThreadIds=${legacyFallbackThreads.take(5).map((t) => t.id).join(",")}',
    );
  }

  Stream<List<ChatThreadModel>> streamAdminSupportInboxThreads() {
    return _threads.orderBy('updatedAt', descending: true).snapshots().map(
      (snapshot) {
        final typed = <ChatThreadModel>[];
        final legacyFallback = <ChatThreadModel>[];

        for (final doc in snapshot.docs) {
          final thread = ChatThreadModel.fromFirestore(doc);
          if (thread.archived) continue;

          if (thread.threadType == 'admin_support') {
            typed.add(thread);
            continue;
          }

          if (_isLegacyAdminSupportThread(thread)) {
            legacyFallback.add(thread);
          }
        }

        return [...typed, ...legacyFallback];
      },
    );
  }

  /// Streams escalated chat cases assigned to a specific clinician.
  /// Filters by assignedToType == 'clinician' and assignedToUid == [clinicianUid].
  Stream<List<ChatEscalationModel>> streamClinicianEscalations(
    String clinicianUid,
  ) {
    return _escalations
        .where('assignedToType', isEqualTo: 'clinician')
        .where('assignedToUid', isEqualTo: clinicianUid)
        .orderBy('createdAt', descending: true)
      .snapshots()
      .asyncMap((snapshot) async {
        final items = <ChatEscalationModel>[];
        final matchedThreads = <ChatThreadModel>[];

        for (final doc in snapshot.docs) {
          final escalation = ChatEscalationModel.fromFirestore(doc);
          ChatThreadModel? thread;
          try {
            thread = await getThread(escalation.threadId);
          } catch (e) {
            if (kDebugMode) {
              debugPrint(
                'CHAT_CLINICIAN_THREAD_READ_SKIP '
                'clinicianUid=$clinicianUid '
                'escalationId=${escalation.id} '
                'threadId=${escalation.threadId} '
                'error=$e',
              );
            }
            continue;
          }
          if (thread == null) continue;
          if (_matchesClinicianInboxThread(thread)) {
            matchedThreads.add(thread);
            items.add(escalation);
          }
      }

      _debugMeasureLegacyClinicianFallbackThreads(
        clinicianUid,
        matchedThreads,
      );

      return items;
    });
  }

  Stream<List<ClinicianOptionModel>> streamClinicians() {
    return _clinicians.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ClinicianOptionModel.fromFirestore(doc))
              .where((c) => c.isActive)
              .toList(),
        );
  }

  Stream<Map<String, ClinicianOptionModel>> streamCliniciansMap() {
    return streamClinicians().map(
      (items) => {for (final c in items) c.id: c},
    );
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
        'lifecycleState': safetyTriggered
            ? 'escalated'
            : (riskLevel == 'medium' || riskLevel == 'high'
                ? 'watching'
                : 'active_ai'),
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

  Future<void> archiveThread(String threadId) async {
    await _threads.doc(threadId).update({
      'archived': true,
      'closedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> linkBookingToThread({
    required String threadId,
    required String bookingRequestId,
    required String officialClientUid,
  }) async {
    await _threads.doc(threadId).update({
      'threadType': 'booking_followup',
      'bookingLinked': true,
      'bookingRequestId': bookingRequestId,
      'convertedToOfficialClient': true,
      'officialClientUid': officialClientUid,
      'isTemporary': false,
      'identityState': 'upgraded',
      'sourceType': 'booking_flow',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> assignEscalationToAdmin({
    required String escalationId,
    required String threadId,
    required String adminUid,
  }) async {
    await _firestore.runTransaction((tx) async {
      tx.update(_escalations.doc(escalationId), {
        'assignedToType': 'admin',
        'assignedToUid': adminUid,
        'status': 'assigned',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      tx.update(_threads.doc(threadId), {
        'assignedAdminUid': adminUid,
        'handoffState': 'admin_review',
        'lifecycleState': 'assigned_admin',
        'needsHumanSupport': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> forwardEscalationToClinician({
    required String escalationId,
    required String threadId,
    required String clinicianUid,
  }) async {
    await _firestore.runTransaction((tx) async {
      tx.update(_escalations.doc(escalationId), {
        'assignedToType': 'clinician',
        'assignedToUid': clinicianUid,
        'status': 'forwarded_to_clinician',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      tx.update(_threads.doc(threadId), {
        'assignedClinicianUid': clinicianUid,
        'threadType': 'clinician_case',
        'handoffState': 'clinician_review',
        'lifecycleState': 'assigned_clinician',
        'needsHumanSupport': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> resolveEscalation({
    required String escalationId,
    required String threadId,
    required String resolverUid,
  }) async {
    await _firestore.runTransaction((tx) async {
      tx.update(_escalations.doc(escalationId), {
        'status': 'resolved',
        'resolvedByUid': resolverUid,
        'resolvedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      tx.update(_threads.doc(threadId), {
        'handoffState': 'resolved',
        'lifecycleState': 'resolved',
        'needsHumanSupport': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<String> createEscalation({
    required String threadId,
    required String ownerUid,
    required String ownerDisplayName,
    required int riskScore,
    required String riskLevel,
    required List<String> reasonCodes,
    required String summaryText,
  }) async {
    final doc = await _escalations.add({
      'threadId': threadId,
      'ownerUid': ownerUid,
      'ownerDisplayName': ownerDisplayName,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'riskLevel': riskLevel,
      'riskScore': riskScore,
      'reasonCodes': reasonCodes,
      'summaryText': summaryText,
      'status': 'open',
      'assignedToType': null,
      'assignedToUid': null,
      'resolvedAt': null,
      'resolvedByUid': null,
      'bookingRequestId': null,
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
    required String ownerUid,
    required String ownerDisplayName,
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
      'ownerUid': ownerUid,
      'ownerDisplayName': ownerDisplayName,
      'roleDetected': roleDetected,
      'roleConfidence': roleConfidence,
      'sessionOverview': {
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
      'visibleToAdmin': true,
      'visibleToAssignedClinician': true,
    });
  }
}
