import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';

class CentersFirestoreService {
  CentersFirestoreService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _centers =>
      _firestore.collection('centers');

  Stream<List<CenterModel>> streamActiveCentersByCategory(String category) {
    return _centers
        .where('isActive', isEqualTo: true)
        .where('category', isEqualTo: category)
        .orderBy('sortOrder')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CenterModel.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<CenterModel?> streamCenterById(String centerId) {
    final id = centerId.trim();
    if (id.isEmpty) return Stream<CenterModel?>.value(null);

    return _centers.doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;
      return CenterModel.fromFirestore(doc);
    });
  }

  // ===== Admin methods (do not affect existing public reads) =====

  Stream<List<CenterModel>> streamAllCentersForAdmin() {
    return _centers.orderBy('sortOrder').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => CenterModel.fromFirestore(doc))
              .toList(),
        );
  }

  Future<List<CenterModel>> getAllCentersForAdmin() async {
    final snap = await _centers.orderBy('sortOrder').get();
    return snap.docs.map((doc) => CenterModel.fromFirestore(doc)).toList();
  }

  Future<String> createCenter(CenterModel center) async {
    final ref = center.id.trim().isEmpty
        ? _centers.doc()
        : _centers.doc(center.id.trim());

    final toCreate = center.copyWith(
      id: ref.id,
      createdAt: null,
      updatedAt: null,
    );

    await ref.set(toCreate.toFirestore());
    return ref.id;
  }

  Future<void> updateCenter(CenterModel center) async {
    final id = center.id.trim();
    if (id.isEmpty) {
      throw ArgumentError('center.id is required for updateCenter');
    }

    final data = Map<String, dynamic>.from(center.toFirestore());
    data.remove('createdAt');
    data['updatedAt'] = FieldValue.serverTimestamp();

    await _centers.doc(id).update(data);
  }

  Future<void> toggleCenterActive({
    required String centerId,
    required bool isActive,
  }) async {
    final id = centerId.trim();
    if (id.isEmpty) return;

    await _centers.doc(id).update({
      'isActive': isActive,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
