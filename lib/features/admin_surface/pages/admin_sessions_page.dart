import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/admin_surface/data/services/admin_session_decision_adapter.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminSessionsPage extends StatefulWidget {
  const AdminSessionsPage({super.key});

  @override
  State<AdminSessionsPage> createState() => _AdminSessionsPageState();
}

class _AdminSessionsPageState extends State<AdminSessionsPage> {
  final AdminSessionDecisionAdapter _sessionDecisionAdapter =
      AdminSessionDecisionAdapter();
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
                ? 'Ø£Ø¯Ø®Ù„ Ù…ÙˆØ¹Ø¯ Ø§Ù„Ø¬Ù„Ø³Ø© ÙˆØ§Ù„Ø±Ø§Ø¨Ø· ÙˆØ§Ù„ÙƒÙˆØ¯ Ø£ÙˆÙ„Ù‹Ø§'
                : 'Enter session date, link, and code first',
          ),
        ),
      );
      return;
    }

    await _setBusy(requestId, true);
    try {
      await _sessionDecisionAdapter.scheduleSession(
        requestId: requestId,
        dateText: dateText,
        linkText: linkText,
        codeText: codeText,
        notesText: notesText,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ…Øª Ø¬Ø¯ÙˆÙ„Ø© Ø§Ù„Ø¬Ù„Ø³Ø© Ø¨Ù†Ø¬Ø§Ø­'
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
                ? 'Ø£Ø¯Ø®Ù„ Ø¨Ø¯Ø§ÙŠØ© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© ÙˆÙ†Ù‡Ø§ÙŠØªÙ‡Ø§ ÙˆØ§Ù„Ù…Ø¯Ø© ÙˆØ§Ù„Ø³Ø¨Ø¨ ÙˆØ§Ù„Ø±Ø§Ø¨Ø· ÙˆØ§Ù„ÙƒÙˆØ¯ Ø£ÙˆÙ„Ù‹Ø§'
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
                ? 'Ø£Ø¯Ø®Ù„ Ø¹Ø¯Ø¯ Ø£ÙŠØ§Ù… Ø¥Ù‚Ø§Ù…Ø© ØµØ§Ù„Ø­'
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
        ? 'Ø³Ø¹Ø± ${pricingUnit == 'month' ? 'Ø´Ù‡Ø±ÙŠ' : 'ÙŠÙˆÙ…ÙŠ'} ${unitPrice.toStringAsFixed(unitPrice.truncateToDouble() == unitPrice ? 0 : 2)} Ã— $durationDays ÙŠÙˆÙ… + Ø¶Ø±ÙŠØ¨Ø© ${taxPercent.toStringAsFixed(0)}%'
        : '${pricingUnit == 'month' ? 'Monthly' : 'Daily'} price ${unitPrice.toStringAsFixed(unitPrice.truncateToDouble() == unitPrice ? 0 : 2)} Ã— $durationDays day(s) + ${taxPercent.toStringAsFixed(0)}% tax';

    final shouldOpenPayment = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            isArabic
                ? 'ØªØ£ÙƒÙŠØ¯ Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„ØªØ¬Ù‡ÙŠØ² ÙˆÙØªØ­ Ø§Ù„Ø¯ÙØ¹'
                : 'Confirm setup review and open payment',
          ),
          content: Text(
            isArabic
                ? 'Ø³ÙŠØªÙ… Ø­ÙØ¸ Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„ØªØ¬Ù‡ÙŠØ² ÙˆØ¥Ø±Ø³Ø§Ù„ Ø¨ÙŠØ§Ù† Ø§Ù„Ø¯ÙØ¹ Ù„Ù„Ø¹Ù…ÙŠÙ„. Ù‡Ø°Ø§ Ù„Ø§ ÙŠØ¹Ù†ÙŠ Ø§Ø¹ØªÙ…Ø§Ø¯ Ø§Ù„Ø¯ÙØ¹ Ø¨Ø¹Ø¯.'
                : 'Setup values will be saved and the payment quote will be opened for the client. Payment is not approved yet.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(isArabic ? 'Ø¥Ù„ØºØ§Ø¡' : 'Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                isArabic
                    ? 'ØªØ£ÙƒÙŠØ¯ ÙˆÙØªØ­ Ø§Ù„Ø¯ÙØ¹'
                    : 'Confirm and open payment',
              ),
            ),
          ],
        );
      },
    );
    if (shouldOpenPayment != true) return;

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
      await _sessionDecisionAdapter.scheduleCenterResidency(
        requestId: requestId,
        startText: startText,
        endText: endText,
        durationDays: durationDays,
        durationReasonText: durationReasonText,
        linkText: linkText,
        codeText: codeText,
        notesText: notesText,
        unitPrice: unitPrice,
        pricingUnit: pricingUnit,
        baseAmount: baseAmount,
        taxPercent: taxPercent,
        taxAmount: taxAmount,
        totalAmount: totalAmount,
        paymentBreakdownText: paymentBreakdownText,
        adminUid: FirebaseAuth.instance.currentUser?.uid ?? '',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'ØªÙ…Øª Ø¬Ø¯ÙˆÙ„Ø© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø§Ù„Ù…Ø¨Ø¯Ø¦ÙŠØ© ÙˆØ¥Ø±Ø³Ø§Ù„ Ø¨ÙŠØ§Ù† Ø§Ù„Ø¯ÙØ¹ Ù„Ù„Ø¹Ù…ÙŠÙ„'
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
                ? 'ÙØ´Ù„ Ø­ÙØ¸ Ø§Ù„Ø¬Ø¯ÙˆÙ„Ø© Ø£Ùˆ Ø¥Ø±Ø³Ø§Ù„ Ø¨ÙŠØ§Ù† Ø§Ù„Ø¯ÙØ¹: $e'
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
      await _sessionDecisionAdapter.markInProgress(requestId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… ØªØ­ÙˆÙŠÙ„ Ø§Ù„Ø¬Ù„Ø³Ø© Ø¥Ù„Ù‰ Ø¬Ø§Ø±ÙŠØ©'
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
      await _sessionDecisionAdapter.markCompleted(requestId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… ØªØ¹Ù„ÙŠÙ… Ø§Ù„Ø¬Ù„Ø³Ø© ÙƒÙ…ÙƒØªÙ…Ù„Ø©'
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
      await _sessionDecisionAdapter.moveToReschedule(requestId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… ØªØ­ÙˆÙŠÙ„ Ø§Ù„Ø·Ù„Ø¨ Ø¥Ù„Ù‰ Ø§Ù†ØªØ¸Ø§Ø± Ø¥Ø¹Ø§Ø¯Ø© Ø§Ù„Ø¬Ø¯ÙˆÙ„Ø©'
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

  String _whyHereLabel({
    required bool isArabic,
    required bool isCenterRequest,
    required String status,
    required bool awaitingResidencyStart,
  }) {
    switch (status) {
      case 'session_setup_pending':
        return isCenterRequest
            ? (isArabic
                ? 'بانتظار مراجعة تجهيز الإقامة قبل فتح الدفع'
                : 'Waiting for residency setup review before payment opening')
            : (isArabic
                ? 'بانتظار تجهيز جلسة أخصائي'
                : 'Waiting for clinician session setup');
      case 'reschedule_pending':
        return isArabic
            ? 'بانتظار معالجة إعادة الجدولة'
            : 'Waiting for reschedule handling';
      case 'session_scheduled':
        if (awaitingResidencyStart) {
          return isArabic
              ? 'الإقامة مجدولة وتنتظر تأكيدات البداية'
              : 'Residency is scheduled and waiting for start confirmations';
        }
        return isCenterRequest
            ? (isArabic
                ? 'الإقامة مجدولة للمتابعة'
                : 'Residency is scheduled for monitoring')
            : (isArabic
                ? 'الجلسة مجدولة للمتابعة'
                : 'Session is scheduled for monitoring');
      case 'session_in_progress':
        return isCenterRequest
            ? (isArabic
                ? 'الإقامة جارية وتحت المتابعة'
                : 'Residency is in progress and under monitoring')
            : (isArabic
                ? 'الجلسة جارية وتحت المتابعة'
                : 'Session is in progress and under monitoring');
      case 'session_completed_pending_reviews':
        return isCenterRequest
            ? (isArabic
                ? 'بانتظار تقييم الأسرة وتقرير خروج المركز'
                : 'Waiting for family review and center discharge report')
            : (isArabic
                ? 'بانتظار تقييم العميل والأخصائي'
                : 'Waiting for client and clinician reviews');
      case 'payout_pending':
        return isArabic
            ? 'بانتظار بوابة مالية أو مراجعة مستحقات'
            : 'Waiting for financial gate or payout review';
      default:
        return isArabic
            ? 'متابعة حالة من غرفة التحكم'
            : 'Control-room state monitoring';
    }
  }

  String _nextStepLabel({
    required bool isArabic,
    required bool isCenterRequest,
    required String status,
    required bool awaitingResidencyStart,
    required bool clientReviewSubmitted,
    required bool providerReviewSubmitted,
  }) {
    switch (status) {
      case 'session_setup_pending':
        return isCenterRequest
            ? (isArabic
                ? 'مراجعة التجهيز ثم فتح بيان الدفع'
                : 'Review setup, then open payment quote')
            : (isArabic
                ? 'استخدام إجراء الاسترداد عند الحاجة فقط'
                : 'Use recovery action only if needed');
      case 'reschedule_pending':
        return isArabic
            ? 'إعادة الجدولة كاسترداد مسار'
            : 'Reschedule as flow recovery';
      case 'session_scheduled':
        if (awaitingResidencyStart) {
          return isArabic
              ? 'انتظار تأكيد المركز والأسرة'
              : 'Wait for center and family confirmations';
        }
        return isArabic ? 'متابعة التشغيل' : 'Monitor operation';
      case 'session_in_progress':
        return isArabic ? 'متابعة حتى الاكتمال' : 'Monitor until completion';
      case 'session_completed_pending_reviews':
        if (!clientReviewSubmitted || !providerReviewSubmitted) {
          return isArabic
              ? 'استكمال التقييمات المطلوبة'
              : 'Complete required reviews';
        }
        return isArabic
            ? 'الانتقال للمراجعة المالية عند اكتمالها'
            : 'Move toward financial review when complete';
      case 'payout_pending':
        return isArabic
            ? 'مراجعة أو تأكيد المستحقات المالية'
            : 'Review or confirm financial payout';
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
      case 'session_setup_pending':
        return isCenterRequest
            ? (isArabic
                ? 'بوابة إدارية مالية قبل الدفع'
                : 'Admin financial gate before payment')
            : (isArabic
                ? 'استرداد إداري لجلسة أخصائي'
                : 'Admin recovery for clinician session');
      case 'reschedule_pending':
        return isArabic ? 'استرداد إداري فقط' : 'Admin recovery only';
      case 'session_scheduled':
      case 'session_in_progress':
        return isCenterRequest
            ? (isArabic
                ? 'المسار التشغيلي: المركز / الأسرة'
                : 'Operational path: center / family')
            : (isArabic
                ? 'المسار التشغيلي: الأخصائي / العميل'
                : 'Operational path: clinician / client');
      case 'session_completed_pending_reviews':
        return isCenterRequest
            ? (isArabic
                ? 'التقييمات: الأسرة / المركز'
                : 'Reviews: family / center')
            : (isArabic
                ? 'التقييمات: العميل / الأخصائي'
                : 'Reviews: client / clinician');
      case 'payout_pending':
        return isArabic ? 'بوابة مالية إدارية' : 'Admin financial gate';
      default:
        return isArabic ? 'متابعة من غرفة التحكم' : 'Control-room monitoring';
    }
  }

  String? _blockingReasonLabel({
    required bool isArabic,
    required bool isCenterRequest,
    required String status,
    required bool awaitingResidencyStart,
    required bool centerArrivalConfirmed,
    required bool clientCheckInConfirmed,
    required bool clientReviewSubmitted,
    required bool providerReviewSubmitted,
    required List<String> setupWarnings,
  }) {
    if (status == 'session_setup_pending' ||
        status == 'reschedule_pending') {
      if (setupWarnings.isNotEmpty) {
        return setupWarnings.first;
      }
      return null;
    }
    if (awaitingResidencyStart) {
      if (!centerArrivalConfirmed && !clientCheckInConfirmed) {
        return isArabic
            ? 'بانتظار تأكيد المركز والأسرة لبداية الإقامة'
            : 'Waiting for center and family start confirmations';
      }
      if (!centerArrivalConfirmed) {
        return isArabic
            ? 'بانتظار تأكيد المركز للوصول'
            : 'Waiting for center arrival confirmation';
      }
      return isArabic
          ? 'بانتظار تأكيد الأسرة لبداية الإقامة'
          : 'Waiting for family check-in confirmation';
    }
    if (status == 'session_completed_pending_reviews') {
      if (!clientReviewSubmitted && !providerReviewSubmitted) {
        return isCenterRequest
            ? (isArabic
                ? 'بانتظار تقييم الأسرة وتقرير المركز'
                : 'Waiting for family review and center report')
            : (isArabic
                ? 'بانتظار تقييم العميل والأخصائي'
                : 'Waiting for client and clinician reviews');
      }
      if (!clientReviewSubmitted) {
        return isArabic
            ? 'بانتظار تقييم العميل / الأسرة'
            : 'Waiting for client / family review';
      }
      if (!providerReviewSubmitted) {
        return isCenterRequest
            ? (isArabic
                ? 'بانتظار تقرير المركز'
                : 'Waiting for center report')
            : (isArabic
                ? 'بانتظار تقييم الأخصائي'
                : 'Waiting for clinician review');
      }
    }
    return null;
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
                    child: Column(
                      crossAxisAlignment: isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic
                              ? 'متابعة الجاهزية والاستثناءات للجلسات'
                              : 'Sessions Readiness & Exception Control',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          isArabic
                              ? 'التركيز: جاهزية الجلسات، العوائق، تأكيدات البدء، وحالات الاسترداد.'
                              : 'Focus: session readiness, blockers, start confirmations, and recovery cases.',
                          textAlign: isArabic ? TextAlign.right : TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.obsidian
                                        .withValues(alpha: 0.72),
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          alignment: WrapAlignment.end,
                          children: [
                            ChoiceChip(
                              selected: _tab == 'session_setup_pending',
                              label: Text(
                                isArabic ? 'بانتظار التجهيز' : 'Setup pending',
                              ),
                              onSelected: (_) => setState(
                                  () => _tab = 'session_setup_pending'),
                            ),
                            ChoiceChip(
                              selected: _tab == 'reschedule_pending',
                              label: Text(
                                isArabic ? 'إعادة جدولة' : 'Reschedule',
                              ),
                              onSelected: (_) =>
                                  setState(() => _tab = 'reschedule_pending'),
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
                              selected:
                                  _tab == 'session_completed_pending_reviews',
                              label: Text(
                                isArabic
                                    ? 'بانتظار التقارير/التقييمات'
                                    : 'Pending reviews',
                              ),
                              onSelected: (_) => setState(
                                () =>
                                    _tab = 'session_completed_pending_reviews',
                              ),
                            ),
                          ],
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
                      final providerReviewSubmitted = isCenterRequest
                          ? centerReviewSubmitted
                          : clinicianReviewSubmitted;
                      final residencyStartedBy =
                          (data['residencyStartedBy'] ?? '').toString();
                      final awaitingResidencyStart = _isAwaitingResidencyStart(
                        status,
                        isCenterRequest,
                        centerArrivalConfirmed,
                        clientCheckInConfirmed,
                      );
                      final canOpenPaymentGate = isCenterRequest &&
                          (status == 'session_setup_pending' ||
                              status == 'reschedule_pending');
                      final canScheduleSessionFallback = !isCenterRequest &&
                          (status == 'session_setup_pending' ||
                              status == 'reschedule_pending');
                      final canMarkInProgressAction =
                          status == 'session_scheduled' &&
                              (!isCenterRequest ||
                                  (centerArrivalConfirmed &&
                                      clientCheckInConfirmed));
                      final canShowResidencyStartHint = isCenterRequest &&
                          awaitingResidencyStart &&
                          (!centerArrivalConfirmed || !clientCheckInConfirmed);
                      final canMarkCompletedAction =
                          (status == 'session_scheduled' ||
                                  status == 'session_in_progress') &&
                              (!isCenterRequest || !awaitingResidencyStart);
                      final canRescheduleAction =
                          status == 'session_scheduled' ||
                              status == 'session_in_progress';
                      final hasFallbackActions = canScheduleSessionFallback ||
                          canMarkInProgressAction ||
                          canShowResidencyStartHint ||
                          canMarkCompletedAction ||
                          canRescheduleAction;

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
                              ? 'Ù„Ø§ ØªÙˆØ¬Ø¯ Ù…Ø¯Ø© Ù…ÙˆØµÙ‰ Ø¨Ù‡Ø§ Ù…Ù† Ø§Ù„Ù…Ø±ÙƒØ².'
                              : 'No center-recommended duration is available.',
                        if (isCenterRequest &&
                            centerRecommendedStayDays > 0 &&
                            enteredDurationDays > 0 &&
                            enteredDurationDays != centerRecommendedStayDays)
                          isArabic
                              ? 'Ù…Ø¯Ø© Ø§Ù„ØªØ¬Ù‡ÙŠØ² ØªØ®ØªÙ„Ù Ø¹Ù† Ù…Ø¯Ø© ØªÙˆØµÙŠØ© Ø§Ù„Ù…Ø±ÙƒØ².'
                              : 'Setup duration differs from the center recommendation.',
                        if (isCenterRequest &&
                            (selectedAccommodationPrice <= 0 ||
                                selectedAccommodationPricingUnit.isEmpty))
                          isArabic
                              ? 'Ø¨ÙŠØ§Ù†Ø§Øª ØªØ³Ø¹ÙŠØ± Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© ØºÙŠØ± Ù…ÙƒØªÙ…Ù„Ø©.'
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
                              ? 'Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø§Ù„Ù…Ø®ØªØ§Ø±Ø© ØªØ®ØªÙ„Ù Ø¹Ù† Ù…Ø³ÙˆØ¯Ø© Ø§Ù„Ø¹Ù‚Ø¯.'
                              : 'Selected accommodation differs from the contract draft.',
                        if (isCenterRequest && existingQuoteAlready)
                          isArabic
                              ? 'ÙŠÙˆØ¬Ø¯ ØªØ¬Ù‡ÙŠØ² Ø³Ø§Ø¨Ù‚ Ù…Ø­ÙÙˆØ¸Ø› Ù„Ù† ÙŠØªÙ… Ø§Ø³ØªØ®Ø¯Ø§Ù… Ø§Ù„Ù…Ù„Ø¡ Ø§Ù„ØªÙ„Ù‚Ø§Ø¦ÙŠ.'
                              : 'Existing setup already exists; pre-fill is not applied.',
                      ];
                      final whyHere = _whyHereLabel(
                        isArabic: isArabic,
                        isCenterRequest: isCenterRequest,
                        status: status,
                        awaitingResidencyStart: awaitingResidencyStart,
                      );
                      final nextStructuredStep = _nextStepLabel(
                        isArabic: isArabic,
                        isCenterRequest: isCenterRequest,
                        status: status,
                        awaitingResidencyStart: awaitingResidencyStart,
                        clientReviewSubmitted: clientReviewSubmitted,
                        providerReviewSubmitted: providerReviewSubmitted,
                      );
                      final ownershipCue = _ownershipCueLabel(
                        isArabic: isArabic,
                        isCenterRequest: isCenterRequest,
                        status: status,
                      );
                      final blockingReason = _blockingReasonLabel(
                        isArabic: isArabic,
                        isCenterRequest: isCenterRequest,
                        status: status,
                        awaitingResidencyStart: awaitingResidencyStart,
                        centerArrivalConfirmed: centerArrivalConfirmed,
                        clientCheckInConfirmed: clientCheckInConfirmed,
                        clientReviewSubmitted: clientReviewSubmitted,
                        providerReviewSubmitted: providerReviewSubmitted,
                        setupWarnings: setupWarnings,
                      );
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
                                                  ? 'Ø§Ù„Ù…Ø±ÙƒØ²: $companionName'
                                                  : 'Center: $companionName')
                                              : (isArabic
                                                  ? 'Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ: $companionName'
                                                  : 'Clinician: $companionName'),
                                        ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isCenterRequest
                                            ? (isArabic
                                                ? 'Ø·Ù„Ø¨ Ù…Ø±ÙƒØ²'
                                                : 'Center request')
                                            : (isArabic
                                                ? 'Ø·Ù„Ø¨ Ø£Ø®ØµØ§Ø¦ÙŠ'
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
                                          ? 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªØ£ÙƒÙŠØ¯ Ø§Ù„Ø¨Ø¯Ø§ÙŠØ©'
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
                                      ? 'ØªØ§Ø±ÙŠØ® Ø§Ù„Ø·Ù„Ø¨: $createdAt'
                                      : 'Request date: $createdAt',
                                ),
                              ),
                            if (note.trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppSpacing.xs),
                                child: Text(
                                  isArabic
                                      ? 'Ù…Ù„Ø§Ø­Ø¸Ø© Ø§Ù„Ø¹Ù…ÙŠÙ„: $note'
                                      : 'Client note: $note',
                                ),
                              ),
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
                                        ? 'Ù…Ø±Ø§Ù‚Ø¨Ø© / Ø¹ÙˆØ§Ø¦Ù‚ / Ø§Ù„Ø®Ø·ÙˆØ© Ø§Ù„ØªØ§Ù„ÙŠØ©'
                                        : 'Monitoring / Blockers / Next Step',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ø³Ø¨Ø¨ ÙˆØ¬ÙˆØ¯ Ø§Ù„Ø·Ù„Ø¨ Ù‡Ù†Ø§: $whyHere'
                                        : 'Why this is here: $whyHere',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ø§Ù„Ø®Ø·ÙˆØ© Ø§Ù„Ù…Ù†Ø¸Ù…Ø© Ø§Ù„ØªØ§Ù„ÙŠØ©: $nextStructuredStep'
                                        : 'Next structured step: $nextStructuredStep',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ø¥Ø´Ø§Ø±Ø© Ø§Ù„Ù…Ù„ÙƒÙŠØ©: $ownershipCue'
                                        : 'Ownership cue: $ownershipCue',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  if (blockingReason != null) ...[
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      isArabic
                                          ? 'Ø³Ø¨Ø¨ Ø§Ù„ØªØ¹Ø·ÙŠÙ„: $blockingReason'
                                          : 'Blocking reason: $blockingReason',
                                      textAlign: isArabic
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: const Color(0xFF9A6A00),
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            if (status == 'session_setup_pending' ||
                                status == 'reschedule_pending') ...[
                              Text(
                                isArabic ? 'Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„ØªØ¬Ù‡ÙŠØ²' : 'Setup review',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                isArabic
                                    ? 'Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„ØªØ¬Ù‡ÙŠØ² Ø®Ø·ÙˆØ© ØªØ­Ù‚Ù‚ Ù‚Ø¨Ù„ ÙØªØ­ Ø§Ù„Ø¯ÙØ¹ØŒ ÙˆÙ„ÙŠØ³Øª Ù…Ù„ÙƒÙŠØ© ØªØ´ØºÙŠÙ„ÙŠØ© Ø¹Ø§Ø¯ÙŠØ© Ù„Ù„Ø¥Ø¯Ø§Ø±Ø©.'
                                    : 'Setup review is a verification step before payment opening, not normal admin operational ownership.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.obsidian
                                          .withValues(alpha: 0.72),
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              TextField(
                                controller: dateCtrl,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic
                                      ? (isCenterRequest
                                          ? 'Ù…ÙˆØ¹Ø¯ Ø¨Ø¯Ø§ÙŠØ© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©'
                                          : 'Ù…ÙˆØ¹Ø¯ Ø§Ù„Ø¬Ù„Ø³Ø©')
                                      : (isCenterRequest
                                          ? 'Residency start'
                                          : 'Session date/time'),
                                  icon: Icons.event_outlined,
                                  hintText: isArabic
                                      ? 'Ù…Ø«Ø§Ù„: 25-03-2026 08:30 PM'
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
                                            ? 'Ø³ÙŠØ§Ù‚ Ø§Ù„ØªØ¬Ù‡ÙŠØ² Ø§Ù„Ù…Ù‚ØªØ±Ø­'
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
                                              ? 'ØªÙˆØµÙŠØ© Ø§Ù„Ù…Ø±ÙƒØ²: ${_centerCareLevelLabel(centerRecommendedCareLevel, isArabic)}'
                                              : 'Center recommendation: ${_centerCareLevelLabel(centerRecommendedCareLevel, isArabic)}',
                                        ),
                                      if (centerRecommendedStayDays > 0)
                                        Text(
                                          isArabic
                                              ? 'Ù…Ø¯Ø© Ù…ÙˆØµÙ‰ Ø¨Ù‡Ø§: $centerRecommendedStayDays ÙŠÙˆÙ…'
                                              : 'Recommended duration: $centerRecommendedStayDays day(s)',
                                        ),
                                      Text(
                                        isArabic
                                            ? 'ÙŠØ­ØªØ§Ø¬ ØªÙ‚ÙŠÙŠÙ…Ù‹Ø§ Ø¯Ø§Ø®Ù„ÙŠÙ‹Ø§: ${centerNeedsInternalAssessment ? 'Ù†Ø¹Ù…' : 'Ù„Ø§'}'
                                            : 'Needs internal assessment: ${centerNeedsInternalAssessment ? 'Yes' : 'No'}',
                                      ),
                                      if (selectedAccommodationLabel.isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø§Ù„Ù…Ø®ØªØ§Ø±Ø©: $selectedAccommodationLabel'
                                              : 'Selected accommodation: $selectedAccommodationLabel',
                                        ),
                                      if (selectedAccommodationPrice > 0 ||
                                          selectedAccommodationPricingUnit
                                              .isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'ØªØ³Ø¹ÙŠØ± Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©: ${selectedAccommodationPrice.toStringAsFixed(selectedAccommodationPrice.truncateToDouble() == selectedAccommodationPrice ? 0 : 2)} / $selectedAccommodationPricingUnit'
                                              : 'Accommodation pricing: ${selectedAccommodationPrice.toStringAsFixed(selectedAccommodationPrice.truncateToDouble() == selectedAccommodationPrice ? 0 : 2)} / $selectedAccommodationPricingUnit',
                                        ),
                                      if (contractRoomLabel.isNotEmpty ||
                                          contractRoomPrice > 0 ||
                                          contractPricingUnit.isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'Ù…Ø³ÙˆØ¯Ø© Ø§Ù„Ø¹Ù‚Ø¯: ${contractRoomLabel.isEmpty ? '-' : contractRoomLabel} | ${contractRoomPrice.toStringAsFixed(contractRoomPrice.truncateToDouble() == contractRoomPrice ? 0 : 2)} / $contractPricingUnit'
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
                                        ? 'ØªØ§Ø±ÙŠØ® Ù†Ù‡Ø§ÙŠØ© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø§Ù„Ù…Ø¨Ø¯Ø¦ÙŠ'
                                        : 'Preliminary residency end',
                                    icon: Icons.event_available_outlined,
                                    hintText: isArabic
                                        ? 'Ù…Ø«Ø§Ù„: 30-03-2026 12:00 PM'
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
                                        ? 'Ø¹Ø¯Ø¯ Ø£ÙŠØ§Ù… Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø§Ù„Ù…Ø¨Ø¯Ø¦ÙŠ'
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
                                        ? 'Ø³Ø¨Ø¨ ØªØ­Ø¯ÙŠØ¯ Ø§Ù„Ù…Ø¯Ø© Ù…Ø¨Ø¯Ø¦ÙŠÙ‹Ø§'
                                        : 'Reason for preliminary duration',
                                    icon: Icons.fact_check_outlined,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  isArabic
                                      ? 'Ù‡Ø°Ù‡ Ø§Ù„Ù…Ø¯Ø© Ù…Ø¨Ø¯Ø¦ÙŠØ© Ø­ØªÙ‰ ØªÙ‚ÙŠÙŠÙ… Ø§Ù„Ø­Ø§Ù„Ø© Ø¹Ù†Ø¯ Ø§Ù„Ø§Ø³ØªÙ‚Ø¨Ø§Ù„ Ø¯Ø§Ø®Ù„ Ø§Ù„Ù…Ø±ÙƒØ².'
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
                                              ? 'ØªÙ†Ø¨ÙŠÙ‡Ø§Øª ØºÙŠØ± Ù…Ø§Ù†Ø¹Ø©'
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
                                    isArabic ? 'ÙØªØ­ Ø§Ù„Ø¯ÙØ¹' : 'Payment opening',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ø³ÙŠØ¤Ø¯ÙŠ Ø§Ù„ØªØ£ÙƒÙŠØ¯ Ø¥Ù„Ù‰ Ø¥Ø±Ø³Ø§Ù„ Ø¨ÙŠØ§Ù† Ø§Ù„Ø¯ÙØ¹ Ù„Ù„Ø¹Ù…ÙŠÙ„ØŒ ÙˆÙ„ÙŠØ³ Ø§Ø¹ØªÙ…Ø§Ø¯ Ø§Ù„Ø¯ÙØ¹.'
                                        : 'Confirming sends the payment quote to the client; it does not approve payment.',
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ù‡Ø°Ù‡ Ø¨ÙˆØ§Ø¨Ø© Ù…Ø§Ù„ÙŠØ© ØªØ­Øª Ø¥Ø´Ø±Ø§Ù Ø§Ù„Ø¥Ø¯Ø§Ø±Ø©ØŒ ÙˆÙ„ÙŠØ³Øª Ø§Ø¹ØªÙ…Ø§Ø¯Ù‹Ø§ Ù„Ù„Ø¯ÙØ¹ Ø£Ùˆ ØªÙ†ÙÙŠØ°Ù‹Ø§ Ù„Ù„Ø±Ø¹Ø§ÙŠØ©.'
                                        : 'This is an admin-supervised financial gate, not payment approval or care execution.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.obsidian
                                              .withValues(alpha: 0.72),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    isArabic
                                        ? 'Ø§Ù„Ø³Ø¹Ø± ${selectedAccommodationPricingUnit == 'month' ? 'Ø§Ù„Ø´Ù‡Ø±ÙŠ' : 'Ø§Ù„ÙŠÙˆÙ…ÙŠ'}: ${selectedAccommodationPrice.toStringAsFixed(selectedAccommodationPrice.truncateToDouble() == selectedAccommodationPrice ? 0 : 2)}'
                                        : '${selectedAccommodationPricingUnit == 'month' ? 'Monthly' : 'Daily'} price: ${selectedAccommodationPrice.toStringAsFixed(selectedAccommodationPrice.truncateToDouble() == selectedAccommodationPrice ? 0 : 2)}',
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ø§Ù„Ù…Ø¨Ù„Øº Ø§Ù„Ø£Ø³Ø§Ø³ÙŠ: ${computedBaseAmount.toStringAsFixed(2)}'
                                        : 'Base amount: ${computedBaseAmount.toStringAsFixed(2)}',
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ø§Ù„Ø¶Ø±ÙŠØ¨Ø© 10%: ${computedTaxAmount.toStringAsFixed(2)}'
                                        : 'Tax 10%: ${computedTaxAmount.toStringAsFixed(2)}',
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ø§Ù„Ù…Ø¨Ù„Øº Ø§Ù„Ù…Ø·Ù„ÙˆØ¨ Ù…Ù† Ø§Ù„Ø¹Ù…ÙŠÙ„: ${computedTotalAmount.toStringAsFixed(2)}'
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
                                          ? 'Ø±Ø§Ø¨Ø· Ø§Ù„Ù…ØªØ§Ø¨Ø¹Ø©'
                                          : 'Ø±Ø§Ø¨Ø· Ø§Ù„Ø¬Ù„Ø³Ø©')
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
                                          ? 'ÙƒÙˆØ¯ Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©'
                                          : 'ÙƒÙˆØ¯ Ø§Ù„Ø¬Ù„Ø³Ø©')
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
                                      ? 'Ù…Ù„Ø§Ø­Ø¸Ø§Øª Ø§Ù„Ø¥Ø¯Ø§Ø±Ø©'
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
                                        ? '${isCenterRequest ? 'Ù…ÙˆØ¹Ø¯ Ø¨Ø¯Ø§ÙŠØ© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©' : 'Ù…ÙˆØ¹Ø¯ Ø§Ù„Ø¬Ù„Ø³Ø©'}: ${(data['sessionDateText'] ?? '').toString()}'
                                        : '${isCenterRequest ? 'Residency start' : 'Session date'}: ${(data['sessionDateText'] ?? '').toString()}',
                                  ),
                                ),
                              if (isCenterRequest && stayEndDateText.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'Ù†Ù‡Ø§ÙŠØ© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø§Ù„Ù…Ø¨Ø¯Ø¦ÙŠØ©: $stayEndDateText'
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
                                        ? 'Ù…Ø¯Ø© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø§Ù„Ù…Ø¨Ø¯Ø¦ÙŠØ©: $stayDurationDays ÙŠÙˆÙ…'
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
                                        ? 'Ø³Ø¨Ø¨ ØªØ­Ø¯ÙŠØ¯ Ø§Ù„Ù…Ø¯Ø© Ù…Ø¨Ø¯Ø¦ÙŠÙ‹Ø§: $stayDurationReason'
                                        : 'Reason for preliminary duration: $stayDurationReason',
                                  ),
                                ),
                              if (isCenterRequest && stayDurationIsPreliminary)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Text(
                                    isArabic
                                        ? 'Ù…Ù„Ø§Ø­Ø¸Ø©: Ø§Ù„Ù…Ø¯Ø© Ù…Ø¨Ø¯Ø¦ÙŠØ© ÙˆØªØ¤ÙƒØ¯ Ø£Ùˆ ØªØ¹Ø¯Ù„ Ø¨Ø¹Ø¯ ØªÙ‚ÙŠÙŠÙ… Ø§Ù„Ø§Ø³ØªÙ‚Ø¨Ø§Ù„ Ø¯Ø§Ø®Ù„ Ø§Ù„Ù…Ø±ÙƒØ².'
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
                                        ? 'Ø§Ù„Ø±Ø§Ø¨Ø·: ${(data['sessionLink'] ?? '').toString()}'
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
                                        ? 'Ø§Ù„ÙƒÙˆØ¯: ${(data['sessionCode'] ?? '').toString()}'
                                        : 'Code: ${(data['sessionCode'] ?? '').toString()}',
                                  ),
                                ),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                            if (isCenterRequest) ...[
                              Text(
                                isArabic
                                    ? 'ØªØ£ÙƒÙŠØ¯ Ø§Ù„Ù…Ø±ÙƒØ² Ù„ÙˆØµÙˆÙ„ Ø§Ù„Ø­Ø§Ù„Ø©: ${centerArrivalConfirmed ? 'ØªÙ…' : 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„ØªØ£ÙƒÙŠØ¯'}'
                                    : 'Center arrival confirmation: ${centerArrivalConfirmed ? 'confirmed' : 'pending'}',
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                isArabic
                                    ? 'ØªØ£ÙƒÙŠØ¯ Ø§Ù„Ø£Ø³Ø±Ø© Ù„Ø¨Ø¯Ø§ÙŠØ© Ø§Ù„Ø¥Ù‚Ø§Ù…Ø©: ${clientCheckInConfirmed ? 'ØªÙ…' : 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„ØªØ£ÙƒÙŠØ¯'}'
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
                                        ? 'Ø¨Ø¯Ø¡ Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ù…Ø¤ÙƒØ¯${residencyStartedBy.isEmpty ? '' : ' Ø¨ÙˆØ§Ø³Ø·Ø© ${residencyStartedBy == 'center' ? 'Ø§Ù„Ù…Ø±ÙƒØ²' : 'Ø§Ù„Ø£Ø³Ø±Ø©'}'}'
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
                                      ? 'ØªÙ‚ÙŠÙŠÙ… Ø§Ù„Ø£Ø³Ø±Ø©: ${clientReviewSubmitted ? 'ØªÙ…' : 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ø¥Ø±Ø³Ø§Ù„'}'
                                      : 'Family review: ${clientReviewSubmitted ? 'submitted' : 'pending'}',
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  isArabic
                                      ? 'ØªÙ‚Ø±ÙŠØ± Ø®Ø±ÙˆØ¬ Ø§Ù„Ù…Ø±ÙƒØ²: ${centerReviewSubmitted ? 'ØªÙ…' : 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ø¥Ø±Ø³Ø§Ù„'}'
                                      : 'Center discharge report: ${centerReviewSubmitted ? 'submitted' : 'pending'}',
                                ),
                                const SizedBox(height: AppSpacing.sm),
                              ],
                            ] else if (status ==
                                    'session_completed_pending_reviews' ||
                                status == 'payout_pending') ...[
                              Text(
                                isArabic
                                    ? 'ØªÙ‚ÙŠÙŠÙ… Ø§Ù„Ø¹Ù…ÙŠÙ„: ${clientReviewSubmitted ? 'ØªÙ…' : 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ø¥Ø±Ø³Ø§Ù„'}'
                                    : 'Client review: ${clientReviewSubmitted ? 'submitted' : 'pending'}',
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                isArabic
                                    ? 'ØªÙ‚ÙŠÙŠÙ… Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ: ${clinicianReviewSubmitted ? 'ØªÙ…' : 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ø¥Ø±Ø³Ø§Ù„'}'
                                    : 'Clinician review: ${clinicianReviewSubmitted ? 'submitted' : 'pending'}',
                              ),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                            if (canOpenPaymentGate) ...[
                              Wrap(
                                spacing: AppSpacing.sm,
                                runSpacing: AppSpacing.sm,
                                alignment: WrapAlignment.end,
                                children: [
                                  FilledButton.icon(
                                    onPressed: busy
                                        ? null
                                        : () => _scheduleCenterResidency(
                                              requestId,
                                              data,
                                            ),
                                    icon: const Icon(Icons.payments_outlined),
                                    label: Text(
                                      isArabic
                                          ? 'ØªØ£ÙƒÙŠØ¯ Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„ØªØ¬Ù‡ÙŠØ² ÙˆÙØªØ­ Ø§Ù„Ø¯ÙØ¹'
                                          : 'Confirm setup review and open payment',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                            if (hasFallbackActions)
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
                                        ? 'Ø¥Ø¬Ø±Ø§Ø¡Ø§Øª Ø§Ø³ØªØ«Ù†Ø§Ø¦ÙŠØ© / Ø§Ø³ØªØ±Ø¯Ø§Ø¯ Ø§Ù„Ù…Ø³Ø§Ø±'
                                        : 'Fallback / Recovery Actions',
                                    textAlign:
                                        isArabic ? TextAlign.right : TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  subtitle: Text(
                                    isArabic
                                        ? 'ØªÙØ³ØªØ®Ø¯Ù… Ù‡Ø°Ù‡ Ø§Ù„Ø¥Ø¬Ø±Ø§Ø¡Ø§Øª ÙÙ‚Ø· Ø¹Ù†Ø¯ Ø§Ù„Ø­Ø§Ø¬Ø© Ø¥Ù„Ù‰ ØªØµØ­ÙŠØ­ Ø¥Ø¯Ø§Ø±ÙŠ Ø£Ùˆ Ø§Ø³ØªØ±Ø¯Ø§Ø¯ Ø§Ù„Ù…Ø³Ø§Ø±ØŒ ÙˆÙ„ÙŠØ³Øª Ø§Ù„Ù…Ø³Ø§Ø± Ø§Ù„ØªØ´ØºÙŠÙ„ÙŠ Ø§Ù„Ù…Ø¹ØªØ§Ø¯.'
                                        : 'These actions are for admin correction or flow recovery only, not the normal operational path.',
                                    textAlign:
                                        isArabic ? TextAlign.right : TextAlign.left,
                                  ),
                                  children: [
                                    Wrap(
                                      spacing: AppSpacing.sm,
                                      runSpacing: AppSpacing.sm,
                                      alignment: WrapAlignment.end,
                                      children: [
                                        if (canScheduleSessionFallback)
                                          FilledButton.icon(
                                            onPressed: busy
                                                ? null
                                                : () =>
                                                    _scheduleSession(requestId),
                                            icon: const Icon(
                                              Icons.video_call_outlined,
                                            ),
                                            label: Text(
                                              isArabic
                                                  ? 'Ø¥Ù†Ø´Ø§Ø¡/Ø¬Ø¯ÙˆÙ„Ø© Ø§Ù„Ø¬Ù„Ø³Ø©'
                                                  : 'Schedule session',
                                            ),
                                          ),
                                        if (canMarkInProgressAction)
                                          FilledButton.tonalIcon(
                                            onPressed: busy
                                                ? null
                                                : () =>
                                                    _markInProgress(requestId),
                                            icon: const Icon(
                                              Icons.play_circle_outline,
                                            ),
                                            label: Text(
                                              isArabic
                                                  ? (isCenterRequest
                                                      ? 'ØªØ¹Ù„ÙŠÙ… ÙƒØ¥Ù‚Ø§Ù…Ø© Ø¬Ø§Ø±ÙŠØ©'
                                                      : 'ØªØ¹Ù„ÙŠÙ… ÙƒØ¬Ù„Ø³Ø© Ø¬Ø§Ø±ÙŠØ©')
                                                  : (isCenterRequest
                                                      ? 'Mark residency in progress'
                                                      : 'Mark in progress'),
                                            ),
                                          ),
                                        if (canShowResidencyStartHint)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: AppSpacing.xs,
                                            ),
                                            child: Text(
                                              isArabic
                                                  ? 'Ø³ÙŠØ¸Ù‡Ø± Ø¨Ø¯Ø¡ Ø§Ù„Ø¥Ù‚Ø§Ù…Ø© Ø¨Ø¹Ø¯ ØªØ£ÙƒÙŠØ¯ Ø§Ù„ÙˆØµÙˆÙ„ Ù…Ù† Ø§Ù„Ù…Ø±ÙƒØ² ÙˆØªØ£ÙƒÙŠØ¯ Ø§Ù„Ø¨Ø¯Ø§ÙŠØ© Ù…Ù† Ø§Ù„Ø£Ø³Ø±Ø©.'
                                                  : 'Residency start will appear after center arrival and family check-in confirmations.',
                                            ),
                                          ),
                                        if (canMarkCompletedAction)
                                          FilledButton.tonalIcon(
                                            onPressed: busy
                                                ? null
                                                : () =>
                                                    _markCompleted(requestId),
                                            icon: const Icon(
                                              Icons.task_alt_outlined,
                                            ),
                                            label: Text(
                                              isArabic
                                                  ? (isCenterRequest
                                                      ? 'ØªØ¹Ù„ÙŠÙ… ÙƒØ¥Ù‚Ø§Ù…Ø© Ù…ÙƒØªÙ…Ù„Ø©'
                                                      : 'ØªØ¹Ù„ÙŠÙ… ÙƒÙ…ÙƒØªÙ…Ù„Ø©')
                                                  : (isCenterRequest
                                                      ? 'Mark residency completed'
                                                      : 'Mark completed'),
                                            ),
                                          ),
                                        if (canRescheduleAction)
                                          OutlinedButton.icon(
                                            onPressed: busy
                                                ? null
                                                : () =>
                                                    _moveToReschedule(requestId),
                                            icon:
                                                const Icon(Icons.update_outlined),
                                            label: Text(
                                              isArabic
                                                  ? 'Ø¥Ø¹Ø§Ø¯Ø© Ø¬Ø¯ÙˆÙ„Ø©'
                                                  : 'Reschedule',
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
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
