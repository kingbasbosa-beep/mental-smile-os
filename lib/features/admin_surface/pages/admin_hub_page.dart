import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/core/system/domain_status_service.dart';
import 'package:flutterprojects/features/gateway_layer/core/gateway_monitor.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_status.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminHubPage extends StatelessWidget {
  const AdminHubPage({super.key});

  static const String _adminBookingQueueRoute = '/admin/booking-queue';
  static const String _adminAlertsReviewRoute = '/admin/alerts-review';
  static const DomainStatusService _domainStatusService = DomainStatusService();
  static const GatewayMonitor _gatewayMonitor = GatewayMonitor();

  Stream<_SystemAdvisorySummary> _systemAdvisoryStream() {
    return Stream<_SystemAdvisorySummary>.multi((controller) {
      final statuses = <DomainKey, DomainStatus>{};
      final subscriptions = <StreamSubscription<DomainStatus>>[];

      void emit() {
        if (statuses.length < domainRegistry.length) return;

        final affected = statuses.entries
            .where((entry) => entry.value.status != 'active')
            .toList();

        if (affected.isEmpty) {
          controller.add(const _SystemAdvisorySummary.none());
          return;
        }

        String highestSeverity = 'unknown';
        int rank = -1;

        for (final entry in affected) {
          final status = entry.value.status;
          final currentRank = switch (status) {
            'disabled' => 3,
            'maintenance' => 2,
            'degraded' => 1,
            _ => 0,
          };

          if (currentRank > rank) {
            rank = currentRank;
            highestSeverity = status;
          }
        }

        controller.add(
          _SystemAdvisorySummary(
            affectedCount: affected.length,
            highestSeverity: highestSeverity,
          ),
        );
      }

      for (final domain in domainRegistry) {
        final sub = _domainStatusService.watchDomainStatus(domain.key).listen(
          (status) {
            statuses[domain.key] = status;
            emit();
          },
          onError: controller.addError,
        );
        subscriptions.add(sub);
      }

      controller.onCancel = () async {
        for (final subscription in subscriptions) {
          await subscription.cancel();
        }
      };
    });
  }

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

    final escalationsOpenStream = _openEscalationsStream();
    final gatewayStatuses = _gatewayMonitor.familyStatuses();

    final pendingApprovalsStream = Stream<int>.multi((controller) {
      int clinicianPending = 0;
      int profilePending = 0;
      int centersPending = 0;

      void emit() {
        controller.add(clinicianPending + profilePending + centersPending);
      }

      final clinicianSub = clinicianPendingStream.listen(
        (value) {
          clinicianPending = value;
          emit();
        },
        onError: controller.addError,
      );
      final profileSub = clinicianProfileRequestsStream.listen(
        (value) {
          profilePending = value;
          emit();
        },
        onError: controller.addError,
      );
      final centersSub = centersPendingStream.listen(
        (value) {
          centersPending = value;
          emit();
        },
        onError: controller.addError,
      );

      controller.onCancel = () async {
        await clinicianSub.cancel();
        await profileSub.cancel();
        await centersSub.cancel();
      };
    });

    final compactCounters = <_QuickStatItem>[
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
        title: isArabic ? 'تصعيدات غير مغلقة' : 'Open escalations',
        color: const Color(0xFF6C55B3),
        stream: escalationsOpenStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'اعتمادات معلقة' : 'Pending approvals',
        color: const Color(0xFFE2A067),
        stream: pendingApprovalsStream,
      ),
      _QuickStatItem(
        title: isArabic ? 'بوابات/أجهزة degraded' : 'Gateway/device degraded',
        color: const Color(0xFF4D7C6A),
        stream: Stream<int>.value(_gatewayMonitor.attentionCount()),
      ),
    ];

    final sectionCards = <_AdminSectionLaunchCardData>[
      _AdminSectionLaunchCardData(
        title: isArabic ? 'العمليات' : 'Operations',
        subtitle: isArabic
            ? 'الحجوزات والمدفوعات والجلسات'
            : 'Requests, payments, and sessions',
        icon: Icons.assignment_outlined,
        color: const Color(0xFF7C6EF6),
        route: Routes.adminOperations,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'الاتصالات' : 'Communications',
        subtitle: isArabic
            ? 'الدعم والمحادثات والتصعيدات'
            : 'Support, conversations, and escalations',
        icon: Icons.support_agent_outlined,
        color: const Color(0xFFE58667),
        route: Routes.adminCommunications,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'الدليل والاعتمادات' : 'Directory & Approvals',
        subtitle: isArabic
            ? 'العملاء والمراكز والاعتمادات'
            : 'Clients, centers, and approval surfaces',
        icon: Icons.apartment_outlined,
        color: const Color(0xFF37B8B0),
        route: Routes.adminClinicianRequests,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'الحوكمة' : 'Governance',
        subtitle: isArabic
            ? 'سياسات الذكاء وحالة النطاقات'
            : 'Policies, domains, and governance visibility',
        icon: Icons.policy_outlined,
        color: const Color(0xFF4F7BFF),
        route: Routes.adminDomainStatus,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'طبقة البوابات' : 'Gateway Layer',
        subtitle: isArabic
            ? 'قنوات وتكاملات وأجهزة وصيانة'
            : 'Channels, tools, devices, and maintenance',
        icon: Icons.hub_outlined,
        color: const Color(0xFF3E8B7B),
        route: Routes.adminGatewayLayer,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'الأرشيف' : 'Archive',
        subtitle: isArabic
            ? 'مرجع تاريخي وتقارير مؤرشفة'
            : 'Historical lookup and archived reporting',
        icon: Icons.archive_outlined,
        color: const Color(0xFF4D7C6A),
        route: Routes.adminArchive,
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
                  _SystemAdvisoryCard(
                    advisoryStream: _systemAdvisoryStream(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _AdminHomeCountersSection(
                    isArabic: isArabic,
                    cards: compactCounters,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _GatewaySummaryStrip(statuses: gatewayStatuses),
                  const SizedBox(height: AppSpacing.lg),
                  const _ControlRoomIntro(),
                  const SizedBox(height: AppSpacing.md),
                  _ControlRoomTileGrid(
                    children: [
                      const _AdminSystemHealthCard(),
                      const _OperationalAlertsCard(),
                      const _CriticalAlertsCard(),
                      _GatewaySignalsCard(
                        statuses: gatewayStatuses,
                        gatewayMonitor: _gatewayMonitor,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _AdminSectionLaunchpad(
                    cards: sectionCards,
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
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

class _AdminSectionLaunchCardData {
  const _AdminSectionLaunchCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;
}

class _AdminSectionLaunchpad extends StatelessWidget {
  const _AdminSectionLaunchpad({
    required this.cards,
    required this.crossAxisCount,
    required this.childAspectRatio,
  });

  final List<_AdminSectionLaunchCardData> cards;
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Sections',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Launch the right admin section without turning the home page into a workbench.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.70),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              return _AdminSectionLaunchCard(item: cards[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _AdminSectionLaunchCard extends StatelessWidget {
  const _AdminSectionLaunchCard({
    required this.item,
  });

  final _AdminSectionLaunchCardData item;

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                      ),
                      child: Text(
                        'Open section',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                height: 1.08,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              item.subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SystemAdvisorySummary {
  const _SystemAdvisorySummary({
    required this.affectedCount,
    required this.highestSeverity,
  });

  const _SystemAdvisorySummary.none()
      : affectedCount = 0,
        highestSeverity = 'active';

  final int affectedCount;
  final String highestSeverity;

  bool get hasAdvisory => affectedCount > 0;
}

class _SystemAdvisoryCard extends StatelessWidget {
  const _SystemAdvisoryCard({
    required this.advisoryStream,
  });

  final Stream<_SystemAdvisorySummary> advisoryStream;

  Color _severityColor(String severity) {
    switch (severity) {
      case 'disabled':
        return const Color(0xFFC97C7C);
      case 'maintenance':
        return const Color(0xFF6A8FBE);
      case 'degraded':
        return const Color(0xFFD9A441);
      default:
        return AppColors.mist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<_SystemAdvisorySummary>(
      stream: advisoryStream,
      builder: (context, snapshot) {
        final summary = snapshot.data;
        if (summary == null || !summary.hasAdvisory) {
          return const SizedBox.shrink();
        }

        final color = _severityColor(summary.highestSeverity);

        return AppSurfaceCard(
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Advisory',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${summary.affectedCount} domains require attention (highest: ${summary.highestSeverity})',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'This is an informational advisory. No actions are blocked.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.obsidian.withValues(alpha: 0.72),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.adminDomainStatus);
                },
                child: const Text('View details'),
              ),
            ],
          ),
        );
      },
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
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Fast access to the current admin surfaces',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.70),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
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

class _AdminHomeCountersSection extends StatelessWidget {
  const _AdminHomeCountersSection({
    required this.isArabic,
    required this.cards,
  });

  final bool isArabic;
  final List<_QuickStatItem> cards;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'عدادات تشغيلية مدمجة' : 'Compact operating counters',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isArabic
                ? 'أرقام سريعة للمتابعة فقط، بدون تحويل الصفحة الرئيسية إلى لوحة تشغيل مزدحمة.'
                : 'Fast supervisory counts only, without turning the home page into a crowded workbench.',
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

class _GatewaySummaryStrip extends StatelessWidget {
  const _GatewaySummaryStrip({
    required this.statuses,
  });

  final List<GatewayStatus> statuses;

  @override
  Widget build(BuildContext context) {
    final items = [
      _GatewaySummaryItem(
        title: 'Communication Gateway',
        status: _statusFor('communication'),
        route: Routes.adminCommunicationGateway,
      ),
      _GatewaySummaryItem(
        title: 'Engineering Gateway',
        status: _statusFor('engineering'),
        route: Routes.adminEngineeringGateway,
      ),
      _GatewaySummaryItem(
        title: 'Device / Storage Gateway',
        status: _statusFor('device_storage'),
        route: Routes.adminDeviceStorageGateway,
      ),
    ];

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gateway Layer',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Shell-level supervision for channels, tools, devices, and storage boundaries.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.70),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children:
                items.map((item) => _GatewaySummaryPill(item: item)).toList(),
          ),
        ],
      ),
    );
  }

  GatewayStatus _statusFor(String key) {
    return statuses.firstWhere(
      (status) => status.key == key,
      orElse: () => const GatewayStatus(
        key: 'unknown',
        label: 'Unknown Gateway',
        level: GatewayHealthLevel.planned,
        summary: 'Gateway shell is defined.',
      ),
    );
  }
}

class _GatewaySummaryItem {
  const _GatewaySummaryItem({
    required this.title,
    required this.status,
    required this.route,
  });

  final String title;
  final GatewayStatus status;
  final String route;
}

class _GatewaySummaryPill extends StatelessWidget {
  const _GatewaySummaryPill({
    required this.item,
  });

  final _GatewaySummaryItem item;

  @override
  Widget build(BuildContext context) {
    final color = gatewayHealthColor(item.status.level);
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.pill),
      onTap: () => Navigator.of(context).pushNamed(item.route),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(color: color.withValues(alpha: 0.24)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hub_outlined, color: color, size: 18),
            const SizedBox(width: AppSpacing.xs),
            Text(
              item.title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            GatewayHealthBadge(level: item.status.level),
          ],
        ),
      ),
    );
  }
}

class _GatewaySignalsCard extends StatelessWidget {
  const _GatewaySignalsCard({
    required this.statuses,
    required this.gatewayMonitor,
  });

  final List<GatewayStatus> statuses;
  final GatewayMonitor gatewayMonitor;

  @override
  Widget build(BuildContext context) {
    return _ControlRoomCardShell(
      title: 'Gateway Signals',
      subtitle: 'Gateway-layer supervision by family',
      child: _ControlRoomBodyFrame(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: statuses.map((status) {
                return _GatewaySignalChip(
                  label: status.label ?? status.key ?? 'Gateway',
                  alertType:
                      gatewayMonitor.alertTypeFor(status.key ?? 'unknown'),
                  level: status.level,
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Gateway health reflects shell readiness and isolation boundaries, without triggering external integrations.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.72),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GatewaySignalChip extends StatelessWidget {
  const _GatewaySignalChip({
    required this.label,
    required this.alertType,
    required this.level,
  });

  final String label;
  final String alertType;
  final GatewayHealthLevel level;

  @override
  Widget build(BuildContext context) {
    final color = gatewayHealthColor(level);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          GatewayHealthBadge(level: level),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Boundary signal: $alertType',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.72),
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
        AppStatusBadge(
          label: 'Status: $statusText',
          color: AppColors.info,
        ),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'Issues: —',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const _ControlRoomEmptyState(
          message: 'No audit data yet',
        ),
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
        AppStatusBadge(
          label: 'Status: $statusText',
          color: _statusColor(statusText),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Issues: $issuesText',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (timestampText.isNotEmpty) ...[
          Text('Last Scan: $timestampText'),
          const SizedBox(height: AppSpacing.sm),
        ],
        Text('Summary: $summaryText'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ControlRoomCardShell(
      title: 'System Health',
      subtitle: 'Python QA snapshot',
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('system_health')
            .doc('latest')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildSystemHealthFallback("جارٍ التحديث...");
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              !snapshot.data!.exists) {
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
    final bookingRequests =
        FirebaseFirestore.instance.collection('booking_requests');
    final centers = FirebaseFirestore.instance.collection('centers');
    final clientUpdatesStream = bookingRequests
        .where('status', isEqualTo: 'client_update_required')
        .snapshots();
    final centerFollowUpStream = bookingRequests
        .where('status', isEqualTo: 'center_follow_up')
        .snapshots();
    final payoutPendingStream = bookingRequests
        .where('status', isEqualTo: 'payout_pending')
        .snapshots();
    final centersPendingStream =
        centers.where('approvalStatus', isEqualTo: 'pending_admin').snapshots();

    return _ControlRoomCardShell(
      title: 'Pending Actions',
      subtitle: 'Requests needing attention',
      child: _ControlRoomBodyFrame(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: clientUpdatesStream,
          builder: (context, clientSnapshot) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: centerFollowUpStream,
              builder: (context, followUpSnapshot) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: payoutPendingStream,
                  builder: (context, payoutSnapshot) {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: centersPendingStream,
                      builder: (context, centersSnapshot) {
                        final waiting = clientSnapshot.connectionState ==
                                ConnectionState.waiting ||
                            followUpSnapshot.connectionState ==
                                ConnectionState.waiting ||
                            payoutSnapshot.connectionState ==
                                ConnectionState.waiting ||
                            centersSnapshot.connectionState ==
                                ConnectionState.waiting ||
                            !clientSnapshot.hasData ||
                            !followUpSnapshot.hasData ||
                            !payoutSnapshot.hasData ||
                            !centersSnapshot.hasData;

                        final clientCount =
                            clientSnapshot.data?.docs.length ?? 0;
                        final followUpCount =
                            followUpSnapshot.data?.docs.length ?? 0;
                        final payoutCount =
                            payoutSnapshot.data?.docs.length ?? 0;
                        final centersCount =
                            centersSnapshot.data?.docs.length ?? 0;
                        final totalCount = clientCount +
                            followUpCount +
                            payoutCount +
                            centersCount;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (waiting)
                              Wrap(
                                spacing: AppSpacing.md,
                                runSpacing: AppSpacing.md,
                                children: const [
                                  _StaticInfoChip(label: 'Client Updates: —'),
                                  _StaticInfoChip(label: 'Center Follow-up: —'),
                                  _StaticInfoChip(label: 'Payout Pending: —'),
                                  _StaticInfoChip(
                                      label: 'Centers Pending Admin: —'),
                                ],
                              )
                            else if (totalCount == 0)
                              const _ControlRoomEmptyState(
                                message: 'No pending actions',
                              )
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: AppSpacing.md,
                                    runSpacing: AppSpacing.md,
                                    children: [
                                      _StaticInfoChip(
                                        label: 'Client Updates: $clientCount',
                                      ),
                                      _StaticInfoChip(
                                        label:
                                            'Center Follow-up: $followUpCount',
                                      ),
                                      _StaticInfoChip(
                                        label: 'Payout Pending: $payoutCount',
                                      ),
                                      _StaticInfoChip(
                                        label:
                                            'Centers Pending Admin: $centersCount',
                                      ),
                                    ],
                                  ),
                                  if (totalCount > 0) ...[
                                    const SizedBox(height: AppSpacing.sm),
                                    _ControlRoomActionButton(
                                      label: 'Open Requests Queue',
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AdminHubPage._adminBookingQueueRoute,
                                        );
                                      },
                                    ),
                                  ],
                                ],
                              ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ActiveConversationsCard extends StatelessWidget {
  const _ActiveConversationsCard();

  @override
  Widget build(BuildContext context) {
    return _ControlRoomCardShell(
      title: 'Active Conversations',
      subtitle: 'Open human-support threads',
      child: _ControlRoomBodyFrame(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('chat_threads')
              .where('needsHumanSupport', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            final docs = snapshot.data?.docs ?? const [];
            final humanSupportCount = docs.length;
            final centerChatsCount = docs.where((doc) {
              final ownerType =
                  (doc.data()['ownerType'] ?? '').toString().toLowerCase();
              return ownerType.contains('center');
            }).length;
            final clientChatsCount = docs.where((doc) {
              final ownerType =
                  (doc.data()['ownerType'] ?? '').toString().toLowerCase();
              return !ownerType.contains('center');
            }).length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (snapshot.connectionState == ConnectionState.waiting)
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: const [
                      _StaticInfoChip(label: 'Human Support: —'),
                      _StaticInfoChip(label: 'Center Chats: —'),
                      _StaticInfoChip(label: 'Client Chats: —'),
                    ],
                  )
                else if (snapshot.connectionState == ConnectionState.active &&
                    docs.isEmpty)
                  const _ControlRoomEmptyState(
                    message: 'No active conversations',
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.md,
                        children: [
                          _ConversationCountChip(
                            label: 'Human Support',
                            count: '$humanSupportCount',
                          ),
                          _ConversationCountChip(
                            label: 'Center Chats',
                            count: '$centerChatsCount',
                          ),
                          _ConversationCountChip(
                            label: 'Client Chats',
                            count: '$clientChatsCount',
                          ),
                        ],
                      ),
                      if (humanSupportCount > 0) ...[
                        const SizedBox(height: AppSpacing.sm),
                        _ControlRoomActionButton(
                          label: 'Open Human Support Chats',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.adminSupportChats,
                            );
                          },
                        ),
                      ],
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OperationalAlertsCard extends StatelessWidget {
  const _OperationalAlertsCard();

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

  @override
  Widget build(BuildContext context) {
    return _ControlRoomCardShell(
      title: 'Operational Alerts',
      subtitle: 'Python-generated operational signals',
      child: _ControlRoomBodyFrame(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('system_alerts')
              .doc('latest')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: const [
                  _StaticInfoChip(label: 'Center Follow-up: —'),
                  _StaticInfoChip(label: 'Client Update Required: —'),
                  _StaticInfoChip(label: 'Payout Pending: —'),
                ],
              );
            }

            if (!snapshot.hasData ||
                snapshot.data == null ||
                !snapshot.data!.exists) {
              return const _ControlRoomEmptyState(
                message: 'No alert snapshot available',
              );
            }

            final data = snapshot.data!.data();
            if (data == null) {
              return const _ControlRoomEmptyState(
                message: 'No alert snapshot available',
              );
            }

            final status = (data['status'] ?? 'unknown').toString();
            final summary = (data['summary'] ?? '').toString().trim();
            final timestamp = _dateText(data['timestamp']);
            final centerFollowUpCount =
                (data['centerFollowUpCount'] ?? 0).toString();
            final clientUpdateRequiredCount =
                (data['clientUpdateRequiredCount'] ?? 0).toString();
            final payoutPendingCount =
                (data['payoutPendingCount'] ?? 0).toString();
            final alertsCount = (int.tryParse(centerFollowUpCount) ?? 0) +
                (int.tryParse(clientUpdateRequiredCount) ?? 0) +
                (int.tryParse(payoutPendingCount) ?? 0);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStatusBadge(
                  label: 'Status: $status',
                  color: _statusColor(status),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    _StaticInfoChip(
                      label: 'Center Follow-up: $centerFollowUpCount',
                    ),
                    _StaticInfoChip(
                      label:
                          'Client Update Required: $clientUpdateRequiredCount',
                    ),
                    _StaticInfoChip(
                      label: 'Payout Pending: $payoutPendingCount',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Summary: $summary'),
                if (timestamp.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text('Last Scan: $timestamp'),
                ],
                if (alertsCount > 0) ...[
                  const SizedBox(height: AppSpacing.sm),
                  _ControlRoomActionButton(
                    label: 'Review Alerts',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AdminHubPage._adminAlertsReviewRoute,
                      );
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CriticalAlertsCard extends StatelessWidget {
  const _CriticalAlertsCard();

  @override
  Widget build(BuildContext context) {
    final bookingRequests =
        FirebaseFirestore.instance.collection('booking_requests');
    final chatThreads = FirebaseFirestore.instance.collection('chat_threads');

    final stuckFollowUpsStream = bookingRequests
        .where('status', isEqualTo: 'center_follow_up')
        .snapshots();
    final unresolvedSupportChatsStream =
        chatThreads.where('needsHumanSupport', isEqualTo: true).snapshots();
    final pendingPayoutsStream = bookingRequests
        .where('status', isEqualTo: 'payout_pending')
        .snapshots();

    return _ControlRoomCardShell(
      title: 'Critical Alerts',
      subtitle: 'Operational warning signals',
      child: _ControlRoomBodyFrame(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: stuckFollowUpsStream,
          builder: (context, followUpsSnapshot) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: unresolvedSupportChatsStream,
              builder: (context, chatsSnapshot) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: pendingPayoutsStream,
                  builder: (context, payoutsSnapshot) {
                    final waiting = followUpsSnapshot.connectionState ==
                            ConnectionState.waiting ||
                        chatsSnapshot.connectionState ==
                            ConnectionState.waiting ||
                        payoutsSnapshot.connectionState ==
                            ConnectionState.waiting;

                    final stuckFollowUpsCount =
                        followUpsSnapshot.data?.docs.length ?? 0;
                    final unresolvedSupportChatsCount =
                        chatsSnapshot.data?.docs.length ?? 0;
                    final pendingPayoutsCount =
                        payoutsSnapshot.data?.docs.length ?? 0;
                    final totalCount = stuckFollowUpsCount +
                        unresolvedSupportChatsCount +
                        pendingPayoutsCount;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (waiting)
                          Wrap(
                            spacing: AppSpacing.md,
                            runSpacing: AppSpacing.md,
                            children: const [
                              _StaticInfoChip(label: 'Stuck Follow-ups: —'),
                              _StaticInfoChip(label: 'Support Alerts: —'),
                              _StaticInfoChip(label: 'Pending Payouts: —'),
                            ],
                          )
                        else if (followUpsSnapshot.connectionState ==
                                ConnectionState.active &&
                            chatsSnapshot.connectionState ==
                                ConnectionState.active &&
                            payoutsSnapshot.connectionState ==
                                ConnectionState.active &&
                            totalCount == 0)
                          const _ControlRoomEmptyState(
                            message: 'No critical alerts',
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: AppSpacing.md,
                                runSpacing: AppSpacing.md,
                                children: [
                                  _StaticInfoChip(
                                    label:
                                        'Stuck Follow-ups: $stuckFollowUpsCount',
                                  ),
                                  _StaticInfoChip(
                                    label:
                                        'Support Alerts: $unresolvedSupportChatsCount',
                                  ),
                                  _StaticInfoChip(
                                    label:
                                        'Pending Payouts: $pendingPayoutsCount',
                                  ),
                                ],
                              ),
                              if (totalCount > 0) ...[
                                const SizedBox(height: AppSpacing.sm),
                                _ControlRoomActionButton(
                                  label: 'Review Alerts',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AdminHubPage._adminAlertsReviewRoute,
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ControlRoomIntro extends StatelessWidget {
  const _ControlRoomIntro();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Control Room',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Live operational snapshots for health, requests, conversations, and alerts.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.70),
                ),
          ),
        ],
      ),
    );
  }
}

class _ControlRoomTileGrid extends StatelessWidget {
  const _ControlRoomTileGrid({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.md;
        final useTwoColumns = constraints.maxWidth >= 980;
        final tileWidth = useTwoColumns
            ? (constraints.maxWidth - gap) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: children.map((child) {
            return SizedBox(
              width: tileWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}

class _ControlRoomCardShell extends StatelessWidget {
  const _ControlRoomCardShell({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.68),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

class _ControlRoomEmptyState extends StatelessWidget {
  const _ControlRoomEmptyState({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.obsidian.withValues(alpha: 0.68),
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
      ),
    );
  }
}

class _ControlRoomBodyFrame extends StatelessWidget {
  const _ControlRoomBodyFrame({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 80),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: child,
      ),
    );
  }
}

class _ControlRoomActionButton extends StatelessWidget {
  const _ControlRoomActionButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        child: Text(label),
      ),
    );
  }
}

void _showControlRoomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}

class _StaticInfoChip extends StatelessWidget {
  const _StaticInfoChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.mist,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.20),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
      ),
    );
  }
}

class _ConversationCountChip extends StatelessWidget {
  const _ConversationCountChip({
    required this.label,
    required this.count,
  });

  final String label;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
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
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
      ),
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
            final countText = hasError ? '!' : (count == null ? '—' : '$count');
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
                    alignment:
                        isArabic ? Alignment.centerRight : Alignment.centerLeft,
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
                    alignment:
                        isArabic ? Alignment.topRight : Alignment.topLeft,
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
