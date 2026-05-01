import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/admin_surface/data/services/admin_payment_decision_adapter.dart';
import 'package:flutterprojects/features/booking/data/services/booking_health_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminPaymentsPage extends StatefulWidget {
  const AdminPaymentsPage({super.key});

  @override
  State<AdminPaymentsPage> createState() => _AdminPaymentsPageState();
}

class _AdminPaymentsPageState extends State<AdminPaymentsPage> {
  static const BookingHealthService _bookingHealthService =
      BookingHealthService();
  final AdminPaymentDecisionAdapter _paymentDecisionAdapter =
      AdminPaymentDecisionAdapter();
  String _tab = 'payment_review';
  final Set<String> _busyIds = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emitBookingHealth();
    });
  }

  Future<void> _emitBookingHealth() async {
    try {
      await _bookingHealthService.emitHealthSnapshot(
        sampleType: 'admin_payments_open',
      );
    } catch (_) {
      // Health reporting must stay quiet and never block payments usage.
    }
  }

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

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

  Future<void> _approvePayment(String requestId) async {
    await _setBusy(requestId, true);
    try {
      final result = await _paymentDecisionAdapter.approvePayment(requestId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? (result.isCenterRequest
                    ? 'ØªÙ… Ø§Ø¹ØªÙ…Ø§Ø¯ Ø§Ù„Ø³Ø¯Ø§Ø¯ ÙˆØªØ­ÙˆÙŠÙ„ Ø§Ù„Ø·Ù„Ø¨ Ø¥Ù„Ù‰ Ø¥Ù‚Ø§Ù…Ø© Ù…Ø¨Ø¯Ø¦ÙŠØ© Ù…Ø¬Ø¯ÙˆÙ„Ø©'
                    : 'ØªÙ… Ø§Ø¹ØªÙ…Ø§Ø¯ Ø§Ù„Ø³Ø¯Ø§Ø¯ ÙˆØªØ­ÙˆÙŠÙ„ Ø§Ù„Ø·Ù„Ø¨ Ø¥Ù„Ù‰ Ù‚Ø³Ù… Ø§Ù„Ø¬Ù„Ø³Ø§Øª')
                : (result.isCenterRequest
                    ? 'Payment signal confirmed; next step updated to preliminary residency scheduled'
                    : 'Payment signal confirmed; next step updated to sessions setup'),
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _rejectPayment(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _paymentDecisionAdapter.rejectPayment(requestId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… Ø±ÙØ¶ Ø¥Ø«Ø¨Ø§Øª Ø§Ù„Ø³Ø¯Ø§Ø¯ ÙˆØ¥Ø±Ø¬Ø§Ø¹ Ø§Ù„Ø·Ù„Ø¨ Ù„Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ø¯ÙØ¹'
                : 'Payment issue flagged and returned to awaiting payment',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _confirmClinicianPayout(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _paymentDecisionAdapter.confirmClinicianPayout(requestId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… ØªØ³Ø¬ÙŠÙ„ ØªØ­ÙˆÙŠÙ„ Ù…Ø³ØªØ­Ù‚ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ ÙˆØ¥ØºÙ„Ø§Ù‚ Ø§Ù„Ø¹Ù…Ù„ÙŠØ© Ø¨Ù†Ø¬Ø§Ø­'
                : 'Clinician payout confirmed and flow completed successfully',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _confirmCenterAccountingReview(
    BuildContext context,
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
    final commissionController = TextEditingController(
      text: commissionValue.toStringAsFixed(0),
    );
    final noteController = TextEditingController(
      text: (data['accountingReviewNotes'] ?? '').toString(),
    );

    final shouldSubmit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: AlertDialog(
          title: Text(
            isArabic ? 'Ù…Ø±Ø§Ø¬Ø¹Ø© Ù…Ø­Ø§Ø³Ø¨ÙŠØ©' : 'Accounting review',
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
                        ? 'Ø¥Ø¬Ù…Ø§Ù„ÙŠ Ø§Ù„Ù…Ø¯ÙÙˆØ¹ Ù…Ù† Ø§Ù„Ø¹Ù…ÙŠÙ„'
                        : 'Gross client-paid amount',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: commissionController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: isArabic ? 'Ù†Ø³Ø¨Ø© Ø§Ù„Ø¹Ù…ÙˆÙ„Ø©' : 'Commission percent',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText:
                        isArabic ? 'Ù…Ù„Ø§Ø­Ø¸Ø§Øª Ù…Ø­Ø§Ø³Ø¨ÙŠØ©' : 'Accounting notes',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(isArabic ? 'Ø¥Ù„ØºØ§Ø¡' : 'Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(isArabic ? 'Ø§Ø¹ØªÙ…Ø§Ø¯' : 'Confirm'),
            ),
          ],
        ),
      ),
    );

    if (shouldSubmit != true) {
      grossController.dispose();
      commissionController.dispose();
      noteController.dispose();
      return;
    }

    await _setBusy(requestId, true);
    try {
      final gross = double.tryParse(grossController.text.trim()) ?? 0;
      final baseSeed = data['stayBaseAmount'] ?? 0;
      final baseAmount = baseSeed is num
          ? baseSeed.toDouble()
          : double.tryParse('$baseSeed') ?? 0;
      final commissionPercent =
          double.tryParse(commissionController.text.trim()) ?? 10;
      await _paymentDecisionAdapter.confirmCenterAccountingReview(
        requestId: requestId,
        gross: gross,
        baseAmount: baseAmount,
        commissionPercent: commissionPercent,
        note: noteController.text.trim(),
        adminUid: FirebaseAuth.instance.currentUser?.uid ?? '',
      );
    } finally {
      grossController.dispose();
      commissionController.dispose();
      noteController.dispose();
      await _setBusy(requestId, false);
    }
  }

  Future<void> _confirmCenterPayout(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _paymentDecisionAdapter.confirmCenterPayout(requestId);
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _sendToSessionArchive(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _paymentDecisionAdapter.sendToSessionArchive(requestId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… Ø¥Ø±Ø³Ø§Ù„ Ø§Ù„Ø·Ù„Ø¨ Ø¥Ù„Ù‰ Ø£Ø±Ø´ÙŠÙ Ø§Ù„Ø¬Ù„Ø³Ø§Øª'
                : 'Request sent to sessions archive',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _sendToFinancialArchive(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _paymentDecisionAdapter.sendToFinancialArchive(requestId);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… Ø¥Ø±Ø³Ø§Ù„ Ø§Ù„Ø·Ù„Ø¨ Ø¥Ù„Ù‰ Ø£Ø±Ø´ÙŠÙ Ø§Ù„Ù…Ø¯ÙÙˆØ¹Ø§Øª'
                : 'Request sent to payments archive',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  bool _isInPaymentReview(Map<String, dynamic> data) {
    final status = (data['status'] ?? '').toString();
    final paymentStatus = (data['paymentStatus'] ?? '').toString();
    final receiptFile =
        (data['paymentReceiptFileName'] ?? '').toString().trim();

    if (status == 'payment_review') return true;
    if (paymentStatus == 'submitted_by_client') return true;
    if (status == 'awaiting_payment' && receiptFile.isNotEmpty) return true;

    return false;
  }

  bool _isInApprovedPayments(Map<String, dynamic> data) {
    final status = (data['status'] ?? '').toString();
    final paymentStatus = (data['paymentStatus'] ?? '').toString();

    if (paymentStatus == 'approved') return true;

    return status == 'session_setup_pending' ||
        status == 'session_scheduled' ||
        status == 'session_in_progress' ||
        status == 'session_completed_pending_reviews' ||
        status == 'payout_pending' ||
        status == 'completed_success';
  }

  bool _matchesTab(Map<String, dynamic> data) {
    if ((data['archived'] ?? false) == true) {
      return false;
    }

    if (_tab == 'approved') {
      return _isInApprovedPayments(data);
    }
    return _isInPaymentReview(data);
  }

  String _statusLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();
    final requestKind = (data['requestKind'] ?? '').toString();
    final paymentStatus = (data['paymentStatus'] ?? '').toString();
    final payoutStatus = (data['payoutStatus'] ?? '').toString();
    final accountingReviewStatus =
        (data['accountingReviewStatus'] ?? '').toString();

    if (_isInPaymentReview(data)) {
      return isArabic ? 'بانتظار مراقبة السداد' : 'Payment monitoring';
    }

    if (status == 'payout_pending') {
      if (requestKind == 'center' && accountingReviewStatus != 'confirmed') {
        return isArabic
            ? 'بانتظار مراجعة محاسبية للمركز'
            : 'Center accounting review pending';
      }
      return isArabic
          ? (requestKind == 'center'
              ? 'بانتظار تحويل مستحق المركز'
              : 'بانتظار تحويل مستحق الأخصائي')
          : (requestKind == 'center'
              ? 'Center payout pending'
              : 'Payout pending');
    }

    if (payoutStatus == 'paid_to_clinician' ||
        payoutStatus == 'paid_to_center' ||
        status == 'completed_success') {
      return isArabic ? 'مكتمل ومغلق' : 'Completed and closed';
    }

    if (paymentStatus == 'approved' && status == 'session_setup_pending') {
      return isArabic
          ? 'معتمد وبانتظار تجهيز الجلسة'
          : 'Approved / session setup pending';
    }

    switch (status) {
      case 'session_scheduled':
        return isArabic ? 'جلسة مجدولة' : 'Session scheduled';
      case 'session_in_progress':
        return isArabic ? 'جلسة جارية' : 'Session in progress';
      case 'session_completed_pending_reviews':
        return isArabic ? 'بانتظار التقييمات' : 'Pending reviews';
      default:
        return isArabic ? 'حالة مالية' : 'Payment state';
    }
  }

  Color _statusColor(Map<String, dynamic> data) {
    final status = (data['status'] ?? '').toString();
    final payoutStatus = (data['payoutStatus'] ?? '').toString();

    if (_isInPaymentReview(data)) {
      return const Color(0xFFE39B2E);
    }

    if (status == 'payout_pending') {
      return const Color(0xFF2E5AAC);
    }

    if (payoutStatus == 'paid_to_clinician' ||
        payoutStatus == 'paid_to_center' ||
        status == 'completed_success') {
      return const Color(0xFF1F9D63);
    }

    switch (status) {
      case 'session_setup_pending':
      case 'session_scheduled':
      case 'session_in_progress':
        return const Color(0xFF2E5AAC);
      case 'session_completed_pending_reviews':
        return const Color(0xFF1F9D63);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _whyHereLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();
    final requestKind = (data['requestKind'] ?? '').toString();
    final accountingReviewStatus =
        (data['accountingReviewStatus'] ?? '').toString();

    if (_isInPaymentReview(data)) {
      return isArabic
          ? 'إثبات سداد بانتظار قرار مالي'
          : 'Payment proof is waiting for a financial decision';
    }
    if (status == 'payout_pending') {
      if (requestKind == 'center' && accountingReviewStatus != 'confirmed') {
        return isArabic
            ? 'مستحق مركز بانتظار مراجعة محاسبية'
            : 'Center payout is waiting for accounting review';
      }
      return isArabic
          ? 'مستحق بانتظار تأكيد التحويل'
          : 'Payout is waiting for transfer confirmation';
    }
    if (status == 'completed_success') {
      return isArabic
          ? 'عملية مكتملة بانتظار بوابة الأرشفة'
          : 'Completed flow is waiting for archive gate';
    }
    return isArabic
        ? 'حالة مالية مرئية لغرفة التحكم'
        : 'Financial state visible to the control room';
  }

  String _requiredGateLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();
    final requestKind = (data['requestKind'] ?? '').toString();
    final accountingReviewStatus =
        (data['accountingReviewStatus'] ?? '').toString();

    if (_isInPaymentReview(data)) {
      return isArabic
          ? 'اعتماد أو رفض إثبات السداد'
          : 'Confirm payment signal or flag an issue';
    }
    if (status == 'payout_pending') {
      if (requestKind == 'center' && accountingReviewStatus != 'confirmed') {
        return isArabic
            ? 'مراجعة محاسبية قبل التحويل'
            : 'Confirm accounting review before payout';
      }
      return isArabic
          ? 'تأكيد تحويل المستحق'
          : 'Confirm payout transfer';
    }
    if (status == 'completed_success') {
      return isArabic ? 'بوابة أرشفة' : 'Archive gate';
    }
    return isArabic ? 'متابعة مالية فقط' : 'Financial monitoring only';
  }

  String _nextStepLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();
    final requestKind = (data['requestKind'] ?? '').toString();
    final accountingReviewStatus =
        (data['accountingReviewStatus'] ?? '').toString();

    if (_isInPaymentReview(data)) {
      return isArabic
          ? 'قرار مالي ثم عودة الطلب للمسار المنظم'
          : 'Financial decision, then return to the structured flow';
    }
    if (status == 'payout_pending') {
      if (requestKind == 'center' && accountingReviewStatus != 'confirmed') {
        return isArabic
            ? 'إكمال المراجعة المحاسبية'
            : 'Complete accounting review exception';
      }
      return isArabic ? 'تأكيد التحويل' : 'Confirm payout';
    }
    if (status == 'completed_success') {
      return isArabic ? 'الأرشفة المناسبة' : 'Archive in the proper section';
    }
    return isArabic ? 'متابعة الحالة المالية' : 'Monitor financial state';
  }

  String _ownershipCueLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();

    if (_isInPaymentReview(data) || status == 'payout_pending') {
      return isArabic
          ? 'بوابة مالية استثنائية'
          : 'Financial exception gate';
    }
    if (status == 'completed_success') {
      return isArabic
          ? 'إغلاق وأرشفة تحت تحكم الإدارة'
          : 'Admin closeout and archive';
    }
    return isArabic
        ? 'رؤية مالية من غرفة التحكم'
        : 'Control-room financial visibility';
  }

  String? _blockingReasonLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();
    final requestKind = (data['requestKind'] ?? '').toString();
    final receiptFile =
        (data['paymentReceiptFileName'] ?? '').toString().trim();
    final accountingReviewStatus =
        (data['accountingReviewStatus'] ?? '').toString();

    if (_isInPaymentReview(data)) {
      return receiptFile.isEmpty
          ? (isArabic
              ? 'لا يظهر اسم ملف إثبات السداد'
              : 'Payment proof file name is not visible')
          : null;
    }
    if (status == 'payout_pending' &&
        requestKind == 'center' &&
        accountingReviewStatus != 'confirmed') {
      return isArabic
          ? 'المراجعة المحاسبية لم تعتمد بعد'
          : 'Accounting review is not confirmed yet';
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

  List<Map<String, dynamic>> _normalizeDocs(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    String source,
  ) {
    return docs.map((doc) {
      final data = doc.data();
      return {
        ...data,
        '_id': doc.id,
        '_source': source,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic
              ? 'مراقبة المدفوعات والبوابة المالية'
              : 'Payment Monitoring & Financial Gate',
        ),
        body: AppPageBackground(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('booking_requests')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل المدفوعات'
                      : 'Unable to load payments',
                  icon: Icons.error_outline,
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = _normalizeDocs(
                snapshot.data!.docs,
                'booking_requests',
              ).where(_matchesTab).toList()
                ..sort((a, b) {
                  final aTs = a['archivedAt'] ??
                      a['payoutTransferredAt'] ??
                      a['paymentSubmittedAt'] ??
                      a['createdAt'];
                  final bTs = b['archivedAt'] ??
                      b['payoutTransferredAt'] ??
                      b['paymentSubmittedAt'] ??
                      b['createdAt'];

                  DateTime ad = DateTime.fromMillisecondsSinceEpoch(0);
                  DateTime bd = DateTime.fromMillisecondsSinceEpoch(0);

                  if (aTs is Timestamp) ad = aTs.toDate();
                  if (bTs is Timestamp) bd = bTs.toDate();

                  return bd.compareTo(ad);
                });

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
                              ? 'مراقبة المدفوعات والبوابة المالية'
                              : 'Payment Monitoring & Financial Gate',
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          isArabic
                              ? 'هذا القسم مخصص لمراقبة سير النظام. الإجراءات هنا استثنائية ولا تمثل المسار الطبيعي للتشغيل.'
                              : 'This section monitors system flows. Actions here are exception-based and should not replace normal workflow progression.',
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
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
                              selected: _tab == 'payment_review',
                              label: Text(
                                isArabic
                                    ? 'بوابة مراقبة السداد'
                                    : 'Payment monitoring gate',
                              ),
                              onSelected: (_) =>
                                  setState(() => _tab = 'payment_review'),
                            ),
                            ChoiceChip(
                              selected: _tab == 'approved',
                              label: Text(
                                isArabic
                                    ? 'المعتمدة / المستحقات / الإغلاق'
                                    : 'Approved / payout / closeout',
                              ),
                              onSelected: (_) =>
                                  setState(() => _tab = 'approved'),
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
                    ...docs.map((data) {
                      final requestId = (data['_id'] ?? '').toString();
                      final busy = _busyIds.contains(requestId);

                      final clientName =
                          (data['clientName'] ?? 'Client').toString();
                      final clinicianName = (data['assignedClinicianName'] ??
                              data['clinicianName'] ??
                              '')
                          .toString();
                      final receiptFile =
                          (data['paymentReceiptFileName'] ?? '').toString();
                      final clientNote =
                          (data['paymentClientNote'] ?? '').toString();
                      final createdAt = _dateText(data['createdAt']);
                      final submittedAt = _dateText(data['paymentSubmittedAt']);
                      final approvedAt = _dateText(data['paymentApprovedAt']);
                      final payoutTransferredAt =
                          _dateText(data['payoutTransferredAt']);
                      final archivedAt = _dateText(data['archivedAt']);
                      final status = (data['status'] ?? '').toString();
                      final requestKind =
                          (data['requestKind'] ?? '').toString();
                      final paymentStatus =
                          (data['paymentStatus'] ?? '').toString();
                      final payoutStatus =
                          (data['payoutStatus'] ?? '').toString();
                      final accountingReviewStatus =
                          (data['accountingReviewStatus'] ?? '').toString();
                      final source = (data['_source'] ?? '').toString();
                      final finalReviewRaw = data['finalReviewPercentage'];
                      final finalReviewPercentage = finalReviewRaw is num
                          ? finalReviewRaw.toDouble()
                          : 0.0;
                      final archived = (data['archived'] ?? false) == true;
                      final archiveSection =
                          (data['archiveSection'] ?? '').toString();
                      final whyHere = _whyHereLabel(data, isArabic);
                      final requiredGate =
                          _requiredGateLabel(data, isArabic);
                      final nextStructuredStep =
                          _nextStepLabel(data, isArabic);
                      final ownershipCue =
                          _ownershipCueLabel(data, isArabic);
                      final blockingReason =
                          _blockingReasonLabel(data, isArabic);
                      final hasFinancialGateActions =
                          _isInPaymentReview(data) ||
                              (status == 'payout_pending');
                      final hasArchiveGateActions =
                          status == 'completed_success' && !archived;

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
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      if (clinicianName.trim().isNotEmpty)
                                        Text(
                                          isArabic
                                              ? 'الأخصائي: $clinicianName'
                                              : 'Clinician: $clinicianName',
                                        ),
                                    ],
                                  ),
                                ),
                                AppStatusBadge(
                                  label: _statusLabel(data, isArabic),
                                  color: _statusColor(data),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text('ID: $requestId'),
                            Text('source: $source'),
                            Text('status: $status'),
                            Text('paymentStatus: $paymentStatus'),
                            if (payoutStatus.isNotEmpty)
                              Text('payoutStatus: $payoutStatus'),
                            if (accountingReviewStatus.isNotEmpty)
                              Text(
                                'accountingReviewStatus: $accountingReviewStatus',
                              ),
                            if (archived)
                              Text(
                                isArabic
                                    ? 'مؤرشف: نعم ($archiveSection)'
                                    : 'Archived: yes ($archiveSection)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                              ),
                            if (finalReviewPercentage > 0)
                              Text(
                                isArabic
                                    ? 'المتوسط النهائي: ${finalReviewPercentage.toStringAsFixed(1)}%'
                                    : 'Final average: ${finalReviewPercentage.toStringAsFixed(1)}%',
                              ),
                            if (createdAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'تاريخ الطلب: $createdAt'
                                      : 'Request date: $createdAt',
                                ),
                              ),
                            if (submittedAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'تاريخ إرسال الإثبات: $submittedAt'
                                      : 'Proof submitted at: $submittedAt',
                                ),
                              ),
                            if (approvedAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'تاريخ اعتماد السداد: $approvedAt'
                                      : 'Payment signal confirmed at: $approvedAt',
                                ),
                              ),
                            if (payoutTransferredAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'تاريخ تحويل المستحق: $payoutTransferredAt'
                                      : 'Payout transferred at: $payoutTransferredAt',
                                ),
                              ),
                            if (archivedAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'تاريخ الأرشفة: $archivedAt'
                                      : 'Archived at: $archivedAt',
                                ),
                              ),
                            if (receiptFile.trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'اسم الملف: $receiptFile'
                                      : 'File name: $receiptFile',
                                ),
                              ),
                            if (clientNote.trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'ملاحظة العميل: $clientNote'
                                      : 'Client note: $clientNote',
                                ),
                              ),
                            const SizedBox(height: AppSpacing.sm),
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
                                        ? 'بوابة مالية / الخطوة التالية'
                                    : 'Why this is here / Next expected step',
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
                                        ? 'سبب وجود السجل هنا: $whyHere'
                                        : 'Why this is here: $whyHere',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'البوابة المالية المطلوبة: $requiredGate'
                                        : 'Exception action (if needed): $requiredGate',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'الخطوة المنظمة التالية: $nextStructuredStep'
                                        : 'Next expected step: $nextStructuredStep',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'إشارة الملكية: $ownershipCue'
                                        : 'Current owner: $ownershipCue',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  if (blockingReason != null) ...[
                                    const SizedBox(height: AppSpacing.xs),
                                    Text(
                                      isArabic
                                          ? 'سبب التعطيل: $blockingReason'
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
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              alignment: WrapAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      Routes.adminSessionReport,
                                      arguments: {
                                        'requestId': requestId,
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.assessment_outlined),
                                  label: Text(
                                    isArabic ? 'عرض التقرير' : 'View report',
                                  ),
                                ),
                              ],
                            ),
                            if (hasFinancialGateActions) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                isArabic
                                    ? 'إجراءات البوابة المالية'
                                    : 'Exception Actions (if needed)',
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Wrap(
                                spacing: AppSpacing.sm,
                                runSpacing: AppSpacing.sm,
                                alignment: WrapAlignment.end,
                                children: [
                                  if (_isInPaymentReview(data))
                                    FilledButton.icon(
                                      onPressed: busy
                                          ? null
                                          : () => _approvePayment(requestId),
                                      icon: const Icon(
                                        Icons.check_circle_outline,
                                      ),
                                      label: Text(
                                        isArabic
                                            ? 'اعتماد السداد'
                                            : 'Confirm payment signal',
                                      ),
                                    ),
                                  if (_isInPaymentReview(data))
                                    OutlinedButton.icon(
                                      onPressed: busy
                                          ? null
                                          : () => _rejectPayment(requestId),
                                      icon: const Icon(Icons.cancel_outlined),
                                      label: Text(
                                        isArabic
                                            ? 'رفض السداد'
                                            : 'Flag payment issue',
                                      ),
                                      style: appDestructiveButtonStyle(),
                                    ),
                                  if (status == 'payout_pending' &&
                                      requestKind != 'center')
                                    FilledButton.icon(
                                      onPressed: busy
                                          ? null
                                          : () =>
                                              _confirmClinicianPayout(requestId),
                                      icon: const Icon(Icons.payments_outlined),
                                      label: Text(
                                        isArabic
                                            ? 'تم تحويل مستحق الأخصائي'
                                            : 'Confirm payout transfer',
                                      ),
                                    ),
                                  if (status == 'payout_pending' &&
                                      requestKind == 'center' &&
                                      accountingReviewStatus != 'confirmed')
                                    FilledButton.icon(
                                      onPressed: busy
                                          ? null
                                          : () => _confirmCenterAccountingReview(
                                                context,
                                                requestId,
                                                data,
                                              ),
                                      icon: const Icon(Icons.calculate_outlined),
                                      label: Text(
                                        isArabic
                                            ? 'مراجعة محاسبية'
                                            : 'Confirm accounting review',
                                      ),
                                    ),
                                  if (status == 'payout_pending' &&
                                      requestKind == 'center' &&
                                      accountingReviewStatus == 'confirmed')
                                    FilledButton.icon(
                                      onPressed: busy
                                          ? null
                                          : () => _confirmCenterPayout(
                                                requestId,
                                              ),
                                      icon: const Icon(
                                        Icons.account_balance_wallet_outlined,
                                      ),
                                      label: Text(
                                        isArabic
                                            ? 'تم تحويل مستحق المركز'
                                            : 'Confirm payout transfer',
                                      ),
                                    ),
                                ],
                              ),
                            ],
                            if (hasArchiveGateActions) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                isArabic
                                    ? 'بوابة الإغلاق والأرشفة'
                                    : 'Archive / Historical Closeout',
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Wrap(
                                spacing: AppSpacing.sm,
                                runSpacing: AppSpacing.sm,
                                alignment: WrapAlignment.end,
                                children: [
                                  if (status == 'completed_success' &&
                                      !archived)
                                    FilledButton.tonalIcon(
                                      onPressed: busy
                                          ? null
                                          : () =>
                                              _sendToSessionArchive(requestId),
                                      icon: const Icon(Icons.video_call_outlined),
                                      label: Text(
                                        isArabic
                                            ? 'أرشفة جلسية'
                                            : 'Session archive',
                                      ),
                                    ),
                                  if (status == 'completed_success' &&
                                      !archived)
                                    FilledButton.tonalIcon(
                                      onPressed: busy
                                          ? null
                                          : () =>
                                              _sendToFinancialArchive(requestId),
                                      icon: const Icon(
                                        Icons.account_balance_wallet_outlined,
                                      ),
                                      label: Text(
                                        isArabic
                                            ? 'أرشفة مالية'
                                            : 'Financial archive',
                                      ),
                                    ),
                                ],
                              ),
                            ],
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
