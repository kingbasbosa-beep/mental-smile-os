import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';

class AdminArchiveCentersPage extends StatefulWidget {
  const AdminArchiveCentersPage({super.key});

  @override
  State<AdminArchiveCentersPage> createState() =>
      _AdminArchiveCentersPageState();
}

class _AdminArchiveCentersPageState extends State<AdminArchiveCentersPage> {
  final TextEditingController _searchController = TextEditingController();

  String _centerFilter = 'all';
  String _statusFilter = 'all';
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

  bool _isCenterArchiveRelevant(Map<String, dynamic> item) {
    if ((item['archived'] ?? false) != true) return false;
    final requestKind = (item['requestKind'] ?? '').toString().trim();
    final centerName =
        (item['centerName'] ?? item['displayName'] ?? '').toString().trim();
    final centerId = (item['centerId'] ?? '').toString().trim();
    return requestKind == 'center' ||
        centerName.isNotEmpty ||
        centerId.isNotEmpty;
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
      case 'approved':
        return isArabic ? 'مركز معتمد' : 'Approved center';
      case 'center_follow_up':
        return isArabic ? 'متابعة المراكز' : 'Center follow-up';
      case 'completed_success':
        return isArabic ? 'مكتمل ومغلق' : 'Completed and closed';
      default:
        return status.isEmpty ? (isArabic ? 'غير محدد' : 'Unknown') : status;
    }
  }

  bool _matchesSearch(Map<String, dynamic> item) {
    if (_search.trim().isEmpty) return true;
    final haystack = [
      (item['_id'] ?? '').toString(),
      (item['centerName'] ?? item['displayName'] ?? '').toString(),
      (item['centerId'] ?? '').toString(),
      (item['clientName'] ?? '').toString(),
      (item['status'] ?? '').toString(),
      (item['requestKind'] ?? '').toString(),
      (item['archiveSection'] ?? '').toString(),
    ].join(' ').toLowerCase();
    return haystack.contains(_search.toLowerCase());
  }

  bool _matchesFilters(Map<String, dynamic> item) {
    final centerName =
        (item['centerName'] ?? item['displayName'] ?? '').toString().trim();
    final status = (item['status'] ?? '').toString().trim();
    if (_centerFilter != 'all' && centerName != _centerFilter) return false;
    if (_statusFilter != 'all' && status != _statusFilter) return false;
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
          title: isArabic ? 'أرشيف المراكز' : 'Centers Archive',
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
                          ? 'تعذر تحميل أرشيف المراكز'
                          : 'Unable to load centers archive',
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
                      .where(_isCenterArchiveRelevant)
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

                  final centerNames = items
                      .map((e) => (e['centerName'] ?? e['displayName'] ?? '')
                          .toString()
                          .trim())
                      .where((e) => e.isNotEmpty)
                      .toSet()
                      .toList()
                    ..sort();

                  final filtered = items.where(_matchesFilters).toList();

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
                              isArabic ? 'أرشيف المراكز' : 'Centers Archive',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              isArabic
                                  ? 'عرض خاص بطلبات المراكز المؤرشفة وسير الموافقة والمتابعة الخاصة بها.'
                                  : 'A center-focused archive view for archived center requests and their approval/follow-up trail.',
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
                                    initialValue: _centerFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: isArabic ? 'المركز' : 'Center',
                                      icon: Icons.apartment_outlined,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...centerNames.map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _centerFilter = value ?? 'all',
                                    ),
                                  ),
                                ),
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
                                        'approved',
                                        'center_follow_up',
                                        'completed_success',
                                      ].map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child:
                                              Text(_statusLabel(e, isArabic)),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _statusFilter = value ?? 'all',
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
                              ? 'عدد النتائج بعد الفلترة: ${filtered.length}'
                              : 'Filtered results: ${filtered.length}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
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
                          final centerName =
                              (item['centerName'] ?? item['displayName'] ?? '')
                                  .toString()
                                  .trim();
                          final status = (item['status'] ?? '').toString();
                          final requestKind =
                              (item['requestKind'] ?? '').toString();
                          final centerId = (item['centerId'] ?? '').toString();
                          final clientName =
                              (item['clientName'] ?? '').toString().trim();
                          final note = (item['note'] ?? '').toString().trim();
                          final archivedAt = _dateText(item['archivedAt']);

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
                                        child: Text(
                                          centerName.isNotEmpty
                                              ? centerName
                                              : (isArabic ? 'مركز' : 'Center'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      AppStatusBadge(
                                        label: _statusLabel(status, isArabic),
                                        color: const Color(0xFF37B8B0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  if (centerId.trim().isNotEmpty)
                                    Text(
                                      isArabic
                                          ? 'معرف المركز: $centerId'
                                          : 'Center ID: $centerId',
                                    ),
                                  if (requestKind.trim().isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'نوع الطلب: $requestKind'
                                            : 'Request kind: $requestKind',
                                      ),
                                    ),
                                  if (clientName.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'العميل المرتبط: $clientName'
                                            : 'Related client: $clientName',
                                      ),
                                    ),
                                  if (note.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        isArabic
                                            ? 'ملاحظة الطلب: $note'
                                            : 'Request note: $note',
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
