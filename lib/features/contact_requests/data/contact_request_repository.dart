import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/features/signals/signals.dart';

import '../domain/models/center_contact_request_record.dart';
import '../domain/models/provider_contact_request_record.dart';

class ContactRequestRepository {
  ContactRequestRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<String> createProviderContactRequest({
    required String clientId,
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
      'clientId': clientId,
      'providerId': providerId,
      'message': message,
      'goalSignals': goalSignals,
      'interestSignals': interestSignals,
      'accessibilitySignals': accessibilitySignals,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await const CleanSignalRuntime().emit(
      SignalPackageFactory.providerContactStarted(
        actorRole: 'client',
        targetId: providerId,
      ),
    );
    return ref.id;
  }

  Future<String> createCenterContactRequest({
    required String clientId,
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
      'clientId': clientId,
      'centerId': centerId,
      'message': message,
      'goalSignals': goalSignals,
      'interestSignals': interestSignals,
      'accessibilitySignals': accessibilitySignals,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    await const CleanSignalRuntime().emit(
      SignalPackageFactory.centerContactStarted(
        actorRole: 'client',
        targetId: centerId,
      ),
    );
    return ref.id;
  }
}
