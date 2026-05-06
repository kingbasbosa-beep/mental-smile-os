import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class ClientSessionsPage extends StatefulWidget {
  const ClientSessionsPage({super.key});

  @override
  State<ClientSessionsPage> createState() => _ClientSessionsPageState();
}

class _ClientSessionsPageState extends State<ClientSessionsPage> {
  final Set<String> _busyIds = {};

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  bool _isCenterRequestData(Map<String, dynamic> data) {
    final requestKind = (data['requestKind'] ?? '').toString().trim();
    final centerId = (data['centerId'] ?? '').toString().trim();
    final centerName = (data['centerName'] ?? '').toString().trim();
    return requestKind == 'center' ||
        centerId.isNotEmpty ||
        centerName.isNotEmpty;
  }

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

  String _statusLabel(String status, bool isArabic, bool isCenterRequest) {
    switch (status) {
      case 'session_setup_pending':
        return isCenterRequest
            ? (isArabic ? 'بانتظار تجهيز الإقامة' : 'Residency setup pending')
            : (isArabic ? 'بانتظار تجهيز الجلسة' : 'Session setup pending');
      case 'session_scheduled':
        return isCenterRequest
            ? (isArabic ? 'إقامة مجدولة' : 'Residency scheduled')
            : (isArabic ? 'جلسة مجدولة' : 'Session scheduled');
      case 'session_in_progress':
        return isCenterRequest
            ? (isArabic ? 'الإقامة جارية' : 'Residency in progress')
            : (isArabic ? 'الجلسة جارية' : 'Session in progress');
      case 'session_completed_pending_reviews':
        return isCenterRequest
            ? (isArabic ? 'بانتظار تقارير الخروج' : 'Pending discharge reviews')
            : (isArabic ? 'بانتظار التقييمات' : 'Pending reviews');
      case 'payout_pending':
        return isCenterRequest
            ? (isArabic
                ? 'بانتظار المراجعة المحاسبية للمركز'
                : 'Pending center accounting review')
            : (isArabic ? 'بانتظار التحويل للأخصائي' : 'Payout pending');
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

  bool _isAwaitingResidencyStart(
    String status,
    bool isCenterRequest,
    bool centerArrivalConfirmed,
    bool clientCheckInConfirmed,
  ) {
    return isCenterRequest &&
        status == 'session_scheduled' &&
        (!centerArrivalConfirmed || !clientCheckInConfirmed);
  }

  bool _hasPreliminaryResidencyDetails(Map<String, dynamic> data) {
    return (data['stayStartDateText'] ?? data['sessionDateText'] ?? '')
            .toString()
            .trim()
            .isNotEmpty &&
        (data['stayEndDateText'] ?? '').toString().trim().isNotEmpty &&
        (data['stayDurationReason'] ?? '').toString().trim().isNotEmpty;
  }

  bool _canClientReview(Map<String, dynamic> data) {
    final status = (data['status'] ?? '').toString();
    final sessionStatus = (data['sessionStatus'] ?? '').toString();
    final reviewStatus = (data['reviewStatus'] ?? '').toString();
    final clientReviewSubmitted =
        (data['clientReviewSubmitted'] ?? false) == true;

    if (clientReviewSubmitted) return false;

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

  Future<void> _setBusy(String requestId, bool value) async {
    if (!mounted) return;
    setState(() {
      if (value) {
        _busyIds.add(requestId);
      } else {
        _busyIds.remove(requestId);
      }
    });
  }

  Future<Map<String, dynamic>?> _showCheckInDialog(
    BuildContext context,
    bool isArabic,
  ) async {
    final notesController = TextEditingController();
    var placeMatched = true;
    var rightsExplained = true;
    var specialistMet = true;
    var receptionRating = 5;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                isArabic ? 'تأكيد بداية الإقامة' : 'Confirm residency start',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: placeMatched,
                      onChanged: (value) {
                        setState(() {
                          placeMatched = value ?? true;
                        });
                      },
                      title: Text(
                        isArabic
                            ? 'المكان والغرفة مطابقان لما تم حجزه'
                            : 'Place and room match the booking',
                      ),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: rightsExplained,
                      onChanged: (value) {
                        setState(() {
                          rightsExplained = value ?? true;
                        });
                      },
                      title: Text(
                        isArabic
                            ? 'تم شرح النظام والحقوق والالتزامات'
                            : 'Rules and rights were explained clearly',
                      ),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: specialistMet,
                      onChanged: (value) {
                        setState(() {
                          specialistMet = value ?? true;
                        });
                      },
                      title: Text(
                        isArabic
                            ? 'استقبلهم شخص مختص وشرح التفاصيل'
                            : 'A qualified specialist welcomed and explained details',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isArabic
                          ? 'تقييم الاستقبال الأولي'
                          : 'Initial reception rating',
                    ),
                    DropdownButtonFormField<int>(
                      value: receptionRating,
                      items: List.generate(
                        5,
                        (index) => DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text('${index + 1}/5'),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          receptionRating = value ?? 5;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: isArabic ? 'ملاحظات الأسرة' : 'Family notes',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(isArabic ? 'إلغاء' : 'Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop({
                      'clientCheckInNotes': notesController.text.trim(),
                      'clientArrivalPlaceMatched': placeMatched,
                      'clientArrivalRightsExplained': rightsExplained,
                      'clientArrivalSpecialistMet': specialistMet,
                      'clientArrivalReceptionRating': receptionRating,
                    });
                  },
                  child: Text(isArabic ? 'تأكيد البداية' : 'Confirm start'),
                ),
              ],
            );
          },
        );
      },
    );

    notesController.dispose();
    return result;
  }

  Future<void> _confirmResidencyStart(
    BuildContext context,
    String requestId,
    Map<String, dynamic> data,
    bool isArabic,
  ) async {
    final dialogResult = await _showCheckInDialog(context, isArabic);
    if (dialogResult == null) return;

    await _setBusy(requestId, true);
    try {
      final updates = <String, dynamic>{
        'clientCheckInConfirmed': true,
        'clientCheckInConfirmedAt': FieldValue.serverTimestamp(),
        'clientCheckInNotes': dialogResult['clientCheckInNotes'] ?? '',
        'clientArrivalPlaceMatched':
            dialogResult['clientArrivalPlaceMatched'] == true,
        'clientArrivalRightsExplained':
            dialogResult['clientArrivalRightsExplained'] == true,
        'clientArrivalSpecialistMet':
            dialogResult['clientArrivalSpecialistMet'] == true,
        'clientArrivalReceptionRating':
            dialogResult['clientArrivalReceptionRating'] ?? 5,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if ((data['centerArrivalConfirmed'] ?? false) == true) {
        updates.addAll({
          'status': 'session_in_progress',
          'workflowStage': 'session_in_progress',
          'sessionStatus': 'in_progress',
          'residencyStartedAt': FieldValue.serverTimestamp(),
          'residencyStartedBy': 'client',
          'residencyStatus': 'in_progress',
        });
      }

      await FirebaseFirestore.instance
          .collection('booking_requests')
          .doc(requestId)
          .update(updates);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم تأكيد بداية الإقامة بنجاح'
                : 'Residency start confirmed successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'فشل تأكيد بداية الإقامة: $e'
                : 'Failed to confirm residency start: $e',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
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
          title: Text(
            isArabic ? 'جلساتي وإقاماتي' : 'My Sessions & Residencies',
          ),
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
                    .where('clientId', isEqualTo: uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        isArabic
                            ? 'تعذر تحميل الجلسات والإقامات'
                            : 'Unable to load sessions and residencies',
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = _normalizeDocs(
                    snapshot.data!.docs,
                    'booking_requests',
                  ).where(_isSessionRelated).toList()
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
                            ? 'لا توجد جلسات أو إقامات ظاهرة حاليًا'
                            : 'No visible sessions or residencies yet',
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: docs.map((data) {
                      final requestId = (data['_id'] ?? '').toString();
                      final status = (data['status'] ?? '').toString();
                      final isCenterRequest = _isCenterRequestData(data);
                      final clinicianName = (data['assignedClinicianName'] ??
                              data['clinicianName'] ??
                              '')
                          .toString();
                      final centerName = (data['centerName'] ?? '').toString();
                      final titleText = isCenterRequest
                          ? (centerName.trim().isEmpty
                              ? (isArabic ? 'المركز' : 'Center')
                              : centerName)
                          : (clinicianName.trim().isEmpty
                              ? (isArabic ? 'الأخصائي' : 'Clinician')
                              : clinicianName);
                      final sessionDate =
                          (data['sessionDateText'] ?? '').toString();
                      final sessionLink =
                          (data['sessionLink'] ?? '').toString();
                      final sessionCode =
                          (data['sessionCode'] ?? '').toString();
                      final adminNotes =
                          (data['sessionAdminNotes'] ?? '').toString();
                      final stayStartText = (data['stayStartDateText'] ??
                              data['sessionDateText'] ??
                              '')
                          .toString()
                          .trim();
                      final stayEndText =
                          (data['stayEndDateText'] ?? '').toString().trim();
                      final stayDurationDays =
                          (data['stayDurationDays'] ?? '').toString().trim();
                      final stayDurationReason =
                          (data['stayDurationReason'] ?? '').toString().trim();
                      final stayDurationIsPreliminary =
                          (data['stayDurationIsPreliminary'] ?? false) == true;
                      final createdAt = _dateText(data['createdAt']);
                      final centerArrivalConfirmed =
                          (data['centerArrivalConfirmed'] ?? false) == true;
                      final clientCheckInConfirmed =
                          (data['clientCheckInConfirmed'] ?? false) == true;
                      final clientReviewSubmitted =
                          (data['clientReviewSubmitted'] ?? false) == true;
                      final centerReviewSubmitted =
                          ((data['centerReviewSubmitted'] ??
                                      data['clinicianReviewSubmitted']) ??
                                  false) ==
                              true;
                      final awaitingResidencyStart = _isAwaitingResidencyStart(
                        status,
                        isCenterRequest,
                        centerArrivalConfirmed,
                        clientCheckInConfirmed,
                      );
                      final hasPreliminaryResidencyDetails =
                          _hasPreliminaryResidencyDetails(data);
                      final busy = _busyIds.contains(requestId);

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
                                        titleText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        isCenterRequest
                                            ? (isArabic
                                                ? 'طلب مركز'
                                                : 'Center request')
                                            : (isArabic
                                                ? 'طلب أخصائي'
                                                : 'Clinician request'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color: scheme.primary,
                                              fontWeight: FontWeight.w700,
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
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    awaitingResidencyStart
                                        ? (isArabic
                                            ? 'بانتظار تأكيد البداية'
                                            : 'Awaiting start confirmations')
                                        : _statusLabel(
                                            status,
                                            isArabic,
                                            isCenterRequest,
                                          ),
                                    style: TextStyle(
                                      color: awaitingResidencyStart
                                          ? const Color(0xFFE39B2E)
                                          : _statusColor(status),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            if (stayStartText.isNotEmpty)
                              Text(
                                isArabic
                                    ? '${isCenterRequest ? 'موعد بداية الإقامة' : 'موعد الجلسة'}: $stayStartText'
                                    : '${isCenterRequest ? 'Residency start' : 'Session date'}: $stayStartText',
                              ),
                            if (isCenterRequest && stayEndText.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'نهاية الإقامة المبدئية: $stayEndText'
                                    : 'Preliminary residency end: $stayEndText',
                              ),
                            ],
                            if (isCenterRequest &&
                                stayDurationDays.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'مدة الإقامة المبدئية: $stayDurationDays يوم'
                                    : 'Preliminary stay duration: $stayDurationDays day(s)',
                              ),
                            ],
                            if (isCenterRequest &&
                                stayDurationReason.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'سبب تحديد المدة مبدئيًا: $stayDurationReason'
                                    : 'Reason for preliminary duration: $stayDurationReason',
                              ),
                            ],
                            if (isCenterRequest &&
                                stayDurationIsPreliminary) ...[
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'ملاحظة: هذه المدة مبدئية حتى يؤكدها أو يعدلها المركز بعد تقييم الاستقبال.'
                                    : 'Note: This duration is preliminary until the center confirms or adjusts it after intake assessment.',
                              ),
                            ],
                            if (sessionLink.trim().isNotEmpty) ...[
                              const SizedBox(height: 8),
                              SelectableText(
                                isArabic
                                    ? '${isCenterRequest ? 'رابط المتابعة' : 'رابط الجلسة'}: $sessionLink'
                                    : '${isCenterRequest ? 'Follow-up link' : 'Session link'}: $sessionLink',
                              ),
                            ],
                            if (sessionCode.trim().isNotEmpty) ...[
                              const SizedBox(height: 8),
                              SelectableText(
                                isArabic
                                    ? '${isCenterRequest ? 'كود الإقامة' : 'كود الجلسة'}: $sessionCode'
                                    : '${isCenterRequest ? 'Residency code' : 'Session code'}: $sessionCode',
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
                            if (stayStartText.isEmpty &&
                                sessionLink.trim().isEmpty &&
                                sessionCode.trim().isEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'سيتم عرض بيانات الإقامة هنا بمجرد تجهيزها.'
                                    : 'Residency details will appear here once prepared.',
                              ),
                            ],
                            if (isCenterRequest) ...[
                              const SizedBox(height: 8),
                              Text(
                                isArabic
                                    ? 'تأكيد المركز للوصول: ${centerArrivalConfirmed ? 'تم' : 'بانتظار التأكيد'}'
                                    : 'Center arrival confirmation: ${centerArrivalConfirmed ? 'confirmed' : 'pending'}',
                              ),
                              const SizedBox(height: 6),
                              Text(
                                isArabic
                                    ? 'تأكيد الأسرة لبداية الإقامة: ${clientCheckInConfirmed ? 'تم' : 'بانتظار التأكيد'}'
                                    : 'Family check-in confirmation: ${clientCheckInConfirmed ? 'confirmed' : 'pending'}',
                              ),
                              if (status ==
                                      'session_completed_pending_reviews' ||
                                  status == 'payout_pending') ...[
                                const SizedBox(height: 6),
                                Text(
                                  isArabic
                                      ? 'تقييم الأسرة: ${clientReviewSubmitted ? 'تم الإرسال' : 'بانتظار الإرسال'}'
                                      : 'Family review: ${clientReviewSubmitted ? 'submitted' : 'pending'}',
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  isArabic
                                      ? 'تقرير خروج المركز: ${centerReviewSubmitted ? 'تم الإرسال' : 'بانتظار الإرسال'}'
                                      : 'Center discharge report: ${centerReviewSubmitted ? 'submitted' : 'pending'}',
                                ),
                              ],
                            ],
                            if (isCenterRequest &&
                                (status == 'session_setup_pending' ||
                                    status == 'session_scheduled' ||
                                    status == 'reschedule_pending') &&
                                !clientCheckInConfirmed &&
                                hasPreliminaryResidencyDetails) ...[
                              const SizedBox(height: 14),
                              FilledButton.icon(
                                onPressed: busy
                                    ? null
                                    : () => _confirmResidencyStart(
                                          context,
                                          requestId,
                                          data,
                                          isArabic,
                                        ),
                                icon: const Icon(Icons.home_work_outlined),
                                label: Text(
                                  isArabic
                                      ? 'تأكيد بداية الإقامة'
                                      : 'Confirm residency start',
                                ),
                              ),
                            ],
                            if (isCenterRequest &&
                                !hasPreliminaryResidencyDetails) ...[
                              const SizedBox(height: 14),
                              Text(
                                isArabic
                                    ? 'سيظهر تأكيد بداية الإقامة بعد إرسال بيانات الإقامة المبدئية كاملة من الإدارة.'
                                    : 'Residency start confirmation will appear after the admin sends the preliminary stay details.',
                              ),
                            ],
                            if (_canClientReview(data)) ...[
                              const SizedBox(height: 14),
                              FilledButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    Routes.sessionReview,
                                    arguments: {
                                      'requestId': requestId,
                                      'reviewerType': 'client',
                                    },
                                  );
                                },
                                icon: const Icon(Icons.rate_review_outlined),
                                label: Text(
                                  isCenterRequest
                                      ? (isArabic
                                          ? 'تقييم الإقامة'
                                          : 'Review residency')
                                      : (isArabic
                                          ? 'تقييم الجلسة'
                                          : 'Review session'),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
      ),
    );
  }
}



