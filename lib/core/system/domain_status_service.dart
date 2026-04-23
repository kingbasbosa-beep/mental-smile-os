import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';

class DomainStatusService {
  const DomainStatusService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  FirebaseFirestore get _db => _firestore ?? FirebaseFirestore.instance;

  Stream<DomainStatus> watchDomainStatus(DomainKey domain) {
    return _db
        .collection('system_domains')
        .doc(domain.definition.id)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) {
        return DomainStatus.unknown();
      }
      return DomainStatus.fromMap(data);
    });
  }

  Future<DomainStatus?> getDomainStatus(DomainKey domain) async {
    final snapshot =
        await _db.collection('system_domains').doc(domain.definition.id).get();
    final data = snapshot.data();
    if (!snapshot.exists || data == null) return null;
    return DomainStatus.fromMap(data);
  }
}
