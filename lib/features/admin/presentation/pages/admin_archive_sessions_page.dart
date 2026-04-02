import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';

class AdminArchiveSessionsPage extends StatefulWidget {
  const AdminArchiveSessionsPage({super.key});

  @override
  State<AdminArchiveSessionsPage> createState() =>
      _AdminArchiveSessionsPageState();
}

class _AdminArchiveSessionsPageState extends State<AdminArchiveSessionsPage> {
  final TextEditingController _searchController = TextEditingController();

  String _statusFilter = 'all';
  String _clinicianFilter = 'all';
  String _clientFilter = 'all';
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

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'completed_success':
        return isArabic ? 'مكتمل ومغلق' : 'Completed and closed';
      case 'payout_pending':
        return isArabic ? 'بانتظار التحويل' : 'Payout pending';
      case 'session_completed_pending_reviews':
        return isArabic ? 'بانتظار التقييمات' : 'Pending reviews';
      case 'session_scheduled':
        return isArabic ? 'جلسة مجدولة' : 'Session scheduled';
      case 'session_in_progress':
        return isArabic ? 'جلسة جارية' : 'Session in progress';
      case 'session_setup_pending':
        return isArabic ? 'بانتظار تجهيز الجلسة' : 'Session setup pending';
      default:
        return status.isEmpty ? (isArabic ? 'غير محدد' : 'Unknown') : status;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'completed_success':
        return const Color(0xFF1F9D63);
      case 'payout_pending':
        return const Color(0xFF2E5AAC);
      case 'session_completed_pending_reviews':
        return const Color(0xFFE39B2E);
      case 'session_scheduled':
      case 'session_in_progress':
      case 'session_setup_pending':
        return const Color(0xFF6C55B3);
      default:
        return const Color(0xFF6F9DC7);
    }
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
      (item['sessionDateText'] ?? '').toString(),
      (item['sessionCode'] ?? '').toString(),
      (item['sessionLink'] ?? '').toString(),
      (item['sessionStatus'] ?? '').toString(),
      (item['reviewStatus'] ?? '').toString(),
      (item['status'] ?? '').toString(),
    ].join(' ').toLowerCase();

    return haystack.contains(_search.toLowerCase());
  }

  bool _matchesFilters(Map<String, dynamic> item) {
    final status = (item['status'] ?? '').toString();
    final clinicianName =
        (item['assignedClinicianName'] ?? item['clinicianName'] ?? '')
            .toString()
            .trim();
    final clientName = (item['clientName'] ?? '').toString().trim();

    if (_statusFilter != 'all' && status != _statusFilter) return false;
    if (_clinicianFilter != 'all' && clinicianName != _clinicianFilter) {
      return false;
    }
    if (_clientFilter != 'all' && clientName != _clientFilter) return false;

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

  void _printArchiveItem(BuildContext context, Map<String, dynamic> item) {
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
    final status = (item['status'] ?? '').toString();
    final sessionDate = (item['sessionDateText'] ?? '').toString();
    final sessionLink = (item['sessionLink'] ?? '').toString();
    final sessionCode = (item['sessionCode'] ?? '').toString();
    final adminNotes = (item['sessionAdminNotes'] ?? '').toString();
    final sessionStatus = (item['sessionStatus'] ?? '').toString();
    final reviewStatus = (item['reviewStatus'] ?? '').toString();
    final createdAt = _dateText(item['createdAt']);
    final archivedAt = _dateText(item['archivedAt']);
    final finalReviewPercentage =
        ((item['finalReviewPercentage'] ?? 0) as num).toDouble();

    final lines = <String>[
      isArabic ? 'تقرير أرشيف جلسة' : 'Archived Session Report',
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
          ? 'الحالة: ${_statusLabel(status, isArabic)}'
          : 'Status: ${_statusLabel(status, isArabic)}'),
      if (sessionDate.isNotEmpty)
        (isArabic ? 'موعد الجلسة: $sessionDate' : 'Session date: $sessionDate'),
      if (sessionLink.isNotEmpty)
        (isArabic ? 'رابط الجلسة: $sessionLink' : 'Session link: $sessionLink'),
      if (sessionCode.isNotEmpty)
        (isArabic ? 'كود الجلسة: $sessionCode' : 'Session code: $sessionCode'),
      if (createdAt.isNotEmpty)
        (isArabic ? 'تاريخ الإنشاء: $createdAt' : 'Created at: $createdAt'),
      if (archivedAt.isNotEmpty)
        (isArabic ? 'تاريخ الأرشفة: $archivedAt' : 'Archived at: $archivedAt'),
      if (sessionStatus.isNotEmpty)
        (isArabic
            ? 'حالة الجلسة: $sessionStatus'
            : 'Session status: $sessionStatus'),
      if (reviewStatus.isNotEmpty)
        (isArabic
            ? 'حالة التقييم: $reviewStatus'
            : 'Review status: $reviewStatus'),
      if (finalReviewPercentage > 0)
        (isArabic
            ? 'المتوسط النهائي: ${finalReviewPercentage.toStringAsFixed(1)}%'
            : 'Final average: ${finalReviewPercentage.toStringAsFixed(1)}%'),
      if (adminNotes.isNotEmpty)
        (isArabic
            ? 'ملاحظات الإدارة: $adminNotes'
            : 'Admin notes: $adminNotes'),
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
          title:
              isArabic ? 'أرشيف الجلسات المتقدم' : 'Advanced Sessions Archive',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('booking_requests')
                .where('archived', isEqualTo: true)
                .where('archiveSection', isEqualTo: 'sessions')
                .snapshots(),
            builder: (context, snapA) {
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('bookingRequests')
                    .where('archived', isEqualTo: true)
                    .where('archiveSection', isEqualTo: 'sessions')
                    .snapshots(),
                builder: (context, snapB) {
                  if (snapA.hasError && snapB.hasError) {
                    return AppEmptyState(
                      message: isArabic
                          ? 'تعذر تحميل أرشيف الجلسات'
                          : 'Unable to load sessions archive',
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

                  final items = unique.values.toList()
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

                  final clientNames = items
                      .map((e) => (e['clientName'] ?? '').toString().trim())
                      .where((e) => e.isNotEmpty)
                      .toSet()
                      .toList()
                    ..sort();

                  final filtered = items.where(_matchesFilters).toList();

                  final completedCount = items
                      .where((e) =>
                          (e['status'] ?? '').toString() == 'completed_success')
                      .length;

                  final avgFinal = filtered.isEmpty
                      ? 0.0
                      : filtered
                              .map((e) =>
                                  ((e['finalReviewPercentage'] ?? 0) as num)
                                      .toDouble())
                              .fold<double>(0, (a, b) => a + b) /
                          filtered.length;

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
                                  ? 'أرشيف الجلسات المتقدم'
                                  : 'Advanced Sessions Archive',
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
                                  ? 'عرض جلسي فقط للعمليات المؤرشفة: بيانات الجلسة والتنفيذ والتقييم النهائي، بدون تفاصيل الدفع والتحويل.'
                                  : 'Session-only archive view for execution and review data, without payment or payout details.',
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
                                    ? 'ابحث بالعميل أو الأخصائي أو المعرف أو التاريخ'
                                    : 'Search by client, clinician, id, or date',
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
                                    initialValue: _statusFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: isArabic ? 'الحالة' : 'Status',
                                      icon: Icons.filter_alt_outlined,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...[
                                        'completed_success',
                                        'payout_pending',
                                        'session_completed_pending_reviews',
                                        'session_scheduled',
                                        'session_in_progress',
                                        'session_setup_pending',
                                      ].map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child:
                                              Text(_statusLabel(e, isArabic)),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(
                                          () => _statusFilter = value ?? 'all');
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
                                SizedBox(
                                  width: 260,
                                  child: DropdownButtonFormField<String>(
                                    initialValue: _clientFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: isArabic ? 'العميل' : 'Client',
                                      icon: Icons.person_outline_rounded,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...clientNames.map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(
                                          () => _clientFilter = value ?? 'all');
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
                          int count = 3;
                          if (constraints.maxWidth < 950) count = 2;
                          if (constraints.maxWidth < 650) count = 1;

                          return GridView.count(
                            crossAxisCount: count,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 2.2,
                            children: [
                              _summaryCard(
                                context,
                                title:
                                    isArabic ? 'إجمالي العناصر' : 'Total items',
                                value: '${items.length}',
                                color: const Color(0xFF6F9DC7),
                              ),
                              _summaryCard(
                                context,
                                title: isArabic ? 'مكتمل ومغلق' : 'Completed',
                                value: '$completedCount',
                                color: const Color(0xFF1F9D63),
                              ),
                              _summaryCard(
                                context,
                                title: isArabic
                                    ? 'متوسط النسبة الحالية'
                                    : 'Current average %',
                                value: '${avgFinal.toStringAsFixed(1)}%',
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
                          final status = (item['status'] ?? '').toString();
                          final sessionStatus =
                              (item['sessionStatus'] ?? '').toString();
                          final reviewStatus =
                              (item['reviewStatus'] ?? '').toString();
                          final sessionDate =
                              (item['sessionDateText'] ?? '').toString();
                          final sessionLink =
                              (item['sessionLink'] ?? '').toString();
                          final sessionCode =
                              (item['sessionCode'] ?? '').toString();
                          final adminNotes =
                              (item['sessionAdminNotes'] ?? '').toString();
                          final createdAt = _dateText(item['createdAt']);
                          final archivedAt = _dateText(item['archivedAt']);
                          final finalReviewPercentage =
                              ((item['finalReviewPercentage'] ?? 0) as num)
                                  .toDouble();

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
                                      AppStatusBadge(
                                        label: _statusLabel(status, isArabic),
                                        color: _statusColor(status),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text('ID: $id'),
                                  Text('source: $source'),
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
                                  if (sessionDate.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'موعد الجلسة: $sessionDate'
                                            : 'Session date: $sessionDate',
                                      ),
                                    ),
                                  if (sessionStatus.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'حالة الجلسة: $sessionStatus'
                                            : 'Session status: $sessionStatus',
                                      ),
                                    ),
                                  if (reviewStatus.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'حالة التقييم: $reviewStatus'
                                            : 'Review status: $reviewStatus',
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
                                  if (sessionLink.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'رابط الجلسة: $sessionLink'
                                            : 'Session link: $sessionLink',
                                      ),
                                    ),
                                  if (sessionCode.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'كود الجلسة: $sessionCode'
                                            : 'Session code: $sessionCode',
                                      ),
                                    ),
                                  if (finalReviewPercentage > 0)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'المتوسط النهائي: ${finalReviewPercentage.toStringAsFixed(1)}%'
                                            : 'Final average: ${finalReviewPercentage.toStringAsFixed(1)}%',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  if (adminNotes.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'ملاحظات الإدارة: $adminNotes'
                                            : 'Admin notes: $adminNotes',
                                      ),
                                    ),
                                  const SizedBox(height: 14),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      FilledButton.tonalIcon(
                                        onPressed: () =>
                                            _printArchiveItem(context, item),
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
