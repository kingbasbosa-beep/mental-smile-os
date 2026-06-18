import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_smile_os/features/signals/signals.dart';

import '../domain/models/center_contact_request_record.dart';
import '../domain/models/provider_contact_request_record.dart';

class ContactRequestRepository {
  ContactRequestRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<String> createProviderContactRequest({
    required String requesterSessionId,
    required String providerId,
    required String message,
    List<String> goalSignals = const <String>[],
    List<String> interestSignals = const <String>[],
    List<String> accessibilitySignals = const <String>[],
  }) async {
    final ref = _firestore
        .collection(ProviderContactRequestRecord.collectionName)
        .doc();
    await ref.set(<String, dynamic>{
      'requestId': ref.id,
      'requesterSessionId': requesterSessionId,
      'requesterRole': 'session',
      'providerId': providerId,
      'message': message,
      'goalSignals': goalSignals,
      'interestSignals': interestSignals,
      'accessibilitySignals': accessibilitySignals,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await CleanSignalRuntime.firestore().emit(
      SignalPackageFactory.providerContactStarted(
        actorId: requesterSessionId,
        actorRole: 'session',
        targetId: providerId,
      ),
    );
    return ref.id;
  }

  Future<String> createCenterContactRequest({
    required String requesterSessionId,
    required String centerId,
    required String message,
    List<String> goalSignals = const <String>[],
    List<String> interestSignals = const <String>[],
    List<String> accessibilitySignals = const <String>[],
  }) async {
    final ref =
        _firestore.collection(CenterContactRequestRecord.collectionName).doc();
    await ref.set(<String, dynamic>{
      'requestId': ref.id,
      'requesterSessionId': requesterSessionId,
      'requesterRole': 'session',
      'centerId': centerId,
      'message': message,
      'goalSignals': goalSignals,
      'interestSignals': interestSignals,
      'accessibilitySignals': accessibilitySignals,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await CleanSignalRuntime.firestore().emit(
      SignalPackageFactory.centerContactStarted(
        actorId: requesterSessionId,
        actorRole: 'session',
        targetId: centerId,
      ),
    );
    return ref.id;
  }
}
