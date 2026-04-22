import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminSessionsPage extends StatefulWidget {
  const AdminSessionsPage({super.key});

  @override
  State<AdminSessionsPage> createState() => _AdminSessionsPageState();
}

class _AdminSessionsPageState extends State<AdminSessionsPage> {
  String _tab = 'session_setup_pending';
  final Set<String> _busyIds = {};
  late final Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _bookingDocsStreamRef;

  final Map<String, TextEditingController> _dateControllers = {};
  final Map<String, TextEditingController> _endDateControllers = {};
  final Map<String, TextEditingController> _durationControllers = {};
  final Map<String, TextEditingController> _durationReasonControllers = {};
  final Map<String, TextEditingController> _linkControllers = {};
  final Map<String, TextEditingController> _codeControllers = {};
  final Map<String, TextEditingController> _notesControllers = {};

  @override
  void initState() {
    super.initState();
    _bookingDocsStreamRef = _bookingDocsStream();
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

  TextEditingController _controllerFor(
    Map<String, TextEditingController> map,
    String requestId, {
    String initial = '',
  }) {
    return map.putIfAbsent(
      requestId,
      () => TextEditingController(text: initial),
    );
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

  double _asDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse('$value') ?? 0;
  }

  int _asInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse('$value') ?? 0;
  }

  double _centerQuotedBaseAmount(Map<String, dynamic> data, int durationDays) {
    final unitPrice = _asDouble(data['selectedAccommodationPrice']);
    final pricingUnit =
        (data['selectedAccommodationPricingUnit'] ?? '').toString().trim();
    if (durationDays <= 0 || unitPrice <= 0) return 0;
    if (pricingUnit == 'month') {
      return (unitPrice / 30.0) * durationDays;
    }
    return unitPrice * durationDays;
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

  Future<void> _updateRequestEverywhere(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final payload = {
      ..._withCanonicalWorkflowStage(updates),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final ref = FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(requestId);
    final snap = await ref.get();
    if (snap.exists) {
      await ref.update(payload);
    }
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _bookingDocsStream() {
    final primary = FirebaseFirestore.instance
        .collection('booking_requests')
        .orderBy('createdAt', descending: true)
        .snapshots();

    return Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>.multi(
      (controller) {
        QuerySnapshot<Map<String, dynamic>>? primarySnapshot;

        void emitDocs() {
          if (primarySnapshot == null) {
            return;
          }

          final docs = primarySnapshot!.docs.toList()
            ..sort((a, b) {
              final aTs = a.data()['createdAt'];
              final bTs = b.data()['createdAt'];

              final aDate = aTs is Timestamp
                  ? aTs.toDate()
                  : DateTime.fromMillisecondsSinceEpoch(0);
              final bDate = bTs is Timestamp
                  ? bTs.toDate()
                  : DateTime.fromMillisecondsSinceEpoch(0);

              return bDate.compareTo(aDate);
            });

          controller.add(docs);
        }

        final primarySub = primary.listen(
          (snapshot) {
            primarySnapshot = snapshot;
            emitDocs();
          },
          onError: controller.addError,
        );

        controller.onCancel = () async {
          await primarySub.cancel();
        };
      },
    );
  }

  Future<void> _scheduleSession(String requestId) async {
    final dateText = _dateControllers[requestId]?.text.trim() ?? '';
    final linkText = _linkControllers[requestId]?.text.trim() ?? '';
    final codeText = _codeControllers[requestId]?.text.trim() ?? '';
    final notesText = _notesControllers[requestId]?.text.trim() ?? '';

    if (dateText.isEmpty || linkText.isEmpty || codeText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'أدخل موعد الجلسة والرابط والكود أولًا'
                : 'Enter session date, link, and code first',
          ),
        ),
      );
      return;
    }

    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'session_scheduled',
        'sessionStatus': 'scheduled',
        'sessionDateText': dateText,
        'sessionLink': linkText,
        'sessionCode': codeText,
        'sessionAdminNotes': notesText,
        'sessionCreatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تمت جدولة الجلسة بنجاح'
                : 'Session scheduled successfully',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _scheduleCenterResidency(
    String requestId,
    Map<String, dynamic> data,
  ) async {
    final isArabic = _isArabic(context);
    final startText = _dateControllers[requestId]?.text.trim() ?? '';
    final endText = _endDateControllers[requestId]?.text.trim() ?? '';
    final durationText = _durationControllers[requestId]?.text.trim() ?? '';
    final durationReasonText =
        _durationReasonControllers[requestId]?.text.trim() ?? '';
    final linkText = _linkControllers[requestId]?.text.trim() ?? '';
    final codeText = _codeControllers[requestId]?.text.trim() ?? '';
    final notesText = _notesControllers[requestId]?.text.trim() ?? '';

    if (startText.isEmpty ||
        endText.isEmpty ||
        durationText.isEmpty ||
        durationReasonText.isEmpty ||
        linkText.isEmpty ||
        codeText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'أدخل بداية الإقامة ونهايتها والمدة والسبب والرابط والكود أولًا'
                : 'Enter start, end, duration, reason, link, and code first',
          ),
        ),
      );
      return;
    }

    final durationDays = _asInt(durationText);
    if (durationDays <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'أدخل عدد أيام إقامة صالح'
                : 'Enter a valid number of residency days',
          ),
        ),
      );
      return;
    }

    final baseAmount = _centerQuotedBaseAmount(data, durationDays);
    final taxPercent = 10.0;
    final taxAmount = baseAmount * (taxPercent / 100);
    final totalAmount = baseAmount + taxAmount;
    final pricingUnit =
        (data['selectedAccommodationPricingUnit'] ?? '').toString().trim();
    final unitPrice = _asDouble(data['selectedAccommodationPrice']);
    final paymentBreakdownText = isArabic
        ? 'سعر ${pricingUnit == 'month' ? 'شهري' : 'يومي'} ${unitPrice.toStringAsFixed(unitPrice.truncateToDouble() == unitPrice ? 0 : 2)} × $durationDays يوم + ضريبة ${taxPercent.toStringAsFixed(0)}%'
        : '${pricingUnit == 'month' ? 'Monthly' : 'Daily'} price ${unitPrice.toStringAsFixed(unitPrice.truncateToDouble() == unitPrice ? 0 : 2)} × $durationDays day(s) + ${taxPercent.toStringAsFixed(0)}% tax';

    await _setBusy(requestId, true);
    try {
      debugPrint(
        'CENTER_SCHEDULE_TRACE '
        'requestId=$requestId '
        'status_before=${(data['status'] ?? '').toString()} '
        'stayStart=$startText '
        'stayEnd=$endText '
        'stayDays=$durationDays '
        'pricingUnit=$pricingUnit '
        'unitPrice=$unitPrice '
        'baseAmount=$baseAmount '
        'taxAmount=$taxAmount '
        'totalAmount=$totalAmount',
      );
      await _updateRequestEverywhere(requestId, {
        'status': 'awaiting_payment',
        'workflowStage': 'awaiting_payment',
        'paymentStatus': 'pending_client_transfer',
        'payment_confirmed': false,
        'sessionStatus': 'not_created',
        'stayStartDateText': startText,
        'stayEndDateText': endText,
        'stayDurationDays': durationDays,
        'stayDurationReason': durationReasonText,
        'stayDurationIsPreliminary': true,
        'sessionDateText': startText,
        'sessionLink': linkText,
        'sessionCode': codeText,
        'sessionAdminNotes': notesText,
        'stayUnitPrice': unitPrice,
        'stayPricingUnit': pricingUnit,
        'stayBaseAmount': baseAmount,
        'stayTaxPercent': taxPercent,
        'stayTaxAmount': taxAmount,
        'stayTotalAmount': totalAmount,
        'grossClientPaidAmount': totalAmount,
        'paymentBreakdownText': paymentBreakdownText,
        'paymentQuotePreparedAt': FieldValue.serverTimestamp(),
        'paymentQuotePreparedBy': FirebaseAuth.instance.currentUser?.uid ?? '',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تمت جدولة الإقامة المبدئية وإرسال بيان الدفع للعميل'
                : 'Preliminary residency scheduled and payment quote sent to client',
          ),
        ),
      );
    } catch (e) {
      debugPrint(
        'CENTER_SCHEDULE_TRACE_ERROR requestId=$requestId error=$e',
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'فشل حفظ الجدولة أو إرسال بيان الدفع: $e'
                : 'Failed to save schedule or send payment quote: $e',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _markInProgress(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'session_in_progress',
        'sessionStatus': 'in_progress',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تحويل الجلسة إلى جارية'
                : 'Session marked in progress',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _markCompleted(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'session_completed_pending_reviews',
        'sessionStatus': 'completed',
        'reviewStatus': 'pending_reviews',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تعليم الجلسة كمكتملة'
                : 'Session marked completed',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _moveToReschedule(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'reschedule_pending',
        'sessionStatus': 'reschedule_pending',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تحويل الطلب إلى انتظار إعادة الجدولة'
                : 'Moved to reschedule pending',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  bool _matchesTab(String status) {
    switch (_tab) {
      case 'session_scheduled':
        return status == 'session_scheduled' || status == 'session_in_progress';
      case 'session_completed_pending_reviews':
        return status == 'session_completed_pending_reviews';
      case 'reschedule_pending':
        return status == 'reschedule_pending';
      default:
        return status == 'session_setup_pending';
    }
  }

  String _statusLabel(String status, bool isArabic, bool isCenterRequest) {
    switch (status) {
      case 'session_scheduled':
        return isCenterRequest
            ? (isArabic ? 'إقامة مجدولة' : 'Residency scheduled')
            : (isArabic ? 'جلسة مجدولة' : 'Session scheduled');
      case 'session_in_progress':
        return isCenterRequest
            ? (isArabic ? 'الإقامة جارية' : 'Residency in progress')
            : (isArabic ? 'جلسة جارية' : 'Session in progress');
      case 'session_completed_pending_reviews':
        return isCenterRequest
            ? (isArabic ? 'بانتظار تقارير الخروج' : 'Pending discharge reviews')
            : (isArabic ? 'بانتظار التقييمات' : 'Pending reviews');
      case 'reschedule_pending':
        return isArabic ? 'بانتظار إعادة الجدولة' : 'Reschedule pending';
      default:
        return isCenterRequest
            ? (isArabic ? 'بانتظار تجهيز الإقامة' : 'Residency setup pending')
            : (isArabic ? 'بانتظار تجهيز الجلسة' : 'Session setup pending');
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'session_scheduled':
      case 'session_in_progress':
        return const Color(0xFF2E5AAC);
      case 'session_completed_pending_reviews':
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

  @override
  void dispose() {
    for (final c in _dateControllers.values) {
      c.dispose();
    }
    for (final c in _endDateControllers.values) {
      c.dispose();
    }
    for (final c in _durationControllers.values) {
      c.dispose();
    }
    for (final c in _durationReasonControllers.values) {
      c.dispose();
    }
    for (final c in _linkControllers.values) {
      c.dispose();
    }
    for (final c in _codeControllers.values) {
      c.dispose();
    }
    for (final c in _notesControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'الجلسات والإقامات' : 'Sessions & Residencies',
        ),
        body: AppPageBackground(
          child:
              StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
            stream: _bookingDocsStreamRef,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل الجلسات والإقامات'
                      : 'Unable to load sessions and residencies',
                  icon: Icons.error_outline,
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.where((doc) {
                if ((doc.data()['archived'] ?? false) == true) {
                  return false;
                }
                final status = (doc.data()['status'] ?? 'session_setup_pending')
                    .toString();
                return _matchesTab(status);
              }).toList();

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      alignment: WrapAlignment.end,
                      children: [
                        ChoiceChip(
                          selected: _tab == 'session_setup_pending',
                          label: Text(
                            isArabic ? 'بانتظار التجهيز' : 'Setup pending',
                          ),
                          onSelected: (_) =>
                              setState(() => _tab = 'session_setup_pending'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'session_scheduled',
                          label: Text(
                            isArabic ? 'مجدولة' : 'Scheduled',
                          ),
                          onSelected: (_) =>
                              setState(() => _tab = 'session_scheduled'),
                        ),
                        ChoiceChip(
                          selected: _tab == 'session_completed_pending_reviews',
                          label: Text(
                            isArabic
                                ? 'بانتظار التقارير/التقييمات'
                                : 'Pending reviews',
                          ),
                          onSelected: (_) => setState(
                            () => _tab = 'session_completed_pending_reviews',
                          ),
                        ),
                        ChoiceChip(
                          selected: _tab == 'reschedule_pending',
                          label: Text(
                            isArabic ? 'إعادة جدولة' : 'Reschedule',
                          ),
                          onSelected: (_) =>
                              setState(() => _tab = 'reschedule_pending'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (docs.isEmpty)
                    AppEmptyState(
                      message: isArabic
                          ? 'لا توجد طلبات في هذا القسم'
                          : 'No requests in this section',
                    )
                  else
                    ...docs.map((doc) {
                      final data = doc.data();
                      final requestId = doc.id;
                      final busy = _busyIds.contains(requestId);

                      final clientName =
                          (data['clientName'] ?? 'Client').toString();
                      final isCenterRequest = _isCenterRequestData(data);
                      final clinicianName = (data['assignedClinicianName'] ??
                              data['clinicianName'] ??
                              '')
                          .toString();
                      final centerName = (data['centerName'] ?? '').toString();
                      final note = (data['note'] ?? '').toString();
                      final status = (data['status'] ?? '').toString();
                      final createdAt = _dateText(data['createdAt']);
                      final companionName =
                          isCenterRequest ? centerName : clinicianName;
                      final centerArrivalConfirmed =
                          (data['centerArrivalConfirmed'] ?? false) == true;
                      final clientCheckInConfirmed =
                          (data['clientCheckInConfirmed'] ?? false) == true;
                      final stayEndDateText =
                          (data['stayEndDateText'] ?? '').toString().trim();
                      final stayDurationDays =
                          (data['stayDurationDays'] ?? '').toString().trim();
                      final stayDurationReason =
                          (data['stayDurationReason'] ?? '').toString().trim();
                      final stayDurationIsPreliminary =
                          (data['stayDurationIsPreliminary'] ?? false) == true;
                      final centerRecommendedCareLevel =
                          (data['centerRecommendedCareLevel'] ?? '')
                              .toString()
                              .trim();
                      final centerRecommendedStayDays =
                          _asInt(data['centerRecommendedStayDays']);
                      final centerNeedsInternalAssessment =
                          (data['centerNeedsInternalAssessment'] ?? false) ==
                              true;
                      final selectedAccommodationLabel =
                          (data['selectedAccommodationLabelAr'] ?? '')
                              .toString()
                              .trim();
                      final selectedAccommodationPrice =
                          _asDouble(data['selectedAccommodationPrice']);
                      final selectedAccommodationPricingUnit =
                          (data['selectedAccommodationPricingUnit'] ?? '')
                              .toString()
                              .trim();
                      final contract = data['contract'];
                      final rawContractRoom =
                          contract is Map ? contract['room'] : null;
                      final contractRoom =
                          rawContractRoom is Map ? rawContractRoom : null;
                      final contractRoomLabel = contractRoom == null
                          ? ''
                          : (contractRoom['label'] ?? '').toString().trim();
                      final contractRoomPrice = contractRoom == null
                          ? 0.0
                          : _asDouble(contractRoom['price']);
                      final contractPricingUnit = contractRoom == null
                          ? ''
                          : (contractRoom['pricingUnit'] ?? '')
                              .toString()
                              .trim();
                      final existingQuoteAlready =
                          (data['paymentQuotePreparedAt'] != null) ||
                              (data['stayBaseAmount'] != null) ||
                              (data['stayTaxAmount'] != null) ||
                              (data['stayTotalAmount'] != null) ||
                              (data['grossClientPaidAmount'] != null) ||
                              ((data['paymentBreakdownText'] ?? '')
                                  .toString()
                                  .trim()
                                  .isNotEmpty);
                      final clientReviewSubmitted =
                          (data['clientReviewSubmitted'] ?? false) == true;
                      final centerReviewSubmitted =
                          ((data['centerReviewSubmitted'] ??
                                      data['clinicianReviewSubmitted']) ??
                                  false) ==
                              true;
                      final clinicianReviewSubmitted =
                          (data['clinicianReviewSubmitted'] ?? false) == true;
                      final residencyStartedBy =
                          (data['residencyStartedBy'] ?? '').toString();
                      final awaitingResidencyStart = _isAwaitingResidencyStart(
                        status,
                        isCenterRequest,
                        centerArrivalConfirmed,
                        clientCheckInConfirmed,
                      );

                      final dateCtrl = _controllerFor(
                        _dateControllers,
                        requestId,
                        initial: (data['sessionDateText'] ?? '').toString(),
                      );
                      final endDateCtrl = _controllerFor(
                        _endDateControllers,
                        requestId,
                        initial: (data['stayEndDateText'] ?? '').toString(),
                      );
                      final durationCtrl = _controllerFor(
                        _durationControllers,
                        requestId,
                        initial: stayDurationDays.isNotEmpty
                            ? stayDurationDays
                            : (!existingQuoteAlready &&
                                    centerRecommendedStayDays > 0)
                                ? centerRecommendedStayDays.toString()
                                : '',
                      );
                      if (isCenterRequest &&
                          !existingQuoteAlready &&
                          stayDurationDays.isEmpty &&
                          durationCtrl.text.trim().isEmpty &&
                          centerRecommendedStayDays > 0) {
                        durationCtrl.text = centerRecommendedStayDays.toString();
                      }
                      final durationReasonCtrl = _controllerFor(
                        _durationReasonControllers,
                        requestId,
                        initial: (data['stayDurationReason'] ?? '').toString(),
                      );
                      final enteredDurationDays = _asInt(
                          durationCtrl.text.trim().isEmpty
                              ? data['stayDurationDays']
                              : durationCtrl.text.trim());
                      final computedBaseAmount =
                          _centerQuotedBaseAmount(data, enteredDurationDays);
                      final computedTaxAmount = computedBaseAmount * 0.10;
                      final computedTotalAmount =
                          computedBaseAmount + computedTaxAmount;
                      final setupWarnings = <String>[
                        if (isCenterRequest &&
                            centerRecommendedStayDays <= 0)
                          isArabic
                              ? 'لا توجد مدة موصى بها من المركز.'
                              : 'No center-recommended duration is available.',
                        if (isCenterRequest &&
                            centerRecommendedStayDays > 0 &&
                            enteredDurationDays > 0 &&
                            enteredDurationDays != centerRecommendedStayDays)
                          isArabic
                              ? 'مدة التجهيز تختلف عن مدة توصية المركز.'
                              : 'Setup duration differs from the center recommendation.',
                        if (isCenterRequest &&
                            (selectedAccommodationPrice <= 0 ||
                                selectedAccommodationPricingUnit.isEmpty))
                          isArabic
                              ? 'بيانات تسعير الإقامة غير مكتملة.'
                              : 'Accommodation pricing data is incomplete.',
                        if (isCenterRequest &&
                            contractRoom != null &&
                            ((contractRoomLabel.isNotEmpty &&
                                    selectedAccommodationLabel.isNotEmpty &&
                                    contractRoomLabel !=
                                        selectedAccommodationLabel) ||
                                (contractRoomPrice > 0 &&
                                    selectedAccommodationPrice > 0 &&
                                    contractRoomPrice !=
                                        selectedAccommodationPrice) ||
                                (contractPricingUnit.isNotEmpty &&
                                    selectedAccommodationPricingUnit
                                        .isNotEmpty &&
                                    contractPricingUnit !=
                                        selectedAccommodationPricingUnit)))
                          isArabic
                              ? 'بيانات الإقامة المختارة تختلف عن مسودة العقد.'
                              : 'Selected accommodation differs from the contract draft.',
                        if (isCenterRequest && existingQuoteAlready)
                          isArabic
                              ? 'يوجد تجهيز سابق محفوظ؛ لن يتم استخدام الملء التلقائي.'
                              : 'Existing setup already exists; pre-fill is not applied.',
                      ];
                      final linkCtrl = _controllerFor(
                        _linkControllers,
                        requestId,
                        initial: (data['sessionLink'] ?? '').toString(),
                      );
                      final codeCtrl = _controllerFor(
                        _codeControllers,
                        requestId,
                        initial: (data['sessionCode'] ?? '').toString(),
                      );
                      final notesCtrl = _controllerFor(
                        _notesControllers,
                        requestId,
                        initial: (data['sessionAdminNotes'] ?? '').toString(),
                      );

                      return AppSurfaceCard(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        color: Colors.white.withValues(alpha: 0.84),
                        child: Column(
                          crossAxisAlignment: isArabic
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Row(
                              textDirection: isArabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
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
                                                fontWeight: FontWeight.w800),
                                        textAlign: isArabic
                                            ? TextAlign.right
                                            : TextAlign.left,
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      if (companionName.trim().isNotEmpty)
                                        Text(
                                          isCenterRequest
                                              ? (isArabic
                                                  ? 'المركز: $companionName'
                                                  : 'Center: $companionName')
                                              : (isArabic
                                                  ? 'الأخصائي: $companionName'
                                                  : 'Clinician: $companionName'),
                                        ),
                                      const SizedBox(height: AppSpacing.xs),
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
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                AppStatusBadge(
                                  label: awaitingResidencyStart
                                      ? (isArabic
                                          ? 'بانتظار تأكيد البداية'
                                          : 'Awaiting start confirmations')
                                      : _statusLabel(
                                          status,
                                          isArabic,
                                          isCenterRequest,
                                        ),
                                  color: awaitingResidencyStart
                                      ? const Color(0xFFE39B2E)
                                      : _statusColor(status),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            if (createdAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppSpacing.xs),
                                child: Text(
                                  isArabic
                                      ? 'تاريخ الطلب: $createdAt'
                                      : 'Request date: $createdAt',
                                ),
                              ),
                            if (note.trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppSpacing.xs),
                                child: Text(
                                  isArabic
                                      ? 'ملاحظة العميل: $note'
                                      : 'Client note: $note',
                                ),
                              ),
                            const SizedBox(height: AppSpacing.sm),
                            if (status == 'session_setup_pending' ||
                                status == 'reschedule_pending') ...[
                              TextField(
                                controller: dateCtrl,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic
                                      ? (isCenterRequest
                                          ? 'موعد بداية الإقامة'
                                          : 'موعد الجلسة')
                                      : (isCenterRequest
                                          ? 'Residency start'
                                          : 'Session date/time'),
                                  icon: Icons.event_outlined,
                                  hintText: isArabic
                                      ? 'مثال: 25-03-2026 08:30 PM'
                                      : 'Example: 25-03-2026 08:30 PM',
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              if (isCenterRequest) ...[
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainerHighest
                                        .withValues(alpha: 0.45),
                                    borderRadius: BorderRadius.circular(
                                      AppRadii.md,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isArabic
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isArabic
                                            ? 'سياق التجهيز المقترح'
                                            : 'Suggested setup context',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      if (centerRecommendedCareLevel.isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'توصية المركز: ${_centerCareLevelLabel(centerRecommendedCareLevel, isArabic)}'
                                              : 'Center recommendation: ${_centerCareLevelLabel(centerRecommendedCareLevel, isArabic)}',
                                        ),
                                      if (centerRecommendedStayDays > 0)
                                        Text(
                                          isArabic
                                              ? 'مدة موصى بها: $centerRecommendedStayDays يوم'
                                              : 'Recommended duration: $centerRecommendedStayDays day(s)',
                                        ),
                                      Text(
                                        isArabic
                                            ? 'يحتاج تقييمًا داخليًا: ${centerNeedsInternalAssessment ? 'نعم' : 'لا'}'
                                            : 'Needs internal assessment: ${centerNeedsInternalAssessment ? 'Yes' : 'No'}',
                                      ),
                                      if (selectedAccommodationLabel.isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'الإقامة المختارة: $selectedAccommodationLabel'
                                              : 'Selected accommodation: $selectedAccommodationLabel',
                                        ),
                                      if (selectedAccommodationPrice > 0 ||
                                          selectedAccommodationPricingUnit
                                              .isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'تسعير الإقامة: ${selectedAccommodationPrice.toStringAsFixed(selectedAccommodationPrice.truncateToDouble() == selectedAccommodationPrice ? 0 : 2)} / $selectedAccommodationPricingUnit'
                                              : 'Accommodation pricing: ${selectedAccommodationPrice.toStringAsFixed(selectedAccommodationPrice.truncateToDouble() == selectedAccommodationPrice ? 0 : 2)} / $selectedAccommodationPricingUnit',
                                        ),
                                      if (contractRoomLabel.isNotEmpty ||
                                          contractRoomPrice > 0 ||
                                          contractPricingUnit.isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'مسودة العقد: ${contractRoomLabel.isEmpty ? '-' : contractRoomLabel} | ${contractRoomPrice.toStringAsFixed(contractRoomPrice.truncateToDouble() == contractRoomPrice ? 0 : 2)} / $contractPricingUnit'
                                              : 'Contract draft: ${contractRoomLabel.isEmpty ? '-' : contractRoomLabel} | ${contractRoomPrice.toStringAsFixed(contractRoomPrice.truncateToDouble() == contractRoomPrice ? 0 : 2)} / $contractPricingUnit',
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                TextField(
                                  controller: endDateCtrl,
                                  decoration: appInputDecoration(
                                    context: context,
                                    label: isArabic
                                        ? 'تاريخ نهاية الإقامة المبدئي'
                                        : 'Preliminary residency end',
                                    icon: Icons.event_available_outlined,
                                    hintText: isArabic
                                        ? 'مثال: 30-03-2026 12:00 PM'
                                        : 'Example: 30-03-2026 12:00 PM',
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                TextField(
                                  controller: durationCtrl,
                                  keyboardType: TextInputType.number,
                                  decoration: appInputDecoration(
                                    context: context,
                                    label: isArabic
                                        ? 'عدد أيام الإقامة المبدئي'
                                        : 'Preliminary stay days',
                                    icon: Icons.hotel_outlined,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                TextField(
                                  controller: durationReasonCtrl,
                                  maxLines: 3,
                                  decoration: appInputDecoration(
                                    context: context,
                                    label: isArabic
                                        ? 'سبب تحديد المدة مبدئيًا'
                                        : 'Reason for preliminary duration',
                                    icon: Icons.fact_check_outlined,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  isArabic
                                      ? 'هذه المدة مبدئية حتى تقييم الحالة عند الاستقبال داخل المركز.'
                                      : 'This duration is preliminary until the intake assessment at the center.',
                                ),
                                if (setupWarnings.isNotEmpty) ...[
                                  const SizedBox(height: AppSpacing.sm),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.all(AppSpacing.sm),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF3CD),
                                      border: Border.all(
                                        color: const Color(0xFFE0A800),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        AppRadii.md,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: isArabic
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isArabic
                                              ? 'تنبيهات غير مانعة'
                                              : 'Non-blocking warnings',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                        ),
                                        for (final warning in setupWarnings)
                                          Text('- $warning'),
                                      ],
                                    ),
                                  ),
                                ],
                                if (selectedAccommodationPrice > 0 &&
                                    enteredDurationDays > 0) ...[
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    isArabic
                                        ? 'السعر ${selectedAccommodationPricingUnit == 'month' ? 'الشهري' : 'اليومي'}: ${selectedAccommodationPrice.toStringAsFixed(selectedAccommodationPrice.truncateToDouble() == selectedAccommodationPrice ? 0 : 2)}'
                                        : '${selectedAccommodationPricingUnit == 'month' ? 'Monthly' : 'Daily'} price: ${selectedAccommodationPrice.toStringAsFixed(selectedAccommodationPrice.truncateToDouble() == selectedAccommodationPrice ? 0 : 2)}',
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'المبلغ الأساسي: ${computedBaseAmount.toStringAsFixed(2)}'
                                        : 'Base amount: ${computedBaseAmount.toStringAsFixed(2)}',
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'الضريبة 10%: ${computedTaxAmount.toStringAsFixed(2)}'
                                        : 'Tax 10%: ${computedTaxAmount.toStringAsFixed(2)}',
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'المبلغ المطلوب من العميل: ${computedTotalAmount.toStringAsFixed(2)}'
                                        : 'Gross client-paid amount: ${computedTotalAmount.toStringAsFixed(2)}',
                                  ),
                                ],
                                const SizedBox(height: AppSpacing.sm),
                              ],
                              TextField(
                                controller: linkCtrl,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic
                                      ? (isCenterRequest
                                          ? 'رابط المتابعة'
                                          : 'رابط الجلسة')
                                      : (isCenterRequest
                                          ? 'Follow-up link'
                                          : 'Session link'),
                                  icon: Icons.link_outlined,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              TextField(
                                controller: codeCtrl,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic
                                      ? (isCenterRequest
                                          ? 'كود الإقامة'
                                          : 'كود الجلسة')
                                      : (isCenterRequest
                                          ? 'Residency code'
                                          : 'Session code'),
                                  icon: Icons.password_outlined,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              TextField(
                                controller: notesCtrl,
                                maxLines: 3,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic
                                      ? 'ملاحظات الإدارة'
                                      : 'Admin notes',
                                  icon: Icons.notes_outlined,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                            ],
                            if (status == 'session_scheduled' ||
                                status == 'session_in_progress') ...[
                              if ((data['sessionDateText'] ?? '')
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? '${isCenterRequest ? 'موعد بداية الإقامة' : 'موعد الجلسة'}: ${(data['sessionDateText'] ?? '').toString()}'
                                        : '${isCenterRequest ? 'Residency start' : 'Session date'}: ${(data['sessionDateText'] ?? '').toString()}',
                                  ),
                                ),
                              if (isCenterRequest && stayEndDateText.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'نهاية الإقامة المبدئية: $stayEndDateText'
                                        : 'Preliminary residency end: $stayEndDateText',
                                  ),
                                ),
                              if (isCenterRequest &&
                                  stayDurationDays.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'مدة الإقامة المبدئية: $stayDurationDays يوم'
                                        : 'Preliminary stay duration: $stayDurationDays day(s)',
                                  ),
                                ),
                              if (isCenterRequest &&
                                  stayDurationReason.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'سبب تحديد المدة مبدئيًا: $stayDurationReason'
                                        : 'Reason for preliminary duration: $stayDurationReason',
                                  ),
                                ),
                              if (isCenterRequest && stayDurationIsPreliminary)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'ملاحظة: المدة مبدئية وتؤكد أو تعدل بعد تقييم الاستقبال داخل المركز.'
                                        : 'Note: This duration is preliminary and may be confirmed or adjusted after intake assessment.',
                                  ),
                                ),
                              if ((data['sessionLink'] ?? '')
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'الرابط: ${(data['sessionLink'] ?? '').toString()}'
                                        : 'Link: ${(data['sessionLink'] ?? '').toString()}',
                                  ),
                                ),
                              if ((data['sessionCode'] ?? '')
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'الكود: ${(data['sessionCode'] ?? '').toString()}'
                                        : 'Code: ${(data['sessionCode'] ?? '').toString()}',
                                  ),
                                ),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                            if (isCenterRequest) ...[
                              Text(
                                isArabic
                                    ? 'تأكيد المركز لوصول الحالة: ${centerArrivalConfirmed ? 'تم' : 'بانتظار التأكيد'}'
                                    : 'Center arrival confirmation: ${centerArrivalConfirmed ? 'confirmed' : 'pending'}',
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                isArabic
                                    ? 'تأكيد الأسرة لبداية الإقامة: ${clientCheckInConfirmed ? 'تم' : 'بانتظار التأكيد'}'
                                    : 'Family check-in confirmation: ${clientCheckInConfirmed ? 'confirmed' : 'pending'}',
                              ),
                              if (status == 'session_in_progress')
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: AppSpacing.xs,
                                    bottom: AppSpacing.sm,
                                  ),
                                  child: Text(
                                    isArabic
                                        ? 'بدء الإقامة مؤكد${residencyStartedBy.isEmpty ? '' : ' بواسطة ${residencyStartedBy == 'center' ? 'المركز' : 'الأسرة'}'}'
                                        : 'Residency start confirmed${residencyStartedBy.isEmpty ? '' : ' by ${residencyStartedBy == 'center' ? 'center' : 'client'}'}',
                                  ),
                                )
                              else
                                const SizedBox(height: AppSpacing.sm),
                              if (status ==
                                      'session_completed_pending_reviews' ||
                                  status == 'payout_pending') ...[
                                Text(
                                  isArabic
                                      ? 'تقييم الأسرة: ${clientReviewSubmitted ? 'تم' : 'بانتظار الإرسال'}'
                                      : 'Family review: ${clientReviewSubmitted ? 'submitted' : 'pending'}',
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  isArabic
                                      ? 'تقرير خروج المركز: ${centerReviewSubmitted ? 'تم' : 'بانتظار الإرسال'}'
                                      : 'Center discharge report: ${centerReviewSubmitted ? 'submitted' : 'pending'}',
                                ),
                                const SizedBox(height: AppSpacing.sm),
                              ],
                            ] else if (status ==
                                    'session_completed_pending_reviews' ||
                                status == 'payout_pending') ...[
                              Text(
                                isArabic
                                    ? 'تقييم العميل: ${clientReviewSubmitted ? 'تم' : 'بانتظار الإرسال'}'
                                    : 'Client review: ${clientReviewSubmitted ? 'submitted' : 'pending'}',
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                isArabic
                                    ? 'تقييم الأخصائي: ${clinicianReviewSubmitted ? 'تم' : 'بانتظار الإرسال'}'
                                    : 'Clinician review: ${clinicianReviewSubmitted ? 'submitted' : 'pending'}',
                              ),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              alignment: WrapAlignment.end,
                              children: [
                                if (status == 'session_setup_pending' ||
                                    status == 'reschedule_pending')
                                  FilledButton.icon(
                                    onPressed: busy
                                        ? null
                                        : () => isCenterRequest
                                            ? _scheduleCenterResidency(
                                                requestId,
                                                data,
                                              )
                                            : _scheduleSession(requestId),
                                    icon: const Icon(Icons.video_call_outlined),
                                    label: Text(
                                      isArabic
                                          ? (isCenterRequest
                                              ? 'تأكيد التجهيز وفتح الدفع'
                                              : 'إنشاء/جدولة الجلسة')
                                          : (isCenterRequest
                                              ? 'Confirm setup and open payment'
                                              : 'Schedule session'),
                                    ),
                                  ),
                                if (status == 'session_scheduled' &&
                                    (!isCenterRequest ||
                                        (centerArrivalConfirmed &&
                                            clientCheckInConfirmed)))
                                  FilledButton.tonalIcon(
                                    onPressed: busy
                                        ? null
                                        : () => _markInProgress(requestId),
                                    icon: const Icon(Icons.play_circle_outline),
                                    label: Text(
                                      isArabic
                                          ? (isCenterRequest
                                              ? 'تعليم كإقامة جارية'
                                              : 'تعليم كجلسة جارية')
                                          : (isCenterRequest
                                              ? 'Mark residency in progress'
                                              : 'Mark in progress'),
                                    ),
                                  ),
                                if (isCenterRequest &&
                                    awaitingResidencyStart &&
                                    (!centerArrivalConfirmed ||
                                        !clientCheckInConfirmed))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppSpacing.xs,
                                    ),
                                    child: Text(
                                      isArabic
                                          ? 'سيظهر بدء الإقامة بعد تأكيد الوصول من المركز وتأكيد البداية من الأسرة.'
                                          : 'Residency start will appear after center arrival and family check-in confirmations.',
                                    ),
                                  ),
                                if ((status == 'session_scheduled' ||
                                        status == 'session_in_progress') &&
                                    (!isCenterRequest ||
                                        !awaitingResidencyStart))
                                  FilledButton.tonalIcon(
                                    onPressed: busy
                                        ? null
                                        : () => _markCompleted(requestId),
                                    icon: const Icon(Icons.task_alt_outlined),
                                    label: Text(
                                      isArabic
                                          ? (isCenterRequest
                                              ? 'تعليم كإقامة مكتملة'
                                              : 'تعليم كمكتملة')
                                          : (isCenterRequest
                                              ? 'Mark residency completed'
                                              : 'Mark completed'),
                                    ),
                                  ),
                                if (status == 'session_scheduled' ||
                                    status == 'session_in_progress')
                                  OutlinedButton.icon(
                                    onPressed: busy
                                        ? null
                                        : () => _moveToReschedule(requestId),
                                    icon: const Icon(Icons.update_outlined),
                                    label: Text(
                                      isArabic ? 'إعادة جدولة' : 'Reschedule',
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
