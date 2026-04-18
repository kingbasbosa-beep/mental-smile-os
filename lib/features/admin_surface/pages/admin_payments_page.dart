import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
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

  Future<void> _approvePayment(String requestId) async {
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
        'status': isCenterRequest ? 'session_scheduled' : 'session_setup_pending',
        'paymentStatus': 'approved',
        'paymentApprovedAt': FieldValue.serverTimestamp(),
        'sessionStatus': isCenterRequest ? 'scheduled' : 'not_created',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? (isCenterRequest
                    ? 'تم اعتماد السداد وتحويل الطلب إلى إقامة مبدئية مجدولة'
                    : 'تم اعتماد السداد وتحويل الطلب إلى قسم الجلسات')
                : (isCenterRequest
                    ? 'Payment approved and request moved to preliminary residency scheduled'
                    : 'Payment approved and moved to sessions setup'),
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
      await _updateRequestEverywhere(requestId, {
        'status': 'awaiting_payment',
        'paymentStatus': 'rejected',
        'paymentRejectedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
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
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'completed_success',
        'sessionStatus': 'completed',
        'reviewStatus': 'completed',
        'payoutStatus': 'paid_to_clinician',
        'payoutTransferredAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تسجيل تحويل مستحق الأخصائي وإغلاق العملية بنجاح'
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
            isArabic ? 'مراجعة محاسبية' : 'Accounting review',
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
                        ? 'إجمالي المدفوع من العميل'
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
                    labelText: isArabic ? 'نسبة العمولة' : 'Commission percent',
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
      final commissionAmount = baseAmount * (commissionPercent / 100);
      final netAmount = baseAmount - commissionAmount;
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
      await _updateRequestEverywhere(requestId, {
        'status': 'completed_success',
        'sessionStatus': 'completed',
        'reviewStatus': 'completed',
        'payoutStatus': 'paid_to_center',
        'payoutTransferredAt': FieldValue.serverTimestamp(),
      });
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _sendToSessionArchive(String requestId) async {
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
            _isArabic(context)
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
            _isArabic(context)
                ? 'تم إرسال الطلب إلى أرشيف المدفوعات'
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
      return isArabic ? 'بانتظار مراجعة السداد' : 'Payment review';
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
          title: isArabic ? 'المدفوعات والتحويلات' : 'Payments & Transfers',
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
                        child: Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          alignment: WrapAlignment.end,
                          children: [
                            ChoiceChip(
                              selected: _tab == 'payment_review',
                              label: Text(
                                isArabic
                                    ? 'بانتظار مراجعة السداد'
                                    : 'Payment review',
                              ),
                              onSelected: (_) =>
                                  setState(() => _tab = 'payment_review'),
                            ),
                            ChoiceChip(
                              selected: _tab == 'approved',
                              label: Text(
                                isArabic
                                    ? 'مدفوعات معتمدة'
                                    : 'Approved payments',
                              ),
                              onSelected: (_) =>
                                  setState(() => _tab = 'approved'),
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
                          final clinicianName =
                              (data['assignedClinicianName'] ??
                                      data['clinicianName'] ??
                                      '')
                                  .toString();
                          final receiptFile =
                              (data['paymentReceiptFileName'] ?? '').toString();
                          final clientNote =
                              (data['paymentClientNote'] ?? '').toString();
                          final createdAt = _dateText(data['createdAt']);
                          final submittedAt =
                              _dateText(data['paymentSubmittedAt']);
                          final approvedAt =
                              _dateText(data['paymentApprovedAt']);
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
                          final finalReviewPercentage =
                              finalReviewRaw is num
                                  ? finalReviewRaw.toDouble()
                                  : 0.0;
                          final archived = (data['archived'] ?? false) == true;
                          final archiveSection =
                              (data['archiveSection'] ?? '').toString();

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
                                                    fontWeight:
                                                        FontWeight.w800),
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
                                          : 'Payment approved at: $approvedAt',
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
                                      icon:
                                          const Icon(Icons.assessment_outlined),
                                      label: Text(
                                        isArabic
                                            ? 'عرض التقرير'
                                            : 'View report',
                                      ),
                                    ),
                                    if (_isInPaymentReview(data))
                                      FilledButton.icon(
                                        onPressed: busy
                                            ? null
                                            : () => _approvePayment(requestId),
                                        icon: const Icon(
                                            Icons.check_circle_outline),
                                        label: Text(
                                          isArabic
                                              ? 'اعتماد السداد'
                                              : 'Approve payment',
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
                                              : 'Reject payment',
                                        ),
                                        style: appDestructiveButtonStyle(),
                                      ),
                                    if (status == 'payout_pending' &&
                                        requestKind != 'center')
                                      FilledButton.icon(
                                        onPressed: busy
                                            ? null
                                            : () => _confirmClinicianPayout(
                                                requestId),
                                        icon:
                                            const Icon(Icons.payments_outlined),
                                        label: Text(
                                          isArabic
                                              ? 'تم تحويل مستحق الأخصائي'
                                              : 'Confirm clinician payout',
                                        ),
                                      ),
                                    if (status == 'payout_pending' &&
                                        requestKind == 'center' &&
                                        accountingReviewStatus != 'confirmed')
                                      FilledButton.icon(
                                        onPressed: busy
                                            ? null
                                            : () =>
                                                _confirmCenterAccountingReview(
                                                  context,
                                                  requestId,
                                                  data,
                                                ),
                                        icon: const Icon(
                                            Icons.calculate_outlined),
                                        label: Text(
                                          isArabic
                                              ? 'مراجعة محاسبية'
                                              : 'Accounting review',
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
                                        icon: const Icon(Icons
                                            .account_balance_wallet_outlined),
                                        label: Text(
                                          isArabic
                                              ? 'تم تحويل مستحق المركز'
                                              : 'Confirm center payout',
                                        ),
                                      ),
                                    if (status == 'completed_success' &&
                                        !archived)
                                      FilledButton.tonalIcon(
                                        onPressed: busy
                                            ? null
                                            : () => _sendToSessionArchive(
                                                requestId),
                                        icon: const Icon(
                                            Icons.video_call_outlined),
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
                                            : () => _sendToFinancialArchive(
                                                requestId),
                                        icon: const Icon(Icons
                                            .account_balance_wallet_outlined),
                                        label: Text(
                                          isArabic
                                              ? 'أرشفة مالية'
                                              : 'Financial archive',
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

