import 'package:cloud_firestore/cloud_firestore.dart';

class AiPolicyHealthService {
  const AiPolicyHealthService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  FirebaseFirestore get _db => _firestore ?? FirebaseFirestore.instance;

  Future<void> emitHealthSnapshot() async {
    final policies = _db.collection('ai_policies');
    final draftSnapshot = await policies.doc('draft').get();
    final publishedSnapshot = await policies.doc('published').get();

    final draftData = draftSnapshot.data();
    final publishedData = publishedSnapshot.data();

    final draftExists = draftSnapshot.exists && draftData != null;
    final publishedExists = publishedSnapshot.exists && publishedData != null;

    final degradedFeatures = <String>[
      if (!draftExists) 'missing_draft_policy',
      if (!publishedExists) 'missing_published_policy',
    ];

    final status = degradedFeatures.isEmpty ? 'active' : 'degraded';
    final note = degradedFeatures.isEmpty
        ? 'AI policy documents are available for draft and published inspection.'
        : 'AI policy is available with missing control-plane documents: ${degradedFeatures.join(', ')}';

    await _db.collection('system_domains').doc('aiPolicy').set({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
      'updatedBy': 'ai_policy_health',
      'note': note,
      'degradedFeatures': degradedFeatures,
      'draftExists': draftExists,
      'publishedExists': publishedExists,
      'draftVersion': _stringOrNull(draftData?['policyVersion']),
      'publishedVersion': _stringOrNull(publishedData?['policyVersion']),
    }, SetOptions(merge: true));
  }

  String? _stringOrNull(dynamic value) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? null : text;
  }
}
