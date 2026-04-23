import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';

Map<String, dynamic> _domainSeedPayload() {
  return <String, dynamic>{
    'status': 'active',
    'updatedAt': FieldValue.serverTimestamp(),
    'updatedBy': 'system_seed',
    'note': 'initial domain setup',
    'degradedFeatures': const <String>[],
  };
}

Future<void> seedDomainStatusesToFirestore({
  FirebaseFirestore? firestore,
}) async {
  final db = firestore ?? FirebaseFirestore.instance;
  final batch = db.batch();
  final domains = db.collection('system_domains');

  for (final domain in domainRegistry) {
    batch.set(
      domains.doc(domain.id),
      _domainSeedPayload(),
      SetOptions(merge: true),
    );
  }

  await batch.commit();
}

/// Temporary manual trigger for debug use only.
Future<void> seedDomainStatusesToFirestoreDebug() async {
  await seedDomainStatusesToFirestore();
}
