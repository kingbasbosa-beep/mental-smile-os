import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';

class AdminArchiveAccountingPage extends StatefulWidget {
  const AdminArchiveAccountingPage({super.key});

  @override
  State<AdminArchiveAccountingPage> createState() =>
      _AdminArchiveAccountingPageState();
}

class _AdminArchiveAccountingPageState
    extends State<AdminArchiveAccountingPage> {
  final TextEditingController _searchController = TextEditingController();

  String _paymentFilter = 'all';
  String _payoutFilter = 'all';
  String _search = '';

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  List<Map<String, dynamic>> _normalizeDocs(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    String source,
  ) {
    return docs
        .map((doc) => {
              ...doc.data(),
              '_id': doc.id,
              '_source': source,
            })
        .toList();
  }

  bool _isAccountingArchiveRelevant(Map<String, dynamic> item) {
    if ((item['archived'] ?? false) != true) return false;
    final paymentStatus = (item['paymentStatus'] ?? '').toString().trim();
    final payoutStatus = (item['payoutStatus'] ?? '').toString().trim();
    return (paymentStatus.isNotEmpty && paymentStatus != 'not_started') ||
        (payoutStatus.isNotEmpty && payoutStatus != 'not_started') ||
        item['paymentApprovedAt'] != null ||
        item['payoutTransferredAt'] != null;
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
      (item['clientId'] ?? '').toString(),
      (item['assignedClinicianId'] ?? item['clinicianId'] ?? '').toString(),
      (item['paymentStatus'] ?? '').toString(),
      (item['payoutStatus'] ?? '').toString(),
      (item['paymentReceiptFileName'] ?? '').toString(),
    ].join(' ').toLowerCase();
    return haystack.contains(_search.toLowerCase());
  }

  bool _matchesFilters(Map<String, dynamic> item) {
    final paymentStatus = (item['paymentStatus'] ?? '').toString().trim();
    final payoutStatus = (item['payoutStatus'] ?? '').toString().trim();

    if (_paymentFilter != 'all' && paymentStatus != _paymentFilter) {
      return false;
    }
    if (_payoutFilter != 'all' && payoutStatus != _payoutFilter) return false;
    return _matchesSearch(item);
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
          title: isArabic ? 'أرشيف المحاسبة' : 'Accounting Archive',
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
                          ? 'تعذر تحميل أرشيف المحاسبة'
                          : 'Unable to load accounting archive',
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
                      .where(_isAccountingArchiveRelevant)
                      .where(_matchesFilters)
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
                                  ? 'أرشيف المحاسبة'
                                  : 'Accounting Archive',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              isArabic
                                  ? 'عرض مالي مختصر للحسابات فقط: حالات السداد والتحويل والمراجع والتواريخ الأساسية، بدون كشف بيانات زائدة.'
                                  : 'A compact accounting-only view with payment and payout states, references, and essential dates only.',
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _searchController,
                              onChanged: (value) =>
                                  setState(() => _search = value.trim()),
                              decoration: appInputDecoration(
                                context: context,
                                label: isArabic ? 'بحث' : 'Search',
                                icon: Icons.search,
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
                                          child: Text(e),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _paymentFilter = value ?? 'all',
                                    ),
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
                                          child: Text(e),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _payoutFilter = value ?? 'all',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppSectionPanel(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Text(
                          isArabic
                              ? 'عدد النتائج بعد الفلترة: ${items.length}'
                              : 'Filtered results: ${items.length}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (items.isEmpty)
                        AppEmptyState(
                          message: isArabic
                              ? 'لا توجد نتائج مطابقة'
                              : 'No matching results',
                          icon: Icons.search_off_rounded,
                        )
                      else
                        ...items.map((item) {
                          final id = (item['_id'] ?? '').toString();
                          final clientId = (item['clientId'] ?? '').toString();
                          final clinicianId = (item['assignedClinicianId'] ??
                                  item['clinicianId'] ??
                                  '')
                              .toString();
                          final paymentStatus =
                              (item['paymentStatus'] ?? '').toString();
                          final payoutStatus =
                              (item['payoutStatus'] ?? '').toString();
                          final receipt =
                              (item['paymentReceiptFileName'] ?? '').toString();
                          final archivedAt = _dateText(item['archivedAt']);
                          final approvedAt =
                              _dateText(item['paymentApprovedAt']);
                          final payoutAt =
                              _dateText(item['payoutTransferredAt']);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: AppSurfaceCard(
                              padding: const EdgeInsets.all(AppSpacing.lg),
                              child: Column(
                                crossAxisAlignment: isArabic
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ID: $id',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 12),
                                  if (clientId.trim().isNotEmpty)
                                    Text(
                                      isArabic
                                          ? 'معرف العميل: $clientId'
                                          : 'Client ID: $clientId',
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
                                  if (paymentStatus.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'حالة الدفع: $paymentStatus'
                                            : 'Payment status: $paymentStatus',
                                      ),
                                    ),
                                  if (payoutStatus.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'حالة التحويل: $payoutStatus'
                                            : 'Payout status: $payoutStatus',
                                      ),
                                    ),
                                  if (receipt.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'مرجع الإثبات: $receipt'
                                            : 'Receipt ref: $receipt',
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
                                  if (payoutAt.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'تاريخ تحويل المستحق: $payoutAt'
                                            : 'Payout transferred at: $payoutAt',
                                      ),
                                    ),
                                  if ((item['archiveSection'] ?? '')
                                      .toString()
                                      .trim()
                                      .isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'قسم الأرشفة الأصلي: ${(item['archiveSection'] ?? '').toString()}'
                                            : 'Archive source section: ${(item['archiveSection'] ?? '').toString()}',
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
