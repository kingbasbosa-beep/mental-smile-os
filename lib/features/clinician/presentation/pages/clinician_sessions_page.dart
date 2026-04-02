import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class ClinicianSessionsPage extends StatelessWidget {
  const ClinicianSessionsPage({super.key});

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  bool _isSessionRelated(Map<String, dynamic> data) {
    final status = (data['status'] ?? '').toString();
    return status == 'session_setup_pending' ||
        status == 'session_scheduled' ||
        status == 'session_in_progress' ||
        status == 'session_completed_pending_reviews' ||
        status == 'completed_success' ||
        status == 'reschedule_pending' ||
        status == 'payout_pending';
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'session_setup_pending':
        return isArabic ? 'بانتظار تجهيز الجلسة' : 'Session setup pending';
      case 'session_scheduled':
        return isArabic ? 'جلسة مجدولة' : 'Session scheduled';
      case 'session_in_progress':
        return isArabic ? 'الجلسة جارية' : 'Session in progress';
      case 'session_completed_pending_reviews':
        return isArabic ? 'بانتظار التقييمات' : 'Pending reviews';
      case 'payout_pending':
        return isArabic ? 'بانتظار التحويل المالي' : 'Payout pending';
      case 'completed_success':
        return isArabic ? 'منتهية بنجاح' : 'Completed successfully';
      case 'reschedule_pending':
        return isArabic ? 'بانتظار إعادة الجدولة' : 'Reschedule pending';
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'session_setup_pending':
        return const Color(0xFF6C55B3);
      case 'session_scheduled':
      case 'session_in_progress':
        return const Color(0xFF2E5AAC);
      case 'session_completed_pending_reviews':
      case 'payout_pending':
      case 'completed_success':
        return const Color(0xFF1F9D63);
      case 'reschedule_pending':
        return const Color(0xFFE39B2E);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  bool _canClinicianReview(Map<String, dynamic> data) {
    final status = (data['status'] ?? '').toString();
    final sessionStatus = (data['sessionStatus'] ?? '').toString();
    final reviewStatus = (data['reviewStatus'] ?? '').toString();
    final clinicianReviewSubmitted =
        (data['clinicianReviewSubmitted'] ?? false) == true;

    if (clinicianReviewSubmitted) return false;

    return status == 'session_completed_pending_reviews' ||
        status == 'payout_pending' ||
        (sessionStatus == 'completed' &&
            (reviewStatus == 'pending_reviews' || reviewStatus == 'partial'));
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      final d = value.toDate();
      final day = d.day.toString().padLeft(2, '0');
      final month = d.month.toString().padLeft(2, '0');
      final year = d.year.toString();
      final hour = d.hour.toString().padLeft(2, '0');
      final minute = d.minute.toString().padLeft(2, '0');
      return '$hour:$minute  $day-$month-$year';
    }
    return '';
  }

  List<Map<String, dynamic>> _normalizeDocs(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    String source,
  ) {
    return docs.map((doc) {
      return {
        ...doc.data(),
        '_id': doc.id,
        '_source': source,
      };
    }).toList();
  }

  DateTime _sortMoment(Map<String, dynamic> data) {
    final value = data['updatedAt'] ?? data['createdAt'];
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  Map<String, dynamic> _preferredDoc(
    Map<String, dynamic> current,
    Map<String, dynamic> incoming,
  ) {
    final currentDate = _sortMoment(current);
    final incomingDate = _sortMoment(incoming);
    if (incomingDate.isAfter(currentDate)) return incoming;
    if (currentDate.isAfter(incomingDate)) return current;

    final currentSource = (current['_source'] ?? '').toString();
    final incomingSource = (incoming['_source'] ?? '').toString();
    if (incomingSource == 'booking_requests' &&
        currentSource != 'booking_requests') {
      return incoming;
    }
    return current;
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final scheme = Theme.of(context).colorScheme;
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isArabic ? 'جلسات الأخصائي' : 'Clinician Sessions'),
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: uid.isEmpty
            ? Center(
                child: Text(
                  isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first',
                ),
              )
            : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('booking_requests')
                    .where('assignedClinicianId', isEqualTo: uid)
                    .snapshots(),
                builder: (context, snapA) {
                  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('bookingRequests')
                        .where('assignedClinicianId', isEqualTo: uid)
                        .snapshots(),
                    builder: (context, snapB) {
                      if (snapA.hasError && snapB.hasError) {
                        return Center(
                          child: Text(
                            isArabic
                                ? 'تعذر تحميل الجلسات'
                                : 'Unable to load sessions',
                          ),
                        );
                      }

                      if (!snapA.hasData && !snapB.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final all = <Map<String, dynamic>>[];

                      if (snapA.hasData) {
                        all.addAll(_normalizeDocs(
                            snapA.data!.docs, 'booking_requests'));
                      }
                      if (snapB.hasData) {
                        all.addAll(_normalizeDocs(
                            snapB.data!.docs, 'bookingRequests'));
                      }

                      final unique = <String, Map<String, dynamic>>{};
                      for (final item in all) {
                        final id = (item['_id'] ?? '').toString();
                        if (id.isEmpty) continue;
                        final existing = unique[id];
                        unique[id] = existing == null
                            ? item
                            : _preferredDoc(existing, item);
                      }

                      final docs = unique.values
                          .where(_isSessionRelated)
                          .toList()
                        ..sort((a, b) {
                          final aTs = a['updatedAt'] ?? a['createdAt'];
                          final bTs = b['updatedAt'] ?? b['createdAt'];
                          DateTime ad = DateTime.fromMillisecondsSinceEpoch(0);
                          DateTime bd = DateTime.fromMillisecondsSinceEpoch(0);
                          if (aTs is Timestamp) ad = aTs.toDate();
                          if (bTs is Timestamp) bd = bTs.toDate();
                          return bd.compareTo(ad);
                        });

                      if (docs.isEmpty) {
                        return Center(
                          child: Text(
                            isArabic
                                ? 'لا توجد جلسات ظاهرة حاليًا'
                                : 'No visible sessions yet',
                          ),
                        );
                      }

                      return ListView(
                        padding: const EdgeInsets.all(16),
                        children: docs.map((data) {
                          final requestId = (data['_id'] ?? '').toString();
                          final status = (data['status'] ?? '').toString();
                          final clientName =
                              (data['clientName'] ?? 'Client').toString();
                          final sessionDate =
                              (data['sessionDateText'] ?? '').toString();
                          final sessionLink =
                              (data['sessionLink'] ?? '').toString();
                          final sessionCode =
                              (data['sessionCode'] ?? '').toString();
                          final adminNotes =
                              (data['sessionAdminNotes'] ?? '').toString();
                          final createdAt = _dateText(data['createdAt']);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: scheme.outline.withValues(alpha: 0.14),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: isArabic
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                          ),
                                          if (createdAt.isNotEmpty) ...[
                                            const SizedBox(height: 6),
                                            Text(
                                              isArabic
                                                  ? 'تاريخ الطلب: $createdAt'
                                                  : 'Request date: $createdAt',
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _statusColor(status)
                                            .withValues(alpha: 0.12),
                                        borderRadius:
                                            BorderRadius.circular(999),
                                      ),
                                      child: Text(
                                        _statusLabel(status, isArabic),
                                        style: TextStyle(
                                          color: _statusColor(status),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                if (sessionDate.trim().isNotEmpty)
                                  Text(
                                    isArabic
                                        ? 'موعد الجلسة: $sessionDate'
                                        : 'Session date: $sessionDate',
                                  ),
                                if (sessionLink.trim().isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  SelectableText(
                                    isArabic
                                        ? 'رابط الجلسة: $sessionLink'
                                        : 'Session link: $sessionLink',
                                  ),
                                ],
                                if (sessionCode.trim().isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  SelectableText(
                                    isArabic
                                        ? 'كود الجلسة: $sessionCode'
                                        : 'Session code: $sessionCode',
                                  ),
                                ],
                                if (adminNotes.trim().isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    isArabic
                                        ? 'ملاحظات الإدارة: $adminNotes'
                                        : 'Admin notes: $adminNotes',
                                  ),
                                ],
                                if (sessionDate.trim().isEmpty &&
                                    sessionLink.trim().isEmpty &&
                                    sessionCode.trim().isEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    isArabic
                                        ? 'لم يتم تجهيز بيانات الجلسة بعد.'
                                        : 'Session details are not prepared yet.',
                                  ),
                                ],
                                if (_canClinicianReview(data)) ...[
                                  const SizedBox(height: 14),
                                  FilledButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        Routes.sessionReview,
                                        arguments: {
                                          'requestId': requestId,
                                          'reviewerType': 'clinician',
                                        },
                                      );
                                    },
                                    icon:
                                        const Icon(Icons.rate_review_outlined),
                                    label: Text(
                                      isArabic
                                          ? 'تقييم الجلسة'
                                          : 'Review session',
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
