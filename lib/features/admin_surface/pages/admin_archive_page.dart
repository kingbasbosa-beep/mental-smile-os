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
      case 'sessions':
        return isArabic ? 'أرشيف الجلسات' : 'Sessions Archive';
      case 'payments':
        return isArabic ? 'أرشيف المدفوعات' : 'Payments Archive';
      case 'clinicians':
        return isArabic ? 'أرشيف الأخصائيين' : 'Clinicians Archive';
      case 'centers':
        return isArabic ? 'أرشيف المراكز' : 'Centers Archive';
      case 'support':
        return isArabic ? 'أرشيف الرسائل والدعم' : 'Support Archive';
      case 'reports':
        return isArabic ? 'أرشيف التقارير' : 'Reports Archive';
      case 'accounting':
        return isArabic ? 'أرشيف المحاسبة' : 'Accounting Archive';
      default:
        return key;
    }
  }

  String _sectionSubtitle(String key, bool isArabic) {
    switch (key) {
      case 'sessions':
        return isArabic
            ? 'العمليات والجلسات المكتملة والمؤرشفة'
            : 'Completed sessions and archived flows';
      case 'payments':
        return isArabic
            ? 'سجلات الدفع والتحويلات المالية'
            : 'Payments and transfer records';
      case 'clinicians':
        return isArabic
            ? 'طلبات الأخصائيين وسجل الأداء'
            : 'Clinician requests and performance history';
      case 'centers':
        return isArabic
            ? 'طلبات المراكز والموافقات'
            : 'Center requests and approvals';
      case 'support':
        return isArabic
            ? 'الدعم، الرسائل، والتصعيدات المغلقة'
            : 'Support, messages, and closed escalations';
      case 'reports':
        return isArabic
            ? 'التقارير الإدارية الموحدة'
            : 'Unified administrative reports';
      case 'accounting':
        return isArabic
            ? 'الهيكل المالي والمحاسبي'
            : 'Financial and accounting structure';
      default:
        return '';
    }
  }

  IconData _sectionIcon(String key) {
    switch (key) {
      case 'sessions':
        return Icons.video_call_outlined;
      case 'payments':
        return Icons.account_balance_wallet_outlined;
      case 'clinicians':
        return Icons.verified_user_outlined;
      case 'centers':
        return Icons.apartment_outlined;
      case 'support':
        return Icons.support_agent_outlined;
      case 'reports':
        return Icons.assessment_outlined;
      case 'accounting':
        return Icons.receipt_long_outlined;
      default:
        return Icons.archive_outlined;
    }
  }

  Color _sectionColor(String key) {
    switch (key) {
      case 'sessions':
        return const Color(0xFF6F9DC7);
      case 'payments':
        return const Color(0xFF9A7A6E);
      case 'clinicians':
        return const Color(0xFFE2A067);
      case 'centers':
        return const Color(0xFF37B8B0);
      case 'support':
        return const Color(0xFFE58667);
      case 'reports':
        return const Color(0xFF6C55B3);
      case 'accounting':
        return const Color(0xFF4D7C6A);
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

  bool _hasPaymentContext(Map<String, dynamic> item) {
    final paymentStatus = (item['paymentStatus'] ?? '').toString().trim();
    final payoutStatus = (item['payoutStatus'] ?? '').toString().trim();
    final proof = (item['paymentReceiptFileName'] ?? '').toString().trim();
    final note = (item['paymentClientNote'] ?? '').toString().trim();
    return (paymentStatus.isNotEmpty && paymentStatus != 'not_started') ||
        (payoutStatus.isNotEmpty && payoutStatus != 'not_started') ||
        proof.isNotEmpty ||
        note.isNotEmpty ||
        item['paymentApprovedAt'] != null ||
        item['paymentSubmittedAt'] != null ||
        item['payoutTransferredAt'] != null;
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
          'payout_pending',
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
      case 'sessions':
        return _hasSessionContext(item);
      case 'payments':
        return _hasPaymentContext(item);
      case 'clinicians':
        return _hasClinicianContext(item);
      case 'centers':
        return _hasCenterContext(item);
      case 'support':
        return _hasSupportContext(item);
      case 'reports':
        return _hasReportContext(item);
      case 'accounting':
        return _hasPaymentContext(item);
      default:
        return false;
    }
  }

  void _openSection(BuildContext context, String key) {
    switch (key) {
      case 'sessions':
        Navigator.of(context).pushNamed(Routes.adminArchiveSessions);
        return;
      case 'payments':
        Navigator.of(context).pushNamed(Routes.adminArchivePayments);
        return;
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
      case 'accounting':
        Navigator.of(context).pushNamed(Routes.adminArchiveAccounting);
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
          title: isArabic ? 'الأرشيف' : 'Archive',
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
                      ? 'تعذر تحميل الأرشيف'
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
                'sessions',
                'payments',
                'clinicians',
                'centers',
                'support',
                'reports',
                'accounting',
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
                              ? 'الأرشيف الفعلي المرتبط بالبيانات'
                              : 'Live archive connected to real data',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isArabic
                              ? 'الصفحة الرئيسية للأرشيف تعرض الأقسام فقط. كل العناصر المؤرشفة ستجدها داخل القسم المناسب لها، حتى لا تتكدس العمليات في شاشة واحدة.'
                              : 'The archive home shows sections only. Archived items live inside their own section pages so operations do not pile up in one screen.',
                          textAlign:
                              isArabic ? TextAlign.right : TextAlign.left,
                        ),
                        const SizedBox(height: 12),
                        AppStatusBadge(
                          label: isArabic
                              ? '${items.length} عنصر مؤرشف إجمالًا'
                              : '${items.length} total archived items',
                          color: const Color(0xFF4D7C6A),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      int crossAxisCount = 3;
                      double childAspectRatio = 1.45;

                      if (width < 1150) {
                        crossAxisCount = 2;
                        childAspectRatio = 1.38;
                      }
                      if (width < 760) {
                        crossAxisCount = 1;
                        childAspectRatio = 2.0;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sectionKeys.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          final key = sectionKeys[index];
                          final color = _sectionColor(key);

                          return InkWell(
                            borderRadius: BorderRadius.circular(28),
                            onTap: () => _openSection(context, key),
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Column(
                                crossAxisAlignment: isArabic
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: isArabic
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                    child: Container(
                                      width: 68,
                                      height: 68,
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withValues(alpha: 0.18),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _sectionIcon(key),
                                        color: Colors.white,
                                        size: 34,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    _sectionTitle(key, isArabic),
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      height: 1.08,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _sectionSubtitle(key, isArabic),
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.18),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      isArabic
                                          ? '${counts[key] ?? 0} عنصر'
                                          : '${counts[key] ?? 0} items',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
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
