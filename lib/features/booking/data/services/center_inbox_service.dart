import 'package:cloud_firestore/cloud_firestore.dart';

class CenterInboxRequest {
  final String id;
  final Map<String, dynamic> data;
  final String sourceCollection;

  const CenterInboxRequest({
    required this.id,
    required this.data,
    required this.sourceCollection,
  });
}

class CenterInboxService {
  const CenterInboxService();

  Stream<List<CenterInboxRequest>> watchRequestsForCenter(String centerId) {
    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('centerId', isEqualTo: centerId)
        .snapshots()
        .map((snap) {
      final docs = snap.docs.where((doc) {
        final data = doc.data();
        final requestKind = (data['requestKind'] ?? '').toString().trim();
        final status = (data['status'] ?? '').toString().trim();
        return requestKind == 'center' &&
            (status == 'center_follow_up' || status == 'pending_admin');
      }).toList()
        ..sort((a, b) => _moment(b.data()['createdAt'])
            .compareTo(_moment(a.data()['createdAt'])));

      return docs
          .map(
            (doc) => CenterInboxRequest(
              id: doc.id,
              data: doc.data(),
              sourceCollection: 'booking_requests',
            ),
          )
          .toList();
    });
  }

  Future<void> respondToAvailability({
    required String requestId,
    required String availabilityStatus,
    required String note,
  }) async {
    final db = FirebaseFirestore.instance;
    final payload = <String, dynamic>{
      'centerAvailabilityStatus': availabilityStatus,
      'centerAvailabilityNote': note,
      'centerAvailabilityRespondedAt': FieldValue.serverTimestamp(),
      'centerAvailabilityRespondedBy': availabilityStatus.isEmpty ? '' : '',
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final refs = [
      db.collection('booking_requests').doc(requestId),
      // TODO(EX-137): Legacy bookingRequests fallback is transitional only.
      // Canonical booking collection is booking_requests.
      // Do not expand this fallback; remove only after manual legacy data verification.
      db.collection('bookingRequests').doc(requestId),
    ];

    for (final ref in refs) {
      final snap = await ref.get();
      if (snap.exists) {
        await ref.update(payload);
      }
    }
  }

  static DateTime _moment(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime(1970);
    return DateTime(1970);
  }
}
