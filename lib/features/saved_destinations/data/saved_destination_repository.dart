import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_smile_os/features/signals/signals.dart';

import '../domain/models/saved_destination.dart';

class SavedDestinationRepository {
  SavedDestinationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<String> saveDestination({
    required String sessionId,
    required SavedDestinationType destinationType,
    required String destinationId,
    required String title,
    required String route,
    List<String> signalTags = const <String>[],
  }) async {
    final ref = _firestore.collection(SavedDestination.collectionName).doc();
    await ref.set(<String, dynamic>{
      'savedId': ref.id,
      'sessionId': sessionId,
      'destinationType': destinationType.name,
      'destinationId': destinationId,
      'title': title,
      'route': route,
      'signalTags': signalTags,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await CleanSignalRuntime.firestore().emit(
      SignalPackageFactory.destinationSaved(
        actorId: sessionId,
        actorRole: 'session',
        targetType: destinationType.name,
        targetId: destinationId,
      ),
    );
    return ref.id;
  }

  Stream<List<SavedDestination>> watchSessionDestinations(String sessionId) {
    return _firestore
        .collection(SavedDestination.collectionName)
        .where('sessionId', isEqualTo: sessionId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SavedDestination.fromMap(doc.data()))
              .toList(growable: false),
        );
  }
}
