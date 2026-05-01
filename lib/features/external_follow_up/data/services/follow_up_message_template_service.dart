import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_message_template.dart';

class FollowUpMessageTemplateService {
  FollowUpMessageTemplateService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String collectionName = 'external_follow_up_message_templates';

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(collectionName);

  Stream<List<FollowUpMessageTemplate>> streamActiveTemplates() {
    return _collection
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_templateFromDoc).toList());
  }

  Stream<List<FollowUpMessageTemplate>> streamTemplatesByCategory(
    String category,
  ) {
    return _collection
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_templateFromDoc).toList());
  }

  Stream<List<FollowUpMessageTemplate>> streamTemplatesByCategoryAndTopic(
    String category,
    String topic,
  ) {
    return _collection
        .where('category', isEqualTo: category)
        .where('topic', isEqualTo: topic)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_templateFromDoc).toList());
  }

  Future<FollowUpMessageTemplate> createTemplate(
    FollowUpMessageTemplate template,
  ) async {
    final doc = template.id.trim().isEmpty
        ? _collection.doc()
        : _collection.doc(template.id);
    final now = DateTime.now();
    final normalized = template.copyWith(
      id: doc.id,
      createdAt: template.createdAt ?? now,
      updatedAt: template.updatedAt ?? now,
    );

    await doc.set(normalized.toMap());
    return normalized;
  }

  Future<void> updateTemplate(FollowUpMessageTemplate template) async {
    final id = template.id.trim();
    if (id.isEmpty) {
      throw ArgumentError('FollowUpMessageTemplate.id must not be empty.');
    }

    final normalized = template.copyWith(updatedAt: DateTime.now());
    await _collection.doc(id).update(normalized.toMap());
  }

  Future<void> archiveTemplate(String templateId) async {
    await _collection.doc(templateId).update(<String, dynamic>{
      'isActive': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  FollowUpMessageTemplate _templateFromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    return FollowUpMessageTemplate.fromMap(<String, dynamic>{
      ...data,
      'id': doc.id,
    });
  }
}
