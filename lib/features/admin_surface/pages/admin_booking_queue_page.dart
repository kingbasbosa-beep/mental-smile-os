import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/core/system/domain_status_service.dart';
import 'package:flutterprojects/features/booking/data/services/booking_health_service.dart';
import 'package:flutterprojects/features/admin_surface/widgets/domain_advisory_banner.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminBookingQueuePage extends StatefulWidget {
  const AdminBookingQueuePage({super.key});

  @override
  State<AdminBookingQueuePage> createState() => _AdminBookingQueuePageState();
}

class _AdminBookingQueuePageState extends State<AdminBookingQueuePage> {
  static const BookingHealthService _bookingHealthService =
      BookingHealthService();
  static const DomainStatusService _domainStatusService = DomainStatusService();
  static const bool _adminClinicianForwardBridgeEnabled = false;

  String _centerTypeLabel(String type, bool isArabic) {
    switch (type.trim()) {
      case 'detox':
        return isArabic ? 'ديتوكس / أعراض انسحاب' : 'Detox / Withdrawal';
      case 'hospital':
        return isArabic ? 'مستشفى' : 'Hospital';
      case 'special_needs_care':
        return isArabic ? 'رعاية ذوي الاحتياجات الخاصة' : 'Special Needs Care';
      case 'halfway_house':
      default:
        return isArabic ? 'هاف واي' : 'Halfway House';
    }
  }

  String _tab = 'pending_admin';
  final Set<String> _busyIds = {};
  late final Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _bookingDocsStreamRef;
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _cliniciansStreamRef;

  @override
  void initState() {
    super.initState();
    _bookingDocsStreamRef = _bookingDocsStream();
    _cliniciansStreamRef = _cliniciansStream();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emitBookingHealth();
    });
  }

  Future<void> _emitBookingHealth() async {
    try {
      await _bookingHealthService.emitHealthSnapshot(
        sampleType: 'admin_booking_queue_open',
      );
    } catch (_) {
      // Health reporting must stay quiet and never block booking queue usage.
    }
  }

  Map<String, dynamic> _withCanonicalWorkflowStage(
    Map<String, dynamic> updates,
  ) {
    final status = updates['status'];
    if (status is String &&
        status.trim().isNotEmpty &&
        !updates.containsKey('workflowStage')) {
      return {
        ...updates,
        'workflowStage': status,
      };
    }
    return updates;
  }

  static const List<Map<String, String>> _tabs = [
    {
      'key': 'pending_admin',
      'labelAr': 'بانتظار الإدارة',
      'labelEn': 'Pending admin'
    },
    {
      'key': 'client_update_required',
      'labelAr': 'بانتظار تعديل العميل',
      'labelEn': 'Client update required'
    },
    {
      'key': 'center_follow_up',
      'labelAr': 'متابعة المراكز',
      'labelEn': 'Center follow-up'
    },
    {
      'key': 'payment_review',
      'labelAr': 'مراجعة السداد',
      'labelEn': 'Payment review'
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
    {
      'key': 'center_intake_pending',
      'labelAr': 'بانتظار بيانات التقييم الأولي',
      'labelEn': 'Awaiting intake data'
    },
    {
      'key': 'center_recommendation_pending',
      'labelAr': 'بانتظار توصية المركز',
      'labelEn': 'Awaiting center recommendation'
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
  ];

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  String _advisoryTitle(bool isArabic, String status) {
    switch (status) {
      case 'disabled':
        return isArabic
            ? 'تنبيه: نطاق الحجوزات معطل'
            : 'Advisory: Booking disabled';
      case 'maintenance':
        return isArabic
            ? 'تنبيه: نطاق الحجوزات تحت صيانة مخططة'
            : 'Advisory: Booking maintenance';
      default:
        return isArabic
            ? 'تنبيه: نطاق الحجوزات في حالة degraded'
            : 'Advisory: Booking degraded';
    }
  }

  String _advisoryBody(bool isArabic, DomainStatus status) {
    final reason = (status.statusReason ?? status.note ?? '').trim();
    final source = DomainAdvisoryBanner.statusSourceLabel(status.statusSource);

    final intro = switch (status.status) {
      'disabled' => isArabic
          ? 'هذا السطح يعرض نطاق الحجوزات على أنه معطل حاليًا.'
          : 'This surface is showing the Booking domain as currently disabled.',
      'maintenance' => isArabic
          ? 'هذا السطح يعرض أن نطاق الحجوزات تحت صيانة مخططة.'
          : 'This surface is showing the Booking domain as under planned maintenance.',
      _ => isArabic
          ? 'هذا السطح يعرض أن نطاق الحجوزات في حالة degraded ويجب التعامل مع إشاراته بثقة أقل.'
          : 'This surface is showing the Booking domain as degraded and its signals should be treated with reduced trust.',
    };

    if (reason.isEmpty) {
      return '$intro ${isArabic ? 'المصدر' : 'Source'}: $source.';
    }

    return '$intro ${isArabic ? 'المصدر' : 'Source'}: $source. ${isArabic ? 'الملاحظة' : 'Note'}: $reason';
  }

  Widget _buildDomainAdvisoryBanner(BuildContext context, bool isArabic) {
    return StreamBuilder<DomainStatus>(
      stream: _domainStatusService.watchDomainStatus(DomainKey.booking),
      builder: (context, snapshot) {
        final status = snapshot.data;
        if (status == null || status.status == 'active' || status.isUnknown) {
          return const SizedBox.shrink();
        }

        return DomainAdvisoryBanner(
          status: status,
          domainDisplayName: 'Booking',
          title: _advisoryTitle(isArabic, status.status),
          body: _advisoryBody(isArabic, status),
          nonBlockingMessage: isArabic
              ? 'هذا تنبيه معلوماتي فقط. عمليات الحجوزات لا يتم حظرها بواسطة هذا الإشعار.'
              : 'This is informational only. Booking operations are not blocked by this notice.',
          isArabic: isArabic,
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
        );
      },
    );
  }

  Future<void> _refreshAuthContextForFirestore({
    required String stage,
    required String requestId,
  }) async {
    final auth = FirebaseAuth.instance;
    final beforeUser = auth.currentUser;
    print(
      'CENTER_AUTH_TRACE '
      'stage=$stage '
      'requestId=$requestId '
      'phase=before_refresh '
      'currentUserExists=${beforeUser != null} '
      'currentUserUid=${beforeUser?.uid ?? ''}',
    );

    await beforeUser?.reload();

    final reloadedUser = auth.currentUser;
    print(
      'CENTER_AUTH_TRACE '
      'stage=$stage '
      'requestId=$requestId '
      'phase=after_reload '
      'currentUserExists=${reloadedUser != null} '
      'currentUserUid=${reloadedUser?.uid ?? ''}',
    );

    if (reloadedUser != null) {
      await reloadedUser.getIdToken(true);
      print(
        'CENTER_AUTH_TRACE '
        'stage=$stage '
        'requestId=$requestId '
        'phase=after_token_refresh '
        'currentUserExists=true '
        'currentUserUid=${reloadedUser.uid} '
        'tokenRefresh=true',
      );
    } else {
      print(
        'CENTER_AUTH_TRACE '
        'stage=$stage '
        'requestId=$requestId '
        'phase=after_token_refresh '
        'currentUserExists=false '
        'currentUserUid= '
        'tokenRefresh=false',
      );
    }
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

  String _debugValue(dynamic value) {
    if (value is FieldValue) return 'FieldValue';
    if (value is Timestamp) return value.toDate().toIso8601String();
    return value?.toString() ?? 'null';
  }

  Map<String, String> _debugMap(Map<String, dynamic> value) {
    return {
      for (final entry in value.entries) entry.key: _debugValue(entry.value),
    };
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
      ..._withCanonicalWorkflowStage(updates),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final db = FirebaseFirestore.instance;
    final refs = [
      db.collection('booking_requests').doc(requestId),
    ];

    debugPrint(
      'CENTER_FLOW_ASSIGN_TRACE '
      'requestId=$requestId '
      'targets=${refs.map((ref) => ref.path).join(",")} '
      'legacyMirrorAttempted=false '
      'finalUpdate=${_debugMap(nowUpdates)}',
    );

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
          debugPrint(
            'CENTER_FLOW_ASSIGN_RESOURCE_TRACE '
            'requestId=$requestId '
            'path=${ref.path} '
            'resourceSnapshot=${_debugMap({
                  'requestKind': data['requestKind'],
                  'status': data['status'],
                  'workflowStage': data['workflowStage'],
                  'clientId': data['clientId'],
                  'clientName': data['clientName'],
                  'createdAt': data['createdAt'],
                  'note': data['note'],
                  'clinicianId': data['clinicianId'],
                  'clinicianName': data['clinicianName'],
                  'clinicianUid': data['clinicianUid'],
                  'assignedClinicianId': data['assignedClinicianId'],
                  'assignedClinicianName': data['assignedClinicianName'],
                  'adminForwarded': data['adminForwarded'],
                  'adminAssignedBy': data['adminAssignedBy'],
                  'adminAssignedAt': data['adminAssignedAt'],
                })}',
          );
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

  Future<DocumentSnapshot<Map<String, dynamic>>> _readPrimaryBookingRequest(
    String requestId,
  ) async {
    final ref = FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(requestId);
    _logFirestore(
      page: 'admin_booking_queue',
      role: 'admin',
      operation: 'read',
      collection: 'booking_requests',
      documentId: requestId,
    );
    return ref.get();
  }

  Future<void> _updatePrimaryCenterRequest(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final ref = FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(requestId);
    final nowUpdates = {
      ..._withCanonicalWorkflowStage(updates),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    try {
      await _refreshAuthContextForFirestore(
        stage: '_updatePrimaryCenterRequest',
        requestId: requestId,
      );
      final snap = await _readPrimaryBookingRequest(requestId);
      if (!snap.exists) {
        throw Exception('Center request not found');
      }
      final data = snap.data() ?? <String, dynamic>{};
      print(
        'CENTER_FOLLOWUP_TRACE '
        'requestId=$requestId '
        'currentAuthUid=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
        'resourceRequestKind=${(data['requestKind'] ?? '').toString()} '
        'resourceStatus=${(data['status'] ?? '').toString()} '
        'resourceClientUpdatedAfterCenterFeedback=${data['clientUpdatedAfterCenterFeedback']} '
        'writeStatus=${(nowUpdates['status'] ?? '').toString()} '
        'writeWorkflowStage=${(nowUpdates['workflowStage'] ?? '').toString()} '
        'writeAdminDecisionType=${(nowUpdates['adminDecisionType'] ?? '').toString()} '
        'writeCenterAdminHandledBy=${(nowUpdates['centerAdminHandledBy'] ?? '').toString()}',
      );
      _logFirestore(
        page: 'admin_booking_queue',
        role: 'admin',
        operation: 'update',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: (data['requestKind'] ?? '').toString(),
        status: (data['status'] ?? '').toString(),
        writeStatus: (updates['status'] ?? '').toString(),
      );
      print(
        'CENTER_AUTH_TRACE '
        'stage=_updatePrimaryCenterRequest '
        'requestId=$requestId '
        'phase=before_firestore_update '
        'currentUserExists=${FirebaseAuth.instance.currentUser != null} '
        'currentUserUid=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
        'afterRefresh=true',
      );
      await ref.update(nowUpdates);
      _logFirestore(
        page: 'admin_booking_queue',
        role: 'admin',
        operation: 'transition_success',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: 'center',
        status: (data['status'] ?? '').toString(),
        writeStatus: (updates['status'] ?? '').toString(),
      );
    } catch (e) {
      print(
        'CENTER_FOLLOWUP_TRACE_ERROR '
        'requestId=$requestId '
        'currentAuthUid=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
        'error=$e',
      );
      _logFirestore(
        page: 'admin_booking_queue',
        role: 'admin',
        operation: 'update_error',
        collection: 'booking_requests',
        documentId: requestId,
        requestKind: 'center',
        writeStatus: (updates['status'] ?? '').toString(),
        error: e,
      );
      rethrow;
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
    }

    if (threadRef == null) {
      _logFirestore(
        page: 'admin_booking_queue',
        role: 'admin',
        operation: 'skip_system_message',
        collection: 'chat_threads',
        documentId: threadId,
        error: 'thread_not_found_in_chat_threads',
      );
      return;
    }

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
    return Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>.multi(
      (controller) {
        QuerySnapshot<Map<String, dynamic>>? primarySnapshot;

        void emitMerged() {
          final mergedByDocId =
              <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

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

        controller.onCancel = () async {
          await primarySub.cancel();
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

  Future<void> _rejectRequest(
    String requestId, {
    required bool isCenterRequest,
  }) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      final payload = {
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
        'payment_confirmed': false,
        'sessionStatus': 'cancelled',
        'reviewStatus': 'blocked',
        'payoutStatus': 'blocked',
      };
      if (isCenterRequest) {
        await _updatePrimaryCenterRequest(requestId, payload);
      } else {
        await _updateRequestEverywhere(requestId, payload);
      }

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
        // Canonical ownership field.
        'assignedClinicianId': '',
        'assignedClinicianName': '',
        'clinicianId': '',
        'clinicianName': '',
        // Legacy compatibility field.
        'clinicianUid': '',
        'paymentStatus': 'not_started',
        'payment_confirmed': false,
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
      await _refreshAuthContextForFirestore(
        stage: '_moveCenterToFollowUp',
        requestId: requestId,
      );
      print(
        'CENTER_FOLLOWUP_TRACE '
        'requestId=$requestId '
        'currentAuthUid=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
        'payloadCenterAdminHandledBy=${FirebaseAuth.instance.currentUser?.uid ?? ''} '
        'writeStatus=center_follow_up '
        'writeWorkflowStage=center_follow_up '
        'writeAdminDecisionType=center_follow_up '
        'afterRefresh=true',
      );
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
      await _updatePrimaryCenterRequest(requestId, {
        'status': 'center_follow_up',
        'workflowStage': 'center_follow_up',
        'adminApproved': false,
        'adminRejected': false,
        'adminForwarded': false,
        'adminDecisionType': 'center_follow_up',
        'adminDecisionBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminDecisionAt': FieldValue.serverTimestamp(),
        'adminAssignedBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminAssignedAt': FieldValue.serverTimestamp(),
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

  Future<void> _openCenterIntakeStep(String requestId) async {
    final isArabic = _isArabic(context);
    await _setBusy(requestId, true);
    try {
      await _updatePrimaryCenterRequest(requestId, {
        'status': 'center_intake_pending',
        'workflowStage': 'center_intake_pending',
        'adminDecisionType': 'center_intake_opened',
        'adminDecisionBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminDecisionAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      setState(() => _tab = 'center_intake_pending');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم فتح خطوة التقييم الأولي للعميل'
                : 'Initial intake step opened for the client',
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
      await _updatePrimaryCenterRequest(requestId, {
        'status': 'session_setup_pending',
        'workflowStage': 'session_setup_pending',
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
        // Canonical ownership field.
        'assignedClinicianId': '',
        'assignedClinicianName': '',
        'clinicianId': '',
        'clinicianName': '',
        // Legacy compatibility field.
        'clinicianUid': '',
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? 'تم اعتماد طلب المركز وتحويله إلى مرحلة تجهيز الإقامة المبدئية قبل فتح الدفع.'
            : 'The center request was approved and moved to preliminary residency setup before payment.',
      );

      if (!mounted) return;
      setState(() => _tab = 'session_setup_pending');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم اعتماد طلب المركز وتحويله إلى تجهيز الإقامة المبدئية'
                : 'Center request approved and moved to preliminary residency setup',
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
      await _updatePrimaryCenterRequest(requestId, {
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
        'adminDecisionType': 'returned_to_client',
        'adminDecisionBy': FirebaseAuth.instance.currentUser?.uid ?? '',
        'adminDecisionAt': FieldValue.serverTimestamp(),
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
        'status': 'payout_pending',
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
      final snap = await FirebaseFirestore.instance
          .collection('booking_requests')
          .doc(requestId)
          .get();
      final data = snap.data() ?? const <String, dynamic>{};
      final isCenterRequest =
          (data['requestKind'] ?? '').toString().trim() == 'center' ||
              (data['centerId'] ?? '').toString().trim().isNotEmpty;
      await _updateRequestEverywhere(requestId, {
        'status':
            isCenterRequest ? 'session_scheduled' : 'session_setup_pending',
        'workflowStage':
            isCenterRequest ? 'session_scheduled' : 'session_setup_pending',
        'paymentStatus': 'approved',
        'payment_confirmed': true,
        'paymentApprovedAt': FieldValue.serverTimestamp(),
        'sessionStatus': isCenterRequest ? 'scheduled' : 'not_created',
      });

      await _appendSystemMessage(
        requestId: requestId,
        text: isArabic
            ? (isCenterRequest
                ? 'تم اعتماد السداد وتحويل الطلب إلى إقامة مبدئية مجدولة.'
                : 'تم اعتماد السداد وتحويل الطلب إلى مرحلة تجهيز الجلسة.')
            : (isCenterRequest
                ? 'Payment approved and request moved to preliminary residency scheduled.'
                : 'Payment approved and request moved to session setup.'),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? (isCenterRequest
                    ? 'تم اعتماد السداد وتحويل الطلب إلى إقامة مبدئية مجدولة'
                    : 'تم اعتماد السداد وتحويل الطلب إلى تجهيز الجلسة')
                : (isCenterRequest
                    ? 'Payment approved and moved to preliminary residency scheduled'
                    : 'Payment approved and moved to session setup'),
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
        'payment_confirmed': false,
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
  }) async {
    // Temporary compatibility bridge only; new clinician direct-entry requests
    // are created clinician-visible without requiring admin forward.
    final isArabic = _isArabic(context);
    final adminUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    await _setBusy(requestId, true);
    try {
      if (adminUid.isEmpty) {
        _logFirestore(
          page: 'admin_booking_queue',
          role: 'admin',
          operation: 'assign_skip_missing_admin_uid',
          collection: 'booking_requests',
          documentId: requestId,
          requestKind: 'clinician',
          status: 'pending_admin',
          writeStatus: 'assigned_clinician',
          error: 'current_admin_uid_empty',
        );
        throw Exception('Admin authentication context is unavailable');
      }

      final snap = await _readPrimaryBookingRequest(requestId);
      if (!snap.exists) {
        throw Exception('Booking request not found');
      }
      final resourceSnapshot = snap.data() ?? const <String, dynamic>{};
      final currentStatus =
          (resourceSnapshot['status'] ?? '').toString().trim();
      final currentWorkflowStage =
          (resourceSnapshot['workflowStage'] ?? '').toString().trim();
      final clinicianId = resourceSnapshot['clinicianId'];
      final clinicianName = resourceSnapshot['clinicianName'];
      final clinicianUid = resourceSnapshot['clinicianUid'];

      debugPrint(
        'CENTER_FLOW_ASSIGN_START '
        'requestId=$requestId '
        'adminUid=$adminUid '
        'clinicianId=$clinicianId '
        'clinicianName=$clinicianName '
        'clinicianUid=$clinicianUid',
      );

      final alreadyAssigned = currentStatus == 'assigned_clinician' ||
          currentWorkflowStage == 'assigned_clinician';

      if (alreadyAssigned) {
        _logFirestore(
          page: 'admin_booking_queue',
          role: 'admin',
          operation: 'assign_skip_already_assigned',
          collection: 'booking_requests',
          documentId: requestId,
          requestKind: (resourceSnapshot['requestKind'] ?? '').toString(),
          status: currentStatus,
          writeStatus: 'assigned_clinician',
          error: 'request_already_in_assigned_clinician_state',
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isArabic
                  ? 'الطلب مُحوّل بالفعل إلى أخصائي ولا يمكن إعادة التحويل الآن'
                  : 'This request is already assigned to a clinician and cannot be reassigned right now.',
            ),
          ),
        );
        return;
      }

      if (clinicianId is! String ||
          clinicianName is! String ||
          clinicianUid is! String ||
          clinicianId.isEmpty ||
          clinicianName.isEmpty ||
          clinicianUid.isEmpty) {
        _logFirestore(
          page: 'admin_booking_queue',
          role: 'admin',
          operation: 'assign_skip_missing_requested_clinician',
          collection: 'booking_requests',
          documentId: requestId,
          requestKind: (resourceSnapshot['requestKind'] ?? '').toString(),
          status: currentStatus,
          writeStatus: 'assigned_clinician',
          error: 'requested_clinician_target_missing',
        );
        throw Exception('Requested clinician target is missing');
      }

      await _updateRequestEverywhere(requestId, {
        'status': 'assigned_clinician',
        'workflowStage': 'assigned_clinician',
        'adminApproved': true,
        'adminRejected': false,
        'adminForwarded': true,
        // Actual approved assignment after admin forward.
        'assignedClinicianId': clinicianId,
        'assignedClinicianName': clinicianName,
        'adminAssignedBy': adminUid,
        'adminAssignedAt': FieldValue.serverTimestamp(),
        'adminDecisionType': 'assigned',
        'adminDecisionBy': adminUid,
        'adminDecisionAt': FieldValue.serverTimestamp(),
        'paymentStatus': 'not_started',
        'payment_confirmed': false,
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
      case 'center_intake_pending':
        return isArabic
            ? 'بانتظار بيانات التقييم الأولي'
            : 'Awaiting intake data';
      case 'center_recommendation_pending':
        return isArabic
            ? 'بانتظار توصية المركز'
            : 'Awaiting center recommendation';
      case 'approved':
        return isArabic ? 'طلب مركز معتمد' : 'Approved center request';
      case 'assigned_clinician':
        return isArabic ? 'بانتظار رد الأخصائي' : 'Awaiting clinician response';
      case 'awaiting_payment':
        return isArabic ? 'بانتظار التحويل المالي' : 'Awaiting payment';
      case 'payment_review':
        return isArabic ? 'مراجعة السداد' : 'Payment review';
      case 'session_setup_pending':
        return isArabic
            ? 'تجهيز إقامة بعد توصية المركز'
            : 'Setup after center recommendation';
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
      case 'center_intake_pending':
      case 'center_recommendation_pending':
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

  String _centerAvailabilityOutcomeLabel(String value, bool isArabic) {
    switch (value.trim()) {
      case 'available':
        return isArabic
            ? 'متاح: جاهز لمراجعة التقييم الأولي'
            : 'Available: ready for intake review';
      case 'unavailable':
        return isArabic
            ? 'رد المركز: غير متاح'
            : 'Center responded: unavailable';
      case 'pending':
      case '':
        return isArabic
            ? 'بانتظار رد المركز'
            : 'Pending, no center response yet';
      default:
        return isArabic
            ? 'بانتظار رد المركز'
            : 'Pending, no center response yet';
    }
  }

  Color _centerAvailabilityOutcomeColor(String value) {
    switch (value.trim()) {
      case 'available':
        return const Color(0xFF1F9D63);
      case 'unavailable':
        return const Color(0xFFD84B4B);
      default:
        return const Color(0xFFE39B2E);
    }
  }

  String _centerCareLevelLabel(String value, bool isArabic) {
    switch (value.trim()) {
      case 'residential_psych':
        return isArabic
            ? 'إقامة نفسية داخلية'
            : 'Residential psychiatric care';
      case 'detox':
        return isArabic ? 'سحب سموم ومتابعة' : 'Detox and monitoring';
      case 'dual_diagnosis':
        return isArabic ? 'رعاية مزدوجة' : 'Dual diagnosis care';
      case 'diagnostic_observation':
        return isArabic
            ? 'ملاحظة تشخيصية داخلية'
            : 'Diagnostic observation';
      default:
        return value.trim();
    }
  }

  bool _matchTab(Map<String, dynamic> data) {
    final archived = (data['archived'] ?? false) == true;
    if (archived) return false;

    final status = (data['status'] ?? '').toString().trim();
    final requestKind = (data['requestKind'] ?? '').toString().trim();
    if (status.isEmpty || requestKind.isEmpty) {
      return false;
    }
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

  Color _requestTypeAccent(bool isCenterRequest) {
    return isCenterRequest ? const Color(0xFF2AA7A1) : const Color(0xFF7C6EF6);
  }

  String _requestTypeLabel(bool isArabic, bool isCenterRequest) {
    if (isCenterRequest) {
      return isArabic ? 'طلب مركز' : 'Center request';
    }
    return isArabic ? 'طلب أخصائي' : 'Clinician request';
  }

  String _whyHereLabel({
    required bool isArabic,
    required bool isCenterRequest,
    required String status,
    required String centerAvailabilityStatus,
    required String paymentReceiptFileName,
    required String accountingReviewStatus,
  }) {
    switch (status) {
      case 'pending_admin':
        if (isCenterRequest &&
            centerAvailabilityStatus.trim() != 'available' &&
            centerAvailabilityStatus.trim() != 'unavailable') {
          return isArabic
              ? 'بانتظار رد المركز على التوفر'
              : 'Waiting for center availability response';
        }
        return isArabic
            ? 'بانتظار مراجعة أو استثناء إداري'
            : 'Waiting for admin review or exception handling';
      case 'center_follow_up':
        return centerAvailabilityStatus.trim() == 'unavailable'
            ? (isArabic
                ? 'رد المركز بعدم التوفر ويحتاج مسار استرداد'
                : 'Center unavailable response needs recovery path')
            : (isArabic
                ? 'بانتظار متابعة توفر المركز'
                : 'Waiting for center availability follow-up');
      case 'center_intake_pending':
        return isArabic
            ? 'بانتظار العميل لإرسال بيانات التقييم الأولي'
            : 'Waiting for client intake submission';
      case 'center_recommendation_pending':
        return isArabic
            ? 'بانتظار توصية المركز'
            : 'Waiting for center recommendation';
      case 'client_update_required':
        return isArabic
            ? 'بانتظار تعديل العميل للطلب'
            : 'Waiting for client request update';
      case 'assigned_clinician':
        return isArabic
            ? 'الطلب ظاهر للأخصائي وبانتظار استجابته'
            : 'Request is clinician-visible and waiting for clinician response';
      case 'awaiting_payment':
        return paymentReceiptFileName.isNotEmpty
            ? (isArabic
                ? 'تم رفع إثبات السداد وبانتظار المراجعة'
                : 'Payment proof uploaded and awaiting review')
            : (isArabic
                ? 'بانتظار رفع إثبات السداد من العميل'
                : 'Waiting for client payment proof');
      case 'payment_review':
        return isArabic ? 'بانتظار مراجعة السداد' : 'Waiting for payment review';
      case 'session_setup_pending':
        return isArabic
            ? 'بانتظار تجهيز ما قبل فتح الدفع أو الجلسة'
            : 'Waiting for pre-payment/session setup';
      case 'session_scheduled':
      case 'session_in_progress':
        return isArabic
            ? 'متابعة تشغيلية للمراقبة أو الاسترداد'
            : 'Operational tracking for monitoring or recovery';
      case 'session_completed_pending_reviews':
        return isArabic
            ? 'بانتظار التقييمات أو تقارير الخروج'
            : 'Waiting for reviews or discharge reports';
      case 'payout_pending':
        return accountingReviewStatus == 'confirmed'
            ? (isArabic
                ? 'بانتظار تحويل المستحق'
                : 'Waiting for payout transfer')
            : (isArabic
                ? 'بانتظار المراجعة المحاسبية'
                : 'Waiting for accounting review');
      case 'completed_success':
        return isArabic ? 'جاهز للأرشفة أو المراجعة' : 'Ready for archive or review';
      case 'rejected_admin':
      case 'clinician_rejected':
      case 'reschedule_pending':
      case 'cancellation_pending':
      case 'dispute_pending':
        return isArabic ? 'حالة استثناء أو استرداد' : 'Exception or recovery state';
      default:
        return isArabic ? 'بانتظار متابعة إدارية' : 'Waiting for admin monitoring';
    }
  }

  String _nextStepLabel({
    required bool isArabic,
    required bool isCenterRequest,
    required String status,
    required String centerAvailabilityStatus,
    required String paymentReceiptFileName,
    required String accountingReviewStatus,
  }) {
    switch (status) {
      case 'pending_admin':
        if (isCenterRequest && centerAvailabilityStatus == 'available') {
          return isArabic
              ? 'فتح التقييم الأولي عند تحقق الشروط'
              : 'Open intake review when guard conditions pass';
        }
        if (isCenterRequest && centerAvailabilityStatus == 'unavailable') {
          return isArabic
              ? 'إرجاع العميل لمسار طلب جديد أو استرداد'
              : 'Return client to new-request/recovery path';
        }
        return isCenterRequest
            ? (isArabic
                ? 'انتظار رد المركز أو تدخل استثنائي'
                : 'Wait for center response or exception handling')
            : (isArabic
                ? 'الأخصائي يستلم الطلب مباشرة في المسار الطبيعي'
                : 'Clinician receives the request directly in the normal path');
      case 'center_follow_up':
        return centerAvailabilityStatus == 'available'
            ? (isArabic
                ? 'فتح التقييم الأولي'
                : 'Open intake review')
            : (isArabic
                ? 'إرجاع للعميل عند عدم التوفر'
                : 'Return to client when unavailable');
      case 'center_intake_pending':
        return isArabic ? 'العميل يرسل بيانات التقييم' : 'Client submits intake';
      case 'center_recommendation_pending':
        return isArabic
            ? 'المركز يرسل التوصية'
            : 'Center submits recommendation';
      case 'client_update_required':
        return isArabic ? 'العميل يحدث الطلب' : 'Client updates the request';
      case 'assigned_clinician':
        return isArabic
            ? 'الأخصائي يقبل أو يرفض'
            : 'Clinician accepts or rejects';
      case 'awaiting_payment':
        return paymentReceiptFileName.isNotEmpty
            ? (isArabic
                ? 'مراجعة السداد'
                : 'Review payment proof')
            : (isArabic
                ? 'العميل يرفع إثبات السداد'
                : 'Client uploads payment proof');
      case 'payment_review':
        return isArabic ? 'اعتماد أو رفض السداد' : 'Approve or reject payment';
      case 'session_setup_pending':
        return isArabic
            ? 'مراجعة التجهيز أو فتح الدفع'
            : 'Review setup or open payment';
      case 'session_scheduled':
      case 'session_in_progress':
        return isArabic
            ? 'المتابعة من السطح التشغيلي أو إجراء استرداد'
            : 'Continue from operational surface or recovery action';
      case 'session_completed_pending_reviews':
        return isArabic
            ? 'استكمال التقييمات ثم المراجعة المالية'
            : 'Complete reviews, then financial review';
      case 'payout_pending':
        return accountingReviewStatus == 'confirmed'
            ? (isArabic ? 'تحويل المستحق' : 'Confirm payout')
            : (isArabic ? 'مراجعة محاسبية' : 'Accounting review');
      case 'completed_success':
        return isArabic ? 'الأرشفة المناسبة' : 'Archive in the proper section';
      case 'rejected_admin':
      case 'clinician_rejected':
      case 'reschedule_pending':
      case 'cancellation_pending':
      case 'dispute_pending':
        return isArabic ? 'معالجة استثنائية فقط' : 'Exception handling only';
      default:
        return isArabic ? 'متابعة الحالة' : 'Monitor the state';
    }
  }

  String _ownershipCueLabel({
    required bool isArabic,
    required bool isCenterRequest,
    required String status,
  }) {
    switch (status) {
      case 'center_intake_pending':
      case 'client_update_required':
      case 'awaiting_payment':
        return isArabic ? 'المالك الحالي: العميل' : 'Current owner: client';
      case 'center_follow_up':
      case 'center_recommendation_pending':
        return isArabic ? 'المالك الحالي: المركز' : 'Current owner: center';
      case 'assigned_clinician':
      case 'session_scheduled':
      case 'session_in_progress':
      case 'session_completed_pending_reviews':
        return isCenterRequest
            ? (isArabic
                ? 'المالك الحالي: المركز / العميل'
                : 'Current owner: center / client')
            : (isArabic
                ? 'المالك الحالي: الأخصائي / العميل'
                : 'Current owner: clinician / client');
      case 'payment_review':
      case 'payout_pending':
        return isArabic
            ? 'المالك الحالي: بوابة مالية إدارية'
            : 'Current owner: admin financial gate';
      case 'pending_admin':
      case 'rejected_admin':
      case 'clinician_rejected':
      case 'reschedule_pending':
      case 'cancellation_pending':
      case 'dispute_pending':
        return isArabic
            ? 'المالك الحالي: استثناء إداري'
            : 'Current owner: admin exception';
      default:
        return isArabic
            ? 'المالك الحالي: متابعة من غرفة التحكم'
            : 'Current owner: control-room monitoring';
    }
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
    final status = (data['status'] ?? '').toString().trim();
    final requestKind = _safeText(data, 'requestKind');
    if (status.isEmpty || requestKind.isEmpty) {
      return const SizedBox.shrink();
    }
    final isCenterRequest = requestKind == 'center';
    final canAssignClinician = status == 'pending_admin' &&
        !isCenterRequest &&
        _adminClinicianForwardBridgeEnabled;
    final clientUpdatedAfterCenterFeedback =
        (data['clientUpdatedAfterCenterFeedback'] ?? false) == true;
    final canMoveCenterToFollowUp = isCenterRequest &&
        status == 'pending_admin' &&
        !clientUpdatedAfterCenterFeedback;
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
    final centerAvailabilityRespondedAt =
        _dateText(data['centerAvailabilityRespondedAt']);
    final centerAvailabilityRespondedBy =
        _safeText(data, 'centerAvailabilityRespondedBy');
    final centerAvailabilityNote = _safeText(data, 'centerAvailabilityNote');
    final centerSuggestedAlternativeLabelAr =
        _safeText(data, 'centerSuggestedAlternativeLabelAr');
    final selectedAccommodationKey =
        _safeText(data, 'selectedAccommodationKey');
    final selectedAccommodationLabelAr =
        _safeText(data, 'selectedAccommodationLabelAr');
    final selectedAccommodationPrice =
        _safeText(data, 'selectedAccommodationPrice');
    final selectedAccommodationPricingUnit =
        _safeText(data, 'selectedAccommodationPricingUnit');
    final contract = data['contract'];
    final contractRoom = contract is Map ? contract['room'] : null;
    final contractDuration = contract is Map ? contract['duration'] : null;
    final contractPricing = contract is Map ? contract['pricing'] : null;
    final contractMeta = contract is Map ? contract['meta'] : null;
    final contractStatus =
        contract is Map ? (contract['status'] ?? '').toString().trim() : '';
    final contractVersion =
        contract is Map ? (contract['version'] ?? '').toString().trim() : '';
    final contractRoomLabel = contractRoom is Map
        ? (contractRoom['label'] ?? '').toString().trim()
        : '';
    final contractRoomPrice = contractRoom is Map
        ? (contractRoom['price'] ?? '').toString().trim()
        : '';
    final contractPricingUnit = contractRoom is Map
        ? (contractRoom['pricingUnit'] ?? '').toString().trim()
        : '';
    final contractDurationBasis = contractDuration is Map
        ? (contractDuration['basis'] ?? '').toString().trim()
        : '';
    final contractBaseAmount = contractPricing is Map
        ? (contractPricing['baseAmount'] ?? '').toString().trim()
        : '';
    final contractSource = contractMeta is Map
        ? (contractMeta['source'] ?? '').toString().trim()
        : '';
    final selectedCenterType = _safeText(data, 'selectedCenterType');
    final centerHasDetoxUnit = (data['centerHasDetoxUnit'] ?? false) == true;
    final lastCenterAvailabilityNote =
        _safeText(data, 'lastCenterAvailabilityNote');
    final lastCenterSuggestedAlternativeLabelAr =
        _safeText(data, 'lastCenterSuggestedAlternativeLabelAr');
    final centerRecommendedCareLevel =
        _safeText(data, 'centerRecommendedCareLevel');
    final centerRecommendedStayDays =
        _safeText(data, 'centerRecommendedStayDays');
    final centerNeedsInternalAssessment =
        (data['centerNeedsInternalAssessment'] ?? false) == true;
    final centerRecommendationSubmittedAt =
        _dateText(data['centerRecommendationSubmittedAt']);
    final centerRecommendationSubmittedBy =
        _safeText(data, 'centerRecommendationSubmittedBy');
    final accountingReviewStatus = _safeText(data, 'accountingReviewStatus');
    final grossClientPaidAmount = _safeText(data, 'grossClientPaidAmount');
    final paymentQuotePreparedAt = data['paymentQuotePreparedAt'];
    final appCommissionPercent = _safeText(data, 'appCommissionPercent');
    final appCommissionAmount = _safeText(data, 'appCommissionAmount');
    final netAmountDueToCenter = _safeText(data, 'netAmountDueToCenter');
    final accountingReviewNotes = _safeText(data, 'accountingReviewNotes');
    final canApproveCenter = isCenterRequest &&
        (status == 'center_recommendation_pending' ||
            (status == 'pending_admin' && clientUpdatedAfterCenterFeedback));
    final requestedClinicianId = _safeText(data, 'clinicianId');
    final requestedClinicianName = _safeText(data, 'clinicianName');
    final canReviewPayment = (status == 'payment_review' ||
        paymentStatus == 'submitted_by_client' ||
        (status == 'awaiting_payment' && paymentReceiptFileName.isNotEmpty));
    final canReturnCenterToClient = isCenterRequest &&
        status == 'center_follow_up' &&
        centerAvailabilityStatus == 'unavailable';
    final noQuoteOrPaymentStarted =
        (paymentStatus.isEmpty || paymentStatus == 'not_started') &&
            paymentReceiptFileName.isEmpty &&
            grossClientPaidAmount.isEmpty &&
            paymentQuotePreparedAt == null;
    final canOpenCenterIntake = isCenterRequest &&
        centerAvailabilityStatus == 'available' &&
        (status == 'pending_admin' || status == 'center_follow_up') &&
        !archived &&
        noQuoteOrPaymentStarted &&
        contractStatus == 'draft' &&
        selectedAccommodationKey.isNotEmpty &&
        selectedAccommodationLabelAr.isNotEmpty &&
        selectedAccommodationPrice.isNotEmpty &&
        selectedAccommodationPricingUnit.isNotEmpty;
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
            status == 'clinician_rejected');
    final requestAccent = _requestTypeAccent(isCenterRequest);
    final whyHere = _whyHereLabel(
      isArabic: isArabic,
      isCenterRequest: isCenterRequest,
      status: status,
      centerAvailabilityStatus: centerAvailabilityStatus,
      paymentReceiptFileName: paymentReceiptFileName,
      accountingReviewStatus: accountingReviewStatus,
    );
    final nextStructuredStep = _nextStepLabel(
      isArabic: isArabic,
      isCenterRequest: isCenterRequest,
      status: status,
      centerAvailabilityStatus: centerAvailabilityStatus,
      paymentReceiptFileName: paymentReceiptFileName,
      accountingReviewStatus: accountingReviewStatus,
    );
    final ownershipCue = _ownershipCueLabel(
      isArabic: isArabic,
      isCenterRequest: isCenterRequest,
      status: status,
    );
    final hasRequiredAdminGate = status == 'pending_admin' ||
        canReviewPayment ||
        (!isCenterRequest && status == 'payout_pending') ||
        canRunAccountingReview ||
        canConfirmCenterPayout ||
        (status == 'completed_success' && !archived) ||
        (isCenterRequest && status == 'center_follow_up');
    final hasFallbackActions = canMoveCenterToFollowUp ||
        canAssignClinician ||
        canApproveCenter ||
        canOpenCenterIntake ||
        canReturnCenterToClient ||
        canReturnToPending;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.xl),
          border: Border.all(
            color: requestAccent.withValues(alpha: 0.30),
            width: 2,
          ),
        ),
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
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: isArabic
                              ? WrapAlignment.end
                              : WrapAlignment.start,
                          children: [
                            AppStatusBadge(
                              label: _requestTypeLabel(
                                isArabic,
                                isCenterRequest,
                              ),
                              color: requestAccent,
                            ),
                            AppStatusBadge(
                              label: _statusLabel(status, isArabic),
                              color: _statusColor(status),
                            ),
                            if (isCenterRequest)
                              AppStatusBadge(
                                label: _centerAvailabilityOutcomeLabel(
                                  centerAvailabilityStatus,
                                  isArabic,
                                ),
                                color: _centerAvailabilityOutcomeColor(
                                  centerAvailabilityStatus,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isCenterRequest
                              ? (isArabic
                                  ? 'طلب مركز عبر الإدارة'
                                  : 'Center request via admin')
                              : (isArabic
                                  ? 'طلب أخصائي'
                                  : 'Specialist booking request'),
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.mist,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AppSectionPanel(
                color: Colors.white.withValues(alpha: 0.70),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic
                          ? 'مراقبة / عوائق / الخطوة التالية'
                          : 'Monitoring / Blockers / Next Step',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    _buildDetailLine(
                      context: context,
                      isArabic: isArabic,
                      arLabel: 'سبب وجود الطلب هنا',
                      enLabel: 'Why this is here',
                      value: whyHere,
                    ),
                    _buildDetailLine(
                      context: context,
                      isArabic: isArabic,
                      arLabel: 'الخطوة المنظمة التالية',
                      enLabel: 'Next structured step',
                      value: nextStructuredStep,
                    ),
                    _buildDetailLine(
                      context: context,
                      isArabic: isArabic,
                      arLabel: 'إشارة الملكية',
                      enLabel: 'Ownership cue',
                      value: ownershipCue,
                    ),
                  ],
                ),
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
                value: isCenterRequest
                    ? _centerAvailabilityOutcomeLabel(
                        centerAvailabilityStatus,
                        isArabic,
                      )
                    : centerAvailabilityStatus,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'وقت رد المركز',
                enLabel: 'Center responded at',
                value: centerAvailabilityRespondedAt,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'معرف المركز صاحب الرد',
                enLabel: 'Center responded by',
                value: centerAvailabilityRespondedBy,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'نوع الإقامة المختار',
                enLabel: 'Selected accommodation',
                value: selectedAccommodationLabelAr,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'حالة مسودة العقد',
                enLabel: 'Contract draft status',
                value: contractStatus,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'غرفة العقد',
                enLabel: 'Contract room',
                value: contractRoomLabel,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'سعر غرفة العقد',
                enLabel: 'Contract room price',
                value: contractRoomPrice,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'وحدة التسعير',
                enLabel: 'Pricing unit',
                value: contractPricingUnit,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'أساس المدة',
                enLabel: 'Duration basis',
                value: contractDurationBasis,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'المبلغ الأساسي للعقد',
                enLabel: 'Contract base amount',
                value: contractBaseAmount,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'إصدار العقد',
                enLabel: 'Contract version',
                value: contractVersion,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'مصدر العقد',
                enLabel: 'Contract source',
                value: contractSource,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'نوع المركز',
                enLabel: 'Center type',
                value: selectedCenterType.isEmpty
                    ? ''
                    : _centerTypeLabel(selectedCenterType, isArabic),
              ),
              if (centerHasDetoxUnit && selectedCenterType != 'detox')
                _buildDetailLine(
                  context: context,
                  isArabic: isArabic,
                  arLabel: 'قسم أعراض الانسحاب',
                  enLabel: 'Withdrawal unit',
                  value: isArabic ? 'متاح داخليًا' : 'Available internally',
                ),
              if (clientUpdatedAfterCenterFeedback)
                _buildDetailLine(
                  context: context,
                  isArabic: isArabic,
                  arLabel: 'الاعتماد المباشر',
                  enLabel: 'Direct approval',
                  value: isArabic
                      ? 'مسموح به دون إعادة الإرسال للمركز'
                      : 'Allowed without returning to center',
                ),
              if (centerRecommendedCareLevel.isNotEmpty ||
                  centerRecommendedStayDays.isNotEmpty)
                _buildDetailLine(
                  context: context,
                  isArabic: isArabic,
                  arLabel: 'حدود المرحلة',
                  enLabel: 'Stage boundary',
                  value: isArabic
                      ? 'توصية المركز مستلمة؛ الخطوة التالية تجهيز إداري فقط وليست اعتماد دفع.'
                      : 'Center recommendation received; next step is admin setup, not payment approval.',
                ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'مصدر التوصية',
                enLabel: 'Recommendation source',
                value: centerRecommendedCareLevel.isEmpty &&
                        centerRecommendedStayDays.isEmpty
                    ? ''
                    : (isArabic ? 'المركز' : 'Center'),
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'مستوى الرعاية الموصى به',
                enLabel: 'Recommended care level',
                value: centerRecommendedCareLevel.isEmpty
                    ? ''
                    : _centerCareLevelLabel(
                        centerRecommendedCareLevel,
                        isArabic,
                      ),
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'مدة الإقامة الموصى بها',
                enLabel: 'Recommended stay days',
                value: centerRecommendedStayDays,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'يحتاج تقييمًا داخليًا',
                enLabel: 'Needs internal assessment',
                value: centerRecommendedCareLevel.isEmpty &&
                        centerRecommendedStayDays.isEmpty
                    ? ''
                    : (centerNeedsInternalAssessment
                        ? (isArabic ? 'نعم' : 'Yes')
                        : (isArabic ? 'لا' : 'No')),
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'وقت إرسال توصية المركز',
                enLabel: 'Recommendation submitted at',
                value: centerRecommendationSubmittedAt,
              ),
              _buildDetailLine(
                context: context,
                isArabic: isArabic,
                arLabel: 'مرسل توصية المركز',
                enLabel: 'Recommendation submitted by',
                value: centerRecommendationSubmittedBy,
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
                    : (isArabic
                        ? 'رابط الجلسة متاح'
                        : 'Session link available'),
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
              if (hasRequiredAdminGate) ...[
                const SizedBox(height: 12),
                Text(
                  isArabic ? 'بوابة إدارية مطلوبة' : 'Required Admin Gate',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment:
                      isArabic ? WrapAlignment.end : WrapAlignment.start,
                  children: [
                    if (status == 'pending_admin')
                      OutlinedButton.icon(
                        onPressed: busy
                            ? null
                            : () => _rejectRequest(
                                  requestId,
                                  isCenterRequest: isCenterRequest,
                                ),
                        icon: const Icon(Icons.cancel_outlined),
                        label: Text(isArabic ? 'رفض' : 'Reject'),
                      ),
                    if (canReviewPayment)
                      FilledButton.icon(
                        onPressed:
                            busy ? null : () => _approvePayment(requestId),
                        icon: const Icon(Icons.verified_outlined),
                        label: Text(
                          isArabic ? 'اعتماد السداد' : 'Approve payment',
                        ),
                      ),
                    if (canReviewPayment)
                      OutlinedButton.icon(
                        onPressed:
                            busy ? null : () => _rejectPayment(requestId),
                        icon: const Icon(Icons.cancel_outlined),
                        label: Text(
                          isArabic ? 'رفض السداد' : 'Reject payment',
                        ),
                      ),
                    if (!isCenterRequest && status == 'payout_pending')
                      FilledButton.icon(
                        onPressed: busy
                            ? null
                            : () => _confirmClinicianPayout(requestId),
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
                            : () =>
                                _confirmCenterAccountingReview(requestId, data),
                        icon: const Icon(Icons.calculate_outlined),
                        label: Text(
                          isArabic ? 'مراجعة محاسبية' : 'Accounting review',
                        ),
                      ),
                    if (canConfirmCenterPayout)
                      FilledButton.icon(
                        onPressed:
                            busy ? null : () => _confirmCenterPayout(requestId),
                        icon:
                            const Icon(Icons.account_balance_wallet_outlined),
                        label: Text(
                          isArabic
                              ? 'تم تحويل مستحق المركز'
                              : 'Confirm center payout',
                        ),
                      ),
                    if (status == 'completed_success' && !archived)
                      FilledButton.tonalIcon(
                        onPressed: busy
                            ? null
                            : () => _sendToSessionArchive(requestId),
                        icon: const Icon(Icons.video_call_outlined),
                        label: Text(
                          isArabic ? 'أرشفة جلسية' : 'Session archive',
                        ),
                      ),
                    if (status == 'completed_success' && !archived)
                      FilledButton.tonalIcon(
                        onPressed: busy
                            ? null
                            : () => _sendToFinancialArchive(requestId),
                        icon:
                            const Icon(Icons.account_balance_wallet_outlined),
                        label: Text(
                          isArabic ? 'أرشفة مالية' : 'Financial archive',
                        ),
                      ),
                    if (isCenterRequest && status == 'center_follow_up')
                      OutlinedButton.icon(
                        onPressed: busy
                            ? null
                            : () => _rejectRequest(
                                  requestId,
                                  isCenterRequest: true,
                                ),
                        icon: const Icon(Icons.cancel_outlined),
                        label: Text(isArabic ? 'رفض' : 'Reject'),
                      ),
                  ],
                ),
              ],
              if (hasFallbackActions) ...[
                const SizedBox(height: 12),
                AppSectionPanel(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.34),
                  padding: EdgeInsets.zero,
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    title: Text(
                      isArabic
                          ? 'إجراءات الاسترداد / التوافق'
                          : 'Fallback / Compatibility Actions',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    subtitle: Text(
                      isArabic
                          ? 'تُستخدم فقط للاستثناءات، استرداد المسار، أو سجلات التوافق القديمة؛ وليست المسار التشغيلي الطبيعي.'
                          : 'Use only for exceptions, flow recovery, or legacy compatibility records; not the normal operational path.',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment:
                            isArabic ? WrapAlignment.end : WrapAlignment.start,
                        children: [
                          if (canMoveCenterToFollowUp)
                            FilledButton.icon(
                              onPressed: busy
                                  ? null
                                  : () => _moveCenterToFollowUp(requestId),
                              icon: const Icon(Icons.fact_check_outlined),
                              label: Text(
                                isArabic
                                    ? 'نقل للمتابعة'
                                    : 'Move to follow-up',
                              ),
                            ),
                          if (canAssignClinician)
                            FilledButton.tonalIcon(
                              onPressed: busy ||
                                      requestedClinicianId.isEmpty ||
                                      requestedClinicianName.isEmpty
                                  ? null
                                  : () => _assignToClinician(
                                        requestId: requestId,
                                      ),
                              icon:
                                  const Icon(Icons.forward_to_inbox_outlined),
                              label: Text(
                                isArabic
                                    ? 'استعادة توافق: تحويل للأخصائي'
                                    : 'Compatibility forward',
                              ),
                            ),
                          if (canApproveCenter)
                            FilledButton.icon(
                              onPressed: busy
                                  ? null
                                  : () => _approveCenterRequest(requestId),
                              icon: const Icon(Icons.verified_outlined),
                              label: Text(
                                isArabic
                                    ? 'اعتماد وفتح الجدولة'
                                    : 'Approve and open scheduling',
                              ),
                            ),
                          if (canOpenCenterIntake)
                            FilledButton.tonalIcon(
                              onPressed: busy
                                  ? null
                                  : () => _openCenterIntakeStep(requestId),
                              icon: const Icon(
                                Icons.assignment_turned_in_outlined,
                              ),
                              label: Text(
                                isArabic
                                    ? 'فتح التقييم الأولي'
                                    : 'Open intake review',
                              ),
                            ),
                          if (canReturnCenterToClient)
                            OutlinedButton.icon(
                              onPressed: busy
                                  ? null
                                  : () => _returnCenterRequestToClient(
                                        requestId,
                                        data,
                                      ),
                              icon: const Icon(Icons.reply_outlined),
                              label: Text(
                                isArabic
                                    ? 'إرجاع للعميل للتعديل'
                                    : 'Return to client for edit',
                              ),
                            ),
                          if (canReturnToPending)
                            TextButton.icon(
                              onPressed: busy
                                  ? null
                                  : () => _returnToPending(requestId),
                              icon: const Icon(Icons.refresh),
                              label: Text(
                                isArabic
                                    ? 'إرجاع للبندنج'
                                    : 'Return to pending',
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
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
            stream: _bookingDocsStreamRef,
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
                stream: _cliniciansStreamRef,
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
                  if (_tab == 'pending_admin') {
                    allDocs.sort((a, b) {
                      final aCenter =
                          (a.data()['requestKind'] ?? '').toString() ==
                              'center';
                      final bCenter =
                          (b.data()['requestKind'] ?? '').toString() ==
                              'center';
                      if (aCenter != bCenter) {
                        return aCenter ? -1 : 1;
                      }

                      final aCreatedAt = a.data()['createdAt'];
                      final bCreatedAt = b.data()['createdAt'];
                      if (aCreatedAt is Timestamp && bCreatedAt is Timestamp) {
                        return bCreatedAt.compareTo(aCreatedAt);
                      }
                      return 0;
                    });
                  }

                  return ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      _buildDomainAdvisoryBanner(context, isArabic),
                      AppSurfaceCard(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: isArabic
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic
                                  ? 'لوحة مراقبة الطلبات والاستثناءات'
                                  : 'Request Monitoring & Exception Board',
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              isArabic
                                  ? 'هذه الصفحة لمراقبة الطلبات والعوائق والبوابات المالية والاستثناءات؛ وليست ملكية تشغيل يومية للمسارات المنظمة.'
                                  : 'This page monitors requests, blockers, financial gates, and exceptions; it is not daily operational ownership of structured flows.',
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.obsidian
                                        .withValues(alpha: 0.72),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Wrap(
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
                                    isArabic
                                        ? item['labelAr']!
                                        : item['labelEn']!,
                                  ),
                                  onSelected: (_) => setState(() => _tab = key),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_tab == 'pending_admin')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AppSectionPanel(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            color: const Color(0xFFF8FAFC),
                            child: Text(
                              isArabic
                                  ? 'تعرض هذه المرحلة طلبات المراكز وحالات الأخصائي القديمة فقط. طلبات الأخصائي الجديدة تظهر مباشرة في تبويب بانتظار رد الأخصائي.'
                                  : 'This stage shows center requests and legacy clinician fallback records only. New clinician requests appear directly under Awaiting clinician.',
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.obsidian),
                            ),
                          ),
                        ),
                      if (_tab == 'assigned_clinician')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AppSectionPanel(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            color: const Color(0xFFF8FAFC),
                            child: Text(
                              isArabic
                                  ? 'هذا هو المسار الطبيعي لطلبات الأخصائي الجديدة. مسار التحويل الإداري باقٍ فقط لاستعادة التوافق مع السجلات القديمة.'
                                  : 'This is the normal path for new clinician requests. Admin forwarding remains only as a compatibility fallback for older records.',
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.obsidian),
                            ),
                          ),
                        ),
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
