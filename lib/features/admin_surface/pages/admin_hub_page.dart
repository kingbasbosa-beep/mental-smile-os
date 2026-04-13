import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminHubPage extends StatelessWidget {
  const AdminHubPage({super.key});

  Stream<int> _openEscalationsStream() {
    return FirebaseFirestore.instance
        .collection('chat_escalations')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status = (data['status'] ?? 'open').toString();
              return status != 'resolved';
            }).length);
  }

  bool _isArabic(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl;
  }

  Stream<int> _profileChangeRequestsCountStream() {
    final db = FirebaseFirestore.instance;

    return Stream.multi((controller) {
      int clinicianCount = 0;
      int centerCount = 0;

      void emit() {
        controller.add(clinicianCount + centerCount);
      }

      final clinicianSub =
          db.collection('clinician_profile_change_requests').snapshots().listen(
        (snapshot) {
          clinicianCount = snapshot.docs.where((doc) {
            final data = doc.data();
            return (data['status'] ?? 'pending').toString() == 'pending';
          }).length;
          emit();
        },
        onError: controller.addError,
      );

      final centerSub =
          db.collection('center_profile_change_requests').snapshots().listen(
        (snapshot) {
          centerCount = snapshot.docs.where((doc) {
            final data = doc.data();
            return (data['status'] ?? 'pending').toString() == 'pending';
          }).length;
          emit();
        },
        onError: controller.addError,
      );

      controller.onCancel = () async {
        await clinicianSub.cancel();
        await centerSub.cancel();
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    final clinicianPendingStream = FirebaseFirestore.instance
        .collection('clinicians')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status =
                  (data['approvalStatus'] ?? 'pending_review').toString();
              return status == 'pending_review';
            }).length);

    final clinicianProfileRequestsStream = _profileChangeRequestsCountStream();

    final centersPendingStream = FirebaseFirestore.instance
        .collection('centers')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status =
                  (data['approvalStatus'] ?? 'pending_admin').toString();
              return status == 'pending_admin' ||
                  status == 'pending_review' ||
                  status == 'center_follow_up';
            }).length);

    final bookingOpenStream = FirebaseFirestore.instance
        .collection('booking_requests')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final archived = (data['archived'] ?? false) == true;
              final status = (data['status'] ?? 'pending_admin').toString();
              return !archived && status != 'completed_success';
            }).length);

    final paymentsReviewStream = FirebaseFirestore.instance
        .collection('booking_requests')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status = (data['status'] ?? '').toString();
              final paymentStatus = (data['paymentStatus'] ?? '').toString();
              return status == 'payment_review' ||
                  paymentStatus == 'submitted_by_client';
            }).length);

    final sessionsActionStream = FirebaseFirestore.instance
        .collection('booking_requests')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status = (data['status'] ?? '').toString();
              return status == 'session_setup_pending' ||
                  status == 'session_scheduled' ||
                  status == 'session_in_progress' ||
                  status == 'reschedule_pending' ||
                  status == 'session_completed_pending_reviews';
            }).length);

    final supportChatsStream = FirebaseFirestore.instance
        .collection('chat_threads')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              return (data['needsHumanSupport'] ?? false) == true;
            }).length);

    final escalationsOpenStream = _openEscalationsStream();

    final archivedItemsStream = FirebaseFirestore.instance
        .collection('booking_requests')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              return (data['archived'] ?? false) == true;
            }).length);

    final clientsCountStream = FirebaseFirestore.instance
        .collection('clients')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);

    final quickActions = <_AdminQuickAction>[
      _AdminQuickAction(
        label: 'Admin Messages',
        icon: Icons.support_agent_outlined,
        route: Routes.adminSupportChats,
        color: const Color(0xFFE58667),
      ),
      _AdminQuickAction(
        label: 'Clients',
        icon: Icons.people_alt_outlined,
        route: Routes.adminClients,
        color: const Color(0xFF5D8CFF),
      ),
      _AdminQuickAction(
        label: 'Clinician Requests',
        icon: Icons.verified_user_outlined,
        route: Routes.adminClinicianRequests,
        color: const Color(0xFFE2A067),
      ),
      _AdminQuickAction(
        label: 'Profile/Data Requests',
        icon: Icons.manage_accounts_outlined,
        route: Routes.adminClinicianProfileRequests,
        color: AppColors.accentLavender,
      ),
      _AdminQuickAction(
        label: 'Archive',
        icon: Icons.archive_outlined,
        route: Routes.adminArchive,
        color: const Color(0xFF4D7C6A),
      ),
    ];

    final items = <_AdminHubItem>[
      _AdminHubItem(
        title: isArabic ? 'تسجيل الأخصائيين' : 'Clinician Registrations',
        subtitle: isArabic
            ? 'مراجعة الحسابات الجديدة والموافقة عليها'
            : 'Review new clinician accounts',
        icon: Icons.verified_user_outlined,
        route: Routes.adminClinicianRequests,
        color: const Color(0xFFE2A067),
        countLabel: isArabic ? 'بانتظار المراجعة' : 'Pending review',
        countStream: clinicianPendingStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'طلبات تعديل البيانات' : 'Profile/data requests',
        subtitle: isArabic
            ? 'مراجعة طلبات تعديل بيانات الأخصائيين والمراكز'
            : 'Review clinician and center data change requests',
        icon: Icons.manage_accounts_outlined,
        route: Routes.adminClinicianProfileRequests,
        color: AppColors.accentLavender,
        countLabel: isArabic ? 'طلبات تعديل معلقة' : 'Pending profile changes',
        countStream: clinicianProfileRequestsStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'إدارة المراكز' : 'Centers Management',
        subtitle: isArabic
            ? 'إضافة وتعديل وتفعيل المراكز'
            : 'Add, edit and activate centers',
        icon: Icons.apartment_outlined,
        route: Routes.adminCenters,
        color: const Color(0xFF37B8B0),
        countLabel: isArabic ? 'مراكز تنتظر الإدارة' : 'Pending centers',
        countStream: centersPendingStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'إدارة العملاء' : 'Clients Management',
        subtitle: isArabic
            ? 'البحث في حسابات العملاء وحظرها أو إلغاء حظرها'
            : 'Search, block, and unblock client accounts',
        icon: Icons.people_alt_outlined,
        route: Routes.adminClients,
        color: const Color(0xFF5D8CFF),
        countLabel: isArabic ? 'إجمالي العملاء' : 'Total clients',
        countStream: clientsCountStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'طلبات الحجز' : 'Booking Requests',
        subtitle: isArabic
            ? 'مراجعة واعتماد وتحويل الطلبات'
            : 'Review and route booking requests',
        icon: Icons.assignment_outlined,
        route: '/admin/booking-queue',
        color: const Color(0xFF7C6EF6),
        countLabel: isArabic ? 'طلبات تشغيل مفتوحة' : 'Open workflow requests',
        countStream: bookingOpenStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'المدفوعات والتحويلات' : 'Payments & Transfers',
        subtitle: isArabic
            ? 'متابعة الدفع والتحويلات المالية'
            : 'Track payments and transfers',
        icon: Icons.account_balance_wallet_outlined,
        route: Routes.adminPayments,
        color: const Color(0xFF9A7A6E),
        countLabel: isArabic ? 'تحتاج مراجعة سداد' : 'Awaiting payment review',
        countStream: paymentsReviewStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'الجلسات والروابط' : 'Sessions & Links',
        subtitle: isArabic
            ? 'Zoom / Meet / أكواد الجلسات'
            : 'Zoom / Meet / session links',
        icon: Icons.video_call_outlined,
        route: Routes.adminSessions,
        color: AppColors.info,
        countLabel: isArabic ? 'جلسات تحتاج إجراء' : 'Sessions need action',
        countStream: sessionsActionStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'الرسائل والدعم' : 'Messages & Support',
        subtitle: isArabic
            ? 'تواصل مع العملاء والأخصائيين'
            : 'Client and clinician conversations',
        icon: Icons.support_agent_outlined,
        route: Routes.adminSupportChats,
        color: const Color(0xFFE58667),
        countLabel: isArabic ? 'محادثات تحتاج تدخل' : 'Chats need admin',
        countStream: supportChatsStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'تصعيدات الشات' : 'Chat Escalations',
        subtitle:
            isArabic ? 'الحالات المصعدة من الشات' : 'Escalated chat cases',
        icon: Icons.warning_amber_rounded,
        route: Routes.chatEscalations,
        color: const Color(0xFF6C55B3),
        countLabel: isArabic ? 'تصعيدات غير مغلقة' : 'Open escalations',
        countStream: escalationsOpenStream,
      ),
      _AdminHubItem(
        title: isArabic ? 'الأرشيف' : 'Archive',
        subtitle: isArabic
            ? 'هيكل أرشفة منظم لكل أقسام المشروع'
            : 'Organized archive structure for all project sections',
        icon: Icons.archive_outlined,
        route: Routes.adminArchive,
        color: const Color(0xFF4D7C6A),
        countLabel: isArabic ? 'عناصر مؤرشفة' : 'Archived items',
        countStream: archivedItemsStream,
      ),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        appBar: AppShellActions.buildAppBar(
          context,
          title: 'لوحة الإدارة',
        ),
        body: AppPageBackground(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              int crossAxisCount = 3;
              double childAspectRatio = 1.58;

              if (width < 1150) {
                crossAxisCount = 2;
                childAspectRatio = 1.58;
              }
              if (width < 700) {
                crossAxisCount = 1;
                childAspectRatio = 2.05;
              }

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  const Center(
                    child: AppLogoWordmark(width: 220, height: 128),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _AdminQuickActionsSection(
                    actions: quickActions,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _AdminQuickStatsSection(
                    isArabic: isArabic,
                    clinicianPendingStream: clinicianPendingStream,
                    clinicianProfileRequestsStream:
                        clinicianProfileRequestsStream,
                    bookingOpenStream: bookingOpenStream,
                    paymentsReviewStream: paymentsReviewStream,
                    supportChatsStream: supportChatsStream,
                    escalationsOpenStream: escalationsOpenStream,
                    sessionsActionStream: sessionsActionStream,
                    archivedItemsStream: archivedItemsStream,
                    centersPendingStream: centersPendingStream,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const _AdminSystemHealthCard(),
                  const SizedBox(height: AppSpacing.md),
                  const _PendingActionsCard(),
                  const SizedBox(height: AppSpacing.md),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _AdminHubCard(
                        item: item,
                        isArabic: isArabic,
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

class _AdminQuickAction {
  final String label;
  final IconData icon;
  final String route;
  final Color color;

  const _AdminQuickAction({
    required this.label,
    required this.icon,
    required this.route,
    required this.color,
  });
}

class _AdminQuickActionsSection extends StatelessWidget {
  const _AdminQuickActionsSection({
    required this.actions,
  });

  final List<_AdminQuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Control Center',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: actions.map((action) {
              return InkWell(
                borderRadius: BorderRadius.circular(AppRadii.lg),
                onTap: () => Navigator.pushNamed(context, action.route),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: action.color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                    border: Border.all(
                      color: action.color.withValues(alpha: 0.22),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(action.icon, color: action.color, size: 20),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        action.label,
                        style: TextStyle(
                          color: action.color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _AdminHubItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final Color color;
  final Stream<int> countStream;
  final String countLabel;

  const _AdminHubItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.color,
    required this.countStream,
    required this.countLabel,
  });
}

class _AdminHubCard extends StatelessWidget {
  const _AdminHubCard({
    required this.item,
    required this.isArabic,
  });

  final _AdminHubItem item;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final labelAlign = isArabic ? Alignment.topRight : Alignment.topLeft;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () => Navigator.of(context).pushNamed(item.route),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: StreamBuilder<int>(
                    stream: item.countStream,
                    builder: (context, snapshot) {
                      final waiting =
                          snapshot.connectionState == ConnectionState.waiting &&
                              !snapshot.hasData;
                      final hasError = snapshot.hasError;
                      final count = snapshot.data;
                      final badgeText = hasError
                          ? (isArabic ? '! خطأ' : '! Error')
                          : (waiting
                              ? '...'
                              : (count == null
                                  ? '—'
                                  : (isArabic
                                      ? '$count عنصر'
                                      : '$count items')));

                      return Column(
                        crossAxisAlignment: isArabic
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: labelAlign,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.20),
                                borderRadius:
                                    BorderRadius.circular(AppRadii.pill),
                              ),
                              child: Text(
                                badgeText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Align(
                            alignment: labelAlign,
                            child: Text(
                              hasError
                                  ? (isArabic
                                      ? 'تعذر تحميل العداد'
                                      : 'Failed to load count')
                                  : item.countLabel,
                              textAlign:
                                  isArabic ? TextAlign.right : TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                height: 1.15,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              item.title,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.08,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              item.subtitle,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: Text(
                isArabic ? 'فتح القسم' : 'Open section',
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
  }
}

class _AdminQuickStatsSection extends StatelessWidget {
  const _AdminQuickStatsSection({
    required this.isArabic,
    required this.clinicianPendingStream,
    required this.clinicianProfileRequestsStream,
    required this.bookingOpenStream,
    required this.paymentsReviewStream,
    required this.supportChatsStream,
    required this.escalationsOpenStream,
    required this.sessionsActionStream,
    required this.archivedItemsStream,
    required this.centersPendingStream,
  });

  final bool isArabic;
  final Stream<int> clinicianPendingStream;
  final Stream<int> clinicianProfileRequestsStream;
  final Stream<int> bookingOpenStream;
  final Stream<int> paymentsReviewStream;
  final Stream<int> supportChatsStream;
  final Stream<int> escalationsOpenStream;
  final Stream<int> sessionsActionStream;
  final Stream<int> archivedItemsStream;
  final Stream<int> centersPendingStream;

  @override
  Widget build(BuildContext context) {
    final cards = <_QuickStatItem>[
      _QuickStatItem(
        title: isArabic ? 'طلبات التشغيل المفتوحة' : 'Open workflow',
        color: const Color(0xFF7C6EF6),
        stream: bookingOpenStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'السداد تحت المراجعة' : 'Payment review',
        color: const Color(0xFF9A7A6E),
        stream: paymentsReviewStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'جلسات تحتاج إجراء' : 'Sessions need action',
        color: AppColors.info,
        stream: sessionsActionStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'رسائل تحتاج تدخل' : 'Support waiting',
        color: const Color(0xFFE58667),
        stream: supportChatsStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'تصعيدات غير مغلقة' : 'Open escalations',
        color: const Color(0xFF6C55B3),
        stream: escalationsOpenStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'أخصائيون بانتظار المراجعة' : 'Clinicians pending',
        color: const Color(0xFFE2A067),
        stream: clinicianPendingStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'طلبات تعديل البيانات' : 'Profile/data requests',
        color: AppColors.accentLavender,
        stream: clinicianProfileRequestsStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'مراكز بانتظار الإدارة' : 'Centers pending',
        color: const Color(0xFF37B8B0),
        stream: centersPendingStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'عناصر مؤرشفة' : 'Archived items',
        color: const Color(0xFF4D7C6A),
        stream: archivedItemsStream,
      ),
    ];

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'إحصاءات سريعة' : 'Quick stats',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isArabic
                ? 'ملخص سريع للحالات المفتوحة داخل غرفة عمليات الإدارة.'
                : 'A quick summary of open operational admin queues.',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: cards.map((item) {
                return _QuickStatCard(
                  item: item,
                  isArabic: isArabic,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminSystemHealthCard extends StatelessWidget {
  const _AdminSystemHealthCard();

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toIso8601String();
    }
    return value?.toString().trim() ?? '';
  }

  Color _statusColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'ok':
        return const Color(0xFF1F9D63);
      case 'warning':
        return const Color(0xFFE39B2E);
      case 'error':
        return const Color(0xFFC74646);
      default:
        return AppColors.info;
    }
  }

  Widget _buildSystemHealthFallback(String statusText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('System Health'),
        const SizedBox(height: AppSpacing.sm),
        AppStatusBadge(
          label: 'Status: $statusText',
          color: AppColors.info,
        ),
        const SizedBox(height: AppSpacing.sm),
        const Text(
          'Issues: —',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text('Summary: No audit data yet'),
      ],
    );
  }

  Widget _buildSystemHealthContent({
    required dynamic status,
    required dynamic issues,
    required dynamic summary,
    required dynamic timestamp,
  }) {
    final statusText = status.toString().trim();
    final issuesText = issues.toString().trim();
    final summaryText = summary.toString().trim();
    final timestampText = _dateText(timestamp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('System Health'),
        const SizedBox(height: AppSpacing.sm),
        AppStatusBadge(
          label: 'Status: $statusText',
          color: _statusColor(statusText),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Issues: $issuesText',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        if (timestampText.isNotEmpty) ...[
          Text('Last Scan: $timestampText'),
          const SizedBox(height: AppSpacing.xs),
        ],
        Text('Summary: $summaryText'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('system_health')
            .doc('latest')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildSystemHealthFallback("جارٍ التحديث...");
          }

          if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
            return _buildSystemHealthFallback("Awaiting QA snapshot");
          }

          final data = snapshot.data!.data();
          if (data == null) {
            return _buildSystemHealthFallback("No audit data yet");
          }

          final status = data['status'] ?? 'unknown';
          final issues = data['issuesCount'] ?? 0;
          final summary = data['summary'] ?? '';
          final timestamp = data['timestamp'] ?? '';

          return _buildSystemHealthContent(
            status: status,
            issues: issues,
            summary: summary,
            timestamp: timestamp,
          );
        },
      ),
    );
  }
}

class _PendingActionsCard extends StatelessWidget {
  const _PendingActionsCard();

  @override
  Widget build(BuildContext context) {
    final bookingRequests = FirebaseFirestore.instance.collection('booking_requests');
    final centers = FirebaseFirestore.instance.collection('centers');

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pending Actions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: const [
              _PendingActionChip(
                label: 'Client Updates',
                stream: null,
                collection: 'booking_requests',
                field: 'status',
                value: 'client_update_required',
              ),
              _PendingActionChip(
                label: 'Center Follow-up',
                stream: null,
                collection: 'booking_requests',
                field: 'status',
                value: 'center_follow_up',
              ),
              _PendingActionChip(
                label: 'Payout Pending',
                stream: null,
                collection: 'booking_requests',
                field: 'status',
                value: 'payout_pending',
              ),
              _PendingActionChip(
                label: 'Centers Pending Admin',
                stream: null,
                collection: 'centers',
                field: 'approvalStatus',
                value: 'pending_admin',
              ),
            ].map((chip) {
              final source = chip.collection == 'centers' ? centers : bookingRequests;
              return _PendingActionChip(
                label: chip.label,
                stream: source.where(chip.field, isEqualTo: chip.value).snapshots(),
                collection: chip.collection,
                field: chip.field,
                value: chip.value,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PendingActionChip extends StatelessWidget {
  const _PendingActionChip({
    required this.label,
    required this.stream,
    required this.collection,
    required this.field,
    required this.value,
  });

  final String label;
  final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;
  final String collection;
  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        final count = snapshot.hasError
            ? '—'
            : (!snapshot.hasData ? '—' : '${snapshot.data!.docs.length}');

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.mist,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: AppColors.info.withValues(alpha: 0.20),
            ),
          ),
          child: Text(
            '$label: $count',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }
}

class _QuickStatItem {
  final String title;
  final Color color;
  final Stream<int> stream;

  const _QuickStatItem({
    required this.title,
    required this.color,
    required this.stream,
  });
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.item,
    required this.isArabic,
  });

  final _QuickStatItem item;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: AppSectionPanel(
        color: item.color.withValues(alpha: 0.10),
        borderColor: item.color.withValues(alpha: 0.22),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: StreamBuilder<int>(
        stream: item.stream,
        builder: (context, snapshot) {
            final waiting =
                snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData;
            final hasError = snapshot.hasError;
            final count = snapshot.data;
            final countText = hasError
                ? '!'
                : (count == null ? '—' : '$count');
            final statusText = hasError
                ? (isArabic ? 'تعذر التحميل' : 'Load failed')
                : (waiting
                    ? (isArabic ? 'جارٍ التحديث' : 'Updating')
                    : item.title);

            return Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                  child: Align(
                    alignment: isArabic
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      countText,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                        color: item.color,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                SizedBox(
                  height: 34,
                  child: Align(
                    alignment: isArabic
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Text(
                      statusText,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                        color: item.color,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

