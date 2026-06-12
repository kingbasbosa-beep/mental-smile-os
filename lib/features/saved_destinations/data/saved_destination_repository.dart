import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/features/signals/signals.dart';

import '../domain/models/saved_destination.dart';

class SavedDestinationRepository {
  SavedDestinationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<String> saveDestination({
    required String clientId,
    required SavedDestinationType destinationType,
    required String destinationId,
    required String title,
    required String route,
    List<String> signalTags = const <String>[],
  }) async {
    final ref = _firestore.collection(SavedDestination.collectionName).doc();
    await ref.set(<String, dynamic>{
      'savedId': ref.id,
      'clientId': clientId,
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
        actorId: clientId,
        actorRole: 'client',
        targetType: destinationType.name,
        targetId: destinationId,
      ),
    );
    return ref.id;
  }

  Stream<List<SavedDestination>> watchClientDestinations(String clientId) {
    return _firestore
        .collection(SavedDestination.collectionName)
        .where('clientId', isEqualTo: clientId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SavedDestination.fromMap(doc.data()))
              .toList(growable: false),
        );
  }
}
