import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/core/system/domain_status_service.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';
import 'package:flutterprojects/features/gateway_layer/core/gateway_monitor.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_status.dart';
import 'package:flutterprojects/features/admin_surface/models/analytics_summary_models.dart';
import 'package:flutterprojects/features/admin_surface/services/analytics_summary_repository.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

enum AdminVisualGroup {
  requests,
  sessions,
  payments,
  support,
  analytics,
  system,
}

Color _adminVisualGroupColor(AdminVisualGroup? group) {
  switch (group) {
    case AdminVisualGroup.requests:
      return const Color(0xFF5B6FA8);
    case AdminVisualGroup.sessions:
      return const Color(0xFF4F8FB8);
    case AdminVisualGroup.payments:
      return const Color(0xFF8A7468);
    case AdminVisualGroup.support:
      return const Color(0xFFC66A4A);
    case AdminVisualGroup.analytics:
      return const Color(0xFF6E5FA3);
    case AdminVisualGroup.system:
      return const Color(0xFF3E7C6F);
    case null:
      return AppColors.deepTeal;
  }
}

// ADMIN_SURFACE: SAFE_UI
class AdminHubPage extends StatefulWidget {
  const AdminHubPage({super.key});

  static const String _adminBookingQueueRoute = '/admin/booking-queue';
  static const String _adminAlertsReviewRoute = '/admin/alerts-review';
  static const DomainStatusService _domainStatusService = DomainStatusService();
  static const GatewayMonitor _gatewayMonitor = GatewayMonitor();

  @override
  State<AdminHubPage> createState() => _AdminHubPageState();
}

class _AdminHubPageState extends State<AdminHubPage> {
  late final Stream<int> _clinicianPendingStream;
  late final Stream<int> _clinicianProfileRequestsStream;
  late final Stream<int> _centersPendingStream;
  late final Stream<int> _bookingOpenStream;
  late final Stream<int> _paymentsReviewStream;
  late final Stream<int> _sessionsActionStream;
  late final Stream<int> _escalationsOpenStream;
  late final Stream<int> _pendingApprovalsStream;
  late final Stream<int> _gatewayAttentionStream;
  int _selectedDetailSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    _clinicianPendingStream = FirebaseFirestore.instance
        .collection('clinicians')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status =
                  (data['approvalStatus'] ?? 'pending_review').toString();
              return status == 'pending_review';
            }).length)
        .asBroadcastStream();

    _clinicianProfileRequestsStream = _profileChangeRequestsCountStream();

    _centersPendingStream = FirebaseFirestore.instance
        .collection('centers')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status =
                  (data['approvalStatus'] ?? 'pending_admin').toString();
              return status == 'pending_admin' ||
                  status == 'pending_review' ||
                  status == 'center_follow_up';
            }).length)
        .asBroadcastStream();

    _bookingOpenStream = FirebaseFirestore.instance
        .collection('booking_requests')
        .where('archived', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length)
        .asBroadcastStream();

    _paymentsReviewStream = FirebaseFirestore.instance
        .collection('booking_requests')
        .where('payment_confirmed', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length)
        .asBroadcastStream();

    _sessionsActionStream = FirebaseFirestore.instance
        .collection('booking_requests')
        .where('status', whereIn: [
          'session_setup_pending',
          'reschedule_pending',
        ])
        .snapshots()
        .map((snapshot) => snapshot.docs.length)
        .asBroadcastStream();

    _escalationsOpenStream = ChatFirestoreService()
        .streamAdminSupportInboxThreads()
        .map((threads) => threads.length)
        .asBroadcastStream();

    _pendingApprovalsStream = FirebaseFirestore.instance
        .collection('clinicians')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs.length)
        .asBroadcastStream();

    _gatewayAttentionStream = Stream<int>.fromFuture(
      Future<int>(() {
        final families = AdminHubPage._gatewayMonitor.familyStatuses();
        return families
            .where((family) => family.level != GatewayHealthLevel.healthy)
            .length;
      }),
    ).asBroadcastStream();
  }

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
        final sub =
            AdminHubPage._domainStatusService.watchDomainStatus(domain.key)
                .listen(
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

    return Stream<int>.multi((controller) {
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
    }).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    final gatewayStatuses = AdminHubPage._gatewayMonitor.familyStatuses();

    final compactCounters = <_QuickStatItem>[
      _QuickStatItem(
        title: isArabic ? 'إشارات طلبات مفتوحة' : 'Open request signals',
        group: AdminVisualGroup.requests,
        stream: _bookingOpenStream,
        crossSignalStream: _escalationsOpenStream,
        route: Routes.adminOperations,
      ),
      _QuickStatItem(
        title: isArabic ? 'السداد تحت المراجعة' : 'Payment review',
        group: AdminVisualGroup.payments,
        stream: _paymentsReviewStream,
        route: Routes.adminPayments,
      ),
      _QuickStatItem(
        title: isArabic ? 'إشارات جاهزية الجلسات' : 'Session readiness signals',
        group: AdminVisualGroup.sessions,
        stream: _sessionsActionStream,
        route: Routes.adminSessions,
      ),
      _QuickStatItem(
        title: isArabic ? 'حالات دعم مصعّدة' : 'Escalated Support Cases',
        group: AdminVisualGroup.support,
        stream: _escalationsOpenStream,
        crossSignalStream: _bookingOpenStream,
        route: Routes.adminSupportChats,
      ),
      _QuickStatItem(
        title: isArabic ? 'بوابات اعتماد معلقة' : 'Pending approval gates',
        group: AdminVisualGroup.requests,
        stream: _pendingApprovalsStream,
        route: Routes.adminClinicianRequests,
      ),
      _QuickStatItem(
        title: isArabic ? 'إشارات بوابات/أجهزة' : 'Gateway/device signals',
        group: AdminVisualGroup.system,
        stream: _gatewayAttentionStream,
        route: Routes.adminGatewayLayer,
      ),
    ];

    final sectionCards = <_AdminSectionLaunchCardData>[
      _AdminSectionLaunchCardData(
        title: isArabic ? 'مراقبة الطلبات والبوابات' : 'Requests & Gates',
        subtitle: isArabic
            ? 'مراقبة الطلبات والمدفوعات والجلسات دون ملكية تشغيل يومية'
            : 'Monitor requests, payments, and sessions without daily operational ownership',
        icon: Icons.assignment_outlined,
        group: AdminVisualGroup.requests,
        route: Routes.adminOperations,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic
            ? 'المراجعة البشرية والتصعيد'
            : 'Human Review & Escalated Support',
        subtitle: isArabic
            ? 'مراجعة بشرية مطلوبة وحالات دعم مصعّدة للمتابعة فقط'
            : 'Human review needed and escalated support cases for visibility only',
        icon: Icons.support_agent_outlined,
        group: AdminVisualGroup.support,
        route: Routes.adminCommunications,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'الدليل وبوابات الاعتماد' : 'Directory & Approval Gates',
        subtitle: isArabic
            ? 'العملاء والمراكز وإشارات الاعتماد'
            : 'Clients, centers, and approval-gate visibility',
        icon: Icons.apartment_outlined,
        group: AdminVisualGroup.requests,
        route: Routes.adminClinicianRequests,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'الحوكمة' : 'Governance',
        subtitle: isArabic
            ? 'سياسات الذكاء وحالة النطاقات'
            : 'Policies, domains, and governance visibility',
        icon: Icons.policy_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminDomainStatus,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'برامج المحتوى والرعاية' : 'Content & Care Programs',
        subtitle: isArabic
            ? 'حوكمة المحتوى والرسائل والمتابعة الداعمة'
            : 'Governance for content, support messaging, and follow-up care',
        icon: Icons.menu_book_outlined,
        group: AdminVisualGroup.support,
        route: Routes.adminContentCarePrograms,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'النمو والانتشار' : 'Growth & Awareness',
        subtitle: isArabic
            ? 'التوعية، التوزيع، وخطط الظهور المدروسة'
            : 'Awareness, distribution, and supervised exposure planning',
        icon: Icons.campaign_outlined,
        group: AdminVisualGroup.analytics,
        route: Routes.adminGrowthLayer,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'طبقة البوابات' : 'Gateway Layer',
        subtitle: isArabic
            ? 'قنوات وتكاملات وأجهزة وصيانة'
            : 'Channels, tools, devices, and maintenance',
        icon: Icons.hub_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminGatewayLayer,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'الأرشيف' : 'Archive',
        subtitle: isArabic
            ? 'مرجع تاريخي وتقارير مؤرشفة'
            : 'Historical lookup and archived reporting',
        icon: Icons.archive_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminArchive,
      ),
    ];

    final quickActions = <_AdminQuickActionItem>[
      _AdminQuickActionItem(
        label: isArabic ? 'Support Email' : 'Support Email',
        icon: Icons.email_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminCommunicationGateway,
      ),
      _AdminQuickActionItem(
        label: isArabic ? 'Messaging Governance' : 'Messaging Governance',
        icon: Icons.mark_chat_read_outlined,
        group: AdminVisualGroup.support,
        route: Routes.adminSupportMessagingGovernance,
      ),
      _AdminQuickActionItem(
        label: isArabic ? 'Follow-up Governance' : 'Follow-up Governance',
        icon: Icons.volunteer_activism_outlined,
        group: AdminVisualGroup.sessions,
        route: Routes.adminFollowupCareGovernance,
      ),
      _AdminQuickActionItem(
        label: isArabic ? 'Library Governance' : 'Library Governance',
        icon: Icons.local_library_outlined,
        group: AdminVisualGroup.support,
        route: Routes.adminLibraryGovernance,
      ),
    ];

    final keyReferences = <_AdminQuickActionItem>[
      _AdminQuickActionItem(
        label: isArabic ? 'System Activation Pack' : 'System Activation Pack',
        icon: Icons.inventory_2_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminSystemActivationPack,
      ),
      _AdminQuickActionItem(
        label: isArabic ? 'Blueprint Handoff' : 'Blueprint Handoff',
        icon: Icons.map_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminBlueprintHandoff,
      ),
      _AdminQuickActionItem(
        label: isArabic ? 'Compliance Checkpoints' : 'Compliance Checkpoints',
        icon: Icons.verified_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminComplianceCheckpoints,
      ),
      _AdminQuickActionItem(
        label: isArabic ? 'Exposure Rules' : 'Exposure Rules',
        icon: Icons.visibility_outlined,
        group: AdminVisualGroup.analytics,
        route: Routes.adminExposureRules,
      ),
    ];

    final guidedWorkflows = <_AdminGuidedWorkflowCardData>[
      _AdminGuidedWorkflowCardData(
        title: isArabic ? 'معالجة الدعم' : 'Support Handling',
        subtitle: isArabic
            ? 'ابدأ من حدود القناة ثم راجع حوكمة الرسائل الداعمة.'
            : 'Start with channel boundaries, then review support messaging governance.',
        primaryActionLabel:
            isArabic ? 'Communication Gateway' : 'Communication Gateway',
        primaryRoute: Routes.adminCommunicationGateway,
        secondaryActionLabel:
            isArabic ? 'Messaging Governance' : 'Messaging Governance',
        secondaryRoute: Routes.adminSupportMessagingGovernance,
        group: AdminVisualGroup.support,
      ),
      _AdminGuidedWorkflowCardData(
        title: isArabic ? 'جاهزية المتابعة' : 'Follow-Up Readiness',
        subtitle: isArabic
            ? 'راجع حوكمة المتابعة ثم حدود الذكاء قبل أي توسع لاحق.'
            : 'Review follow-up governance, then AI boundaries before any later expansion.',
        primaryActionLabel:
            isArabic ? 'Follow-Up Care Governance' : 'Follow-Up Care Governance',
        primaryRoute: Routes.adminFollowupCareGovernance,
        secondaryActionLabel:
            isArabic ? 'AI Follow-Up Boundaries' : 'AI Follow-Up Boundaries',
        secondaryRoute: Routes.adminAiFollowupBoundaries,
        group: AdminVisualGroup.sessions,
      ),
      _AdminGuidedWorkflowCardData(
        title: isArabic ? 'مراجعة إدخال المحتوى' : 'Content Intake Review',
        subtitle: isArabic
            ? 'راجع حوكمة المكتبة ثم ارجع إلى سطح برامج المحتوى والرعاية.'
            : 'Review library governance, then return to the content and care surface.',
        primaryActionLabel:
            isArabic ? 'Library Governance' : 'Library Governance',
        primaryRoute: Routes.adminLibraryGovernance,
        secondaryActionLabel:
            isArabic ? 'Content & Care Programs' : 'Content & Care Programs',
        secondaryRoute: Routes.adminContentCarePrograms,
        group: AdminVisualGroup.support,
      ),
    ];

    final detailSections = <_AdminDetailPanelSection>[
      _AdminDetailPanelSection(
        title: isArabic ? 'المسارات الموجهة' : 'Guided Workflows',
        subtitle: isArabic
            ? 'إظهار المسارات الموجهة فقط عند الحاجة.'
            : 'Guided review paths kept available without stretching the main hub.',
        child: _AdminGuidedWorkflowsSection(
          title: isArabic ? 'مسارات مراجعة موجهة' : 'Guided Review Paths',
          subtitle: isArabic
              ? 'تجميعات تنقل خفيفة للمراجعة والوعي فقط، وليست مسار تشغيل جديد.'
              : 'Compact route groupings for review and awareness only, not a new operating workflow.',
          workflows: guidedWorkflows,
        ),
      ),
      _AdminDetailPanelSection(
        title: isArabic ? 'المراجع' : 'References',
        subtitle: isArabic
            ? 'الروابط المرجعية والسياسات في قسم منفصل قابل للطي.'
            : 'Reference pages and policy shortcuts kept below the fold.',
        child: _AdminQuickActionsStrip(
          title: isArabic ? 'مراجع أساسية' : 'Key References',
          subtitle: isArabic
              ? 'صفحات مرجعية تساعد غرفة التحكم على فهم الحدود والسياسات.'
              : 'Reference pages that help the control room understand boundaries and policy.',
          actions: keyReferences,
        ),
      ),
      _AdminDetailPanelSection(
        title: isArabic ? 'طبقة البوابات' : 'Gateway Layer',
        subtitle: isArabic
            ? 'حالة البوابات والاتصالات في قسم مضغوط.'
            : 'Gateway status and connectivity details in a condensed section.',
        child: _GatewaySummaryStrip(statuses: gatewayStatuses),
      ),
      _AdminDetailPanelSection(
        title: isArabic ? 'متابعة تفصيلية' : 'Detailed Monitoring',
        subtitle: isArabic
            ? 'بطاقات التنبيه والصحة وإشارات البوابات في قسم واحد قابل للطي.'
            : 'Alerts, health, and gateway signals in one collapsible section.',
        child: Column(
          children: [
            const _ControlRoomIntro(),
            const SizedBox(height: 2),
            _ControlRoomDashboardLayout(
              leftCards: const [
                _OperationalAlertsCard(),
                _AdminSystemHealthCard(),
                _CriticalAlertsCard(),
              ],
              supervisoryCard: _GatewaySignalsCard(
                statuses: gatewayStatuses,
                gatewayMonitor: AdminHubPage._gatewayMonitor,
              ),
            ),
          ],
        ),
      ),
      _AdminDetailPanelSection(
        title: isArabic ? 'تفاصيل التحليلات' : 'Analytics Details',
        subtitle: isArabic
            ? 'ملخص السلوك ومؤشرات المراقبة في قسم مختصر.'
            : 'Behavior and monitoring analytics kept available without stretching the main page.',
        child: _UserBehaviorAnalyticsPlaceholder(isArabic: isArabic),
      ),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1316),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 42,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: const SizedBox.shrink(),
          leading: IconButton(
            onPressed: () async {
              final didPop = await Navigator.of(context).maybePop();
              if (!didPop && context.mounted) {
                Navigator.of(context).pushNamed(Routes.menu);
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Color(0xFFE8D7A5),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF13191D),
                Color(0xFF0F1316),
                Color(0xFF151B1F),
              ],
            ),
          ),
          child: Stack(
            children: [
              const Positioned.fill(
                child: IgnorePointer(
                  child: _AdminHubAmbientBackground(),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      2,
                      AppSpacing.sm,
                      AppSpacing.sm,
                    ),
                    children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _AdminQuickActionsStrip(
                    title: isArabic ? 'اختصارات مرجعية' : 'Reference Shortcuts',
                    subtitle: isArabic
                        ? 'وصول سريع لأسطح الحوكمة والدعم دون تحويل الصفحة إلى سطح تنفيذ.'
                        : 'Fast access to governance and support surfaces without turning the hub into an execution console.',
                    actions: quickActions,
                    vertical: true,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        flex: 7,
                        child: _AdminHomeCountersSection(
                          isArabic: isArabic,
                          cards: compactCounters,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width >= 960 ? 1 : 2),
                  if (width >= 960)
                    Row(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _AdminSectionLaunchpad(cards: sectionCards),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          flex: 5,
                          child: _AdminFixedDetailPanel(
                            isArabic: isArabic,
                            sections: detailSections,
                            selectedIndex: _selectedDetailSectionIndex,
                            onSelected: (index) {
                              if (_selectedDetailSectionIndex == index) return;
                              setState(() {
                                _selectedDetailSectionIndex = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  if (false && width >= 960)
                    Row(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _AdminSectionLaunchpad(cards: sectionCards),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          flex: 5,
                          child: Stack(
                            children: [
                              _AdminFixedDetailPanel(
                                isArabic: isArabic,
                                sections: detailSections,
                                selectedIndex: _selectedDetailSectionIndex,
                                onSelected: (index) {
                                  if (_selectedDetailSectionIndex == index) return;
                                  setState(() {
                                    _selectedDetailSectionIndex = index;
                                  });
                                },
                              ),
                              Offstage(
                                offstage: true,
                                child: Column(
                                  children: [
                              _HubExpandableSection(
                                title: isArabic ? 'المسارات الموجهة' : 'Guided Workflows',
                                subtitle: isArabic
                                    ? 'إظهار المسارات الموجهة فقط عند الحاجة.'
                                    : 'Guided review paths kept available without stretching the main hub.',
                                child: Column(
                                  children: [
                                    _AdminGuidedWorkflowsSection(
                                      title: isArabic ? 'مسارات مراجعة موجهة' : 'Guided Review Paths',
                                      subtitle: isArabic
                                          ? 'تجميعات تنقل خفيفة للمراجعة والوعي فقط، وليست مسار تشغيل جديد.'
                                          : 'Compact route groupings for review and awareness only, not a new operating workflow.',
                                      workflows: guidedWorkflows,
                                    ),
                                  ],
                                ),
                              ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 0.5),
                              _HubExpandableSection(
                                title: isArabic ? 'المراجع' : 'References',
                                subtitle: isArabic
                                    ? 'الروابط المرجعية والسياسات في قسم منفصل قابل للطي.'
                                    : 'Reference pages and policy shortcuts kept below the fold.',
                                child: _AdminQuickActionsStrip(
                                  title: isArabic ? 'مراجع أساسية' : 'Key References',
                                  subtitle: isArabic
                                      ? 'صفحات مرجعية تساعد غرفة التحكم على فهم الحدود والسياسات.'
                                      : 'Reference pages that help the control room understand boundaries and policy.',
                                  actions: keyReferences,
                                ),
                              ),
                              const SizedBox(height: 1),
                              _HubExpandableSection(
                                title: isArabic ? 'طبقة البوابات' : 'Gateway Layer',
                                subtitle: isArabic
                                    ? 'حالة البوابات والاتصالات في قسم مضغوط.'
                                    : 'Gateway status and connectivity details in a condensed section.',
                                child: _GatewaySummaryStrip(statuses: gatewayStatuses),
                              ),
                              const SizedBox(height: 2),
                              _HubExpandableSection(
                                title: isArabic ? 'متابعة تفصيلية' : 'Detailed Monitoring',
                                subtitle: isArabic
                                    ? 'بطاقات التنبيه والصحة وإشارات البوابات في قسم واحد قابل للطي.'
                                    : 'Alerts, health, and gateway signals in one collapsible section.',
                                child: Column(
                                  children: [
                                    const _ControlRoomIntro(),
                                    const SizedBox(height: 2),
                                    _ControlRoomDashboardLayout(
                                      leftCards: const [
                                        _OperationalAlertsCard(),
                                        _AdminSystemHealthCard(),
                                        _CriticalAlertsCard(),
                                      ],
                                      supervisoryCard: _GatewaySignalsCard(
                                        statuses: gatewayStatuses,
                                        gatewayMonitor: AdminHubPage._gatewayMonitor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              _HubExpandableSection(
                                title: isArabic ? 'تفاصيل التحليلات' : 'Analytics Details',
                                subtitle: isArabic
                                    ? 'ملخص السلوك ومؤشرات المراقبة في قسم مختصر قابل للطي.'
                                    : 'Behavior and monitoring analytics kept available without stretching the main page.',
                                child: _UserBehaviorAnalyticsPlaceholder(isArabic: isArabic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (width < 960)
                    _AdminSectionLaunchpad(cards: sectionCards),
                  const SizedBox(height: 2),
                  _SystemAdvisoryCard(
                    advisoryStream: _systemAdvisoryStream(),
                  ),
                  if (width < 960) const SizedBox(height: 2),
                  if (width < 960)
                    _HubExpandableSection(
                    title: isArabic ? 'المسارات الموجهة' : 'Guided Workflows',
                    subtitle: isArabic
                        ? 'إظهار المسارات الموجهة فقط عند الحاجة.'
                        : 'Guided review paths kept available without stretching the main hub.',
                    child: Column(
                      children: [
                  _AdminGuidedWorkflowsSection(
                    title: isArabic ? 'مسارات مراجعة موجهة' : 'Guided Review Paths',
                    subtitle: isArabic
                        ? 'تجميعات تنقل خفيفة للمراجعة والوعي فقط، وليست مسار تشغيل جديد.'
                        : 'Compact route groupings for review and awareness only, not a new operating workflow.',
                    workflows: guidedWorkflows,
                  ),
                      ],
                    ),
                  ),
                  if (width < 960) const SizedBox(height: 2),
                  if (width < 960)
                    _HubExpandableSection(
                    title: isArabic ? 'المراجع' : 'References',
                    subtitle: isArabic
                        ? 'الروابط المرجعية والسياسات في قسم منفصل قابل للطي.'
                        : 'Reference pages and policy shortcuts kept below the fold.',
                    child: _AdminQuickActionsStrip(
                    title: isArabic ? 'مراجع أساسية' : 'Key References',
                    subtitle: isArabic
                        ? 'صفحات مرجعية تساعد غرفة التحكم على فهم الحدود والسياسات.'
                        : 'Reference pages that help the control room understand boundaries and policy.',
                    actions: keyReferences,
                  ),
                  ),
                  if (width < 960) const SizedBox(height: 2),
                  if (width < 960)
                    _HubExpandableSection(
                    title: isArabic ? 'طبقة البوابات' : 'Gateway Layer',
                    subtitle: isArabic
                        ? 'حالة البوابات والاتصالات في قسم مضغوط.'
                        : 'Gateway status and connectivity details in a condensed section.',
                    child:
                  _GatewaySummaryStrip(statuses: gatewayStatuses),
                  ),
                  if (width < 960) const SizedBox(height: 2),
                  if (width < 960)
                    _HubExpandableSection(
                    title: isArabic ? 'متابعة تفصيلية' : 'Detailed Monitoring',
                    subtitle: isArabic
                        ? 'بطاقات التنبيه والصحة وإشارات البوابات في قسم واحد قابل للطي.'
                        : 'Alerts, health, and gateway signals in one collapsible section.',
                    child: Column(
                      children: [
                  const _ControlRoomIntro(),
                  const SizedBox(height: 2),
                  _ControlRoomDashboardLayout(
                    leftCards: const [
                      _OperationalAlertsCard(),
                      _AdminSystemHealthCard(),
                      _CriticalAlertsCard(),
                    ],
                    supervisoryCard: _GatewaySignalsCard(
                      statuses: gatewayStatuses,
                      gatewayMonitor: AdminHubPage._gatewayMonitor,
                    ),
                  ),
                      ],
                    ),
                  ),
                  if (width < 960) const SizedBox(height: AppSpacing.sm),
                  if (width < 960)
                    _HubExpandableSection(
                    title: isArabic ? 'تفاصيل التحليلات' : 'Analytics Details',
                    subtitle: isArabic
                        ? 'ملخص السلوك ومؤشرات المراقبة في قسم مختصر قابل للطي.'
                        : 'Behavior and monitoring analytics kept available without stretching the main page.',
                    child: _UserBehaviorAnalyticsPlaceholder(isArabic: isArabic),
                  ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HubExpandableSection extends StatelessWidget {
  const _HubExpandableSection({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Theme(
      data: theme.copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Align(
        alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ExpansionTile(
            controlAffinity: isRtl
                ? ListTileControlAffinity.leading
                : ListTileControlAffinity.trailing,
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(top: 1),
            visualDensity: const VisualDensity(horizontal: -2, vertical: -3),
            minTileHeight: 32,
            title: Tooltip(
              message: subtitle,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF12181D).withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: const Color(0xFFD8B26A).withValues(alpha: 0.18),
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 2,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFD8B26A).withValues(alpha: 0.42),
                            const Color(0xFF3E9B90).withValues(alpha: 0.26),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        title,
                        textAlign: isRtl ? TextAlign.right : TextAlign.left,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: const Color(0xFFF1E5C8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF10161A).withValues(alpha: 0.94),
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  border: Border.all(
                    color: const Color(0xFFD8B26A).withValues(alpha: 0.18),
                    width: 0.8,
                  ),
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminDetailPanelSection {
  const _AdminDetailPanelSection({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;
}

class _AdminFixedDetailPanel extends StatelessWidget {
  const _AdminFixedDetailPanel({
    required this.isArabic,
    required this.sections,
    required this.selectedIndex,
    required this.onSelected,
  });

  final bool isArabic;
  final List<_AdminDetailPanelSection> sections;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final safeIndex =
        selectedIndex >= 0 && selectedIndex < sections.length ? selectedIndex : 0;
    final selected = sections[safeIndex];
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Column(
      crossAxisAlignment:
          isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: isRtl ? WrapAlignment.end : WrapAlignment.start,
          runSpacing: 4,
          spacing: 4,
          children: List.generate(sections.length, (index) {
            final item = sections[index];
            final isSelected = index == safeIndex;
            return Tooltip(
              message: item.subtitle,
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () => onSelected(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF171E23).withValues(alpha: 0.94)
                        : const Color(0xFF10161A).withValues(alpha: 0.76),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFD8B26A).withValues(alpha: 0.28)
                          : const Color(0xFF3E9B90).withValues(alpha: 0.14),
                      width: 0.7,
                    ),
                  ),
                  child: Text(
                    item.title,
                    textAlign: isRtl ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: isSelected
                              ? const Color(0xFFC9A75B)
                              : const Color(0xFF314A5C).withValues(alpha: 0.88),
                        ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 360,
          child: AppSurfaceCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: const Color(0xFF080D10).withValues(alpha: 0.98),
            borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.24),
            child: SingleChildScrollView(
              child: selected.child,
            ),
          ),
        ),
      ],
    );
  }
}

class _AdminHubAmbientBackground extends StatelessWidget {
  const _AdminHubAmbientBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 40,
          left: 80,
          child: _AmbientDisc(
            size: 320,
            glowColor: const Color(0xFFD8B26A).withValues(alpha: 0.16),
            ringColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
          ),
        ),
        Positioned(
          top: 260,
          left: 220,
          child: _AmbientDisc(
            size: 336,
            glowColor: const Color(0xFFD8B26A).withValues(alpha: 0.09),
            ringColor: const Color(0xFF3E9B90).withValues(alpha: 0.14),
          ),
        ),
        Positioned(
          top: 84,
          right: 48,
          child: Container(
            width: 1,
            height: 280,
            color: const Color(0xFF3E9B90).withValues(alpha: 0.12),
          ),
        ),
        Positioned(
          top: 112,
          left: 52,
          child: Container(
            width: 1,
            height: 240,
            color: const Color(0xFF3E9B90).withValues(alpha: 0.09),
          ),
        ),
        Positioned(
          top: 96,
          right: 20,
          child: _EdgeTempleHint(
            height: 320,
            color: const Color(0xFFD8B26A).withValues(alpha: 0.03),
          ),
        ),
        Positioned(
          top: 124,
          left: 20,
          child: _EdgeTempleHint(
            height: 280,
            color: const Color(0xFFD8B26A).withValues(alpha: 0.024),
          ),
        ),
      ],
    );
  }
}

class _AmbientDisc extends StatelessWidget {
  const _AmbientDisc({
    required this.size,
    required this.glowColor,
    required this.ringColor,
  });

  final double size;
  final Color glowColor;
  final Color ringColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  glowColor,
                  glowColor.withValues(alpha: glowColor.a * 0.35),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.42, 1.0],
              ),
            ),
          ),
          Container(
            width: size * 0.74,
            height: size * 0.74,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ringColor, width: 1),
            ),
          ),
          Container(
            width: size * 0.52,
            height: size * 0.52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ringColor.withValues(alpha: ringColor.a * 0.75),
                width: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EdgeTempleHint extends StatelessWidget {
  const _EdgeTempleHint({
    required this.height,
    required this.color,
  });

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: height,
      child: Column(
        children: [
          Container(
            width: 18,
            height: 3,
            color: color,
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color,
                    color.withValues(alpha: color.a * 0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminSectionLaunchCardData {
  const _AdminSectionLaunchCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.group,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final AdminVisualGroup? group;
  final String route;
}

class _AdminQuickActionItem {
  const _AdminQuickActionItem({
    required this.label,
    required this.icon,
    this.group,
    required this.route,
  });

  final String label;
  final IconData icon;
  final AdminVisualGroup? group;
  final String route;
}

class _AdminGuidedWorkflowCardData {
  const _AdminGuidedWorkflowCardData({
    required this.title,
    required this.subtitle,
    required this.primaryActionLabel,
    required this.primaryRoute,
    required this.secondaryActionLabel,
    required this.secondaryRoute,
    this.group,
  });

  final String title;
  final String subtitle;
  final String primaryActionLabel;
  final String primaryRoute;
  final String secondaryActionLabel;
  final String secondaryRoute;
  final AdminVisualGroup? group;
}

class _AdminQuickActionsStrip extends StatelessWidget {
  const _AdminQuickActionsStrip({
    required this.title,
    required this.subtitle,
    required this.actions,
    this.vertical = false,
  });

  final String title;
  final String subtitle;
  final List<_AdminQuickActionItem> actions;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment:
            isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (vertical)
            LayoutBuilder(
              builder: (context, constraints) {
                final chipWidth = constraints.maxWidth >= 360
                    ? (constraints.maxWidth - 4) / 2
                    : constraints.maxWidth;
                return Align(
                  alignment:
                      isRtl ? Alignment.centerRight : Alignment.centerLeft,
                  child: Wrap(
                    alignment: isRtl ? WrapAlignment.end : WrapAlignment.start,
                    spacing: 4,
                    runSpacing: 4,
                    children: actions.map((action) {
                      final color = _adminVisualGroupColor(action.group);
                      return SizedBox(
                        width: chipWidth,
                        child: ActionChip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: const VisualDensity(
                            horizontal: -2,
                            vertical: -2,
                          ),
                          backgroundColor:
                              const Color(0xFF182026).withValues(alpha: 0.88),
                          side: BorderSide(
                            color: const Color(0xFFD8B26A).withValues(alpha: 0.20),
                          ),
                          avatar: Icon(
                            action.icon,
                            size: 18,
                            color: color,
                          ),
                          label: Text(
                            action.label,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFFF1E5C8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () =>
                              Navigator.of(context).pushNamed(action.route),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            )
          else
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: actions
                  .map(
                    (action) {
                      final color = _adminVisualGroupColor(action.group);
                      return ActionChip(
                        backgroundColor:
                            const Color(0xFF182026).withValues(alpha: 0.88),
                        side: BorderSide(
                          color: const Color(0xFFD8B26A).withValues(alpha: 0.18),
                        ),
                        avatar: Icon(
                          action.icon,
                          size: 18,
                          color: color,
                        ),
                        label: Text(
                          action.label,
                          style: const TextStyle(
                            color: Color(0xFFF1E5C8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () =>
                            Navigator.of(context).pushNamed(action.route),
                      );
                    },
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _AdminGuidedWorkflowsSection extends StatelessWidget {
  const _AdminGuidedWorkflowsSection({
    required this.title,
    required this.subtitle,
    required this.workflows,
  });

  final String title;
  final String subtitle;
  final List<_AdminGuidedWorkflowCardData> workflows;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      color: const Color(0xFF0B1014).withValues(alpha: 0.96),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 980;
              if (isNarrow) {
                return Column(
                  children: [
                    for (int i = 0; i < workflows.length; i++) ...[
                      _AdminGuidedWorkflowCard(item: workflows[i]),
                      if (i != workflows.length - 1)
                        const SizedBox(height: AppSpacing.md),
                    ],
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < workflows.length; i++) ...[
                    Expanded(
                      child: _AdminGuidedWorkflowCard(item: workflows[i]),
                    ),
                    if (i != workflows.length - 1)
                      const SizedBox(width: AppSpacing.md),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AdminGuidedWorkflowCard extends StatelessWidget {
  const _AdminGuidedWorkflowCard({
    required this.item,
  });

  final _AdminGuidedWorkflowCardData item;

  @override
  Widget build(BuildContext context) {
    final color = _adminVisualGroupColor(item.group);
    return AppSectionPanel(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.20),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                  height: 1.3,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamed(item.primaryRoute),
                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFC9A75B),
                  side: BorderSide(
                    color: color.withValues(alpha: 0.42),
                  ),
                ),
                child: Text(item.primaryActionLabel),
              ),
              OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(item.secondaryRoute),
                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFC9A75B),
                  side: BorderSide(
                    color: const Color(0xFFD8B26A).withValues(alpha: 0.28),
                  ),
                ),
                child: Text(item.secondaryActionLabel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdminSectionLaunchpad extends StatelessWidget {
  const _AdminSectionLaunchpad({
    required this.cards,
  });

  final List<_AdminSectionLaunchCardData> cards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            textDirection: Directionality.of(context),
            spacing: 10,
            runSpacing: 9,
            children: cards.map((card) {
              return _AdminSectionLaunchCard(item: card);
            }).toList(),
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
    final color = _adminVisualGroupColor(item.group);
    return Tooltip(
      message: item.subtitle,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => Navigator.of(context).pushNamed(item.route),
        child: SizedBox(
          height: 96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF151C21),
                  border: Border.all(
                    color: const Color(0xFFD8B26A).withValues(alpha: 0.34),
                    width: 1.6,
                  ),
                  boxShadow: [
                    ...AppShadows.card,
                    BoxShadow(
                      color: const Color(0xFFD8B26A).withValues(alpha: 0.16),
                      blurRadius: 18,
                      spreadRadius: 0.6,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF0F1519),
                      border: Border.all(
                        color: const Color(0xFFD8B26A).withValues(alpha: 0.42),
                        width: 1.25,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withValues(alpha: 0.14),
                          border: Border.all(
                            color: const Color(0xFF3E9B90).withValues(alpha: 0.26),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          item.icon,
                          color: color,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFFC9A75B),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
            ],
          ),
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
          color: const Color(0xFF151B20).withValues(alpha: 0.94),
          borderColor: color.withValues(alpha: 0.24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 108),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 6),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFF1E5C8),
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${summary.affectedCount} domains require attention (highest: ${summary.highestSeverity})',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                const Color(0xFFD6D8DA).withValues(alpha: 0.84),
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'This is an informational advisory. No actions are blocked.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                const Color(0xFFD6D8DA).withValues(alpha: 0.72),
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
                child: const Text(
                  'View details',
                  style: TextStyle(
                    color: Color(0xFFE8D7A5),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            ),
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
                    color: item.color,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: _buildCounterWrap(0, const []),
    );
  }

  Widget _buildCounterWrap(int index, List<int> counts) {
    if (index >= cards.length) {
      final maxCount = counts.isEmpty ? 0 : counts.reduce((a, b) => a > b ? a : b);
      return Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 4,
              runSpacing: 4,
              children: cards.map((item) {
                return _QuickStatCard(
                  item: item,
                  isArabic: isArabic,
                  maxCount: maxCount,
                );
              }).toList(),
            ),
          ),
        ],
      );
    }

    return StreamBuilder<int>(
      stream: cards[index].stream,
      builder: (context, snapshot) {
        return _buildCounterWrap(
          index + 1,
          [...counts, snapshot.data ?? 0],
        );
      },
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
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gateway Layer',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFF1E5C8),
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Shell-level supervision for channels, tools, devices, and storage boundaries.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
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
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF12181D).withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(
            color: const Color(0xFFD8B26A).withValues(alpha: 0.20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hub_outlined, color: color, size: 18),
            const SizedBox(width: AppSpacing.xs),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFFC9A75B),
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
      group: AdminVisualGroup.system,
      minHeight: 360,
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
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
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
      constraints: const BoxConstraints(minWidth: 180, maxWidth: 240),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFF12181D).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          GatewayHealthBadge(level: level),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Boundary signal: $alertType',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
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
          color: _adminVisualGroupColor(AdminVisualGroup.system),
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
      group: AdminVisualGroup.system,
      minHeight: 224,
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
      title: 'Attention Signals',
      subtitle: 'Requests, gates, and blockers needing control-room awareness',
      group: AdminVisualGroup.requests,
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
                                  _StaticInfoChip(
                                    label: 'Client Updates: —',
                                    group: AdminVisualGroup.requests,
                                  ),
                                  _StaticInfoChip(
                                    label: 'Center Follow-up: —',
                                    group: AdminVisualGroup.requests,
                                  ),
                                  _StaticInfoChip(
                                    label: 'Payout Pending: —',
                                    group: AdminVisualGroup.payments,
                                  ),
                                  _StaticInfoChip(
                                    label: 'Centers Pending Admin: —',
                                    group: AdminVisualGroup.requests,
                                  ),
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
                                        group: AdminVisualGroup.requests,
                                      ),
                                      _StaticInfoChip(
                                        label:
                                            'Center Follow-up: $followUpCount',
                                        group: AdminVisualGroup.requests,
                                      ),
                                      _StaticInfoChip(
                                        label: 'Payout Pending: $payoutCount',
                                        group: AdminVisualGroup.payments,
                                      ),
                                      _StaticInfoChip(
                                        label:
                                            'Centers Pending Admin: $centersCount',
                                        group: AdminVisualGroup.requests,
                                      ),
                                    ],
                                  ),
                                  if (totalCount > 0) ...[
                                    const SizedBox(height: AppSpacing.sm),
                                    _ControlRoomActionButton(
                                      label: 'Open Request Monitoring',
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
      title: 'Human Review Needed',
      subtitle: 'Open support-only threads requiring human review',
      group: AdminVisualGroup.support,
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
                      _StaticInfoChip(
                        label: 'Human Review Needed: —',
                        group: AdminVisualGroup.support,
                      ),
                      _StaticInfoChip(
                        label: 'Center Chats: —',
                        group: AdminVisualGroup.support,
                      ),
                      _StaticInfoChip(
                        label: 'Client Chats: —',
                        group: AdminVisualGroup.support,
                      ),
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
                            label: 'Human Review Needed',
                            count: '$humanSupportCount',
                            group: AdminVisualGroup.support,
                          ),
                          _ConversationCountChip(
                            label: 'Center Chats',
                            count: '$centerChatsCount',
                            group: AdminVisualGroup.support,
                          ),
                          _ConversationCountChip(
                            label: 'Client Chats',
                            count: '$clientChatsCount',
                            group: AdminVisualGroup.support,
                          ),
                        ],
                      ),
                      if (humanSupportCount > 0) ...[
                        const SizedBox(height: AppSpacing.sm),
                        _ControlRoomActionButton(
                          label: 'Open Human Review Threads',
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
      title: 'System Attention Signals',
      subtitle: 'Generated monitoring signals for blockers and exceptions',
      group: AdminVisualGroup.system,
      minHeight: 224,
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
                  _StaticInfoChip(
                    label: 'Center Follow-up: —',
                    group: AdminVisualGroup.requests,
                  ),
                  _StaticInfoChip(
                    label: 'Client Update Required: —',
                    group: AdminVisualGroup.requests,
                  ),
                  _StaticInfoChip(
                    label: 'Payout Pending: —',
                    group: AdminVisualGroup.payments,
                  ),
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
                      group: AdminVisualGroup.requests,
                    ),
                    _StaticInfoChip(
                      label:
                          'Client Update Required: $clientUpdateRequiredCount',
                      group: AdminVisualGroup.requests,
                    ),
                    _StaticInfoChip(
                      label: 'Payout Pending: $payoutPendingCount',
                      group: AdminVisualGroup.payments,
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
                    label: 'Review Alert Signals',
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
      title: 'Safety / Urgent Attention',
      subtitle:
          'High-attention human review, payout, and stuck-flow indicators',
      group: AdminVisualGroup.support,
      minHeight: 224,
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
                              _StaticInfoChip(
                                label: 'Stuck Follow-ups: —',
                                group: AdminVisualGroup.sessions,
                              ),
                              _StaticInfoChip(
                                label: 'Human Review Needed: —',
                                group: AdminVisualGroup.support,
                              ),
                              _StaticInfoChip(
                                label: 'Pending Payouts: —',
                                group: AdminVisualGroup.payments,
                              ),
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
                                    group: AdminVisualGroup.sessions,
                                  ),
                                  _StaticInfoChip(
                                    label:
                                        'Human Review Needed: $unresolvedSupportChatsCount',
                                    group: AdminVisualGroup.support,
                                  ),
                                  _StaticInfoChip(
                                    label:
                                        'Pending Payouts: $pendingPayoutsCount',
                                    group: AdminVisualGroup.payments,
                                  ),
                                ],
                              ),
                              if (totalCount > 0) ...[
                                const SizedBox(height: AppSpacing.sm),
                                _ControlRoomActionButton(
                                  label: 'Review Alert Signals',
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

class _UserBehaviorAnalyticsPlaceholder extends StatefulWidget {
  const _UserBehaviorAnalyticsPlaceholder({
    required this.isArabic,
  });

  final bool isArabic;

  @override
  State<_UserBehaviorAnalyticsPlaceholder> createState() =>
      _UserBehaviorAnalyticsPlaceholderState();
}

class _UserBehaviorAnalyticsPlaceholderState
    extends State<_UserBehaviorAnalyticsPlaceholder> {
  static const AnalyticsSummaryRepository _repository =
      AnalyticsSummaryRepository();

  late final Future<AnalyticsSummaryBundle> _backendSummaryFuture;

  @override
  void initState() {
    super.initState();
    _backendSummaryFuture = _repository.fetchBundle();
  }

  @override
  Widget build(BuildContext context) {
    return _ControlRoomCardShell(
      title: widget.isArabic
          ? 'تحليلات سلوك المستخدمين'
          : 'User Behavior Analytics',
      subtitle: widget.isArabic
          ? 'قراءة هادئة لأنماط دخول المستخدمين واختياراتهم داخل المسارات الأساسية.'
          : 'Passive awareness of user entry patterns and support-path choices across core modules.',
      group: AdminVisualGroup.analytics,
      minHeight: 232,
      child: _ControlRoomBodyFrame(
        child: FutureBuilder<AnalyticsSummaryBundle>(
          future: _backendSummaryFuture,
          builder: (context, snapshot) {
            if (snapshot.data?.hasAnyData == true) {
              return _BackendAnalyticsSummaryView(
                isArabic: widget.isArabic,
                bundle: snapshot.data!,
              );
            }

            return _LocalAnalyticsSummaryView(
              isArabic: widget.isArabic,
            );
          },
        ),
      ),
    );
  }
}

class _BackendAnalyticsSummaryView extends StatelessWidget {
  const _BackendAnalyticsSummaryView({
    required this.isArabic,
    required this.bundle,
  });

  final bool isArabic;
  final AnalyticsSummaryBundle bundle;

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, int>> topModules =
        (bundle.topEntryModules?.items ?? const <TopEntryModuleItem>[])
        .map((item) => MapEntry(item.key, item.count))
        .toList();
    final List<MapEntry<String, int>> topPaths =
        (bundle.topSelectedPaths?.items ?? const <TopSelectedPathItem>[])
        .map((item) => MapEntry(item.key, item.count))
        .toList();
    final Map<String, int> chatSplit = {
      for (final item
          in bundle.chatOpensByContext?.items ?? const <ChatContextCountItem>[])
        item.context: item.count,
    };
    final totalChatOpens = bundle.chatOpensByContext?.total ??
        chatSplit.values.fold<int>(0, (sum, value) => sum + value);
    final hasData =
        topModules.isNotEmpty || topPaths.isNotEmpty || totalChatOpens > 0;

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        AppStatusBadge(
          label: isArabic ? 'أحدث ملخص محفوظ' : 'Latest summary',
          color: _adminVisualGroupColor(AdminVisualGroup.analytics),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            _AnalyticsSummaryCard(
              title: isArabic ? 'مصادر الدخول' : 'Top Entry Modules',
              helper: isArabic
                  ? 'أكثر الأقسام دخولًا من الملخص المحفوظ.'
                  : 'Most entered modules from the latest stored summary.',
              child: _AnalyticsEntryList(
                isArabic: isArabic,
                entries: topModules,
                emptyLabel: isArabic ? 'لا توجد بيانات بعد' : 'No data yet',
              ),
            ),
            _AnalyticsSummaryCard(
              title: isArabic ? 'أكثر المسارات اختيارًا' : 'Top Selected Paths',
              helper: isArabic
                  ? 'أكثر المسارات ظهورًا من الملخص المحفوظ.'
                  : 'Most selected paths from the latest stored summary.',
              child: _AnalyticsEntryList(
                isArabic: isArabic,
                entries: topPaths,
                emptyLabel: isArabic ? 'لا توجد بيانات بعد' : 'No data yet',
              ),
            ),
            _AnalyticsSummaryCard(
              title:
                  isArabic ? 'توزيع فتح الشات حسب السياق' : 'Chat Context Mix',
              helper: isArabic
                  ? 'سياقات فتح الشات من الملخص المحفوظ.'
                  : 'Chat open contexts from the latest stored summary.',
              child: _ChatContextSummary(
                isArabic: isArabic,
                counts: chatSplit,
                totalOverride: totalChatOpens,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (!hasData)
          Text(
            isArabic ? 'لا توجد بيانات بعد' : 'No data yet',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                  fontWeight: FontWeight.w600,
                ),
          ),
      ],
    );
  }
}

class _LocalAnalyticsSummaryView extends StatelessWidget {
  const _LocalAnalyticsSummaryView({
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: AppAnalytics.listenable,
      builder: (context, _, __) {
        final topModules = AppAnalytics.getTopModules().take(5).toList();
        final topPaths = AppAnalytics.getTopPaths().take(5).toList();
        final chatSplit = AppAnalytics.getChatContextSplit();
        final totalChatOpens =
            chatSplit.values.fold<int>(0, (sum, value) => sum + value);
        final hasData =
            topModules.isNotEmpty || topPaths.isNotEmpty || totalChatOpens > 0;

        return Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            AppStatusBadge(
              label: isArabic
                  ? 'معاينة الجلسة الحالية'
                  : 'Current session preview',
              color: _adminVisualGroupColor(AdminVisualGroup.analytics),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                _AnalyticsSummaryCard(
                  title: isArabic ? 'مصادر الدخول' : 'Top Entry Modules',
                  helper: isArabic
                      ? 'أكثر الأقسام دخولًا في هذه الجلسة.'
                      : 'Most entered modules in this session.',
                  child: _AnalyticsEntryList(
                    isArabic: isArabic,
                    entries: topModules,
                    emptyLabel: isArabic ? 'لا توجد بيانات بعد' : 'No data yet',
                  ),
                ),
                _AnalyticsSummaryCard(
                  title: isArabic ? 'أكثر المسارات اختيارًا' : 'Top Selected Paths',
                  helper: isArabic
                      ? 'أكثر المسارات التي تم اختيارها داخل هذه الجلسة.'
                      : 'Most selected paths in this session.',
                  child: _AnalyticsEntryList(
                    isArabic: isArabic,
                    entries: topPaths,
                    emptyLabel: isArabic ? 'لا توجد بيانات بعد' : 'No data yet',
                  ),
                ),
                _AnalyticsSummaryCard(
                  title:
                      isArabic ? 'توزيع فتح الشات حسب السياق' : 'Chat Context Mix',
                  helper: isArabic
                      ? 'الشات العام، والأسرة، والتعافي داخل هذه الجلسة.'
                      : 'General, family, and recovery chat openings in this session.',
                  child: _ChatContextSummary(
                    isArabic: isArabic,
                    counts: chatSplit,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (!hasData)
              Text(
                isArabic ? 'لا توجد بيانات بعد' : 'No data yet',
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                      fontWeight: FontWeight.w600,
                    ),
              ),
          ],
        );
      },
    );
  }
}

class _AnalyticsSummaryCard extends StatelessWidget {
  const _AnalyticsSummaryCard({
    required this.title,
    required this.helper,
    required this.child,
  });

  final String title;
  final String helper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: AppSurfaceCard(
        color: const Color(0xFF10161A).withValues(alpha: 0.94),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFC9A75B),
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              helper,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                    height: 1.25,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            child,
          ],
        ),
      ),
    );
  }
}

class _AnalyticsEntryList extends StatelessWidget {
  const _AnalyticsEntryList({
    required this.isArabic,
    required this.entries,
    required this.emptyLabel,
  });

  final bool isArabic;
  final List<MapEntry<String, int>> entries;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Text(
        emptyLabel,
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF314A5C).withValues(alpha: 0.88),
              fontWeight: FontWeight.w600,
            ),
      );
    }

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < entries.length; i++) ...[
          _AnalyticsLineItem(
            isArabic: isArabic,
            label: entries[i].key,
            value: '${entries[i].value}',
          ),
          if (i != entries.length - 1) const SizedBox(height: AppSpacing.xs),
        ],
      ],
    );
  }
}

class _ChatContextSummary extends StatelessWidget {
  const _ChatContextSummary({
    required this.isArabic,
    required this.counts,
    this.totalOverride,
  });

  final bool isArabic;
  final Map<String, int> counts;
  final int? totalOverride;

  @override
  Widget build(BuildContext context) {
    const contexts = ['general', 'family_support', 'recovery_support'];
    final total =
        totalOverride ?? counts.values.fold<int>(0, (sum, value) => sum + value);

    if (total == 0) {
      return Text(
        isArabic ? 'لا توجد بيانات بعد' : 'No activity yet',
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF314A5C).withValues(alpha: 0.88),
              fontWeight: FontWeight.w600,
            ),
      );
    }

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < contexts.length; i++) ...[
          _AnalyticsLineItem(
            isArabic: isArabic,
            label: contexts[i],
            value: _formatCountWithPercent(
              count: counts[contexts[i]] ?? 0,
              total: total,
            ),
          ),
          if (i != contexts.length - 1) const SizedBox(height: AppSpacing.xs),
        ],
      ],
    );
  }

  String _formatCountWithPercent({
    required int count,
    required int total,
  }) {
    if (total <= 0) return '$count';
    final percent = ((count / total) * 100).round();
    return '$count ($percent%)';
  }
}

class _AnalyticsLineItem extends StatelessWidget {
  const _AnalyticsLineItem({
    required this.isArabic,
    required this.label,
    required this.value,
  });

  final bool isArabic;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFFC9A75B),
              ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
          ),
        ),
      ],
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
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'System awareness for health, blockers, gates, support signals, and exceptions.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                ),
          ),
        ],
      ),
    );
  }
}

class _ControlRoomDashboardLayout extends StatelessWidget {
  const _ControlRoomDashboardLayout({
    required this.leftCards,
    required this.supervisoryCard,
  });

  final List<Widget> leftCards;
  final Widget supervisoryCard;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.md;
        if (constraints.maxWidth < 1040) {
          return Column(
            children: [
              for (final card in leftCards) ...[
                card,
                const SizedBox(height: gap),
              ],
              supervisoryCard,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: leftCards[0]),
                      const SizedBox(width: gap),
                      Expanded(child: leftCards[1]),
                    ],
                  ),
                  const SizedBox(height: gap),
                  leftCards[2],
                ],
              ),
            ),
            const SizedBox(width: gap),
            Expanded(
              flex: 2,
              child: supervisoryCard,
            ),
          ],
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
    this.group,
    this.minHeight = 264,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final AdminVisualGroup? group;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final color = _adminVisualGroupColor(group);
    return AppSurfaceCard(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 44,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD8B26A).withValues(alpha: 0.85),
                    color.withValues(alpha: 0.70),
                    const Color(0xFF3E9B90).withValues(alpha: 0.52),
                  ],
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFC9A75B),
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                child,
              ],
            ),
          ),
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
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF314A5C).withValues(alpha: 0.88),
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
      constraints: const BoxConstraints(minHeight: 144),
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
          foregroundColor: const Color(0xFFE8D7A5),
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
    this.group,
  });

  final String label;
  final AdminVisualGroup? group;

  @override
  Widget build(BuildContext context) {
    final color = _adminVisualGroupColor(group);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF12181D).withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: color.withValues(alpha: 0.28),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: const Color(0xFFC9A75B),
            ),
      ),
    );
  }
}

class _ConversationCountChip extends StatelessWidget {
  const _ConversationCountChip({
    required this.label,
    required this.count,
    this.group,
  });

  final String label;
  final String count;
  final AdminVisualGroup? group;

  @override
  Widget build(BuildContext context) {
    final color = _adminVisualGroupColor(group);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF12181D).withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: color.withValues(alpha: 0.28),
        ),
      ),
      child: Text(
        '$label: $count',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: const Color(0xFFC9A75B),
            ),
      ),
    );
  }
}

class _QuickStatItem {
  final String title;
  final AdminVisualGroup? group;
  final Stream<int> stream;
  final Stream<int>? crossSignalStream;
  final String route;

  const _QuickStatItem({
    required this.title,
    this.group,
    required this.stream,
    this.crossSignalStream,
    required this.route,
  });
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.item,
    required this.isArabic,
    required this.maxCount,
  });

  final _QuickStatItem item;
  final bool isArabic;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final color = _adminVisualGroupColor(item.group);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).pushNamed(item.route),
        child: SizedBox(
          width: 90,
          height: 104,
          child: StreamBuilder<int>(
        stream: item.stream,
        builder: (context, snapshot) {
          final isOpenRequestsCounter = item.group == AdminVisualGroup.requests;
          final isPaymentReviewCounter = item.group == AdminVisualGroup.payments;
          final isSessionReadinessCounter = item.group == AdminVisualGroup.sessions;
          final isHumanReviewCounter = item.group == AdminVisualGroup.support;
          final isGatewaySignalsCounter = item.group == AdminVisualGroup.system;
          final waiting =
              snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData;
          final hasError = snapshot.hasError;
          final count = snapshot.data;
          final openRequestsCountText =
              hasError ? '—' : (waiting ? '...' : '${count ?? 0}');
          final countText = hasError ? '!' : (count == null ? '—' : '$count');
          final humanReviewCountText =
              hasError ? '—' : (waiting ? '...' : '${count ?? 0}');
          final paymentReviewCountText =
              hasError ? '—' : (waiting ? '...' : '${count ?? 0}');
          final sessionReadinessCountText =
              hasError ? '—' : (waiting ? '...' : '${count ?? 0}');
          final gatewaySignalsCountText =
              hasError ? '—' : (waiting ? '...' : '${count ?? 0}');
          final statusText = hasError
              ? (isArabic ? 'تعذر التحميل' : 'Load failed')
              : (waiting
                  ? (isArabic ? 'جارٍ التحديث' : 'Updating')
                  : item.title);
          final displayCountText = isOpenRequestsCounter
              ? openRequestsCountText
              : (isPaymentReviewCounter
                  ? paymentReviewCountText
                  : (isSessionReadinessCounter
                      ? sessionReadinessCountText
                      : (isHumanReviewCounter
                          ? humanReviewCountText
                          : (isGatewaySignalsCounter
                              ? gatewaySignalsCountText
                              : countText))));
          final isTopPriority = (count ?? 0) > 0 && (count ?? 0) == maxCount;

          return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  item.crossSignalStream == null
                      ? Container(
                      width: 76,
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10161A).withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: const Color(0xFFD8B26A).withValues(
                            alpha: isTopPriority
                                ? 0.48
                                : ((count ?? 0) > 0 ? 0.40 : 0.30),
                          ),
                          width: 1.1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD8B26A).withValues(
                              alpha: isTopPriority
                                  ? 0.11
                                  : ((count ?? 0) > 0 ? 0.08 : 0.04),
                            ),
                            blurRadius: 5,
                            spreadRadius: 0.1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            displayCountText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 24,
                            height: 3,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.62),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ],
                      ),
                        )
                      : StreamBuilder<int>(
                      stream: item.crossSignalStream,
                      builder: (context, crossSnapshot) {
                        final crossSignalActive =
                            (count ?? 0) > 0 && (crossSnapshot.data ?? 0) > 0;
                        return Container(
                          width: 76,
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10161A).withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: const Color(0xFFD8B26A).withValues(
                                alpha: isTopPriority
                                    ? 0.52
                                    : (crossSignalActive
                                        ? 0.46
                                        : ((count ?? 0) > 0 ? 0.40 : 0.30)),
                              ),
                              width: 1.1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD8B26A).withValues(
                                  alpha: isTopPriority
                                      ? 0.12
                                      : (crossSignalActive
                                          ? 0.10
                                          : ((count ?? 0) > 0 ? 0.08 : 0.04)),
                                ),
                                blurRadius: 5,
                                spreadRadius: 0.1,
                              ),
                              if (crossSignalActive)
                                BoxShadow(
                                  color: const Color(0xFF3E7C6F).withValues(
                                    alpha: 0.05,
                                  ),
                                  blurRadius: 6,
                                  spreadRadius: 0.15,
                                ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                displayCountText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w900,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: 24,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.62),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 4),
                  Text(
                    statusText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFE6DAB6),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
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
