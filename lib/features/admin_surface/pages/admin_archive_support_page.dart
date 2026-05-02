import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminArchiveSupportPage extends StatefulWidget {
  const AdminArchiveSupportPage({super.key});

  @override
  State<AdminArchiveSupportPage> createState() =>
      _AdminArchiveSupportPageState();
}

class _AdminArchiveSupportPageState extends State<AdminArchiveSupportPage> {
  final TextEditingController _searchController = TextEditingController();
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

  bool _isSupportArchiveRelevant(Map<String, dynamic> item) {
    if ((item['archived'] ?? false) != true) return false;
    final threadId = (item['threadId'] ?? '').toString().trim();
    final escalationId = (item['escalationId'] ?? '').toString().trim();
    return threadId.isNotEmpty || escalationId.isNotEmpty;
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
      (item['threadId'] ?? '').toString(),
      (item['escalationId'] ?? '').toString(),
      (item['status'] ?? '').toString(),
    ].join(' ').toLowerCase();
    return haystack.contains(_search.toLowerCase());
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
          title: isArabic ? 'أرشيف الدعم' : 'Support Archive',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('booking_requests')
                .where('archived', isEqualTo: true)
                .snapshots(),
            builder: (context, snap) {
              if (snap.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل أرشيف الدعم'
                      : 'Unable to load support archive',
                  icon: Icons.error_outline,
                );
              }

              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final items = _normalizeDocs(snap.data!.docs, 'booking_requests')
                  .where(_isSupportArchiveRelevant)
                  .where(_matchesSearch)
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
                          isArabic ? 'أرشيف الدعم' : 'Support Archive',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isArabic
                              ? 'عرض خاص للعناصر المؤرشفة المرتبطة بمحادثات الدعم أو التصعيدات فقط.'
                              : 'A focused view for archived items linked to support threads or escalations only.',
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
                      final clientName =
                          (item['clientName'] ?? '').toString().trim();
                      final status = (item['status'] ?? '').toString();
                      final threadId = (item['threadId'] ?? '').toString();
                      final escalationId =
                          (item['escalationId'] ?? '').toString();
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
                              Text(
                                clientName.isNotEmpty
                                    ? clientName
                                    : (isArabic ? 'عميل' : 'Client'),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 12),
                              if (status.trim().isNotEmpty)
                                Text(
                                  isArabic
                                      ? 'الحالة: $status'
                                      : 'Status: $status',
                                ),
                              if (threadId.trim().isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    isArabic
                                        ? 'معرف المحادثة: $threadId'
                                        : 'Thread ID: $threadId',
                                  ),
                                ),
                              if (escalationId.trim().isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    isArabic
                                        ? 'معرف التصعيد: $escalationId'
                                        : 'Escalation ID: $escalationId',
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
          ),
        ),
      ),
    );
  }
}
