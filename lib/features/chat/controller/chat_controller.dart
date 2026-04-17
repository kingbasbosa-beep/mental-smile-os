import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterprojects/features/chat/data/models/chat_message_model.dart';
import 'package:flutterprojects/features/chat/data/models/chat_thread_model.dart';
import 'package:flutterprojects/features/chat/data/services/chat_ai_service.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';
import 'package:flutterprojects/shared/gateways/role_access_gateway.dart';

class ChatController {
  ChatController({
    ChatFirestoreService? firestoreService,
    FirebaseAuth? auth,
  })  : _firestoreService = firestoreService ?? ChatFirestoreService(),
        _auth = auth ?? FirebaseAuth.instance;

  final ChatFirestoreService _firestoreService;
  final FirebaseAuth _auth;
  final ChatAiService _aiService = const ChatAiService();

  bool _isAdminSupportThread(ChatThreadModel thread) {
    return thread.sourceType == 'admin_support' ||
        thread.handoffState == 'admin_review' ||
        thread.handoffState == 'admin_replying' ||
        thread.lifecycleState == 'assigned_admin';
  }

  Future<void> _maybeCreateEscalation({
    required String threadId,
    required ChatAiResult aiResult,
  }) async {
    if (!aiResult.needsHumanSupport) return;

    final thread = await _firestoreService.getThread(threadId);
    if (thread == null) return;

    if (_isAdminSupportThread(thread) || thread.assignedAdminUid != null) {
      return;
    }

    final reasonCodes = <String>[
      aiResult.riskLevel,
      ...aiResult.statesDetected,
    ].where((item) => item.trim().isNotEmpty).toSet().toList();

    await _firestoreService.createEscalation(
      threadId: threadId,
      ownerUid: thread.ownerUid,
      ownerDisplayName: thread.displayName,
      riskScore: aiResult.riskScore,
      riskLevel: aiResult.riskLevel,
      reasonCodes: reasonCodes,
      summaryText: aiResult.responseText,
    );
  }

  Future<ChatThreadModel> getOrCreateThread() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('لا يوجد مستخدم مسجل حاليًا');
    }

    final existingThreads =
        await _firestoreService.getThreadsForOwner(user.uid);
    final aiThreads = existingThreads
        .where((thread) => !_isAdminSupportThread(thread))
        .toList()
      ..sort((a, b) {
        final aDate = a.updatedAt ??
            a.createdAt ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.updatedAt ??
            b.createdAt ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });

    if (aiThreads.isNotEmpty) return aiThreads.first;

    final isAnonymous = user.isAnonymous;
    return _firestoreService.createThread(
      ownerUid: user.uid,
      ownerType: isAnonymous ? 'anonymous_client' : 'registered_client',
      threadType: 'ai_support',
      displayName: user.email ?? 'مستخدم',
      sourceType: isAnonymous ? 'guest' : 'client',
      isTemporary: isAnonymous,
      identityState: isAnonymous ? 'guest' : 'registered_client',
    );
  }

  Future<ChatThreadModel> getOrCreateAdminSupportThread() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('لا يوجد مستخدم مسجل حاليًا');
    }

    final query = await _firestoreService.getThreadsForOwner(user.uid);

    for (final thread in query) {
      if (_isAdminSupportThread(thread)) {
        return thread;
      }
    }

    final isCenter = await RoleAccessGateway().isCenter();

    final thread = await _firestoreService.createThread(
      ownerUid: user.uid,
      ownerType: isCenter ? 'registered_center' : 'registered_client',
      threadType: 'admin_support',
      displayName: user.email ?? 'مستخدم',
      sourceType: 'admin_support',
      isTemporary: false,
      identityState: isCenter ? 'registered_center' : 'registered_client',
    );

    await _firestoreService.updateThreadState(
      threadId: thread.id,
      updates: {
        'needsHumanSupport': true,
        'handoffState': 'admin_review',
        'lifecycleState': 'assigned_admin',
        'escalationLevel': 'recommended',
        'strategyMode': 'human_handoff',
        'safetyState': 'monitor',
      },
    );

    final created = await _firestoreService.getThread(thread.id);
    return created ?? thread;
  }

  Future<ChatThreadModel?> getThreadById(String threadId) {
    return _firestoreService.getThread(threadId);
  }

  Future<ChatThreadModel> startFreshAiThread({String? archiveThreadId}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('لا يوجد مستخدم مسجل حاليًا');
    }

    if (archiveThreadId != null && archiveThreadId.isNotEmpty) {
      await _firestoreService.archiveThread(archiveThreadId);
    }

    final isAnonymous = user.isAnonymous;
    return _firestoreService.createThread(
      ownerUid: user.uid,
      ownerType: isAnonymous ? 'anonymous_client' : 'registered_client',
      threadType: 'ai_support',
      displayName: user.email ?? 'مستخدم',
      sourceType: isAnonymous ? 'guest' : 'client',
      isTemporary: isAnonymous,
      identityState: isAnonymous ? 'guest' : 'registered_client',
    );
  }

  Future<void> sendUserMessage({
    required String threadId,
    required String text,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('لا يوجد مستخدم مسجل حاليًا');
    }

    final aiResult = _aiService.processUserMessage(text);

    await _firestoreService.sendMessage(
      threadId: threadId,
      senderType: 'user',
      senderUid: user.uid,
      text: text,
      visibleToUser: true,
      messageKind: 'user_message',
      roleDetected: aiResult.roleDetected,
      statesDetected: aiResult.statesDetected,
      riskScore: aiResult.riskScore,
      riskLevel: aiResult.riskLevel,
      strategyMode: aiResult.strategyMode,
      safetyTriggered: aiResult.safetyTriggered,
      containsEscalationSignal: aiResult.containsEscalationSignal,
      aiModelVersion: null,
      systemVersion: 'chat_user_v1',
    );

    await _firestoreService.sendMessage(
      threadId: threadId,
      senderType: 'ai',
      senderUid: null,
      text: aiResult.responseText,
      visibleToUser: true,
      messageKind: 'ai_reply',
      roleDetected: aiResult.roleDetected,
      statesDetected: aiResult.statesDetected,
      riskScore: aiResult.riskScore,
      riskLevel: aiResult.riskLevel,
      strategyMode: aiResult.strategyMode,
      safetyTriggered: aiResult.safetyTriggered,
      containsEscalationSignal: aiResult.containsEscalationSignal,
      aiModelVersion: 'local_rule_ai_v1',
      systemVersion: 'chat_ai_v1',
    );

    await _maybeCreateEscalation(
      threadId: threadId,
      aiResult: aiResult,
    );

    await _firestoreService.updateThreadState(
      threadId: threadId,
      updates: {
        'needsHumanSupport': aiResult.needsHumanSupport,
        'handoffState': aiResult.needsHumanSupport ? 'admin_review' : 'ai_only',
        'lifecycleState':
            aiResult.needsHumanSupport ? 'assigned_admin' : 'active_ai',
        'escalationLevel': aiResult.safetyTriggered
            ? 'urgent'
            : (aiResult.containsEscalationSignal ? 'recommended' : 'none'),
        'strategyMode': aiResult.strategyMode,
        'safetyState': aiResult.safetyTriggered
            ? 'critical'
            : (aiResult.riskLevel == 'high'
                ? 'high_risk'
                : (aiResult.riskLevel == 'medium' ? 'monitor' : 'safe')),
        'riskScore': aiResult.riskScore,
        'riskLevel': aiResult.riskLevel,
        'lastEmotionalStates': aiResult.statesDetected,
        'lastDetectedRole': aiResult.roleDetected,
      },
    );
  }

  Future<void> sendSupportMessage({
    required String threadId,
    required String text,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('لا يوجد مستخدم مسجل حاليًا');
    }

    await _firestoreService.sendMessage(
      threadId: threadId,
      senderType: 'user',
      senderUid: user.uid,
      text: text,
      visibleToUser: true,
      messageKind: 'admin_waiting',
      roleDetected: null,
      statesDetected: const [],
      riskScore: 0,
      riskLevel: 'low',
      strategyMode: 'human_handoff',
      safetyTriggered: false,
      containsEscalationSignal: true,
      aiModelVersion: null,
      systemVersion: 'admin_waiting_v1',
    );

    await _firestoreService.updateThreadState(
      threadId: threadId,
      updates: {
        'needsHumanSupport': true,
        'handoffState': 'admin_review',
        'lifecycleState': 'assigned_admin',
        'escalationLevel': 'recommended',
        'strategyMode': 'human_handoff',
        'safetyState': 'monitor',
      },
    );
  }

  Stream<ChatThreadModel?> streamThread(String threadId) {
    return _firestoreService.streamThread(threadId);
  }

  Stream<List<ChatMessageModel>> streamMessages(String threadId) {
    return _firestoreService.streamMessages(threadId);
  }
}
