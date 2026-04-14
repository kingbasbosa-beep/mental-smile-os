import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminSessionReportPage extends StatelessWidget {
  const AdminSessionReportPage({super.key});

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  Future<Map<String, dynamic>?> _loadRequest(String requestId) async {
    final db = FirebaseFirestore.instance;

    final a = await db.collection('booking_requests').doc(requestId).get();
    if (a.exists && a.data() != null) {
      return {
        '_source': 'booking_requests',
        '_id': a.id,
        ...a.data()!,
      };
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> _loadSessionRatings(
      String requestId) async {
    final query = await FirebaseFirestore.instance
        .collection('sessionRatings')
        .where('requestId', isEqualTo: requestId)
        .get();

    final items = query.docs.map((doc) {
      return {
        '_id': doc.id,
        ...doc.data(),
      };
    }).toList();

    items.sort((a, b) {
      final aTs = a['createdAt'];
      final bTs = b['createdAt'];
      DateTime ad = DateTime.fromMillisecondsSinceEpoch(0);
      DateTime bd = DateTime.fromMillisecondsSinceEpoch(0);
      if (aTs is Timestamp) ad = aTs.toDate();
      if (bTs is Timestamp) bd = bTs.toDate();
      return bd.compareTo(ad);
    });

    return items;
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
    if (value is String && value.trim().isNotEmpty) {
      return value;
    }
    return '';
  }

  String _label(BuildContext context, String key) {
    final isArabic = _isArabic(context);
    switch (key) {
      case 'status':
        return isArabic ? 'الحالة العامة' : 'General status';
      case 'paymentStatus':
        return isArabic ? 'حالة السداد' : 'Payment status';
      case 'sessionStatus':
        return isArabic ? 'حالة الجلسة' : 'Session status';
      case 'reviewStatus':
        return isArabic ? 'حالة التقييم' : 'Review status';
      case 'payoutStatus':
        return isArabic ? 'حالة التحويل' : 'Payout status';
      default:
        return key;
    }
  }

  Widget _infoRow(BuildContext context, String title, String value) {
    final isArabic = _isArabic(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              value.isEmpty ? '-' : value,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final isArabic = _isArabic(context);

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _reviewCard(
    BuildContext context, {
    required Map<String, dynamic> rating,
  }) {
    final reviewerType = (rating['reviewerType'] ?? '').toString();
    final notes = (rating['notes'] ?? '').toString();
    final totalScore = ((rating['totalScore'] ?? 0) as num).toInt();
    final percentageScore =
        ((rating['percentageScore'] ?? 0) as num).toDouble();
    final derivedStars = ((rating['derivedStars'] ?? 0) as num).toDouble();
    final createdAt = _dateText(rating['createdAt']);
    final answers = (rating['answers'] as Map?)?.cast<String, dynamic>() ?? {};
    final isArabic = _isArabic(context);

    final reviewerLabel = reviewerType == 'clinician'
        ? (isArabic ? 'تقييم الأخصائي' : 'Clinician review')
        : reviewerType == 'center'
            ? (isArabic ? 'تقرير خروج المركز' : 'Center discharge report')
            : (isArabic ? 'تقييم العميل' : 'Client review');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            reviewerLabel,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          if (createdAt.isNotEmpty)
            _infoRow(
              context,
              isArabic ? 'وقت الإرسال' : 'Submitted at',
              createdAt,
            ),
          _infoRow(
            context,
            isArabic ? 'المجموع' : 'Total score',
            '$totalScore / 30',
          ),
          _infoRow(
            context,
            isArabic ? 'النسبة' : 'Percentage',
            '${percentageScore.toStringAsFixed(1)}%',
          ),
          _infoRow(
            context,
            isArabic ? 'النجوم المشتقة' : 'Derived stars',
            '${derivedStars.toStringAsFixed(1)} / 5',
          ),
          if (answers.isNotEmpty)
            _infoRow(
              context,
              isArabic ? 'الإجابات' : 'Answers',
              answers.entries.map((e) => '${e.key}:${e.value}').join(' | '),
            ),
          if (notes.trim().isNotEmpty)
            _infoRow(
              context,
              isArabic ? 'ملاحظات' : 'Notes',
              notes,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final requestId = (args?['requestId'] ?? '').toString();

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'تقرير الطلب' : 'Request Report',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: requestId.isEmpty
              ? AppEmptyState(
                  message: isArabic
                      ? 'لم يتم تمرير معرف الطلب'
                      : 'No request id was provided',
                  icon: Icons.error_outline,
                )
              : FutureBuilder<Map<String, dynamic>?>(
                  future: _loadRequest(requestId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.data;
                    if (data == null) {
                      return AppEmptyState(
                        message: isArabic
                            ? 'تعذر العثور على بيانات الطلب'
                            : 'Request data could not be found',
                        icon: Icons.search_off_outlined,
                      );
                    }

                    final clientName =
                        (data['clientName'] ?? '').toString().trim();
                    final clientEmail =
                        (data['clientEmail'] ?? '').toString().trim();
                    final clinicianName = (data['assignedClinicianName'] ??
                            data['clinicianName'] ??
                            '')
                        .toString()
                        .trim();
                    final centerName = (data['centerName'] ?? '').toString().trim();
                    final isCenterRequest =
                        (data['requestKind'] ?? '').toString() == 'center';

                    final status = (data['status'] ?? '').toString();
                    final paymentStatus =
                        (data['paymentStatus'] ?? '').toString();
                    final sessionStatus =
                        (data['sessionStatus'] ?? '').toString();
                    final reviewStatus =
                        (data['reviewStatus'] ?? '').toString();
                    final payoutStatus =
                        (data['payoutStatus'] ?? '').toString();

                    final approvedSlot =
                        (data['approvedSlot'] ?? '').toString().trim();
                    final sessionDateText =
                        (data['sessionDateText'] ?? '').toString().trim();
                    final sessionCode =
                        (data['sessionCode'] ?? '').toString().trim();
                    final sessionLink =
                        (data['sessionLink'] ?? '').toString().trim();
                    final sessionAdminNotes =
                        (data['sessionAdminNotes'] ?? '').toString().trim();
                    final paymentReceiptFileName =
                        (data['paymentReceiptFileName'] ?? '')
                            .toString()
                            .trim();
                    final paymentClientNote =
                        (data['paymentClientNote'] ?? '').toString().trim();
                    final rejectReason =
                        (data['rejectReason'] ?? '').toString().trim();

                    final clientReviewSubmitted =
                        (data['clientReviewSubmitted'] ?? false) == true;
                    final clinicianReviewSubmitted = isCenterRequest
                        ? ((data['centerReviewSubmitted'] ??
                                        data['clinicianReviewSubmitted']) ??
                                    false) ==
                                true
                        : (data['clinicianReviewSubmitted'] ?? false) == true;
                    final clientReviewPercentage =
                        ((data['clientReviewPercentage'] ?? 0) as num)
                            .toDouble();
                    final clinicianReviewPercentage = (((isCenterRequest
                                        ? (data['centerReviewPercentage'] ??
                                            data['clinicianReviewPercentage'])
                                        : data['clinicianReviewPercentage']) ??
                                    0)
                                as num)
                            .toDouble();
                    final finalReviewPercentage =
                        ((data['finalReviewPercentage'] ?? 0) as num)
                            .toDouble();

                    final createdAt = _dateText(data['createdAt']);
                    final paymentSubmittedAt =
                        _dateText(data['paymentSubmittedAt']);
                    final paymentApprovedAt =
                        _dateText(data['paymentApprovedAt']);
                    final paymentRejectedAt =
                        _dateText(data['paymentRejectedAt']);
                    final payoutTransferredAt =
                        _dateText(data['payoutTransferredAt']);
                    final archivedAt = _dateText(data['archivedAt']);
                    final clientReviewSubmittedAt =
                        _dateText(data['clientReviewSubmittedAt']);
                    final clinicianReviewSubmittedAt = _dateText(
                      isCenterRequest
                          ? (data['centerReviewSubmittedAt'] ??
                              data['clinicianReviewSubmittedAt'])
                          : data['clinicianReviewSubmittedAt'],
                    );

                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: _loadSessionRatings(requestId),
                      builder: (context, ratingsSnapshot) {
                        final ratings = ratingsSnapshot.data ??
                            const <Map<String, dynamic>>[];

                        return ListView(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          children: [
                            AppSurfaceCard(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              child: Column(
                                crossAxisAlignment: isArabic
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isArabic
                                        ? 'التقرير الإداري الموحد'
                                        : 'Unified Admin Report',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'ID: $requestId',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            _sectionCard(
                              context,
                              title:
                                  isArabic ? 'بيانات الأطراف' : 'Participants',
                              children: [
                                _infoRow(
                                  context,
                                  isArabic ? 'العميل' : 'Client',
                                  clientName,
                                ),
                                _infoRow(
                                  context,
                                  isArabic ? 'بريد العميل' : 'Client Email',
                                  clientEmail,
                                ),
                                _infoRow(
                                  context,
                                  isCenterRequest
                                      ? (isArabic ? 'المركز' : 'Center')
                                      : (isArabic ? 'الأخصائي' : 'Clinician'),
                                  isCenterRequest ? centerName : clinicianName,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _sectionCard(
                              context,
                              title: isArabic ? 'الحالات' : 'Statuses',
                              children: [
                                _infoRow(
                                    context, _label(context, 'status'), status),
                                _infoRow(
                                  context,
                                  _label(context, 'paymentStatus'),
                                  paymentStatus,
                                ),
                                _infoRow(
                                  context,
                                  _label(context, 'sessionStatus'),
                                  sessionStatus,
                                ),
                                _infoRow(
                                  context,
                                  _label(context, 'reviewStatus'),
                                  reviewStatus,
                                ),
                                _infoRow(
                                  context,
                                  _label(context, 'payoutStatus'),
                                  payoutStatus,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _sectionCard(
                              context,
                              title: isArabic ? 'بيانات الدفع' : 'Payment Data',
                              children: [
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'مرجع إثبات السداد'
                                      : 'Payment proof reference',
                                  paymentReceiptFileName,
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'ملاحظة العميل على السداد'
                                      : 'Client payment note',
                                  paymentClientNote,
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'رفع إثبات السداد'
                                      : 'Payment Submitted',
                                  paymentSubmittedAt,
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'اعتماد السداد'
                                      : 'Payment Approved',
                                  paymentApprovedAt,
                                ),
                                _infoRow(
                                  context,
                                  isArabic ? 'رفض السداد' : 'Payment Rejected',
                                  paymentRejectedAt,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _sectionCard(
                              context,
                              title: isCenterRequest
                                  ? (isArabic
                                      ? 'بيانات الإقامة'
                                      : 'Residency Data')
                                  : (isArabic
                                      ? 'بيانات الجلسة'
                                      : 'Session Data'),
                              children: [
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'موعد/ملاحظة القبول'
                                      : 'Approval slot/note',
                                  approvedSlot,
                                ),
                                _infoRow(
                                  context,
                                  isCenterRequest
                                      ? (isArabic
                                          ? 'موعد بداية الإقامة'
                                          : 'Residency start')
                                      : (isArabic
                                          ? 'موعد الجلسة'
                                          : 'Session Date'),
                                  sessionDateText,
                                ),
                                _infoRow(
                                  context,
                                  isCenterRequest
                                      ? (isArabic
                                          ? 'كود الإقامة'
                                          : 'Residency code')
                                      : (isArabic
                                          ? 'كود الجلسة'
                                          : 'Session Code'),
                                  sessionCode,
                                ),
                                _infoRow(
                                  context,
                                  isCenterRequest
                                      ? (isArabic
                                          ? 'رابط المتابعة'
                                          : 'Follow-up link')
                                      : (isArabic
                                          ? 'رابط الجلسة'
                                          : 'Session Link'),
                                  sessionLink,
                                ),
                                _infoRow(
                                  context,
                                  isCenterRequest
                                      ? (isArabic
                                          ? 'ملاحظات الإدارة على الإقامة'
                                          : 'Admin residency notes')
                                      : (isArabic
                                          ? 'ملاحظات الإدارة'
                                          : 'Admin session notes'),
                                  sessionAdminNotes,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _sectionCard(
                              context,
                              title: isArabic
                                  ? 'التواريخ المهمة'
                                  : 'Important Dates',
                              children: [
                                _infoRow(
                                  context,
                                  isArabic ? 'تاريخ الطلب' : 'Created At',
                                  createdAt,
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'تقييم العميل'
                                      : 'Client review submitted',
                                  clientReviewSubmittedAt,
                                ),
                                _infoRow(
                                  context,
                                  isCenterRequest
                                      ? (isArabic
                                          ? 'تقرير خروج المركز'
                                          : 'Center discharge report submitted')
                                      : (isArabic
                                          ? 'تقييم الأخصائي'
                                          : 'Clinician review submitted'),
                                  clinicianReviewSubmittedAt,
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'تحويل المستحق'
                                      : 'Payout Transferred',
                                  payoutTransferredAt,
                                ),
                                _infoRow(
                                  context,
                                  isArabic ? 'الأرشفة' : 'Archived At',
                                  archivedAt,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _sectionCard(
                              context,
                              title: isArabic
                                  ? 'ملخص التقييمات'
                                  : 'Reviews Summary',
                              children: [
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'تم تقييم العميل'
                                      : 'Client review submitted',
                                  clientReviewSubmitted ? 'نعم' : 'لا',
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? (isCenterRequest
                                          ? 'تم إرسال تقرير المركز'
                                          : 'تم تقييم الأخصائي')
                                      : (isCenterRequest
                                          ? 'Center report submitted'
                                          : 'Clinician review submitted'),
                                  clinicianReviewSubmitted ? 'نعم' : 'لا',
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'نسبة تقييم العميل'
                                      : 'Client review percentage',
                                  clientReviewPercentage > 0
                                      ? '${clientReviewPercentage.toStringAsFixed(1)}%'
                                      : '',
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? (isCenterRequest
                                          ? 'نسبة تقرير المركز'
                                          : 'نسبة تقييم الأخصائي')
                                      : (isCenterRequest
                                          ? 'Center report percentage'
                                          : 'Clinician review percentage'),
                                  clinicianReviewPercentage > 0
                                      ? '${clinicianReviewPercentage.toStringAsFixed(1)}%'
                                      : '',
                                ),
                                _infoRow(
                                  context,
                                  isArabic
                                      ? 'النسبة النهائية'
                                      : 'Final Percentage',
                                  finalReviewPercentage > 0
                                      ? '${finalReviewPercentage.toStringAsFixed(1)}%'
                                      : '',
                                ),
                                if (rejectReason.isNotEmpty)
                                  _infoRow(
                                    context,
                                    isArabic ? 'سبب الرفض' : 'Reject reason',
                                    rejectReason,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _sectionCard(
                              context,
                              title: isArabic
                                  ? 'التقييمات التفصيلية'
                                  : 'Detailed Ratings',
                              children: ratings.isEmpty
                                  ? [
                                      Text(
                                        isArabic
                                            ? 'لا توجد تقييمات محفوظة بعد'
                                            : 'No saved ratings yet',
                                      ),
                                    ]
                                  : ratings
                                      .map((r) =>
                                          _reviewCard(context, rating: r))
                                      .toList(),
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

