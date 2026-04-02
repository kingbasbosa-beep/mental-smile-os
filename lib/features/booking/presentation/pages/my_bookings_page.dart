import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_booking_request_page.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  String _viewFilter = 'current';

  static const List<Map<String, String>> _tabs = [
    {'key': 'current', 'label': 'الجارية'},
    {'key': 'action_needed', 'label': 'تحتاج منك إجراء'},
    {'key': 'completed', 'label': 'المكتملة'},
    {'key': 'closed', 'label': 'المغلقة'},
  ];

  Widget _statusTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: [
          for (final it in _tabs)
            ChoiceChip(
              label: Text(it['label']!),
              selected: _viewFilter == it['key'],
              onSelected: (value) => setState(() => _viewFilter = it['key']!),
            ),
        ],
      ),
    );
  }

  Query<Map<String, dynamic>> _query(String uid) {
    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('clientId', isEqualTo: uid);
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _requestsStream(
    String uid,
  ) {
    final primary = _query(uid).snapshots();
    final legacy = FirebaseFirestore.instance
        .collection('bookingRequests')
        .where('clientId', isEqualTo: uid)
        .snapshots();

    return Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>.multi(
      (controller) {
        QuerySnapshot<Map<String, dynamic>>? primarySnapshot;
        QuerySnapshot<Map<String, dynamic>>? legacySnapshot;

        void emitMerged() {
          final merged =
              <String, QueryDocumentSnapshot<Map<String, dynamic>>>{};

          if (legacySnapshot != null) {
            for (final doc in legacySnapshot!.docs) {
              merged[doc.id] = doc;
            }
          }

          if (primarySnapshot != null) {
            for (final doc in primarySnapshot!.docs) {
              merged[doc.id] = doc;
            }
          }

          final docs = merged.values.toList()..sort(_compareCreatedAt);
          controller.add(docs);
        }

        final primarySub = primary.listen(
          (snapshot) {
            primarySnapshot = snapshot;
            emitMerged();
          },
          onError: controller.addError,
        );

        final legacySub = legacy.listen(
          (snapshot) {
            legacySnapshot = snapshot;
            emitMerged();
          },
          onError: controller.addError,
        );

        controller.onCancel = () async {
          await primarySub.cancel();
          await legacySub.cancel();
        };
      },
    );
  }

  String _fmtTime(dynamic v) {
    try {
      DateTime? dt;
      if (v == null) return '';
      if (v is Timestamp) dt = v.toDate();
      if (v is DateTime) dt = v;
      if (v is String) dt = DateTime.tryParse(v);
      if (dt == null) return v.toString();

      final y = dt.year.toString().padLeft(4, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final d = dt.day.toString().padLeft(2, '0');
      final hh = dt.hour.toString().padLeft(2, '0');
      final mm = dt.minute.toString().padLeft(2, '0');
      return '$y-$m-$d $hh:$mm';
    } catch (_) {
      return v.toString();
    }
  }

  DateTime? _asDateTime(dynamic v) {
    if (v == null) return null;
    if (v is Timestamp) return v.toDate();
    if (v is DateTime) return v;
    if (v is String) return DateTime.tryParse(v);
    return null;
  }

  String _statusLabel(String requestKind, String status) {
    final isCenter = requestKind == 'center';

    if (isCenter) {
      switch (status) {
        case 'pending_admin':
          return 'طلبك قيد المراجعة';
        case 'center_follow_up':
          return 'الطلب لدى المركز للتحقق من التوفر';
        case 'client_update_required':
          return 'المركز طلب تعديل نوع الإقامة';
        case 'approved':
          return 'تمت الموافقة على طلبك';
        case 'awaiting_payment':
          return 'بانتظار التحويل المالي من العميل';
        case 'payment_review':
          return 'إثبات الدفع قيد المراجعة';
        case 'session_setup_pending':
          return 'بانتظار تأكيد الحجز والإقامة';
        case 'session_scheduled':
          return 'تم تأكيد الحجز والإقامة';
        case 'session_in_progress':
          return 'الإقامة أو البرنامج جارٍ';
        case 'session_completed_pending_reviews':
          return 'بانتظار التقييمات';
        case 'payout_pending':
          return 'بانتظار الإغلاق المالي';
        case 'rejected':
        case 'rejected_admin':
          return 'تعذر قبول الطلب';
        case 'completed_success':
          return 'اكتملت العملية';
        default:
          return 'يتم تحديث حالة الطلب';
      }
    }

    switch (status) {
      case 'pending_admin':
        return 'طلبك قيد المراجعة';
      case 'assigned_clinician':
        return 'يجري تنسيق الطلب';
      case 'awaiting_payment':
        return 'يرجى رفع إثبات التحويل';
      case 'payment_review':
        return 'إثبات الدفع قيد المراجعة';
      case 'session_setup_pending':
        return 'جارٍ تجهيز الجلسة';
      case 'session_scheduled':
        return 'تم تحديد الجلسة';
      case 'session_in_progress':
        return 'الجلسة جارية';
      case 'session_completed_pending_reviews':
        return 'بانتظار إغلاق الجلسة';
      case 'payout_pending':
        return 'اكتملت الجلسة وبانتظار الإغلاق';
      case 'completed_success':
        return 'اكتمل الطلب';
      case 'rejected_admin':
        return 'تعذر قبول الطلب';
      case 'clinician_rejected':
        return 'تعذر تأكيد الأخصائي';
      case 'reschedule_pending':
        return 'يجري ترتيب موعد جديد';
      case 'cancellation_pending':
        return 'طلب الإلغاء قيد المراجعة';
      case 'dispute_pending':
        return 'تم استلام الشكوى';
      default:
        return 'يتم تحديث حالة الطلب';
    }
  }

  bool _matchesClientView(String status) {
    switch (_viewFilter) {
      case 'action_needed':
        return status == 'awaiting_payment' || status == 'client_update_required';
      case 'completed':
        return status == 'completed_success';
      case 'closed':
        return status == 'rejected' ||
            status == 'rejected_admin' ||
            status == 'clinician_rejected' ||
            status == 'cancellation_pending' ||
            status == 'dispute_pending';
      case 'current':
      default:
        return status != 'awaiting_payment' &&
            status != 'rejected' &&
            status != 'completed_success' &&
            status != 'rejected_admin' &&
            status != 'clinician_rejected' &&
            status != 'cancellation_pending' &&
            status != 'dispute_pending';
    }
  }

  int _compareCreatedAt(
    QueryDocumentSnapshot<Map<String, dynamic>> a,
    QueryDocumentSnapshot<Map<String, dynamic>> b,
  ) {
    final da = _asDateTime(a.data()['createdAt']);
    final db = _asDateTime(b.data()['createdAt']);
    if (da == null && db == null) return 0;
    if (da == null) return 1;
    if (db == null) return -1;
    return db.compareTo(da);
  }

  String _badgeLabel(String requestKind, String status) {
    return _statusLabel(requestKind, status);
  }

  String _requestTypeLabel(bool isCenter) {
    return isCenter ? 'طلب مركز' : 'طلب أخصائي';
  }

  List<String> _clientDetails(Map<String, dynamic> data) {
    final requestKind = (data['requestKind'] ?? 'clinician').toString();
    final isCenter = requestKind == 'center';
    final status = (data['status'] ?? '').toString();
    final note = (data['note'] ?? '').toString();
    final createdAt = _fmtTime(data['createdAt']);
    final approvedSlot = (data['approvedSlot'] ?? '').toString();
    final rejectReason = (data['rejectReason'] ?? '').toString();
    final selectedAccommodationLabelAr =
        (data['selectedAccommodationLabelAr'] ?? '').toString();
    final lastCenterAvailabilityNote =
        (data['lastCenterAvailabilityNote'] ?? '').toString();
    final lastCenterSuggestedAlternativeLabelAr =
        (data['lastCenterSuggestedAlternativeLabelAr'] ?? '').toString();
    final paymentReceiptFileName =
        (data['paymentReceiptFileName'] ?? '').toString();
    final paymentClientNote = (data['paymentClientNote'] ?? '').toString();
    final sessionDateText = (data['sessionDateText'] ?? '').toString();
    final sessionLink = (data['sessionLink'] ?? '').toString();
    final sessionCode = (data['sessionCode'] ?? '').toString();
    final finalReviewPercentage =
        ((data['finalReviewPercentage'] ?? 0) as num).toDouble();

    return <String>[
      _requestTypeLabel(isCenter),
      if (createdAt.isNotEmpty) 'تاريخ الطلب: $createdAt',
      if (approvedSlot.isNotEmpty) 'الموعد المعتمد: $approvedSlot',
      if (selectedAccommodationLabelAr.isNotEmpty)
        'نوع الإقامة: $selectedAccommodationLabelAr',
      if (lastCenterAvailabilityNote.isNotEmpty)
        'ملاحظة المركز الأخيرة: $lastCenterAvailabilityNote',
      if (lastCenterSuggestedAlternativeLabelAr.isNotEmpty)
        'البديل المقترح: $lastCenterSuggestedAlternativeLabelAr',
      if (sessionDateText.isNotEmpty) 'موعد الجلسة: $sessionDateText',
      if (sessionCode.isNotEmpty) 'كود الجلسة: $sessionCode',
      if (paymentReceiptFileName.isNotEmpty)
        'مرجع إثبات الدفع: $paymentReceiptFileName',
      if (paymentClientNote.isNotEmpty) 'ملاحظة الدفع: $paymentClientNote',
      if (rejectReason.isNotEmpty) 'سبب التعذر: $rejectReason',
      if (sessionLink.isNotEmpty && status == 'session_scheduled')
        'رابط الجلسة متاح',
      if (note.isNotEmpty) 'ملاحظتك: $note',
      if (finalReviewPercentage > 0)
        'التقييم النهائي: ${finalReviewPercentage.toStringAsFixed(1)}%',
    ];
  }

  Color _badgeTint(String requestKind, String status) {
    final isCenter = requestKind == 'center';
    if (isCenter) {
      switch (status) {
        case 'approved':
          return Colors.green.withValues(alpha: 0.10);
        case 'rejected':
        case 'rejected_admin':
          return Colors.red.withValues(alpha: 0.10);
        case 'center_follow_up':
          return Colors.orange.withValues(alpha: 0.10);
        default:
          return Colors.blueGrey.withValues(alpha: 0.10);
      }
    }

    switch (status) {
      case 'completed_success':
        return Colors.green.withValues(alpha: 0.10);
      case 'rejected_admin':
      case 'clinician_rejected':
      case 'cancellation_pending':
      case 'dispute_pending':
        return Colors.red.withValues(alpha: 0.10);
      case 'awaiting_payment':
      case 'payment_review':
      case 'reschedule_pending':
      case 'payout_pending':
        return Colors.orange.withValues(alpha: 0.10);
      case 'session_setup_pending':
      case 'session_scheduled':
      case 'session_in_progress':
        return Colors.blue.withValues(alpha: 0.10);
      default:
        return Colors.blueGrey.withValues(alpha: 0.10);
    }
  }

  Widget _emptyState() {
    String text;
    switch (_viewFilter) {
      case 'action_needed':
        text = 'لا توجد طلبات تحتاج منك إجراء الآن';
        break;
      case 'completed':
        text = 'لا توجد طلبات مكتملة بعد';
        break;
      case 'closed':
        text = 'لا توجد طلبات مغلقة';
        break;
      case 'current':
      default:
        text = 'لا توجد طلبات جارية الآن';
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final u = FirebaseAuth.instance.currentUser;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: 'طلباتي',
        ),
        body: Column(
          children: [
            _statusTabs(context),
            Expanded(
              child: (u == null)
                  ? const Center(child: Text('سجّل الدخول أولًا'))
                  : StreamBuilder<
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                      stream: _requestsStream(u.uid),
                      builder: (context, snap) {
                        if (snap.hasError) {
                          return Center(
                            child: Text('خطأ: ${snap.error}'),
                          );
                        }
                        if (!snap.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final docs = snap.data ?? const [];
                        if (docs.isEmpty) {
                          return _emptyState();
                        }

                        final deduped = <String,
                            QueryDocumentSnapshot<Map<String, dynamic>>>{};

                        for (final doc in docs) {
                          final d = doc.data();
                          final kind =
                              (d['requestKind'] ?? 'clinician').toString();
                          final requestGroupId =
                              (d['requestGroupId'] ?? '').toString();
                          final centerId = (d['centerId'] ?? '').toString();
                          final clinicianId = (d['assignedClinicianId'] ??
                                  d['clinicianId'] ??
                                  '')
                              .toString();
                          final createdAt = _fmtTime(d['createdAt']);

                          final key = kind == 'center'
                              ? (requestGroupId.isNotEmpty
                                  ? 'center-group|$requestGroupId'
                                  : 'center|$centerId|$createdAt')
                              : 'clinician|$clinicianId|$createdAt';

                          deduped.putIfAbsent(key, () => doc);
                        }

                        final visibleDocs = deduped.values.toList()
                          ..retainWhere((doc) {
                            final data = doc.data();
                            final status = (data['status'] ?? '').toString();
                            return _matchesClientView(status);
                          })
                          ..sort(_compareCreatedAt);

                        if (visibleDocs.isEmpty) {
                          return _emptyState();
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: visibleDocs.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, i) {
                            final d = visibleDocs[i].data();

                            final requestKind =
                                (d['requestKind'] ?? 'clinician').toString();
                            final isCenter = requestKind == 'center';
                            final clinicianName = (d['assignedClinicianName'] ??
                                    d['clinicianName'] ??
                                    '')
                                .toString();
                            final centerName =
                                (d['centerName'] ?? '').toString();
                            final status = (d['status'] ?? '').toString();

                            final title = isCenter
                                ? (centerName.isEmpty ? 'طلب مركز' : centerName)
                                : (clinicianName.isEmpty
                                    ? 'الأخصائي'
                                    : clinicianName);

                            final subtitleParts = _clientDetails(d);

                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outline
                                      .withValues(alpha: 0.10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                subtitleParts.join(' • '),
                                                style: const TextStyle(
                                                  height: 1.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _badgeTint(
                                              requestKind,
                                              status,
                                            ),
                                            border: Border.all(
                                              color: Colors.black12,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(999),
                                          ),
                                          child: Text(
                                            _badgeLabel(requestKind, status),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isCenter &&
                                        status == 'client_update_required') ...[
                                      const SizedBox(height: 12),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: FilledButton.icon(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              Routes.centerBookingRequest,
                                              arguments:
                                                  CenterBookingRequestArgs(
                                                    centerId:
                                                        (d['centerId'] ?? '')
                                                            .toString(),
                                                    centerName: centerName,
                                                    existingRequestId:
                                                        visibleDocs[i].id,
                                                  ),
                                            );
                                          },
                                          icon:
                                              const Icon(Icons.edit_outlined),
                                          label:
                                              const Text('تعديل نوع الإقامة'),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
