import 'package:cloud_firestore/cloud_firestore.dart';

class BookingHealthService {
  const BookingHealthService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  FirebaseFirestore get _db => _firestore ?? FirebaseFirestore.instance;

  Future<void> emitHealthSnapshot({
    required String sampleType,
  }) async {
    final degradedFeatures = <String>[];

    int? pendingRequestsCount;
    int? awaitingPaymentCount;
    int? paymentReviewCount;
    int? sessionSetupPendingCount;
    int? pendingReviewsCount;
    int? payoutPendingCount;

    try {
      final collection = _db.collection('booking_requests');

      pendingRequestsCount =
          await _countByStatus(collection, 'pending_admin');
      awaitingPaymentCount =
          await _countByStatus(collection, 'awaiting_payment');
      paymentReviewCount =
          await _countByStatus(collection, 'payment_review');
      sessionSetupPendingCount =
          await _countByStatus(collection, 'session_setup_pending');
      pendingReviewsCount = await _countByStatus(
        collection,
        'session_completed_pending_reviews',
      );
      payoutPendingCount =
          await _countByStatus(collection, 'payout_pending');
    } catch (_) {
      degradedFeatures.add('booking_requests_unreadable');
    }

    final status = degradedFeatures.isEmpty ? 'active' : 'degraded';
    final note = degradedFeatures.isEmpty
        ? 'Booking control-plane snapshot captured successfully.'
        : 'Booking control-plane snapshot captured with degraded signals: ${degradedFeatures.join(', ')}';

    await _db.collection('system_domains').doc('booking').set({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
      'updatedBy': 'booking_health',
      'note': note,
      'degradedFeatures': degradedFeatures,
      'pendingRequestsCount': pendingRequestsCount,
      'awaitingPaymentCount': awaitingPaymentCount,
      'paymentReviewCount': paymentReviewCount,
      'sessionSetupPendingCount': sessionSetupPendingCount,
      'pendingReviewsCount': pendingReviewsCount,
      'payoutPendingCount': payoutPendingCount,
      'lastHealthSampleType': sampleType,
    }, SetOptions(merge: true));
  }

  Future<int> _countByStatus(
    CollectionReference<Map<String, dynamic>> collection,
    String status,
  ) async {
    final snapshot = await collection.where('status', isEqualTo: status).count().get();
    return snapshot.count ?? 0;
  }
}
