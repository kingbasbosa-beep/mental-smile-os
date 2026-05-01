import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminArchivePaymentsPage extends StatefulWidget {
  const AdminArchivePaymentsPage({super.key});

  @override
  State<AdminArchivePaymentsPage> createState() =>
      _AdminArchivePaymentsPageState();
}

class _AdminArchivePaymentsPageState extends State<AdminArchivePaymentsPage> {
  final TextEditingController _searchController = TextEditingController();

  String _paymentFilter = 'all';
  String _payoutFilter = 'all';
  String _clinicianFilter = 'all';
  String _search = '';

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

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

  bool _matchesSearch(Map<String, dynamic> item) {
    if (_search.trim().isEmpty) return true;

    final haystack = [
      (item['_id'] ?? '').toString(),
      (item['clientName'] ?? '').toString(),
      (item['clientEmail'] ?? '').toString(),
      (item['clientId'] ?? '').toString(),
      (item['assignedClinicianName'] ?? item['clinicianName'] ?? '').toString(),
      (item['assignedClinicianId'] ?? item['clinicianId'] ?? '').toString(),
      (item['paymentStatus'] ?? '').toString(),
      (item['payoutStatus'] ?? '').toString(),
      (item['paymentReceiptFileName'] ?? '').toString(),
      (item['paymentClientNote'] ?? '').toString(),
      (item['status'] ?? '').toString(),
    ].join(' ').toLowerCase();

    return haystack.contains(_search.toLowerCase());
  }

  bool _matchesFilters(Map<String, dynamic> item) {
    final paymentStatus = (item['paymentStatus'] ?? '').toString();
    final payoutStatus = (item['payoutStatus'] ?? '').toString();
    final clinicianName =
        (item['assignedClinicianName'] ?? item['clinicianName'] ?? '')
            .toString()
            .trim();

    if (_paymentFilter != 'all' && paymentStatus != _paymentFilter) {
      return false;
    }
    if (_payoutFilter != 'all' && payoutStatus != _payoutFilter) {
      return false;
    }
    if (_clinicianFilter != 'all' && clinicianName != _clinicianFilter) {
      return false;
    }

    return _matchesSearch(item);
  }

  Widget _summaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
  }) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: color.withValues(alpha: 0.10),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _paymentColor(String value) {
    switch (value) {
      case 'approved':
        return const Color(0xFF1F9D63);
      case 'submitted_by_client':
        return const Color(0xFFE39B2E);
      case 'rejected':
        return const Color(0xFFD04B4B);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _paymentLabel(String value, bool isArabic) {
    switch (value) {
      case 'approved':
        return isArabic ? 'سداد معتمد' : 'Approved payment';
      case 'submitted_by_client':
        return isArabic ? 'إثبات مرفوع من العميل' : 'Submitted by client';
      case 'rejected':
        return isArabic ? 'سداد مرفوض' : 'Rejected payment';
      default:
        return value.isEmpty ? (isArabic ? 'غير محدد' : 'Unknown') : value;
    }
  }

  Color _payoutColor(String value) {
    switch (value) {
      case 'paid_to_clinician':
        return const Color(0xFF1F9D63);
      case 'blocked':
        return const Color(0xFFD04B4B);
      case 'pending':
        return const Color(0xFFE39B2E);
      default:
        return const Color(0xFF2E5AAC);
    }
  }

  String _payoutLabel(String value, bool isArabic) {
    switch (value) {
      case 'paid_to_clinician':
        return isArabic ? 'تم تحويل مستحق الأخصائي' : 'Paid to clinician';
      case 'blocked':
        return isArabic ? 'التحويل متوقف' : 'Blocked';
      case 'pending':
        return isArabic ? 'بانتظار التحويل' : 'Pending payout';
      default:
        return value.isEmpty ? (isArabic ? 'غير محدد' : 'Unknown') : value;
    }
  }

  bool _isPaymentArchiveRelevant(Map<String, dynamic> item) {
    if ((item['archived'] ?? false) != true) return false;

    final paymentStatus = (item['paymentStatus'] ?? '').toString().trim();
    final payoutStatus = (item['payoutStatus'] ?? '').toString().trim();
    final receiptFile =
        (item['paymentReceiptFileName'] ?? '').toString().trim();
    final clientNote = (item['paymentClientNote'] ?? '').toString().trim();

    return (paymentStatus.isNotEmpty && paymentStatus != 'not_started') ||
        (payoutStatus.isNotEmpty && payoutStatus != 'not_started') ||
        receiptFile.isNotEmpty ||
        clientNote.isNotEmpty ||
        item['paymentSubmittedAt'] != null ||
        item['paymentApprovedAt'] != null ||
        item['payoutTransferredAt'] != null;
  }

  void _printPaymentItem(BuildContext context, Map<String, dynamic> item) {
    final isArabic = _isArabic(context);

    final id = (item['_id'] ?? '').toString();
    final clientName = (item['clientName'] ?? '').toString();
    final clientEmail = (item['clientEmail'] ?? '').toString();
    final clientId = (item['clientId'] ?? '').toString();
    final clinicianName =
        (item['assignedClinicianName'] ?? item['clinicianName'] ?? '')
            .toString();
    final clinicianId =
        (item['assignedClinicianId'] ?? item['clinicianId'] ?? '').toString();
    final paymentStatus = (item['paymentStatus'] ?? '').toString();
    final payoutStatus = (item['payoutStatus'] ?? '').toString();
    final receiptFile = (item['paymentReceiptFileName'] ?? '').toString();
    final clientNote = (item['paymentClientNote'] ?? '').toString();
    final createdAt = _dateText(item['createdAt']);
    final submittedAt = _dateText(item['paymentSubmittedAt']);
    final approvedAt = _dateText(item['paymentApprovedAt']);
    final payoutTransferredAt = _dateText(item['payoutTransferredAt']);
    final archivedAt = _dateText(item['archivedAt']);

    final lines = <String>[
      isArabic ? 'تقرير أرشيف مالي' : 'Financial Archive Report',
      '----------------------------------------',
      'ID: $id',
      if (clientName.isNotEmpty)
        (isArabic ? 'العميل: $clientName' : 'Client: $clientName'),
      if (clientEmail.isNotEmpty)
        (isArabic ? 'بريد العميل: $clientEmail' : 'Client email: $clientEmail'),
      if (clientId.isNotEmpty)
        (isArabic ? 'معرف العميل: $clientId' : 'Client ID: $clientId'),
      if (clinicianName.isNotEmpty)
        (isArabic ? 'الأخصائي: $clinicianName' : 'Clinician: $clinicianName'),
      if (clinicianId.isNotEmpty)
        (isArabic
            ? 'معرف الأخصائي: $clinicianId'
            : 'Clinician ID: $clinicianId'),
      (isArabic
          ? 'حالة الدفع: ${_paymentLabel(paymentStatus, isArabic)}'
          : 'Payment status: ${_paymentLabel(paymentStatus, isArabic)}'),
      (isArabic
          ? 'حالة التحويل: ${_payoutLabel(payoutStatus, isArabic)}'
          : 'Payout status: ${_payoutLabel(payoutStatus, isArabic)}'),
      if (receiptFile.isNotEmpty)
        (isArabic
            ? 'اسم ملف الإثبات: $receiptFile'
            : 'Receipt file: $receiptFile'),
      if (clientNote.isNotEmpty)
        (isArabic ? 'ملاحظة العميل: $clientNote' : 'Client note: $clientNote'),
      if (createdAt.isNotEmpty)
        (isArabic ? 'تاريخ الإنشاء: $createdAt' : 'Created at: $createdAt'),
      if (submittedAt.isNotEmpty)
        (isArabic
            ? 'تاريخ رفع الإثبات: $submittedAt'
            : 'Proof submitted at: $submittedAt'),
      if (approvedAt.isNotEmpty)
        (isArabic
            ? 'تاريخ اعتماد السداد: $approvedAt'
            : 'Payment approved at: $approvedAt'),
      if (payoutTransferredAt.isNotEmpty)
        (isArabic
            ? 'تاريخ تحويل المستحق: $payoutTransferredAt'
            : 'Payout transferred at: $payoutTransferredAt'),
      if (archivedAt.isNotEmpty)
        (isArabic ? 'تاريخ الأرشفة: $archivedAt' : 'Archived at: $archivedAt'),
    ];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isArabic ? 'معاينة الطباعة' : 'Print Preview'),
        content: SizedBox(
          width: 680,
          child: SingleChildScrollView(
            child: SelectableText(lines.join('\n')),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(isArabic ? 'إغلاق' : 'Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
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
          title: isArabic
              ? 'سجل المدفوعات'
              : 'Payments Ledger',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('booking_requests')
                .where('archived', isEqualTo: true)
                .snapshots(),
            builder: (context, snapA) {
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('bookingRequests')
                    .where('archived', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapB) {
                  if (snapA.hasError && snapB.hasError) {
                    return AppEmptyState(
                      message: isArabic
                          ? 'تعذر تحميل أرشيف المدفوعات'
                          : 'Unable to load payments archive',
                      icon: Icons.error_outline,
                    );
                  }

                  if (!snapA.hasData && !snapB.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final all = <Map<String, dynamic>>[];

                  if (snapA.hasData) {
                    all.addAll(
                        _normalizeDocs(snapA.data!.docs, 'booking_requests'));
                  }
                  if (snapB.hasData) {
                    all.addAll(
                        _normalizeDocs(snapB.data!.docs, 'bookingRequests'));
                  }

                  final unique = <String, Map<String, dynamic>>{};
                  for (final item in all) {
                    final id = (item['_id'] ?? '').toString();
                    if (id.isNotEmpty) unique[id] = item;
                  }

                  final items = unique.values
                      .where(_isPaymentArchiveRelevant)
                      .toList()
                    ..sort((a, b) {
                      final aTs =
                          a['archivedAt'] ?? a['updatedAt'] ?? a['createdAt'];
                      final bTs =
                          b['archivedAt'] ?? b['updatedAt'] ?? b['createdAt'];

                      DateTime ad = DateTime.fromMillisecondsSinceEpoch(0);
                      DateTime bd = DateTime.fromMillisecondsSinceEpoch(0);

                      if (aTs is Timestamp) ad = aTs.toDate();
                      if (bTs is Timestamp) bd = bTs.toDate();

                      return bd.compareTo(ad);
                    });

                  final clinicianNames = items
                      .map((e) => (e['assignedClinicianName'] ??
                              e['clinicianName'] ??
                              '')
                          .toString()
                          .trim())
                      .where((e) => e.isNotEmpty)
                      .toSet()
                      .toList()
                    ..sort();

                  final filtered = items.where(_matchesFilters).toList();

                  final approvedPayments = items
                      .where((e) =>
                          (e['paymentStatus'] ?? '').toString() == 'approved')
                      .length;

                  final paidPayouts = items
                      .where((e) =>
                          (e['payoutStatus'] ?? '').toString() ==
                          'paid_to_clinician')
                      .length;

                  final submittedProofs = items
                      .where((e) => (e['paymentReceiptFileName'] ?? '')
                          .toString()
                          .trim()
                          .isNotEmpty)
                      .length;

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
                                  ? 'سجل المدفوعات'
                                  : 'Payments Ledger',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              isArabic
                                  ? 'عرض مالي فقط لمسار السداد: من إثبات الدفع المرفوع من العميل وحتى تحويل مستحق الأخصائي.'
                                  : 'Financial-only archive view for the payment path from client proof submission to clinician payout.',
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() => _search = value.trim());
                              },
                              decoration: appInputDecoration(
                                context: context,
                                label: isArabic ? 'بحث' : 'Search',
                                icon: Icons.search,
                                hintText: isArabic
                                    ? 'ابحث بالعميل أو الأخصائي أو المعرف أو الملف'
                                    : 'Search by client, clinician, id, or file',
                              ),
                            ),
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                SizedBox(
                                  width: 260,
                                  child: DropdownButtonFormField<String>(
                                    initialValue: _paymentFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: isArabic
                                          ? 'حالة الدفع'
                                          : 'Payment status',
                                      icon: Icons.payments_outlined,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...[
                                        'approved',
                                        'submitted_by_client',
                                        'rejected',
                                      ].map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child:
                                              Text(_paymentLabel(e, isArabic)),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() =>
                                          _paymentFilter = value ?? 'all');
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 260,
                                  child: DropdownButtonFormField<String>(
                                    initialValue: _payoutFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: isArabic
                                          ? 'حالة التحويل'
                                          : 'Payout status',
                                      icon:
                                          Icons.account_balance_wallet_outlined,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...[
                                        'paid_to_clinician',
                                        'blocked',
                                        'pending',
                                      ].map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child:
                                              Text(_payoutLabel(e, isArabic)),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(
                                          () => _payoutFilter = value ?? 'all');
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 260,
                                  child: DropdownButtonFormField<String>(
                                    initialValue: _clinicianFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label:
                                          isArabic ? 'الأخصائي' : 'Clinician',
                                      icon: Icons.medical_services_outlined,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...clinicianNames.map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() =>
                                          _clinicianFilter = value ?? 'all');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int count = 4;
                          if (constraints.maxWidth < 1100) count = 2;
                          if (constraints.maxWidth < 650) count = 1;

                          return GridView.count(
                            crossAxisCount: count,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 2.1,
                            children: [
                              _summaryCard(
                                context,
                                title:
                                    isArabic ? 'إجمالي العناصر' : 'Total items',
                                value: '${items.length}',
                                color: const Color(0xFF9A7A6E),
                              ),
                              _summaryCard(
                                context,
                                title: isArabic
                                    ? 'مدفوعات معتمدة'
                                    : 'Approved payments',
                                value: '$approvedPayments',
                                color: const Color(0xFF1F9D63),
                              ),
                              _summaryCard(
                                context,
                                title: isArabic
                                    ? 'تحويلات مكتملة'
                                    : 'Completed payouts',
                                value: '$paidPayouts',
                                color: const Color(0xFF2E5AAC),
                              ),
                              _summaryCard(
                                context,
                                title: isArabic
                                    ? 'إثباتات مرفوعة'
                                    : 'Submitted proofs',
                                value: '$submittedProofs',
                                color: const Color(0xFF6C55B3),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      AppSectionPanel(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Text(
                          isArabic
                              ? 'عدد النتائج بعد الفلترة: ${filtered.length}'
                              : 'Filtered results: ${filtered.length}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (filtered.isEmpty)
                        AppEmptyState(
                          message: isArabic
                              ? 'لا توجد نتائج مطابقة'
                              : 'No matching results',
                          icon: Icons.search_off_rounded,
                        )
                      else
                        ...filtered.map((item) {
                          final id = (item['_id'] ?? '').toString();
                          final source = (item['_source'] ?? '').toString();
                          final clientName =
                              (item['clientName'] ?? '').toString();
                          final clientEmail =
                              (item['clientEmail'] ?? '').toString();
                          final clientId = (item['clientId'] ?? '').toString();
                          final clinicianName =
                              (item['assignedClinicianName'] ??
                                      item['clinicianName'] ??
                                      '')
                                  .toString();
                          final clinicianId = (item['assignedClinicianId'] ??
                                  item['clinicianId'] ??
                                  '')
                              .toString();
                          final paymentStatus =
                              (item['paymentStatus'] ?? '').toString();
                          final payoutStatus =
                              (item['payoutStatus'] ?? '').toString();
                          final receiptFile =
                              (item['paymentReceiptFileName'] ?? '').toString();
                          final clientNote =
                              (item['paymentClientNote'] ?? '').toString();
                          final createdAt = _dateText(item['createdAt']);
                          final submittedAt =
                              _dateText(item['paymentSubmittedAt']);
                          final approvedAt =
                              _dateText(item['paymentApprovedAt']);
                          final payoutTransferredAt =
                              _dateText(item['payoutTransferredAt']);
                          final archivedAt = _dateText(item['archivedAt']);
                          final archiveSection =
                              (item['archiveSection'] ?? '').toString();

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: AppSurfaceCard(
                              padding: const EdgeInsets.all(AppSpacing.lg),
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
                                              clientName.trim().isNotEmpty
                                                  ? clientName
                                                  : (isArabic
                                                      ? 'عميل'
                                                      : 'Client'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w800),
                                            ),
                                            if (clinicianName
                                                .trim()
                                                .isNotEmpty) ...[
                                              const SizedBox(height: 6),
                                              Text(
                                                isArabic
                                                    ? 'الأخصائي: $clinicianName'
                                                    : 'Clinician: $clinicianName',
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          AppStatusBadge(
                                            label: _paymentLabel(
                                              paymentStatus,
                                              isArabic,
                                            ),
                                            color: _paymentColor(paymentStatus),
                                          ),
                                          AppStatusBadge(
                                            label: _payoutLabel(
                                              payoutStatus,
                                              isArabic,
                                            ),
                                            color: _payoutColor(payoutStatus),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text('ID: $id'),
                                  Text('source: $source'),
                                  if (archiveSection.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'قسم الأرشفة الأصلي: $archiveSection'
                                            : 'Archive source section: $archiveSection',
                                      ),
                                    ),
                                  if (clientEmail.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'بريد العميل: $clientEmail'
                                            : 'Client email: $clientEmail',
                                      ),
                                    ),
                                  if (clientId.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'معرف العميل: $clientId'
                                            : 'Client ID: $clientId',
                                      ),
                                    ),
                                  if (clinicianId.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'معرف الأخصائي: $clinicianId'
                                            : 'Clinician ID: $clinicianId',
                                      ),
                                    ),
                                  if (createdAt.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'تاريخ الإنشاء: $createdAt'
                                            : 'Created at: $createdAt',
                                      ),
                                    ),
                                  if (submittedAt.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'تاريخ رفع الإثبات: $submittedAt'
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
                                            ? 'ملف الإثبات: $receiptFile'
                                            : 'Receipt file: $receiptFile',
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
                                  const SizedBox(height: 14),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      FilledButton.tonalIcon(
                                        onPressed: () =>
                                            _printPaymentItem(context, item),
                                        icon: const Icon(Icons.print_outlined),
                                        label: Text(
                                          isArabic ? 'طباعة' : 'Print',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
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
