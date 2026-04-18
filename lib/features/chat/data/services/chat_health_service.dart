import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHealthService {
  const ChatHealthService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  FirebaseFirestore get _db => _firestore ?? FirebaseFirestore.instance;

  Future<void> emitHealthSnapshot({
    required String sampleType,
  }) async {
    final degradedFeatures = <String>[];

    int? openEscalationsCount;
    int? openAdminSupportCount;

    try {
      final escalationSnapshot =
          await _db.collection('chat_escalations').limit(200).get();
      openEscalationsCount = escalationSnapshot.docs.where((doc) {
        final data = doc.data();
        return (data['status'] ?? '').toString() != 'resolved';
      }).length;
    } catch (_) {
      degradedFeatures.add('chat_escalations_unreadable');
    }

    try {
      final threadSnapshot = await _db.collection('chat_threads').limit(400).get();
      openAdminSupportCount = threadSnapshot.docs.where((doc) {
        final data = doc.data();
        final needsHumanSupport = (data['needsHumanSupport'] ?? false) == true;
        final handoffState = (data['handoffState'] ?? '').toString();
        return needsHumanSupport ||
            handoffState == 'admin_review' ||
            handoffState == 'admin_replying';
      }).length;
    } catch (_) {
      degradedFeatures.add('chat_threads_unreadable');
    }

    final status = degradedFeatures.isEmpty ? 'active' : 'degraded';
    final note = degradedFeatures.isEmpty
        ? 'Chat control-plane snapshot captured successfully.'
        : 'Chat control-plane snapshot captured with degraded signals: ${degradedFeatures.join(', ')}';

    await _db.collection('system_domains').doc('chat').set({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
      'updatedBy': 'chat_health',
      'note': note,
      'degradedFeatures': degradedFeatures,
      'openEscalationsCount': openEscalationsCount,
      'openAdminSupportCount': openAdminSupportCount,
      'lastHealthSampleType': sampleType,
    }, SetOptions(merge: true));
  }
}
