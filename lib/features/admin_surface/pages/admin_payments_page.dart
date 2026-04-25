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
        'status':
            isCenterRequest ? 'session_scheduled' : 'session_setup_pending',
        'paymentStatus': 'approved',
        'payment_confirmed': true,
        'paymentApprovedAt': FieldValue.serverTimestamp(),
        'sessionStatus': isCenterRequest ? 'scheduled' : 'not_created',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? (isCenterRequest
                    ? 'ØªÙ… Ø§Ø¹ØªÙ…Ø§Ø¯ Ø§Ù„Ø³Ø¯Ø§Ø¯ ÙˆØªØ­ÙˆÙŠÙ„ Ø§Ù„Ø·Ù„Ø¨ Ø¥Ù„Ù‰ Ø¥Ù‚Ø§Ù…Ø© Ù…Ø¨Ø¯Ø¦ÙŠØ© Ù…Ø¬Ø¯ÙˆÙ„Ø©'
                    : 'ØªÙ… Ø§Ø¹ØªÙ…Ø§Ø¯ Ø§Ù„Ø³Ø¯Ø§Ø¯ ÙˆØªØ­ÙˆÙŠÙ„ Ø§Ù„Ø·Ù„Ø¨ Ø¥Ù„Ù‰ Ù‚Ø³Ù… Ø§Ù„Ø¬Ù„Ø³Ø§Øª')
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
        'payment_confirmed': false,
        'paymentRejectedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'ØªÙ… Ø±ÙØ¶ Ø¥Ø«Ø¨Ø§Øª Ø§Ù„Ø³Ø¯Ø§Ø¯ ÙˆØ¥Ø±Ø¬Ø§Ø¹ Ø§Ù„Ø·Ù„Ø¨ Ù„Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„Ø¯ÙØ¹'
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
      return isArabic ? 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„Ø³Ø¯Ø§Ø¯' : 'Payment review';
    }

    if (status == 'payout_pending') {
      if (requestKind == 'center' && accountingReviewStatus != 'confirmed') {
        return isArabic
            ? 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ù…Ø±Ø§Ø¬Ø¹Ø© Ù…Ø­Ø§Ø³Ø¨ÙŠØ© Ù„Ù„Ù…Ø±ÙƒØ²'
            : 'Center accounting review pending';
      }
      return isArabic
          ? (requestKind == 'center'
              ? 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªØ­ÙˆÙŠÙ„ Ù…Ø³ØªØ­Ù‚ Ø§Ù„Ù…Ø±ÙƒØ²'
              : 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªØ­ÙˆÙŠÙ„ Ù…Ø³ØªØ­Ù‚ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ')
          : (requestKind == 'center'
              ? 'Center payout pending'
              : 'Payout pending');
    }

    if (payoutStatus == 'paid_to_clinician' ||
        payoutStatus == 'paid_to_center' ||
        status == 'completed_success') {
      return isArabic ? 'Ù…ÙƒØªÙ…Ù„ ÙˆÙ…ØºÙ„Ù‚' : 'Completed and closed';
    }

    if (paymentStatus == 'approved' && status == 'session_setup_pending') {
      return isArabic
          ? 'Ù…Ø¹ØªÙ…Ø¯ ÙˆØ¨Ø§Ù†ØªØ¸Ø§Ø± ØªØ¬Ù‡ÙŠØ² Ø§Ù„Ø¬Ù„Ø³Ø©'
          : 'Approved / session setup pending';
    }

    switch (status) {
      case 'session_scheduled':
        return isArabic ? 'Ø¬Ù„Ø³Ø© Ù…Ø¬Ø¯ÙˆÙ„Ø©' : 'Session scheduled';
      case 'session_in_progress':
        return isArabic ? 'Ø¬Ù„Ø³Ø© Ø¬Ø§Ø±ÙŠØ©' : 'Session in progress';
      case 'session_completed_pending_reviews':
        return isArabic ? 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„ØªÙ‚ÙŠÙŠÙ…Ø§Øª' : 'Pending reviews';
      default:
        return isArabic ? 'Ø­Ø§Ù„Ø© Ù…Ø§Ù„ÙŠØ©' : 'Payment state';
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
          ? 'Ø¥Ø«Ø¨Ø§Øª Ø³Ø¯Ø§Ø¯ Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ù‚Ø±Ø§Ø± Ù…Ø§Ù„ÙŠ'
          : 'Payment proof is waiting for a financial decision';
    }
    if (status == 'payout_pending') {
      if (requestKind == 'center' && accountingReviewStatus != 'confirmed') {
        return isArabic
            ? 'Ù…Ø³ØªØ­Ù‚ Ù…Ø±ÙƒØ² Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ù…Ø±Ø§Ø¬Ø¹Ø© Ù…Ø­Ø§Ø³Ø¨ÙŠØ©'
            : 'Center payout is waiting for accounting review';
      }
      return isArabic
          ? 'Ù…Ø³ØªØ­Ù‚ Ø¨Ø§Ù†ØªØ¸Ø§Ø± ØªØ£ÙƒÙŠØ¯ Ø§Ù„ØªØ­ÙˆÙŠÙ„'
          : 'Payout is waiting for transfer confirmation';
    }
    if (status == 'completed_success') {
      return isArabic
          ? 'Ø¹Ù…Ù„ÙŠØ© Ù…ÙƒØªÙ…Ù„Ø© Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø¨ÙˆØ§Ø¨Ø© Ø§Ù„Ø£Ø±Ø´ÙØ©'
          : 'Completed flow is waiting for archive gate';
    }
    return isArabic
        ? 'Ø­Ø§Ù„Ø© Ù…Ø§Ù„ÙŠØ© Ù…Ø±Ø¦ÙŠØ© Ù„ØºØ±ÙØ© Ø§Ù„ØªØ­ÙƒÙ…'
        : 'Financial state visible to the control room';
  }

  String _requiredGateLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();
    final requestKind = (data['requestKind'] ?? '').toString();
    final accountingReviewStatus =
        (data['accountingReviewStatus'] ?? '').toString();

    if (_isInPaymentReview(data)) {
      return isArabic
          ? 'Ø§Ø¹ØªÙ…Ø§Ø¯ Ø£Ùˆ Ø±ÙØ¶ Ø¥Ø«Ø¨Ø§Øª Ø§Ù„Ø³Ø¯Ø§Ø¯'
          : 'Approve or reject payment proof';
    }
    if (status == 'payout_pending') {
      if (requestKind == 'center' && accountingReviewStatus != 'confirmed') {
        return isArabic
            ? 'Ù…Ø±Ø§Ø¬Ø¹Ø© Ù…Ø­Ø§Ø³Ø¨ÙŠØ© Ù‚Ø¨Ù„ Ø§Ù„ØªØ­ÙˆÙŠÙ„'
            : 'Accounting review before payout';
      }
      return isArabic
          ? 'ØªØ£ÙƒÙŠØ¯ ØªØ­ÙˆÙŠÙ„ Ø§Ù„Ù…Ø³ØªØ­Ù‚'
          : 'Confirm payout transfer';
    }
    if (status == 'completed_success') {
      return isArabic ? 'Ø¨ÙˆØ§Ø¨Ø© Ø£Ø±Ø´ÙØ©' : 'Archive gate';
    }
    return isArabic ? 'Ù…ØªØ§Ø¨Ø¹Ø© Ù…Ø§Ù„ÙŠØ© ÙÙ‚Ø·' : 'Financial monitoring only';
  }

  String _nextStepLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();
    final requestKind = (data['requestKind'] ?? '').toString();
    final accountingReviewStatus =
        (data['accountingReviewStatus'] ?? '').toString();

    if (_isInPaymentReview(data)) {
      return isArabic
          ? 'Ù‚Ø±Ø§Ø± Ù…Ø§Ù„ÙŠ Ø«Ù… Ø¹ÙˆØ¯Ø© Ø§Ù„Ø·Ù„Ø¨ Ù„Ù„Ù…Ø³Ø§Ø± Ø§Ù„Ù…Ù†Ø¸Ù…'
          : 'Financial decision, then return to the structured flow';
    }
    if (status == 'payout_pending') {
      if (requestKind == 'center' && accountingReviewStatus != 'confirmed') {
        return isArabic
            ? 'Ø¥ÙƒÙ…Ø§Ù„ Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„Ù…Ø­Ø§Ø³Ø¨ÙŠØ©'
            : 'Complete accounting review';
      }
      return isArabic ? 'ØªØ£ÙƒÙŠØ¯ Ø§Ù„ØªØ­ÙˆÙŠÙ„' : 'Confirm payout';
    }
    if (status == 'completed_success') {
      return isArabic ? 'Ø§Ù„Ø£Ø±Ø´ÙØ© Ø§Ù„Ù…Ù†Ø§Ø³Ø¨Ø©' : 'Archive in the proper section';
    }
    return isArabic ? 'Ù…ØªØ§Ø¨Ø¹Ø© Ø§Ù„Ø­Ø§Ù„Ø© Ø§Ù„Ù…Ø§Ù„ÙŠØ©' : 'Monitor financial state';
  }

  String _ownershipCueLabel(Map<String, dynamic> data, bool isArabic) {
    final status = (data['status'] ?? '').toString();

    if (_isInPaymentReview(data) || status == 'payout_pending') {
      return isArabic
          ? 'Ø¨ÙˆØ§Ø¨Ø© Ù…Ø§Ù„ÙŠØ© Ø¥Ø¯Ø§Ø±ÙŠØ©'
          : 'Admin financial gate';
    }
    if (status == 'completed_success') {
      return isArabic
          ? 'Ø¥ØºÙ„Ø§Ù‚ ÙˆØ£Ø±Ø´ÙØ© ØªØ­Øª ØªØ­ÙƒÙ… Ø§Ù„Ø¥Ø¯Ø§Ø±Ø©'
          : 'Admin closeout and archive';
    }
    return isArabic
        ? 'Ø±Ø¤ÙŠØ© Ù…Ø§Ù„ÙŠØ© Ù…Ù† ØºØ±ÙØ© Ø§Ù„ØªØ­ÙƒÙ…'
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
              ? 'Ù„Ø§ ÙŠØ¸Ù‡Ø± Ø§Ø³Ù… Ù…Ù„Ù Ø¥Ø«Ø¨Ø§Øª Ø§Ù„Ø³Ø¯Ø§Ø¯'
              : 'Payment proof file name is not visible')
          : null;
    }
    if (status == 'payout_pending' &&
        requestKind == 'center' &&
        accountingReviewStatus != 'confirmed') {
      return isArabic
          ? 'Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„Ù…Ø­Ø§Ø³Ø¨ÙŠØ© Ù„Ù… ØªØ¹ØªÙ…Ø¯ Ø¨Ø¹Ø¯'
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
              ? 'Ø¨ÙˆØ§Ø¨Ø§Øª Ø§Ù„Ø³Ø¯Ø§Ø¯ ÙˆØ§Ù„Ù…Ø­Ø§Ø³Ø¨Ø©'
              : 'Payment & Accounting Gates',
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
                      ? 'ØªØ¹Ø°Ø± ØªØ­Ù…ÙŠÙ„ Ø§Ù„Ù…Ø¯ÙÙˆØ¹Ø§Øª'
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
                              ? 'Ø¨ÙˆØ§Ø¨Ø© Ù…Ø§Ù„ÙŠØ© Ù…Ù† ØºØ±ÙØ© Ø§Ù„ØªØ­ÙƒÙ…'
                              : 'Control-Room Financial Gate',
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
                              ? 'التركيز: المدفوعات التي تحتاج مراجعة أو اعتماد. تبقى المراحل الأخرى للمستحقات والإغلاق المالي.'
                              : 'Focus: payments requiring review or approval. Later stages remain available for payout and financial closeout.',
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
                                    ? 'Ø¨ÙˆØ§Ø¨Ø© Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„Ø³Ø¯Ø§Ø¯'
                                    : 'Payment review gate',
                              ),
                              onSelected: (_) =>
                                  setState(() => _tab = 'payment_review'),
                            ),
                            ChoiceChip(
                              selected: _tab == 'approved',
                              label: Text(
                                isArabic
                                    ? 'Ø§Ù„Ù…Ø¹ØªÙ…Ø¯Ø© / Ø§Ù„Ù…Ø³ØªØ­Ù‚Ø§Øª / Ø§Ù„Ø¥ØºÙ„Ø§Ù‚'
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
                          ? 'Ù„Ø§ ØªÙˆØ¬Ø¯ Ø·Ù„Ø¨Ø§Øª ÙÙŠ Ù‡Ø°Ø§ Ø§Ù„Ù‚Ø³Ù…'
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
                                              ? 'Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ: $clinicianName'
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
                                    ? 'Ù…Ø¤Ø±Ø´Ù: Ù†Ø¹Ù… ($archiveSection)'
                                    : 'Archived: yes ($archiveSection)',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800),
                              ),
                            if (finalReviewPercentage > 0)
                              Text(
                                isArabic
                                    ? 'Ø§Ù„Ù…ØªÙˆØ³Ø· Ø§Ù„Ù†Ù‡Ø§Ø¦ÙŠ: ${finalReviewPercentage.toStringAsFixed(1)}%'
                                    : 'Final average: ${finalReviewPercentage.toStringAsFixed(1)}%',
                              ),
                            if (createdAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'ØªØ§Ø±ÙŠØ® Ø§Ù„Ø·Ù„Ø¨: $createdAt'
                                      : 'Request date: $createdAt',
                                ),
                              ),
                            if (submittedAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'ØªØ§Ø±ÙŠØ® Ø¥Ø±Ø³Ø§Ù„ Ø§Ù„Ø¥Ø«Ø¨Ø§Øª: $submittedAt'
                                      : 'Proof submitted at: $submittedAt',
                                ),
                              ),
                            if (approvedAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'ØªØ§Ø±ÙŠØ® Ø§Ø¹ØªÙ…Ø§Ø¯ Ø§Ù„Ø³Ø¯Ø§Ø¯: $approvedAt'
                                      : 'Payment approved at: $approvedAt',
                                ),
                              ),
                            if (payoutTransferredAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'ØªØ§Ø±ÙŠØ® ØªØ­ÙˆÙŠÙ„ Ø§Ù„Ù…Ø³ØªØ­Ù‚: $payoutTransferredAt'
                                      : 'Payout transferred at: $payoutTransferredAt',
                                ),
                              ),
                            if (archivedAt.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'ØªØ§Ø±ÙŠØ® Ø§Ù„Ø£Ø±Ø´ÙØ©: $archivedAt'
                                      : 'Archived at: $archivedAt',
                                ),
                              ),
                            if (receiptFile.trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'Ø§Ø³Ù… Ø§Ù„Ù…Ù„Ù: $receiptFile'
                                      : 'File name: $receiptFile',
                                ),
                              ),
                            if (clientNote.trim().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  isArabic
                                      ? 'Ù…Ù„Ø§Ø­Ø¸Ø© Ø§Ù„Ø¹Ù…ÙŠÙ„: $clientNote'
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
                                        ? 'Ø¨ÙˆØ§Ø¨Ø© Ù…Ø§Ù„ÙŠØ© / Ø§Ù„Ø®Ø·ÙˆØ© Ø§Ù„ØªØ§Ù„ÙŠØ©'
                                        : 'Financial Gate / Next Step',
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
                                        ? 'Ø³Ø¨Ø¨ ÙˆØ¬ÙˆØ¯ Ø§Ù„Ø³Ø¬Ù„ Ù‡Ù†Ø§: $whyHere'
                                        : 'Why this is here: $whyHere',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    isArabic
                                        ? 'Ø§Ù„Ø¨ÙˆØ§Ø¨Ø© Ø§Ù„Ù…Ø§Ù„ÙŠØ© Ø§Ù„Ù…Ø·Ù„ÙˆØ¨Ø©: $requiredGate'
                                        : 'Required financial/admin gate: $requiredGate',
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
                                    isArabic ? 'Ø¹Ø±Ø¶ Ø§Ù„ØªÙ‚Ø±ÙŠØ±' : 'View report',
                                  ),
                                ),
                              ],
                            ),
                            if (hasFinancialGateActions) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                isArabic
                                    ? 'Ø¥Ø¬Ø±Ø§Ø¡Ø§Øª Ø§Ù„Ø¨ÙˆØ§Ø¨Ø© Ø§Ù„Ù…Ø§Ù„ÙŠØ©'
                                    : 'Financial Gate Actions',
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
                                            ? 'Ø§Ø¹ØªÙ…Ø§Ø¯ Ø§Ù„Ø³Ø¯Ø§Ø¯'
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
                                            ? 'Ø±ÙØ¶ Ø§Ù„Ø³Ø¯Ø§Ø¯'
                                            : 'Reject payment',
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
                                            ? 'ØªÙ… ØªØ­ÙˆÙŠÙ„ Ù…Ø³ØªØ­Ù‚ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ'
                                            : 'Confirm clinician payout',
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
                                            ? 'Ù…Ø±Ø§Ø¬Ø¹Ø© Ù…Ø­Ø§Ø³Ø¨ÙŠØ©'
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
                                      icon: const Icon(
                                        Icons.account_balance_wallet_outlined,
                                      ),
                                      label: Text(
                                        isArabic
                                            ? 'ØªÙ… ØªØ­ÙˆÙŠÙ„ Ù…Ø³ØªØ­Ù‚ Ø§Ù„Ù…Ø±ÙƒØ²'
                                            : 'Confirm center payout',
                                      ),
                                    ),
                                ],
                              ),
                            ],
                            if (hasArchiveGateActions) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                isArabic
                                    ? 'Ø¨ÙˆØ§Ø¨Ø© Ø§Ù„Ø¥ØºÙ„Ø§Ù‚ ÙˆØ§Ù„Ø£Ø±Ø´ÙØ©'
                                    : 'Closeout / Archive Gate',
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
                                            ? 'Ø£Ø±Ø´ÙØ© Ø¬Ù„Ø³ÙŠØ©'
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
                                            ? 'Ø£Ø±Ø´ÙØ© Ù…Ø§Ù„ÙŠØ©'
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
