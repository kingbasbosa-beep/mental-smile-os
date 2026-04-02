import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';

class AdminBookingQueuePage extends StatefulWidget {
  const AdminBookingQueuePage({super.key});

  @override
  State<AdminBookingQueuePage> createState() => _AdminBookingQueuePageState();
}

class _AdminBookingQueuePageState extends State<AdminBookingQueuePage> {
  String _tab = 'pending_admin';
  final Map<String, String> _selectedClinicianByRequest = {};
  final Set<String> _busyIds = {};

  static const List<Map<String, String>> _tabs = [
    {
      'key': 'pending_admin',
      'labelAr': 'بانتظار الإدارة',
      'labelEn': 'Pending admin'
    },
    {
      'key': 'center_follow_up',
      'labelAr': 'متابعة المراكز',
      'labelEn': 'Center follow-up'
    },
    {
      'key': 'client_update_required',
      'labelAr': 'بانتظار تعديل العميل',
      'labelEn': 'Client update required'
    },
    {
      'key': 'approved',
      'labelAr': 'طلبات مراكز معتمدة',
      'labelEn': 'Approved center requests'
    },
    {
      'key': 'assigned_clinician',
      'labelAr': 'بانتظار رد الأخصائي',
      'labelEn': 'Awaiting clinician'
    },
    {
      'key': 'awaiting_payment',
      'labelAr': 'بانتظار التحويل المالي',
      'labelEn': 'Awaiting payment'
    },
    {
      'key': 'payment_review',
      'labelAr': 'مراجعة السداد',
      'labelEn': 'Payment review'
    },
    {
      'key': 'session_setup_pending',
      'labelAr': 'تجهيز الجلسة',
      'labelEn': 'Session setup'
    },
    {
      'key': 'session_scheduled',
      'labelAr': 'جلسات مجدولة',
      'labelEn': 'Scheduled sessions'
    },
    {
      'key': 'session_completed_pending_reviews',
      'labelAr': 'بانتظار التقييمات',
      'labelEn': 'Pending reviews'
    },
    {
      'key': 'payout_pending',
      'labelAr': 'بانتظار تحويل المستحق',
      'labelEn': 'Payout pending'
    },
    {
      'key': 'completed_success',
      'labelAr': 'مكتملة بنجاح',
      'labelEn': 'Completed'
    },
    {
      'key': 'rejected_admin',
      'labelAr': 'مرفوضة إداريًا',
      'labelEn': 'Admin rejected'
    },
    {
      'key': 'clinician_rejected',
      'labelAr': 'مرفوضة من الأخصائي',
      'labelEn': 'Clinician rejected'
    },
    {
      'key': 'reschedule_pending',
      'labelAr': 'إعادة جدولة',
      'labelEn': 'Reschedule'
    },
    {
      'key': 'cancellation_pending',
      'labelAr': 'إلغاء',
      'labelEn': 'Cancellation'
    },
    {'key': 'dispute_pending', 'labelAr': 'نزاع', 'labelEn': 'Dispute'},
  ];

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  void _logFirestore({
    required String page,
    required String role,
    required String operation,
    required String collection,
    String? documentId,
    String? requestKind,
    String? status,
    String? writeStatus,
    Object? error,
  }) {
    final user = FirebaseAuth.instance.currentUser;
    debugPrint(
      'CENTER_FLOW page=$page role=$role uid=${user?.uid ?? 'null'} '
      'op=$operation collection=$collection doc=${documentId ?? '-'} '
      'requestKind=${requestKind ?? '-'} status=${status ?? '-'} '
      'writeStatus=${writeStatus ?? '-'} error=${error ?? '-'}',
    );
  }

  DateTime _docMoment(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    String key,
  ) {
    final value = doc.data()[key];
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  String _logicalRequestKey(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final requestKind = (data['requestKind'] ?? 'clinician').toString().trim();
    if (requestKind != 'center') return doc.id;

    final requestGroupId = (data['requestGroupId'] ?? '').toString().trim();
    if (requestGroupId.isNotEmpty) {
      return 'center-group|$requestGroupId';
    }

    final clientId = (data['clientId'] ?? '').toString().trim();
    final centerId = (data['centerId'] ?? '').toString().trim();
    final createdAt = _docMoment(doc, 'createdAt').millisecondsSinceEpoch;
    return 'center|$clientId|$centerId|$createdAt';
  }

  QueryDocumentSnapshot<Map<String, dynamic>> _preferredDuplicate(
    QueryDocumentSnapshot<Map<String, dynamic>> current,
    QueryDocumentSnapshot<Map<String, dynamic>> incoming,
  ) {
    final currentUpdated = _docMoment(current, 'updatedAt');
    final incomingUpdated = _docMoment(incoming, 'updatedAt');
    if (incomingUpdated.isAfter(currentUpdated)) return incoming;
    if (currentUpdated.isAfter(incomingUpdated)) return current;

    final currentCreated = _docMoment(current, 'createdAt');
    final incomingCreated = _docMoment(incoming, 'createdAt');
    if (incomingCreated.isAfter(currentCreated)) return incoming;
    return current;
  }

  Future<void> _updateRequestEverywhere(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final nowUpdates = {
      ...updates,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final db = FirebaseFirestore.instance;

    final refs = [
      db.collection('booking_requests').doc(requestId),
      db.collection('bookingRequests').doc(requestId),
    ];

    for (final ref in refs) {
      try {
        _logFirestore(
          page: 'admin_booking_queue',
          role: 'admin',
          operation: 'read',
          collection: ref.parent.id,
          documentId: requestId,
          writeStatus: (updates['status'] ?? '').toString(),
        );
        final snap = await ref.get();
        if (snap.exists) {
          final data = snap.data() ?? <String, dynamic>{};
          _logFirestore(
            page: 'admin_booking_queue',
            role: 'admin',
            operation: 'update',
            collection: ref.parent.id,
            documentId: requestId,
            requestKind: (data['requestKind'] ?? '').toString(),
            status: (data['status'] ?? '').toString(),
            writeStatus: (updates['status'] ?? '').toString(),
          );
          await ref.update(nowUpdates);
        }
      } catch (e) {
        _logFirestore(
          page: 'admin_booking_queue',
          role: 'admin',
          operation: 'update_error',
          collection: ref.parent.id,
          documentId: requestId,
          writeStatus: (updates['status'] ?? '').toString(),
          error: e,
        );
        rethrow;
      }
    }
  }

  Future<void> _appendSystemMessage({
    required String requestId,
    required String text,
  }) async {
    final db = FirebaseFirestore.instance;
    Map<String, dynamic>? requestData;

    final requestRefs = [
      db.collection('booking_requests').doc(requestId),
      db.collection('bookingRequests').doc(requestId),
    ];

    for (final ref in requestRefs) {
      try {
        _logFirestore(
          page: 'admin_booking_queue',
          role: 'admin',
          operation: 'read',
          collection: ref.parent.id,
          documentId: requestId,
        );
        final snap = await ref.get();
        if (snap.exists) {
          requestData = snap.data();
          break;
        }
      } catch (e) {
        _logFirestore(
          page: 'admin_booking_queue',
          role: 'admin',
          operation: 'read_error',
          collection: ref.parent.id,
          documentId: requestId,
          error: e,
        );
        rethrow;
      }
    }

    if (requestData == null) return;
    final threadId = (requestData['threadId'] ?? '').toString();
    if (threadId.trim().isEmpty) return;

    DocumentReference<Map<String, dynamic>>? threadRef;

    final chatThreadsRef = db.collection('chat_threads').doc(threadId);
    _logFirestore(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: 'read',
      collection: 'chat_threads',
      documentId: threadId,
    );
    final chatThreadsSnap = await chatThreadsRef.get();
    if (chatThreadsSnap.exists) {
      threadRef = chatThreadsRef;
    } else {
      final legacyThreadRef = db.collection('chatThreads').doc(threadId);
      _logFirestore(
        page: 'admin_booking_queue',
        role: 'admin',
        operation: 'read',
        collection: 'chatThreads',
        documentId: threadId,
      );
      final legacyThreadSnap = await legacyThreadRef.get();
      if (legacyThreadSnap.exists) {
        threadRef = legacyThreadRef;
      }
    }

    if (threadRef == null) return;

    _logFirestore(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: 'read',
      collection: '${threadRef.parent.id}/messages',
      documentId: threadId,
    );
    final latestMessage = await threadRef
        .collection('messages')
        .orderBy('sequenceNumber', descending: true)
        .limit(1)
        .get();

    int nextSequence = 1;
    if (latestMessage.docs.isNotEmpty) {
      final current = latestMessage.docs.first.data()['sequenceNumber'];
      if (current is int) {
        nextSequence = current + 1;
      } else {
        nextSequence = (int.tryParse('$current') ?? 0) + 1;
      }
    }

    _logFirestore(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: 'create',
      collection: '${threadRef.parent.id}/messages',
      documentId: threadId,
    );
    await threadRef.collection('messages').add({
      'threadId': threadId,
      'senderType': 'admin',
      'senderUid': FirebaseAuth.instance.currentUser?.uid ?? '',
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
      'sequenceNumber': nextSequence,
      'visibleToUser': true,
      'messageKind': 'admin_update',
      'roleDetected': null,
      'statesDetected': const [],
      'riskScore': 0,
      'riskLevel': 'low',
      'strategyMode': 'containment',
      'safetyTriggered': false,
      'containsEscalationSignal': false,
      'aiModelVersion': null,
      'systemVersion': 'admin_queue_v1',
      'metadata': {
        'requestId': requestId,
        'source': 'admin_booking_queue',
      },
    });

    _logFirestore(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: 'update',
      collection: threadRef.parent.id,
      documentId: threadId,
    );
    await threadRef.update({
      'lastMessagePreview': text.length > 120 ? text.substring(0, 120) : text,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'messageCount': FieldValue.increment(1),
      'lastSenderType': 'admin',
      'handoffState': 'admin_replying',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _bookingDocsStream() {
    _logFirestore(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: 'stream_start',
      collection: 'booking_requests',
    );
    final primary = FirebaseFirestore.instance
        .collection('booking_requests')
        .orderBy('createdAt', descending: true)
        .snapshots();
    _logFirestore(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: 'stream_start',
      collection: 'bookingRequests',
    );
    final legacy = FirebaseFirestore.instance
        .collection('bookingRequests')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>.multi(
      (controller) {
        QuerySnapshot<Map<String, dynamic>>? primarySnapshot;
        QuerySnapshot<Map<String, dynamic>>? legacySnapshot;

        void emitMerged() {
          final mergedByDocId =
              <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

          if (legacySnapshot != null) {
            for (final doc in legacySnapshot!.docs) {
              mergedByDocId[doc.id] = doc;
            }
          }

          if (primarySnapshot != null) {
            for (final doc in primarySnapshot!.docs) {
              mergedByDocId[doc.id] = doc;
            }
          }

          final dedupedByLogicalRequest =
              <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};
          for (final doc in mergedByDocId.values) {
            final key = _logicalRequestKey(doc);
            final existing = dedupedByLogicalRequest[key];
            if (existing == null) {
              dedupedByLogicalRequest[key] = doc;
            } else {
              dedupedByLogicalRequest[key] = _preferredDuplicate(existing, doc);
            }
          }

          final docs = dedupedByLogicalRequest.values.toList()
            ..sort((a, b) {
              final aDate = _docMoment(a, 'createdAt');
              final bDate = _docMoment(b, 'createdAt');

              return bDate.compareTo(aDate);
            });

          controller.add(docs);
        }

        final primarySub = primary.listen(
          (snapshot) {
            _logFirestore(
              page: 'admin_booking_queue',
              role: 'admin',
              operation: 'stream_data',
              collection: 'booking_requests',
            );
            primarySnapshot = snapshot;
            emitMerged();
          },
          onError: (error) {
            _logFirestore(
              page: 'admin_booking_queue',
              role: 'admin',
              operation: 'stream_error',
              collection: 'booking_requests',
              error: error,
            );
            controller.addError(error);
          },
        );

        final legacySub = legacy.listen(
          (snapshot) {
            _logFirestore(
              page: 'admin_booking_queue',
              role: 'admin',
              operation: 'stream_data',
              collection: 'bookingRequests',
            );
            legacySnapshot = snapshot;
            emitMerged();
          },
          onError: (error) {
            _logFirestore(
              page: 'admin_booking_queue',
              role: 'admin',
              operation: 'stream_error',
              collection: 'bookingRequests',
              error: error,
            );
            controller.addError(error);
          },
        );

        controller.onCancel = () async {
          await primarySub.cancel();
          await legacySub.cancel();
        };
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _cliniciansStream() {
    _logFirestore(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: 'stream_start',
      collection: 'clinicians',
    );
    return FirebaseFirestore.instance
        .collection('clinicians')
        .where('isActive', isEqualTo: true)
        .where('role', isEqualTo: 'clinician')
        .snapshots();
  }

  Future<void> _setBusy(String id, bool value) async {
    if (!mounted) return;
    setState(() {
      if (value) {
        _busyIds.add(id);
      } else {
        _busyIds.remove(id);
      }
    });
  }

  Future<void> _rejectRequest(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'rejected_admin',
        'workflowStage': 'rejected_admin',
        'adminApproved': false,
        'adminRejected': true,
        'adminForwarded': false,
        'adminDecisionType': 'rejected',
        'adminDecisionBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminDecisionAt': FieldValue.serverTimestamp(),
        'adminAssignedBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminAssignedAt': FieldValue.serverTimestamp(),
        'paymentStatus': 'blocked',
        'sessionStatus': 'cancelled',
        'reviewStatus': 'blocked',
        'payoutStatus': 'blocked',
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? 'تم رفض الطلب من الإدارة.'
            : 'The request was rejected by admin.',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic ? 'تم رفض الطلب' : 'Request rejected',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _returnToPending(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'pending_admin',
        'workflowStage': 'pending_admin',
        'adminApproved': false,
        'adminRejected': false,
        'adminForwarded': false,
        'adminAssignedBy': '',
        'adminAssignedAt': null,
        'adminDecisionType': 'returned_to_pending',
        'adminDecisionBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminDecisionAt': FieldValue.serverTimestamp(),
        'assignedClinicianId': '',
        'assignedClinicianName': '',
        'clinicianId': '',
        'clinicianName': '',
        'clinicianUid': '',
        'paymentStatus': 'not_started',
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
        'payoutStatus': 'blocked',
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? 'تمت إعادة الطلب إلى انتظار الإدارة.'
            : 'The request was returned to pending admin.',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم إرجاع الطلب إلى انتظار الإدارة'
                : 'Request returned to pending admin',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _moveCenterToFollowUp(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      _logFirestore(
        page: 'admin_booking_queue',
        role: 'admin',
        operation: 'action_start',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: 'center',
        status: 'pending_admin',
        writeStatus: 'center_follow_up',
      );
      await _updateRequestEverywhere(requestId, {
        'status': 'center_follow_up',
        'centerAdminHandledBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'centerAdminHandledAt': FieldValue.serverTimestamp(),
      });

      try {
        await _appendSystemMessage(
          requestId: requestId,
          text: isArabic
              ? 'تم تحويل طلب المركز إلى مرحلة المتابعة والتحقق.'
              : 'The center request was moved to follow-up and verification.',
        );
      } catch (e) {
        _logFirestore(
          page: 'admin_booking_queue',
          role: 'admin',
          operation: 'system_message_error',
          collection: 'chat_threads',
          documentId: requestId,
          requestKind: 'center',
          status: 'center_follow_up',
          error: e,
        );
      }

      if (!mounted) return;
      setState(() => _tab = 'center_follow_up');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم نقل طلب المركز إلى المتابعة'
                : 'Center request moved to follow-up',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _approveCenterRequest(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'awaiting_payment',
        'workflowStage': 'awaiting_payment',
        'adminApproved': true,
        'adminRejected': false,
        'adminForwarded': false,
        'adminDecisionType': 'approved',
        'adminDecisionBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminDecisionAt': FieldValue.serverTimestamp(),
        'adminAssignedBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminAssignedAt': FieldValue.serverTimestamp(),
        'paymentStatus': 'pending_client_transfer',
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
        'payoutStatus': 'blocked',
        'assignedClinicianId': '',
        'assignedClinicianName': '',
        'clinicianId': '',
        'clinicianName': '',
        'clinicianUid': '',
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? 'تم اعتماد طلب المركز بعد المتابعة والتحقق.'
            : 'The center request was approved after follow-up and verification.',
      );

      if (!mounted) return;
      setState(() => _tab = 'awaiting_payment');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم اعتماد طلب المركز وتحويله إلى انتظار الدفع'
                : 'Center request approved and moved to awaiting payment',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _returnCenterRequestToClient(
    String requestId,
    Map<String, dynamic> data,
  ) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      final revision = data['clientRevisionNumber'];
      final revisionNumber =
          revision is num ? revision.toInt() : int.tryParse('$revision') ?? 0;
      await _updateRequestEverywhere(requestId, {
        'status': 'client_update_required',
        'workflowStage': 'client_update_required',
        'lastCenterAvailabilityStatus':
            (data['centerAvailabilityStatus'] ?? '').toString(),
        'lastCenterAvailabilityNote':
            (data['centerAvailabilityNote'] ?? '').toString(),
        'lastCenterSuggestedAlternativeKey':
            (data['centerSuggestedAlternativeKey'] ?? '').toString(),
        'lastCenterSuggestedAlternativeLabelAr':
            (data['centerSuggestedAlternativeLabelAr'] ?? '').toString(),
        'lastCenterFeedbackRevisionNumber': revisionNumber,
        'adminCanApproveWithoutCenterRecheck': false,
      });

      if (!mounted) return;
      setState(() => _tab = 'client_update_required');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تمت إعادة الطلب للعميل لتعديل نوع الإقامة'
                : 'The request was returned to client for accommodation update',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _confirmCenterAccountingReview(
    String requestId,
    Map<String, dynamic> data,
  ) async {
    final isArabic = _isArabic(context);
    final grossSeed = data['grossClientPaidAmount'] ??
        data['selectedAccommodationPrice'] ??
        0;
    final grossValue = grossSeed is num
        ? grossSeed.toDouble()
        : double.tryParse('$grossSeed') ?? 0;
    final commissionSeed = data['appCommissionPercent'] ?? 10;
    final commissionValue = commissionSeed is num
        ? commissionSeed.toDouble()
        : double.tryParse('$commissionSeed') ?? 10;
    final grossController = TextEditingController(
      text: grossValue.toStringAsFixed(0),
    );
    final commissionPercentController = TextEditingController(
      text: commissionValue.toStringAsFixed(0),
    );
    final noteController = TextEditingController(
      text: (data['accountingReviewNotes'] ?? '').toString(),
    );

    final shouldSubmit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: AlertDialog(
            title: Text(
              isArabic ? 'مراجعة محاسبية قبل التحويل' : 'Accounting review',
            ),
            content: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: grossController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: isArabic
                          ? 'إجمالي المبلغ المدفوع من العميل'
                          : 'Gross client-paid amount',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: commissionPercentController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: isArabic
                          ? 'نسبة عمولة التطبيق'
                          : 'App commission percent',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText:
                          isArabic ? 'ملاحظات محاسبية' : 'Accounting notes',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(isArabic ? 'إلغاء' : 'Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(isArabic ? 'اعتماد' : 'Confirm'),
              ),
            ],
          ),
        );
      },
    );
    if (shouldSubmit != true) return;

    await _setBusy(requestId, true);
    try {
      final gross = double.tryParse(grossController.text.trim()) ?? 0;
      final commissionPercent =
          double.tryParse(commissionPercentController.text.trim()) ?? 10;
      final commissionAmount = gross * (commissionPercent / 100);
      final netAmount = gross - commissionAmount;

      await _updateRequestEverywhere(requestId, {
        'accountingReviewStatus': 'confirmed',
        'grossClientPaidAmount': gross,
        'appCommissionPercent': commissionPercent,
        'appCommissionAmount': commissionAmount,
        'netAmountDueToCenter': netAmount,
        'accountingReviewNotes': noteController.text.trim(),
        'accountingConfirmedBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'accountingConfirmedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم اعتماد المراجعة المحاسبية لطلب المركز'
                : 'Center accounting review confirmed',
          ),
        ),
      );
    } finally {
      grossController.dispose();
      commissionPercentController.dispose();
      noteController.dispose();
      await _setBusy(requestId, false);
    }
  }

  Future<void> _confirmCenterPayout(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'completed_success',
        'workflowStage': 'completed_success',
        'sessionStatus': 'completed',
        'reviewStatus': 'completed',
        'payoutStatus': 'paid_to_center',
        'payoutTransferredAt': FieldValue.serverTimestamp(),
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم تحويل مستحق المركز وإغلاق العملية'
                : 'Center payout confirmed and flow completed',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _approvePayment(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'session_setup_pending',
        'workflowStage': 'session_setup_pending',
        'paymentStatus': 'approved',
        'paymentApprovedAt': FieldValue.serverTimestamp(),
        'sessionStatus': 'not_created',
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? 'تم اعتماد السداد وتحويل الطلب إلى مرحلة تجهيز الجلسة.'
            : 'Payment approved and request moved to session setup.',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم اعتماد السداد وتحويل الطلب إلى تجهيز الجلسة'
                : 'Payment approved and moved to session setup',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _rejectPayment(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'awaiting_payment',
        'workflowStage': 'awaiting_payment',
        'paymentStatus': 'rejected',
        'paymentRejectedAt': FieldValue.serverTimestamp(),
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? 'تم رفض إثبات السداد وإرجاع الطلب إلى انتظار الدفع.'
            : 'Payment proof rejected and request returned to awaiting payment.',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم رفض إثبات السداد وإرجاع الطلب لانتظار الدفع'
                : 'Payment proof rejected and returned to awaiting payment',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _confirmClinicianPayout(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'completed_success',
        'workflowStage': 'completed_success',
        'sessionStatus': 'completed',
        'reviewStatus': 'completed',
        'payoutStatus': 'paid_to_clinician',
        'payoutTransferredAt': FieldValue.serverTimestamp(),
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? 'تم تسجيل تحويل مستحق الأخصائي وإغلاق العملية بنجاح.'
            : 'Clinician payout confirmed and flow completed successfully.',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم تحويل مستحق الأخصائي وإغلاق العملية'
                : 'Clinician payout confirmed and flow completed',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _sendToSessionArchive(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'archived': true,
        'archivedAt': FieldValue.serverTimestamp(),
        'archiveSection': 'sessions',
        'archiveReady': true,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم إرسال الطلب إلى أرشيف الجلسات'
                : 'Request sent to sessions archive',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _sendToFinancialArchive(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'archived': true,
        'archivedAt': FieldValue.serverTimestamp(),
        'archiveSection': 'payments',
        'archiveReady': true,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم إرسال الطلب إلى أرشيف المدفوعات'
                : 'Request sent to payments archive',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _assignToClinician({
    required String requestId,
    required String clinicianId,
    required String clinicianName,
  }) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'assigned_clinician',
        'workflowStage': 'assigned_clinician',
        'adminApproved': true,
        'adminRejected': false,
        'adminForwarded': true,
        'assignedClinicianId': clinicianId,
        'assignedClinicianName': clinicianName,
        'clinicianId': clinicianId,
        'clinicianName': clinicianName,
        'clinicianUid': clinicianId,
        'adminAssignedBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminAssignedAt': FieldValue.serverTimestamp(),
        'adminDecisionType': 'assigned',
        'adminDecisionBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminDecisionAt': FieldValue.serverTimestamp(),
        'paymentStatus': 'not_started',
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
        'payoutStatus': 'blocked',
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? 'تم تحويل الطلب إلى الأخصائي: $clinicianName'
            : 'The request was assigned to clinician: $clinicianName',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم تحويل الطلب إلى الأخصائي'
                : 'Request assigned to clinician',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'center_follow_up':
        return isArabic ? 'متابعة المراكز' : 'Center follow-up';
      case 'client_update_required':
        return isArabic ? 'بانتظار تعديل العميل' : 'Client update required';
      case 'approved':
        return isArabic ? 'طلب مركز معتمد' : 'Approved center request';
      case 'assigned_clinician':
        return isArabic ? 'بانتظار رد الأخصائي' : 'Awaiting clinician response';
      case 'awaiting_payment':
        return isArabic ? 'بانتظار التحويل المالي' : 'Awaiting payment';
      case 'payment_review':
        return isArabic ? 'مراجعة السداد' : 'Payment review';
      case 'session_setup_pending':
        return isArabic ? 'بانتظار تجهيز الجلسة' : 'Session setup pending';
      case 'session_scheduled':
        return isArabic ? 'جلسة مجدولة' : 'Session scheduled';
      case 'session_in_progress':
        return isArabic ? 'جلسة جارية' : 'Session in progress';
      case 'session_completed_pending_reviews':
        return isArabic ? 'بانتظار التقييمات' : 'Pending reviews';
      case 'payout_pending':
        return isArabic ? 'بانتظار تحويل المستحق' : 'Payout pending';
      case 'completed_success':
        return isArabic ? 'مكتملة بنجاح' : 'Completed successfully';
      case 'rejected_admin':
        return isArabic ? 'مرفوضة إداريًا' : 'Admin rejected';
      case 'clinician_rejected':
        return isArabic ? 'مرفوضة من الأخصائي' : 'Clinician rejected';
      case 'reschedule_pending':
        return isArabic ? 'إعادة جدولة' : 'Reschedule pending';
      case 'cancellation_pending':
        return isArabic ? 'إلغاء' : 'Cancellation pending';
      case 'dispute_pending':
        return isArabic ? 'نزاع' : 'Dispute pending';
      default:
        return isArabic ? 'بانتظار الإدارة' : 'Pending admin';
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'approved':
        return const Color(0xFF1F9D63);
      case 'assigned_clinician':
      case 'session_setup_pending':
      case 'session_scheduled':
      case 'session_in_progress':
      case 'payout_pending':
        return const Color(0xFF2E5AAC);
      case 'center_follow_up':
      case 'client_update_required':
      case 'awaiting_payment':
      case 'payment_review':
      case 'reschedule_pending':
        return const Color(0xFFE39B2E);
      case 'completed_success':
      case 'session_completed_pending_reviews':
        return const Color(0xFF1F9D63);
      case 'rejected_admin':
      case 'clinician_rejected':
      case 'cancellation_pending':
      case 'dispute_pending':
        return const Color(0xFFD84B4B);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  bool _matchTab(Map<String, dynamic> data) {
    final archived = (data['archived'] ?? false) == true;
    if (archived) return false;

    final status = (data['status'] ?? 'pending_admin').toString();
    return status == _tab;
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      final d = value.toDate();
      final day = d.day.toString().padLeft(2, '0');
      final month = d.month.toString().padLeft(2, '0');
      final year = d.year.toString();
      final hour = d.hour.toString().padLeft(2, '0');
      final minute = d.minute.toString().padLeft(2, '0');
      return '$hour:$minute $day-$month-$year';
    }
    return '';
  }

  String _safeText(Map<String, dynamic> data, String key) {
    return (data[key] ?? '').toString().trim();
  }

  Widget _buildDetailLine({
    required BuildContext context,
    required bool isArabic,
    required String arLabel,
    required String enLabel,
    required String value,
    bool valueOnly = false,
  }) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    final text = valueOnly
        ? value
        : isArabic
            ? '$arLabel: $value'
            : '$enLabel: $value';

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.obsidian,
            ),
      ),
    );
  }

  Widget _buildRequestCard({
    required BuildContext context,
    required bool isArabic,
    required QueryDocumentSnapshot<Map<String, dynamic>> doc,
    required List<Map<String, String>> clinicians,
  }) {
    final data = doc.data();
    final requestId = doc.id;
    final busy = _busyIds.contains(requestId);

    final clientName = _safeText(data, 'clientName').isEmpty
        ? 'Client'
        : _safeText(data, 'clientName');
    final clientId = _safeText(data, 'clientId');
    final status = (data['status'] ?? 'pending_admin').toString();
    final requestKind = _safeText(data, 'requestKind');
    final isCenterRequest = requestKind == 'center';
    final canAssignClinician = status == 'pending_admin' && !isCenterRequest;
    final adminCanApproveWithoutCenterRecheck =
        (data['adminCanApproveWithoutCenterRecheck'] ?? false) == true;
    final canMoveCenterToFollowUp = isCenterRequest &&
        status == 'pending_admin' &&
        !adminCanApproveWithoutCenterRecheck;
    final note = _safeText(data, 'note');
    final createdAt = _dateText(data['createdAt']);
    final assignedName = _safeText(data, 'assignedClinicianName').isNotEmpty
        ? _safeText(data, 'assignedClinicianName')
        : _safeText(data, 'clinicianName');

    final paymentStatus = _safeText(data, 'paymentStatus');
    final sessionStatus = _safeText(data, 'sessionStatus');
    final reviewStatus = _safeText(data, 'reviewStatus');
    final payoutStatus = _safeText(data, 'payoutStatus');
    final archived = (data['archived'] ?? false) == true;
    final paymentReceiptFileName = _safeText(data, 'paymentReceiptFileName');
    final paymentClientNote = _safeText(data, 'paymentClientNote');
    final approvedSlot = _safeText(data, 'approvedSlot');
    final sessionDateText = _safeText(data, 'sessionDateText');
    final sessionCode = _safeText(data, 'sessionCode');
    final sessionLink = _safeText(data, 'sessionLink');
    final rejectReason = _safeText(data, 'rejectReason');
    final adminDecisionNote = _safeText(data, 'adminDecisionNote');
    final clinicianDecisionNote = _safeText(data, 'clinicianDecisionNote');
    final centerAvailabilityStatus =
        _safeText(data, 'centerAvailabilityStatus');
    final centerAvailabilityNote = _safeText(data, 'centerAvailabilityNote');
    final centerSuggestedAlternativeLabelAr =
        _safeText(data, 'centerSuggestedAlternativeLabelAr');
    final selectedAccommodationLabelAr =
        _safeText(data, 'selectedAccommodationLabelAr');
    final lastCenterAvailabilityNote =
        _safeText(data, 'lastCenterAvailabilityNote');
    final lastCenterSuggestedAlternativeLabelAr =
        _safeText(data, 'lastCenterSuggestedAlternativeLabelAr');
    final accountingReviewStatus = _safeText(data, 'accountingReviewStatus');
    final grossClientPaidAmount = _safeText(data, 'grossClientPaidAmount');
    final appCommissionPercent = _safeText(data, 'appCommissionPercent');
    final appCommissionAmount = _safeText(data, 'appCommissionAmount');
    final netAmountDueToCenter = _safeText(data, 'netAmountDueToCenter');
    final accountingReviewNotes = _safeText(data, 'accountingReviewNotes');
    final canApproveCenter = isCenterRequest &&
        ((status == 'center_follow_up' &&
                centerAvailabilityStatus == 'available') ||
            (status == 'pending_admin' && adminCanApproveWithoutCenterRecheck));

    final selectedClinicianId = _selectedClinicianByRequest[requestId];
    final selectedClinician =
        clinicians.cast<Map<String, String>?>().firstWhere(
              (item) => item?['id'] == selectedClinicianId,
              orElse: () => null,
            );
    final canReviewPayment = (status == 'payment_review' ||
        paymentStatus == 'submitted_by_client' ||
        (status == 'awaiting_payment' && paymentReceiptFileName.isNotEmpty));
    final canReturnCenterToClient = isCenterRequest &&
        status == 'center_follow_up' &&
        centerAvailabilityStatus == 'unavailable';
    final canRunAccountingReview = isCenterRequest &&
        status == 'payout_pending' &&
        accountingReviewStatus != 'confirmed';
    final canConfirmCenterPayout = isCenterRequest &&
        status == 'payout_pending' &&
        accountingReviewStatus == 'confirmed';
    final canReturnToPending = !archived &&
        (status == 'assigned_clinician' ||
            status == 'awaiting_payment' ||
            status == 'payment_review' ||
            status == 'session_setup_pending' ||
            status == 'session_scheduled' ||
            status == 'session_in_progress' ||
            status == 'session_completed_pending_reviews' ||
            status == 'reschedule_pending' ||
            status == 'center_follow_up' ||
            status == 'rejected_admin' ||
            status == 'clinician_rejected');

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AppSurfaceCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        clientName,
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isCenterRequest
                            ? (isArabic
                                ? 'طلب مركز عبر الإدارة'
                                : 'Center request via admin')
                            : (isArabic
                                ? 'طلب أخصائي'
                                : 'Specialist booking request'),
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.mist,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: AppStatusBadge(
                    label: _statusLabel(status, isArabic),
                    color: _statusColor(status),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'الأخصائي الحالي',
              enLabel: 'Assigned clinician',
              value: assignedName,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'معرف العميل',
              enLabel: 'Client ID',
              value: clientId,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'تاريخ الإنشاء',
              enLabel: 'Created at',
              value: createdAt,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'ملاحظة العميل',
              enLabel: 'Client note',
              value: note,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'قرار الإدارة',
              enLabel: 'Admin note',
              value: adminDecisionNote,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'رد المركز على التوفر',
              enLabel: 'Center availability',
              value: centerAvailabilityStatus,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'نوع الإقامة المختار',
              enLabel: 'Selected accommodation',
              value: selectedAccommodationLabelAr,
            ),
            if (adminCanApproveWithoutCenterRecheck)
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'الاعتماد المباشر',
                enLabel: 'Direct approval',
                value: isArabic
                    ? 'مسموح به دون إعادة الإرسال للمركز'
                    : 'Allowed without returning to center',
              ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'ملاحظة المركز',
              enLabel: 'Center note',
              value: centerAvailabilityNote,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'البديل المقترح من المركز',
              enLabel: 'Suggested alternative',
              value: centerSuggestedAlternativeLabelAr,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'آخر ملاحظة محفوظة من المركز',
              enLabel: 'Latest saved center note',
              value: lastCenterAvailabilityNote,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'آخر بديل مقترح محفوظ',
              enLabel: 'Latest saved alternative',
              value: lastCenterSuggestedAlternativeLabelAr,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'قرار الأخصائي',
              enLabel: 'Clinician note',
              value: clinicianDecisionNote,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'سبب الرفض',
              enLabel: 'Reject reason',
              value: rejectReason,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'موعد/ملاحظة القبول',
              enLabel: 'Approval slot/note',
              value: approvedSlot,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'حالة الدفع',
              enLabel: 'Payment status',
              value: paymentStatus,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'مرجع إثبات السداد',
              enLabel: 'Payment proof',
              value: paymentReceiptFileName,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'ملاحظة الدفع من العميل',
              enLabel: 'Client payment note',
              value: paymentClientNote,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'حالة الجلسة',
              enLabel: 'Session status',
              value: sessionStatus,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'موعد الجلسة',
              enLabel: 'Session date',
              value: sessionDateText,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'كود الجلسة',
              enLabel: 'Session code',
              value: sessionCode,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'رابط الجلسة',
              enLabel: 'Session link',
              value: sessionLink.isEmpty
                  ? ''
                  : (isArabic ? 'رابط الجلسة متاح' : 'Session link available'),
              valueOnly: true,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'حالة التقييم',
              enLabel: 'Review status',
              value: reviewStatus,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'حالة التحويل',
              enLabel: 'Payout status',
              value: payoutStatus,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'حالة المراجعة المحاسبية',
              enLabel: 'Accounting review status',
              value: accountingReviewStatus,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'إجمالي المدفوع من العميل',
              enLabel: 'Gross client-paid amount',
              value: grossClientPaidAmount,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'نسبة عمولة التطبيق',
              enLabel: 'App commission percent',
              value: appCommissionPercent,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'قيمة العمولة',
              enLabel: 'Commission amount',
              value: appCommissionAmount,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'الصافي المستحق للمركز',
              enLabel: 'Net due to center',
              value: netAmountDueToCenter,
            ),
            _buildDetailLine(
              context: context,
              isArabic: isArabic,
              arLabel: 'ملاحظات المحاسبة',
              enLabel: 'Accounting notes',
              value: accountingReviewNotes,
            ),
            const SizedBox(height: 12),
            if (canAssignClinician) ...[
              AppSectionPanel(
                padding: const EdgeInsets.all(AppSpacing.md),
                color: const Color(0xFFF8F5FC),
                child: DropdownButtonFormField<String>(
                  initialValue: selectedClinicianId,
                  isExpanded: true,
                  decoration: appInputDecoration(
                    context: context,
                    label: isArabic
                        ? 'اختر الأخصائي للتحويل'
                        : 'Select clinician to assign',
                    icon: Icons.person_search_outlined,
                  ),
                  items: clinicians.map((item) {
                    return DropdownMenuItem<String>(
                      value: item['id']!,
                      child: Text(item['name']!),
                    );
                  }).toList(),
                  onChanged: busy
                      ? null
                      : (value) {
                          setState(() {
                            if (value == null) {
                              _selectedClinicianByRequest.remove(requestId);
                            } else {
                              _selectedClinicianByRequest[requestId] = value;
                            }
                          });
                        },
                ),
              ),
              const SizedBox(height: 14),
            ],
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: isArabic ? WrapAlignment.end : WrapAlignment.start,
              children: [
                if (status == 'pending_admin')
                  OutlinedButton.icon(
                    onPressed: busy ? null : () => _rejectRequest(requestId),
                    icon: const Icon(Icons.cancel_outlined),
                    label: Text(isArabic ? 'رفض' : 'Reject'),
                  ),
                if (canMoveCenterToFollowUp)
                  FilledButton.icon(
                    onPressed:
                        busy ? null : () => _moveCenterToFollowUp(requestId),
                    icon: const Icon(Icons.fact_check_outlined),
                    label: Text(
                      isArabic ? 'نقل للمتابعة' : 'Move to follow-up',
                    ),
                  ),
                if (canAssignClinician)
                  FilledButton.tonalIcon(
                    onPressed: busy || selectedClinician == null
                        ? null
                        : () => _assignToClinician(
                              requestId: requestId,
                              clinicianId: selectedClinician['id']!,
                              clinicianName: selectedClinician['name']!,
                            ),
                    icon: const Icon(Icons.forward_to_inbox_outlined),
                    label: Text(
                      isArabic ? 'تحويل لأخصائي' : 'Assign to clinician',
                    ),
                  ),
                if (canApproveCenter)
                  FilledButton.icon(
                    onPressed:
                        busy ? null : () => _approveCenterRequest(requestId),
                    icon: const Icon(Icons.verified_outlined),
                    label: Text(
                      isArabic
                          ? 'اعتماد وفتح الدفع'
                          : 'Approve and open payment',
                    ),
                  ),
                if (canReturnCenterToClient)
                  OutlinedButton.icon(
                    onPressed: busy
                        ? null
                        : () => _returnCenterRequestToClient(requestId, data),
                    icon: const Icon(Icons.reply_outlined),
                    label: Text(
                      isArabic
                          ? 'إرجاع للعميل للتعديل'
                          : 'Return to client for edit',
                    ),
                  ),
                if (canReviewPayment)
                  FilledButton.icon(
                    onPressed: busy ? null : () => _approvePayment(requestId),
                    icon: const Icon(Icons.verified_outlined),
                    label: Text(
                      isArabic ? 'اعتماد السداد' : 'Approve payment',
                    ),
                  ),
                if (canReviewPayment)
                  OutlinedButton.icon(
                    onPressed: busy ? null : () => _rejectPayment(requestId),
                    icon: const Icon(Icons.cancel_outlined),
                    label: Text(
                      isArabic ? 'رفض السداد' : 'Reject payment',
                    ),
                  ),
                if (!isCenterRequest && status == 'payout_pending')
                  FilledButton.icon(
                    onPressed:
                        busy ? null : () => _confirmClinicianPayout(requestId),
                    icon: const Icon(Icons.payments_outlined),
                    label: Text(
                      isArabic
                          ? 'تم تحويل مستحق الأخصائي'
                          : 'Confirm clinician payout',
                    ),
                  ),
                if (canRunAccountingReview)
                  FilledButton.icon(
                    onPressed: busy
                        ? null
                        : () => _confirmCenterAccountingReview(requestId, data),
                    icon: const Icon(Icons.calculate_outlined),
                    label: Text(
                      isArabic ? 'مراجعة محاسبية' : 'Accounting review',
                    ),
                  ),
                if (canConfirmCenterPayout)
                  FilledButton.icon(
                    onPressed:
                        busy ? null : () => _confirmCenterPayout(requestId),
                    icon: const Icon(Icons.account_balance_wallet_outlined),
                    label: Text(
                      isArabic
                          ? 'تم تحويل مستحق المركز'
                          : 'Confirm center payout',
                    ),
                  ),
                if (status == 'completed_success' && !archived)
                  FilledButton.tonalIcon(
                    onPressed:
                        busy ? null : () => _sendToSessionArchive(requestId),
                    icon: const Icon(Icons.video_call_outlined),
                    label: Text(
                      isArabic ? 'أرشفة جلسية' : 'Session archive',
                    ),
                  ),
                if (status == 'completed_success' && !archived)
                  FilledButton.tonalIcon(
                    onPressed:
                        busy ? null : () => _sendToFinancialArchive(requestId),
                    icon: const Icon(Icons.account_balance_wallet_outlined),
                    label: Text(
                      isArabic ? 'أرشفة مالية' : 'Financial archive',
                    ),
                  ),
                if (isCenterRequest && status == 'center_follow_up')
                  OutlinedButton.icon(
                    onPressed: busy ? null : () => _rejectRequest(requestId),
                    icon: const Icon(Icons.cancel_outlined),
                    label: Text(isArabic ? 'رفض' : 'Reject'),
                  ),
                if (canReturnToPending)
                  TextButton.icon(
                    onPressed: busy ? null : () => _returnToPending(requestId),
                    icon: const Icon(Icons.refresh),
                    label: Text(
                      isArabic ? 'إرجاع للبندنج' : 'Return to pending',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'لوحة متابعة الطلبات' : 'Booking workflow pipeline',
          canLogout: false,
        ),
        body: AppPageBackground(
          child:
              StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: _bookingDocsStream(),
            builder: (context, bookingSnap) {
              if (bookingSnap.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل الطلبات'
                      : 'Unable to load booking requests',
                  icon: Icons.error_outline,
                );
              }

              final bookingDocs = bookingSnap.data;
              if (bookingDocs == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _cliniciansStream(),
                builder: (context, clinicianSnap) {
                  if (clinicianSnap.hasError) {
                    return AppEmptyState(
                      message: isArabic
                          ? 'تعذر تحميل الأخصائيين'
                          : 'Unable to load clinicians',
                      icon: Icons.medical_services_outlined,
                    );
                  }

                  final clinicianDocs = clinicianSnap.data?.docs ?? [];
                  final clinicians = clinicianDocs.map((doc) {
                    final data = doc.data();
                    final displayName =
                        (data['displayName'] ?? 'Clinician').toString();
                    final titleAr = (data['professionalTitleLabelAr'] ?? '')
                        .toString()
                        .trim();
                    final fullName = [titleAr, displayName]
                        .where((e) => e.trim().isNotEmpty)
                        .join(' ');
                    return <String, String>{
                      'id': doc.id,
                      'name': fullName.isEmpty ? displayName : fullName,
                    };
                  }).toList();

                  final allDocs = bookingDocs
                      .where((doc) => _matchTab(doc.data()))
                      .toList();

                  return ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      AppSurfaceCard(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: isArabic
                              ? WrapAlignment.end
                              : WrapAlignment.start,
                          children: _tabs.map((item) {
                            final key = item['key']!;
                            return ChoiceChip(
                              selected: _tab == key,
                              label: Text(
                                isArabic ? item['labelAr']! : item['labelEn']!,
                              ),
                              onSelected: (_) => setState(() => _tab = key),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (allDocs.isEmpty)
                        AppEmptyState(
                          message: isArabic
                              ? 'لا توجد طلبات في هذه المرحلة'
                              : 'No requests in this stage',
                          icon: Icons.inbox_outlined,
                        )
                      else
                        ...allDocs.map(
                          (doc) => _buildRequestCard(
                            context: context,
                            isArabic: isArabic,
                            doc: doc,
                            clinicians: clinicians,
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
