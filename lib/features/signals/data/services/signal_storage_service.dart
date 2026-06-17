import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/signal_package.dart';

class SignalStorageService {
  SignalStorageService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String eventsCollection = 'signal_events';

  Future<void> saveSignal(SignalPackage signal) async {
    try {
      final eventRef = _firestore.collection(eventsCollection).doc(signal.signalId);
      await eventRef.set({
        ...signal.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Signal persistence failed: $e');
      // Signal observation must never block the initiating user flow.
    }
  }

  Stream<List<SignalPackage>> watchLatestEvents({
    required String actorId,
    int limit = 50,
  }) {
    return _firestore
        .collection(eventsCollection)
        .where('actorId', isEqualTo: actorId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SignalPackage.fromMap(doc.data()))
            .toList());
  }
}
