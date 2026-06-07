import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminArchivePage extends StatefulWidget {
  const AdminArchivePage({super.key});

  @override
  State<AdminArchivePage> createState() => _AdminArchivePageState();
}

class _AdminArchivePageState extends State<AdminArchivePage> {
  int _selectedSectionIndex = 0;

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

  String _sectionTitle(String key, bool isArabic) {
    switch (key) {
      case 'clinicians':
        return isArabic ? 'Ø£Ø±Ø´ÙŠÙ Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠÙŠÙ†' : 'Clinicians Archive';
      case 'centers':
        return isArabic ? 'Ø£Ø±Ø´ÙŠÙ Ø§Ù„Ù…Ø±Ø§ÙƒØ²' : 'Centers Archive';
      case 'support':
        return isArabic ? 'Ø£Ø±Ø´ÙŠÙ Ø§Ù„Ø±Ø³Ø§Ø¦Ù„ ÙˆØ§Ù„Ø¯Ø¹Ù…' : 'Support Archive';
      case 'reports':
        return isArabic ? 'Ø£Ø±Ø´ÙŠÙ Ø§Ù„ØªÙ‚Ø§Ø±ÙŠØ±' : 'Reports Archive';
      default:
        return key;
    }
  }

  String _sectionSubtitle(String key, bool isArabic) {
    switch (key) {
      case 'clinicians':
        return isArabic
            ? 'Ø·Ù„Ø¨Ø§Øª Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠÙŠÙ† ÙˆØ³Ø¬Ù„ Ø§Ù„Ø£Ø¯Ø§Ø¡'
            : 'Clinician requests and performance history';
      case 'centers':
        return isArabic
            ? 'Ø·Ù„Ø¨Ø§Øª Ø§Ù„Ù…Ø±Ø§ÙƒØ² ÙˆØ§Ù„Ù…ÙˆØ§ÙÙ‚Ø§Øª'
            : 'Center requests and approvals';
      case 'support':
        return isArabic
            ? 'Ø§Ù„Ø¯Ø¹Ù…ØŒ Ø§Ù„Ø±Ø³Ø§Ø¦Ù„ØŒ ÙˆØ§Ù„ØªØµØ¹ÙŠØ¯Ø§Øª Ø§Ù„Ù…ØºÙ„Ù‚Ø©'
            : 'Support, messages, and closed escalations';
      case 'reports':
        return isArabic
            ? 'Ø§Ù„ØªÙ‚Ø§Ø±ÙŠØ± Ø§Ù„Ø¥Ø¯Ø§Ø±ÙŠØ© Ø§Ù„Ù…ÙˆØ­Ø¯Ø©'
            : 'Unified administrative reports';
      default:
        return '';
    }
  }

  IconData _sectionIcon(String key) {
    switch (key) {
      case 'clinicians':
        return Icons.verified_user_outlined;
      case 'centers':
        return Icons.apartment_outlined;
      case 'support':
        return Icons.support_agent_outlined;
      case 'reports':
        return Icons.assessment_outlined;
      default:
        return Icons.archive_outlined;
    }
  }

  Color _sectionColor(String key) {
    switch (key) {
      case 'clinicians':
        return const Color(0xFFE2A067);
      case 'centers':
        return const Color(0xFF37B8B0);
      case 'support':
        return const Color(0xFFE58667);
      case 'reports':
        return const Color(0xFF6C55B3);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  bool _hasClinicianContext(Map<String, dynamic> item) {
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

  bool _hasCenterContext(Map<String, dynamic> item) {
    final requestKind = (item['requestKind'] ?? '').toString().trim();
    final centerName =
        (item['centerName'] ?? item['displayName'] ?? '').toString().trim();
    final centerId = (item['centerId'] ?? '').toString().trim();
    return requestKind == 'center' ||
        centerName.isNotEmpty ||
        centerId.isNotEmpty;
  }


  bool _hasSessionContext(Map<String, dynamic> item) {
    final status = (item['status'] ?? '').toString().trim();
    final sessionStatus = (item['sessionStatus'] ?? '').toString().trim();
    final sessionDate = (item['sessionDateText'] ?? '').toString().trim();
    final sessionCode = (item['sessionCode'] ?? '').toString().trim();
    final sessionLink = (item['sessionLink'] ?? '').toString().trim();
    return (sessionStatus.isNotEmpty && sessionStatus != 'not_created') ||
        sessionDate.isNotEmpty ||
        sessionCode.isNotEmpty ||
        sessionLink.isNotEmpty ||
        {
          'session_setup_pending',
          'session_scheduled',
          'session_in_progress',
          'session_completed_pending_reviews',
          'completed_success',
        }.contains(status);
  }

  bool _hasReportContext(Map<String, dynamic> item) {
    final reviewStatus = (item['reviewStatus'] ?? '').toString().trim();
    final finalReviewPercentage =
        ((item['finalReviewPercentage'] ?? 0) as num).toDouble();
    return (reviewStatus.isNotEmpty &&
            reviewStatus != 'not_started' &&
            reviewStatus != 'blocked') ||
        finalReviewPercentage > 0;
  }

  bool _hasSupportContext(Map<String, dynamic> item) {
    final threadId = (item['threadId'] ?? '').toString().trim();
    final escalationId = (item['escalationId'] ?? '').toString().trim();
    return threadId.isNotEmpty || escalationId.isNotEmpty;
  }

  bool _belongsToSection(Map<String, dynamic> item, String section) {
    if ((item['archived'] ?? false) != true) return false;

    final archiveSection = (item['archiveSection'] ?? '').toString().trim();
    if (archiveSection == section) return true;

    switch (section) {
      case 'clinicians':
        return _hasClinicianContext(item);
      case 'centers':
        return _hasCenterContext(item);
      case 'support':
        return _hasSupportContext(item);
      case 'reports':
        return _hasReportContext(item);
      default:
        return false;
    }
  }

  void _openSection(BuildContext context, String key) {
    switch (key) {
      case 'clinicians':
        Navigator.of(context).pushNamed(Routes.adminArchiveClinicians);
        return;
      case 'centers':
        Navigator.of(context).pushNamed(Routes.adminArchiveCenters);
        return;
      case 'support':
        Navigator.of(context).pushNamed(Routes.adminArchiveSupport);
        return;
      case 'reports':
        Navigator.of(context).pushNamed(Routes.adminArchiveReports);
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'Ø§Ù„Ø£Ø±Ø´ÙŠÙ' : 'Archive',
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
                      ? 'ØªØ¹Ø°Ø± ØªØ­Ù…ÙŠÙ„ Ø§Ù„Ø£Ø±Ø´ÙŠÙ'
                      : 'Unable to load archive',
                  icon: Icons.error_outline,
                );
              }

              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final items =
                  _normalizeDocs(snap.data!.docs, 'booking_requests').toList();
              final sectionKeys = [
                'clinicians',
                'centers',
                'support',
                'reports',
              ];
              final counts = <String, int>{
                for (final key in sectionKeys) key: 0,
              };

              for (final item in items) {
                for (final section in sectionKeys) {
                  if (_belongsToSection(item, section)) {
                    counts[section] = (counts[section] ?? 0) + 1;
                  }
                }
              }
              final selectedSection = sectionKeys[_selectedSectionIndex];
              final selectedColor = _sectionColor(selectedSection);

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
                              ? 'Ø§Ù„Ø£Ø±Ø´ÙŠÙ Ø§Ù„ÙØ¹Ù„ÙŠ Ø§Ù„Ù…Ø±ØªØ¨Ø· Ø¨Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª'
                              : 'Live archive connected to real data',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isArabic
                              ? 'Ø§Ù„ØµÙØ­Ø© Ø§Ù„Ø±Ø¦ÙŠØ³ÙŠØ© Ù„Ù„Ø£Ø±Ø´ÙŠÙ ØªØ¹Ø±Ø¶ Ø§Ù„Ø£Ù‚Ø³Ø§Ù… ÙÙ‚Ø·. ÙƒÙ„ Ø§Ù„Ø¹Ù†Ø§ØµØ± Ø§Ù„Ù…Ø¤Ø±Ø´ÙØ© Ø³ØªØ¬Ø¯Ù‡Ø§ Ø¯Ø§Ø®Ù„ Ø§Ù„Ù‚Ø³Ù… Ø§Ù„Ù…Ù†Ø§Ø³Ø¨ Ù„Ù‡Ø§ØŒ Ø­ØªÙ‰ Ù„Ø§ ØªØªÙƒØ¯Ø³ Ø§Ù„Ø¹Ù…Ù„ÙŠØ§Øª ÙÙŠ Ø´Ø§Ø´Ø© ÙˆØ§Ø­Ø¯Ø©.'
                              : 'The archive home shows sections only. Archived items live inside their own section pages so operations do not pile up in one screen.',
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
                        ),
                        const SizedBox(height: 12),
                        AppStatusBadge(
                          label: isArabic
                              ? '${items.length} Ø¹Ù†ØµØ± Ù…Ø¤Ø±Ø´Ù Ø¥Ø¬Ù…Ø§Ù„Ù‹Ø§'
                              : '${items.length} total archived items',
                          color: const Color(0xFF4D7C6A),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(sectionKeys.length, (index) {
                      final key = sectionKeys[index];
                      final color = _sectionColor(key);
                      final isSelected = _selectedSectionIndex == index;

                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () =>
                            setState(() => _selectedSectionIndex = index),
                        child: Container(
                          width: 142,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? color
                                  : AppColors.mutedGold.withValues(alpha: 0.22),
                            ),
                            color: isSelected
                                ? color.withValues(alpha: 0.08)
                                : null,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor:
                                    isSelected ? color : AppColors.sandstone,
                                child: Icon(
                                  _sectionIcon(key),
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.mist,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _sectionTitle(key, isArabic),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: isSelected ? color : null,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isArabic
                                    ? '${counts[key] ?? 0} Ø¹Ù†ØµØ±'
                                    : '${counts[key] ?? 0} items',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: AppColors.mist,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: selectedColor,
                          child: Icon(
                            _sectionIcon(selectedSection),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _sectionTitle(selectedSection, isArabic),
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _sectionSubtitle(selectedSection, isArabic),
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.mist,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        AppStatusBadge(
                          label: isArabic
                              ? '${counts[selectedSection] ?? 0} Ø¹Ù†ØµØ±'
                              : '${counts[selectedSection] ?? 0} items',
                          color: selectedColor,
                        ),
                        const SizedBox(height: 14),
                        Align(
                          alignment: isArabic
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: FilledButton.icon(
                            onPressed: () =>
                                _openSection(context, selectedSection),
                            icon: const Icon(Icons.arrow_forward),
                            label: Text(
                              isArabic ? 'ÙØªØ­ Ø§Ù„Ù‚Ø³Ù…' : 'Open section',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
