import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_registry_entry.dart';
import 'package:flutterprojects/features/external_follow_up/domain/follow_up_registry_constants.dart';

class FollowUpRegistryService {
  FollowUpRegistryService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String collectionName = 'external_follow_up_registry';

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(collectionName);

  Future<FollowUpRegistryEntry> createEntry(
    FollowUpRegistryEntry entry,
  ) async {
    final doc = entry.id.trim().isEmpty
        ? _collection.doc()
        : _collection.doc(entry.id);
    final now = DateTime.now();
    final normalized = entry.copyWith(
      id: doc.id,
      createdAt: entry.createdAt ?? now,
      updatedAt: entry.updatedAt ?? now,
    );

    await doc.set(normalized.toMap());
    return normalized;
  }

  Future<void> updateEntry(FollowUpRegistryEntry entry) async {
    final id = entry.id.trim();
    if (id.isEmpty) {
      throw ArgumentError('FollowUpRegistryEntry.id must not be empty.');
    }

    final normalized = entry.copyWith(updatedAt: DateTime.now());
    await _collection.doc(id).update(normalized.toMap());
  }

  Stream<List<FollowUpRegistryEntry>> streamEntries() {
    return _collection.orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.docs.map(_entryFromDoc).toList();
      },
    );
  }

  Stream<List<FollowUpRegistryEntry>> streamActiveEntriesByType(String followUpType) {
    return _collection
        .where('status', isEqualTo: FollowUpRegistryStatus.active)
        .where('followUpTypes', arrayContains: followUpType)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map(_entryFromDoc).toList();
    });
  }

  Future<void> archiveEntry(String entryId) async {
    await _collection.doc(entryId).update(<String, dynamic>{
      'status': FollowUpRegistryStatus.archived,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  FollowUpRegistryEntry _entryFromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    return FollowUpRegistryEntry.fromMap(<String, dynamic>{
      ...data,
      'id': doc.id,
    });
  }
}
