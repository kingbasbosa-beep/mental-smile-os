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
        .snapshots()
        .map((snapshot) {
      final centers =
          snapshot.docs.map((doc) => CenterModel.fromFirestore(doc)).toList();
      centers.sort((a, b) {
        final byOrder = a.sortOrder.compareTo(b.sortOrder);
        if (byOrder != 0) return byOrder;
        return a.name.compareTo(b.name);
      });
      return centers;
    });
  }

  Stream<CenterModel?> streamCenterById(String centerId) {
    final id = centerId.trim();
    if (id.isEmpty) return Stream<CenterModel?>.value(null);

    return _centers.doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;
      return CenterModel.fromFirestore(doc);
    });
  }
}
