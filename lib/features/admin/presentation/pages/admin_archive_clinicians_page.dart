import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminArchiveCliniciansPage extends StatefulWidget {
  const AdminArchiveCliniciansPage({super.key});

  @override
  State<AdminArchiveCliniciansPage> createState() =>
      _AdminArchiveCliniciansPageState();
}

class _AdminArchiveCliniciansPageState
    extends State<AdminArchiveCliniciansPage> {
  final TextEditingController _searchController = TextEditingController();

  String _clinicianFilter = 'all';
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

  bool _isClinicianArchiveRelevant(Map<String, dynamic> item) {
    if ((item['archived'] ?? false) != true) return false;
    final clinicianName =
        (item['assignedClinicianName'] ?? item['clinicianName'] ?? '')
            .toString()
            .trim();
    final clinicianId =
        (item['assignedClinicianId'] ?? item['clinicianId'] ?? '')
            .toString()
            .trim();
    return clinicianName.isNotEmpty || clinicianId.isNotEmpty;
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
        return isArabic ? 'Ù…ÙƒØªÙ…Ù„ ÙˆÙ…ØºÙ„Ù‚' : 'Completed and closed';
      case 'session_completed_pending_reviews':
        return isArabic ? 'Ø¨Ø§Ù†ØªØ¸Ø§Ø± Ø§Ù„ØªÙ‚ÙŠÙŠÙ…Ø§Øª' : 'Pending reviews';
      default:
        return status.isEmpty ? (isArabic ? 'ØºÙŠØ± Ù…Ø­Ø¯Ø¯' : 'Unknown') : status;
    }
  }

  bool _matchesSearch(Map<String, dynamic> item) {
    if (_search.trim().isEmpty) return true;
    final haystack = [
      (item['_id'] ?? '').toString(),
      (item['assignedClinicianName'] ?? item['clinicianName'] ?? '').toString(),
      (item['assignedClinicianId'] ?? item['clinicianId'] ?? '').toString(),
      (item['clientName'] ?? '').toString(),
      (item['status'] ?? '').toString(),
      (item['sessionStatus'] ?? '').toString(),
      (item['reviewStatus'] ?? '').toString(),
    ].join(' ').toLowerCase();
    return haystack.contains(_search.toLowerCase());
  }

  bool _matchesFilters(Map<String, dynamic> item) {
    final clinicianName =
        (item['assignedClinicianName'] ?? item['clinicianName'] ?? '')
            .toString()
            .trim();
    final status = (item['status'] ?? '').toString().trim();

    if (_clinicianFilter != 'all' && clinicianName != _clinicianFilter) {
      return false;
    }
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
          title: isArabic ? 'Ø£Ø±Ø´ÙŠÙ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠÙŠÙ†' : 'Clinicians Archive',
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
                      ? 'ØªØ¹Ø°Ø± ØªØ­Ù…ÙŠÙ„ Ø£Ø±Ø´ÙŠÙ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠÙŠÙ†'
                      : 'Unable to load clinicians archive',
                  icon: Icons.error_outline,
                );
              }

              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final items = _normalizeDocs(snap.data!.docs, 'booking_requests')
                  .where(_isClinicianArchiveRelevant)
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
                  .map((e) =>
                      (e['assignedClinicianName'] ?? e['clinicianName'] ?? '')
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
                          isArabic ? 'Ø£Ø±Ø´ÙŠÙ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠÙŠÙ†' : 'Clinicians Archive',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isArabic
                              ? 'Ø¹Ø±Ø¶ Ø®Ø§Øµ Ø¨Ø³Ø¬Ù„ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ Ø¯Ø§Ø®Ù„ Ø§Ù„Ø·Ù„Ø¨Ø§Øª Ø§Ù„Ù…Ø¤Ø±Ø´ÙØ©: Ø§Ù„Ø¬Ù„Ø³Ø§ØªØŒ Ø§Ù„Ø£Ø¯Ø§Ø¡ØŒ ÙˆØ§Ù„ØªÙ‚ÙŠÙŠÙ… Ø§Ù„Ù†Ù‡Ø§Ø¦ÙŠ.'
                              : 'A clinician-focused view across archived requests showing sessions, performance, and final review data.',
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _searchController,
                          onChanged: (value) =>
                              setState(() => _search = value.trim()),
                          decoration: appInputDecoration(
                            context: context,
                            label: isArabic ? 'Ø¨Ø­Ø«' : 'Search',
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
                                initialValue: _clinicianFilter,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic ? 'Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ' : 'Clinician',
                                  icon: Icons.medical_services_outlined,
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: 'all',
                                    child: Text(isArabic ? 'Ø§Ù„ÙƒÙ„' : 'All'),
                                  ),
                                  ...clinicianNames.map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  ),
                                ],
                                onChanged: (value) => setState(
                                  () => _clinicianFilter = value ?? 'all',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 260,
                              child: DropdownButtonFormField<String>(
                                initialValue: _statusFilter,
                                decoration: appInputDecoration(
                                  context: context,
                                  label: isArabic ? 'Ø§Ù„Ø­Ø§Ù„Ø©' : 'Status',
                                  icon: Icons.filter_alt_outlined,
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: 'all',
                                    child: Text(isArabic ? 'Ø§Ù„ÙƒÙ„' : 'All'),
                                  ),
                                  ...[
                                    'completed_success',
                                    'session_completed_pending_reviews',
                                  ].map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(_statusLabel(e, isArabic)),
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
                          ? 'Ø¹Ø¯Ø¯ Ø§Ù„Ù†ØªØ§Ø¦Ø¬ Ø¨Ø¹Ø¯ Ø§Ù„ÙÙ„ØªØ±Ø©: ${filtered.length}'
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
                          ? 'Ù„Ø§ ØªÙˆØ¬Ø¯ Ù†ØªØ§Ø¦Ø¬ Ù…Ø·Ø§Ø¨Ù‚Ø©'
                          : 'No matching results',
                      icon: Icons.search_off_rounded,
                    )
                  else
                    ...filtered.map((item) {
                      final clinicianName = (item['assignedClinicianName'] ??
                              item['clinicianName'] ??
                              '')
                          .toString()
                          .trim();
                      final clientName =
                          (item['clientName'] ?? '').toString().trim();
                      final status = (item['status'] ?? '').toString();
                      final sessionStatus =
                          (item['sessionStatus'] ?? '').toString();
                      final reviewStatus =
                          (item['reviewStatus'] ?? '').toString();
                      final finalReviewPercentage =
                          ((item['finalReviewPercentage'] ?? 0) as num)
                              .toDouble();
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
                                      clinicianName.isNotEmpty
                                          ? clinicianName
                                          : (isArabic ? 'Ø£Ø®ØµØ§Ø¦ÙŠ' : 'Clinician'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  AppStatusBadge(
                                    label: _statusLabel(status, isArabic),
                                    color: const Color(0xFFE2A067),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              if (clientName.isNotEmpty)
                                Text(
                                  isArabic
                                      ? 'Ø§Ù„Ø¹Ù…ÙŠÙ„: $clientName'
                                      : 'Client: $clientName',
                                ),
                              if ((item['assignedClinicianId'] ??
                                      item['clinicianId'] ??
                                      '')
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    isArabic
                                        ? 'Ù…Ø¹Ø±Ù Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠ: ${(item['assignedClinicianId'] ?? item['clinicianId']).toString()}'
                                        : 'Clinician ID: ${(item['assignedClinicianId'] ?? item['clinicianId']).toString()}',
                                  ),
                                ),
                              if (sessionStatus.trim().isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    isArabic
                                        ? 'Ø­Ø§Ù„Ø© Ø§Ù„Ø¬Ù„Ø³Ø©: $sessionStatus'
                                        : 'Session status: $sessionStatus',
                                  ),
                                ),
                              if (reviewStatus.trim().isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    isArabic
                                        ? 'Ø­Ø§Ù„Ø© Ø§Ù„ØªÙ‚ÙŠÙŠÙ…: $reviewStatus'
                                        : 'Review status: $reviewStatus',
                                  ),
                                ),
                              if (finalReviewPercentage > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    isArabic
                                        ? 'Ø§Ù„Ù†Ø³Ø¨Ø© Ø§Ù„Ù†Ù‡Ø§Ø¦ÙŠØ©: ${finalReviewPercentage.toStringAsFixed(1)}%'
                                        : 'Final percentage: ${finalReviewPercentage.toStringAsFixed(1)}%',
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
                                        ? 'Ù‚Ø³Ù… Ø§Ù„Ø£Ø±Ø´ÙØ© Ø§Ù„Ø£ØµÙ„ÙŠ: ${(item['archiveSection'] ?? '').toString()}'
                                        : 'Archive source section: ${(item['archiveSection'] ?? '').toString()}',
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
