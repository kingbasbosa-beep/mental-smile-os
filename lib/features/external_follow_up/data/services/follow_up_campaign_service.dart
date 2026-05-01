import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_campaign.dart';

class FollowUpCampaignService {
  FollowUpCampaignService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String collectionName = 'external_follow_up_campaigns';
  static const String draftStatus = 'draft';

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(collectionName);

  Future<FollowUpCampaign> createDraftCampaign(
    FollowUpCampaign campaign,
  ) async {
    final doc = campaign.id.trim().isEmpty
        ? _collection.doc()
        : _collection.doc(campaign.id);
    final now = DateTime.now();
    final normalized = campaign.copyWith(
      id: doc.id,
      status: draftStatus,
      createdAt: campaign.createdAt ?? now,
    );

    await doc.set(normalized.toMap());
    return normalized;
  }

  Stream<List<FollowUpCampaign>> streamCampaigns() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_campaignFromDoc).toList());
  }

  Stream<List<FollowUpCampaign>> streamCampaignsByStatus(String status) {
    return _collection
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_campaignFromDoc).toList());
  }

  Future<void> updateCampaignStatus({
    required String campaignId,
    required String status,
  }) async {
    await _collection.doc(campaignId).update(<String, dynamic>{
      'status': status,
    });
  }

  FollowUpCampaign _campaignFromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    return FollowUpCampaign.fromMap(<String, dynamic>{
      ...data,
      'id': doc.id,
    });
  }
}
