import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/branding/app_assets.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/core/system/domain_status_service.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';
import 'package:flutterprojects/features/gateway_layer/core/gateway_monitor.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

enum AdminVisualGroup {
  requests,
  sessions,
  support,
  analytics,
  system,
}

Color _adminVisualGroupColor(AdminVisualGroup? group) {
  switch (group) {
    case AdminVisualGroup.requests:
      return const Color(0xFF7891C8);
    case AdminVisualGroup.sessions:
      return const Color(0xFF6CB7D6);
    case AdminVisualGroup.support:
      return const Color(0xFFE08A68);
    case AdminVisualGroup.analytics:
      return const Color(0xFF9584D4);
    case AdminVisualGroup.system:
      return const Color(0xFF54A997);
    case null:
      return const Color(0xFF54A997);
  }
}

// ADMIN_SURFACE: SAFE_UI
class AdminHubPage extends StatefulWidget {
  const AdminHubPage({super.key});

  static const DomainStatusService _domainStatusService = DomainStatusService();
  static const GatewayMonitor _gatewayMonitor = GatewayMonitor();

  @override
  State<AdminHubPage> createState() => _AdminHubPageState();
}

class _AdminHubPageState extends State<AdminHubPage> {
  static const int pendingContentCount = 6;
  static const int openIssuesCount = 3;
  static const int aiDevOpsCount = 4;
  static const int domainAvailabilityCount = 2;
  static const int externalFollowUpCount = 2;
  late final Stream<int> _escalationsOpenStream;
  late final Stream<int> _pendingApprovalsStream;
  late final Stream<int> _gatewayAttentionStream;

  @override
  void initState() {
    super.initState();
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
        final sub = AdminHubPage._domainStatusService
            .watchDomainStatus(domain.key)
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

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  void _backToMenu(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.menu,
      (route) => false,
    );
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    final compactCounters = <_QuickStatItem>[
      _QuickStatItem(
        title: isArabic
            ? 'Ø­Ø§Ù„Ø§Øª Ù…ØµØ¹Ù‘Ø¯Ø© (Ø³Ø¬Ù„ Ù‚Ø¯ÙŠÙ…)'
            : 'Escalated Cases (Historical)',
        group: AdminVisualGroup.support,
        stream: _escalationsOpenStream,
        route: Routes.adminSupportChats,
      ),
      _QuickStatItem(
        title: isArabic ? 'Ø·Ù„Ø¨Ø§Øª ØªØ­ØªØ§Ø¬ Ø§Ù†ØªØ¨Ø§Ù‡' : 'Requests Requiring Attention',
        group: AdminVisualGroup.requests,
        stream: _pendingApprovalsStream,
        route: Routes.adminClinicianRequests,
      ),
      _QuickStatItem(
        title: isArabic ? 'Ø¥Ø´Ø§Ø±Ø§Øª Ø¨ÙˆØ§Ø¨Ø§Øª/Ø£Ø¬Ù‡Ø²Ø©' : 'Gateway/device signals',
        group: AdminVisualGroup.system,
        stream: _gatewayAttentionStream,
        route: Routes.adminGatewayLayer,
      ),
      _QuickStatItem(
        title: isArabic ? 'Ù…Ø´Ø§ÙƒÙ„ Ù…ÙØªÙˆØ­Ø©' : 'Open Issues',
        group: AdminVisualGroup.system,
        staticCount: openIssuesCount,
        route: Routes.adminMaintenanceSystem,
      ),
      _QuickStatItem(
        title: isArabic ? 'Ø­Ø§Ù„Ø© Ø§Ù„Ø£Ù‚Ø³Ø§Ù…' : 'Domains',
        group: AdminVisualGroup.system,
        staticCount: domainAvailabilityCount,
        route: Routes.adminDomainAvailability,
      ),
      _QuickStatItem(
        title: isArabic ? 'Ø±Ø³Ø§Ø¦Ù„ Ù…ØªØ§Ø¨Ø¹Ø©' : 'Follow-up Messages',
        group: AdminVisualGroup.support,
        staticCount: externalFollowUpCount,
        route: Routes.adminCommunicationGateway,
      ),
      _QuickStatItem(
        title: isArabic ? 'ØªØ´ØºÙŠÙ„ Ø§Ù„Ø°ÙƒØ§Ø¡ ÙˆØ§Ù„ÙƒÙˆØ¯' : 'AI DevOps',
        group: AdminVisualGroup.analytics,
        staticCount: aiDevOpsCount,
        route: Routes.adminAiDevOpsCenter,
      ),
      _QuickStatItem(
        title: isArabic ? 'Ù…Ø­ØªÙˆÙ‰ Ù‚ÙŠØ¯ Ø§Ù„ØªÙ†ÙÙŠØ°' : 'Pending Content',
        group: AdminVisualGroup.analytics,
        staticCount: pendingContentCount,
        route: Routes.contentWorkspace,
      ),
    ];

    final mainSectionCards = <_AdminSectionLaunchCardData>[
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø±Ø¤ÙŠØ© Ø§Ù„Ø¹Ù…Ù„ÙŠØ§Øª Ø§Ù„Ù‚Ø¯ÙŠÙ…Ø©' : 'Legacy Operations Visibility',
        subtitle: isArabic
            ? 'Ø±Ø¤ÙŠØ© Ù…Ø§Ù„ÙŠØ© ÙˆØªÙ†Ø³ÙŠÙ‚ÙŠØ© Ù‚Ø¯ÙŠÙ…Ø© Ø¯ÙˆÙ† Ù…Ù„ÙƒÙŠØ© Ø§Ù„ØªØ´ØºÙŠÙ„ Ø§Ù„ÙŠÙˆÙ…ÙŠ'
            : 'Monitor legacy financial signals and coordination without daily operational ownership',
        icon: Icons.assignment_outlined,
        group: AdminVisualGroup.requests,
        route: Routes.adminOperations,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic
            ? 'Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹Ø© Ø§Ù„Ø¨Ø´Ø±ÙŠØ© ÙˆØ§Ù„Ø³Ø¬Ù„ Ø§Ù„Ù‚Ø¯ÙŠÙ…'
            : 'Human Review & Historical Cases',
        subtitle: isArabic
            ? 'Ù‡Ø°Ø§ Ø§Ù„Ù‚Ø³Ù… ÙŠØ¹Ø±Ø¶ Ù…Ø­Ø§Ø¯Ø«Ø§Øª Ø§Ù„Ø´Ø§Øª Ø§Ù„Ù‚Ø¯ÙŠÙ…Ø© ÙÙ‚Ø·. Ø·Ù„Ø¨Ø§Øª Ø§Ù„Ø¯Ø¹Ù… Ø§Ù„Ø¬Ø¯ÙŠØ¯Ø© ØªØªÙ… Ø¹Ø¨Ø± Ø·Ù„Ø¨Ø§Øª Ø¯Ø¹Ù… Ù…Ù†Ø¸Ù‘Ù…Ø©.'
            : 'This section shows historical chat threads only. New support requests are handled via structured support requests.',
        icon: Icons.support_agent_outlined,
        group: AdminVisualGroup.support,
        route: Routes.adminCommunications,
      ),
      _AdminSectionLaunchCardData(
        title:
            isArabic ? 'Ø§Ù„Ø¯Ù„ÙŠÙ„ ÙˆØ¨ÙˆØ§Ø¨Ø§Øª Ø§Ù„Ø§Ø¹ØªÙ…Ø§Ø¯' : 'Directory & Approval Gates',
        subtitle: isArabic
            ? 'Ø§Ù„Ø¹Ù…Ù„Ø§Ø¡ ÙˆØ§Ù„Ù…Ø±Ø§ÙƒØ² ÙˆØ¨ÙˆØ§Ø¨Ø§Øª Ø§Ù„Ø§Ø¹ØªÙ…Ø§Ø¯'
            : 'Clients, centers, and approval-gate visibility',
        icon: Icons.apartment_outlined,
        group: AdminVisualGroup.requests,
        route: Routes.adminClinicianRequests,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ø­ÙˆÙƒÙ…Ø©' : 'Governance',
        subtitle: isArabic
            ? 'Ø§Ù„Ø³ÙŠØ§Ø³Ø§Øª ÙˆØ­Ø§Ù„Ø© Ø§Ù„Ø£Ù‚Ø³Ø§Ù… ÙˆØ±Ø¤ÙŠØ© Ø§Ù„Ø­ÙˆÙƒÙ…Ø©'
            : 'Policies, domains, and governance visibility',
        icon: Icons.policy_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminDomainStatus,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø¨Ø±Ø§Ù…Ø¬ Ø§Ù„Ù…Ø­ØªÙˆÙ‰ ÙˆØ§Ù„Ø±Ø¹Ø§ÙŠØ©' : 'Content & Care Programs',
        subtitle: isArabic
            ? 'Ø­ÙˆÙƒÙ…Ø© Ø§Ù„Ù…Ø­ØªÙˆÙ‰ ÙˆØ±Ø³Ø§Ø¦Ù„ Ø§Ù„Ø¯Ø¹Ù… ÙˆØ§Ù„Ø±Ø¹Ø§ÙŠØ© Ø§Ù„Ù„Ø§Ø­Ù‚Ø©'
            : 'Governance for content, support messaging, and follow-up care',
        icon: Icons.menu_book_outlined,
        group: AdminVisualGroup.support,
        route: Routes.adminContentCarePrograms,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ù†Ù…Ùˆ ÙˆØ§Ù„Ø§Ù†ØªØ´Ø§Ø±' : 'Growth & Awareness',
        subtitle: isArabic
            ? 'Ø§Ù„ØªÙˆØ¹ÙŠØ© ÙˆØ§Ù„ØªÙˆØ²ÙŠØ¹ ÙˆØªØ®Ø·ÙŠØ· Ø§Ù„Ø¸Ù‡ÙˆØ± Ø§Ù„Ù…ÙˆØ¬Ù‘Ù‡'
            : 'Awareness, distribution, and supervised exposure planning',
        icon: Icons.campaign_outlined,
        group: AdminVisualGroup.analytics,
        route: Routes.adminGrowthLayer,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø·Ø¨Ù‚Ø© Ø§Ù„Ø¨ÙˆØ§Ø¨Ø§Øª' : 'Gateway Layer',
        subtitle: isArabic
            ? 'Ø§Ù„Ù‚Ù†ÙˆØ§Øª ÙˆØ§Ù„Ø£Ø¯ÙˆØ§Øª ÙˆØ§Ù„Ø£Ø¬Ù‡Ø²Ø© ÙˆØ§Ù„ØµÙŠØ§Ù†Ø©'
            : 'Channels, tools, devices, and maintenance',
        icon: Icons.hub_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminGatewayLayer,
      ),
    ];

    final departmentSectionCards = <_AdminSectionLaunchCardData>[
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ù…ØªØ§Ø¨Ø¹Ø© ÙˆØ®Ø¯Ù…Ø© Ø§Ù„Ø¹Ù…Ù„Ø§Ø¡' : 'Customer Follow-up',
        subtitle: isArabic
            ? 'Ø·Ù„Ø¨Ø§Øª Ø§Ù„ÙˆÙŠØ¨ ÙˆØ§Ù„Ø¨Ø±ÙŠØ¯ ÙˆØ§Ù„Ù…ØªØ§Ø¨Ø¹Ø© Ø§Ù„ØªØ´ØºÙŠÙ„ÙŠØ©'
            : 'Web requests, email, and operational follow-up',
        icon: Icons.support_agent_outlined,
        group: AdminVisualGroup.support,
        route: Routes.customerFollowUpWorkspace,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ø¯Ø¹Ù… Ø§Ù„ØªÙ‚Ù†ÙŠ ÙˆØ§Ù„ØµÙŠØ§Ù†Ø©' : 'Technical Support',
        subtitle: isArabic
            ? 'Ø§Ù„ØªØ´Ø®ÙŠØµ ÙˆØ§Ù„ØµÙŠØ§Ù†Ø© ÙˆÙ…Ø¹Ø§Ù„Ø¬Ø© Ø§Ù„Ù…Ø´Ø§ÙƒÙ„ ÙˆØµØ­Ø© Ø§Ù„Ù†Ø¸Ø§Ù…'
            : 'Diagnostics, maintenance, issue handling, and system health',
        icon: Icons.build_circle_outlined,
        group: AdminVisualGroup.system,
        route: Routes.technicalSupportWorkspace,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ø¯Ø¹Ø§ÙŠØ© ÙˆØ§Ù„Ù…Ø­ØªÙˆÙ‰' : 'Marketing',
        subtitle: isArabic
            ? 'Ø§Ù„Ù…Ø­ØªÙˆÙ‰ ÙˆØ§Ù„Ø­Ù…Ù„Ø§Øª ÙˆØªØ¬Ù‡ÙŠØ² Ø§Ù„Ù†Ø´Ø± ÙˆØ§Ù„Ù…ÙˆØ§Ø¯ Ø§Ù„ØªØ¹Ù„ÙŠÙ…ÙŠØ©'
            : 'Content, campaigns, publish prep, and educational materials',
        icon: Icons.campaign_outlined,
        group: AdminVisualGroup.analytics,
        route: Routes.marketingWorkspace,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ø£Ø±Ø´ÙŠÙ' : 'Archive',
        subtitle: isArabic
            ? 'Ø§Ø®ØªØµØ§Ø± Ù„Ø³Ø¬Ù„Ø§Øª Ø§Ù„Ø£Ù‚Ø³Ø§Ù… Ø§Ù„Ù…Ø¤Ø±Ø´ÙØ©'
            : 'Shortcut to archived department records',
        icon: Icons.archive_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminArchive,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ù…ØªØ§Ø¨Ø¹Ø© Ø§Ù„Ø®Ø§Ø±Ø¬ÙŠØ©' : 'External Follow-up',
        subtitle: isArabic
            ? 'Ø¥Ø¯Ø§Ø±Ø© ØªØ³Ø¬ÙŠÙ„Ø§Øª Ø§Ù„Ù…ØªØ§Ø¨Ø¹Ø© ÙˆØ§Ù„Ø¯Ø¹Ù… ÙˆØ§Ù„ØªÙ‡Ù†Ø¦Ø© ÙˆØ§Ù„ØªÙˆØ¹ÙŠØ©'
            : 'Manage follow-up, support, greeting, and awareness registrations',
        icon: Icons.mark_email_read_outlined,
        group: AdminVisualGroup.support,
        route: Routes.externalFollowUpWorkspace,
      ),
    ];

    final registrationSectionCards = <_AdminSectionLaunchCardData>[
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ø¹Ù…Ù„Ø§Ø¡' : 'Clients',
        subtitle: isArabic
            ? 'Ù…ØªØ§Ø¨Ø¹Ø© Ø­Ø³Ø§Ø¨Ø§Øª Ø§Ù„Ø¹Ù…Ù„Ø§Ø¡ ÙˆØ­Ø§Ù„Ø§Øª Ø§Ù„Ø­Ø¸Ø±'
            : 'Review client accounts and block status',
        icon: Icons.people_alt_outlined,
        group: AdminVisualGroup.requests,
        route: Routes.adminClients,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ù…Ø±Ø§ÙƒØ²' : 'Centers',
        subtitle: isArabic
            ? 'Ø§Ø¹ØªÙ…Ø§Ø¯ ÙˆÙ…ØªØ§Ø¨Ø¹Ø© ØªØ³Ø¬ÙŠÙ„Ø§Øª Ø§Ù„Ù…Ø±Ø§ÙƒØ²'
            : 'Approve and follow center registrations',
        icon: Icons.apartment_outlined,
        group: AdminVisualGroup.requests,
        route: Routes.adminCenters,
      ),
      _AdminSectionLaunchCardData(
        title: isArabic ? 'Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠÙŠÙ†' : 'Clinicians',
        subtitle: isArabic
            ? 'Ø§Ø¹ØªÙ…Ø§Ø¯ ÙˆÙ…ØªØ§Ø¨Ø¹Ø© ØªØ³Ø¬ÙŠÙ„Ø§Øª Ø§Ù„Ø£Ø®ØµØ§Ø¦ÙŠÙŠÙ†'
            : 'Approve and follow clinician registrations',
        icon: Icons.medical_services_outlined,
        group: AdminVisualGroup.requests,
        route: Routes.adminClinicianRequests,
      ),
      _AdminSectionLaunchCardData(
        title:
            isArabic ? 'ØªÙ‚Ø§Ø±ÙŠØ± Ø§Ù„ØªØ³Ø¬ÙŠÙ„ ÙˆØ§Ù„ØµÙŠØ§Ù†Ø©' : 'Registration Maintenance',
        subtitle: isArabic
            ? 'ØªÙ‚Ø§Ø±ÙŠØ± ØµØ­Ø© Ø§Ù„ØªØ³Ø¬ÙŠÙ„ ÙˆØ§Ù„Ø­Ø³Ø§Ø¨Ø§Øª'
            : 'Registration health and account reports',
        icon: Icons.fact_check_outlined,
        group: AdminVisualGroup.system,
        route: Routes.adminRegistrationMaintenance,
      ),
    ];

    final governanceActions = <_AdminQuickActionItem>[
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

    final detailSections = <_AdminDetailPanelSection>[
      _AdminDetailPanelSection(
        title: isArabic ? 'Ø§Ù„Ù…Ø³Ø§Ø±Ø§Øª Ø§Ù„Ù…ÙˆØ¬Ù‘Ù‡Ø©' : 'Guided Workflows',
        subtitle: isArabic
            ? 'Ù…Ø³Ø§Ø±Ø§Øª Ù…Ø±Ø§Ø¬Ø¹Ø© Ù…ÙˆØ¬Ù‘Ù‡Ø© Ù…ØªØ§Ø­Ø© Ø¯ÙˆÙ† ØªÙ…Ø¯ÙŠØ¯ Ø§Ù„Ù‡Ø¨ Ø§Ù„Ø±Ø¦ÙŠØ³ÙŠ.'
            : 'Guided review paths kept available without stretching the main hub.',
        icon: Icons.route_outlined,
        route: Routes.adminGuidedWorkflows,
      ),
      _AdminDetailPanelSection(
        title: isArabic ? 'Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹' : 'References',
        subtitle: isArabic
            ? 'ØµÙØ­Ø§Øª Ø§Ù„Ù…Ø±Ø§Ø¬Ø¹ ÙˆØ§Ø®ØªØµØ§Ø±Ø§Øª Ø§Ù„Ø³ÙŠØ§Ø³Ø§Øª Ù…Ø­ÙÙˆØ¸Ø© Ø£Ø³ÙÙ„ Ø§Ù„ØµÙØ­Ø©.'
            : 'Reference pages and policy shortcuts kept below the fold.',
        icon: Icons.menu_book_outlined,
        route: Routes.adminReferences,
      ),
      _AdminDetailPanelSection(
        title: isArabic ? 'Ø·Ø¨Ù‚Ø© Ø§Ù„Ø¨ÙˆØ§Ø¨Ø§Øª' : 'Gateway Layer',
        subtitle: isArabic
            ? 'Ø­Ø§Ù„Ø© Ø§Ù„Ø¨ÙˆØ§Ø¨Ø§Øª ÙˆØªÙØ§ØµÙŠÙ„ Ø§Ù„Ø§ØªØµØ§Ù„ ÙÙŠ Ù‚Ø³Ù… Ù…Ø®ØªØµØ±.'
            : 'Gateway status and connectivity details in a condensed section.',
        icon: Icons.hub_outlined,
        route: Routes.adminGatewayLayer,
      ),
      _AdminDetailPanelSection(
        title: isArabic ? 'Ù…ØªØ§Ø¨Ø¹Ø© ØªÙØµÙŠÙ„ÙŠØ©' : 'Detailed Monitoring',
        subtitle: isArabic
            ? 'Ø§Ù„ØªÙ†Ø¨ÙŠÙ‡Ø§Øª ÙˆØ§Ù„ØµØ­Ø© ÙˆØ¥Ø´Ø§Ø±Ø§Øª Ø§Ù„Ø¨ÙˆØ§Ø¨Ø§Øª ÙÙŠ Ù‚Ø³Ù… ÙˆØ§Ø­Ø¯ Ù‚Ø§Ø¨Ù„ Ù„Ù„Ø·ÙŠ.'
            : 'Alerts, health, and gateway signals in one collapsible section.',
        icon: Icons.monitor_heart_outlined,
        route: Routes.adminDetailedMonitoring,
      ),
      _AdminDetailPanelSection(
        title: isArabic ? 'ØªÙØ§ØµÙŠÙ„ Ø§Ù„ØªØ­Ù„ÙŠÙ„Ø§Øª' : 'Analytics Details',
        subtitle: isArabic
            ? 'ØªØ­Ù„ÙŠÙ„Ø§Øª Ø§Ù„Ø³Ù„ÙˆÙƒ ÙˆØ§Ù„Ù…Ø±Ø§Ù‚Ø¨Ø© Ù…ØªØ§Ø­Ø© Ø¯ÙˆÙ† ØªÙ…Ø¯ÙŠØ¯ Ø§Ù„ØµÙØ­Ø© Ø§Ù„Ø±Ø¦ÙŠØ³ÙŠØ©.'
            : 'Behavior and monitoring analytics kept available without stretching the main page.',
        icon: Icons.analytics_outlined,
        route: Routes.adminAnalyticsDetails,
      ),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF11161A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 52,
          automaticallyImplyLeading: false,
          titleSpacing: AppSpacing.sm,
          title: const SizedBox.shrink(),
          actions: [
            _AdminHubTopButton(
              label: isArabic ? 'Ø§Ù„Ù‚Ø§Ø¦Ù…Ø©' : 'Back to Menu',
              icon: Icons.grid_view_rounded,
              onPressed: () => _backToMenu(context),
            ),
            const SizedBox(width: 8),
            _AdminHubTopButton(
              label: isArabic ? 'ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø®Ø±ÙˆØ¬' : 'Logout',
              icon: Icons.logout_rounded,
              onPressed: () => _logout(context),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ),
        body: Container(
          color: const Color(0xFF0D1114),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.adminControlRoomBackground,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: const Color(0x66000000)),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final sideInset = width >= 960 ? 40.0 : 0.0;

                  return ListView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      2,
                      AppSpacing.sm,
                      0,
                    ),
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: EdgeInsets.only(right: sideInset),
                              child: width >= 960
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        _AdminHeaderShortcutBar(
                                          isArabic: isArabic,
                                          governanceActions: governanceActions,
                                          entryActions: mainSectionCards,
                                        ),
                                        const SizedBox(height: 18),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.52,
                                            child: _AdminDepartmentSection(
                                              isArabic: isArabic,
                                              cards: departmentSectionCards,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.52,
                                            child: _AdminTitledLaunchpad(
                                              title: isArabic
                                                  ? 'Ù…ØªØ§Ø¨Ø¹Ø© Ø§Ù„ØªØ³Ø¬ÙŠÙ„Ø§Øª ÙˆØ§Ù„Ø­Ø³Ø§Ø¨Ø§Øª'
                                                  : 'Registration & Account Follow-up',
                                              cards: registrationSectionCards,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : _AdminHeaderShortcutBar(
                                      isArabic: isArabic,
                                      governanceActions: governanceActions,
                                      entryActions: mainSectionCards,
                                    ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.only(left: sideInset),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _AdminHomeCountersSection(
                                    isArabic: isArabic,
                                    cards: compactCounters,
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18),
                                    child: _AdminFixedDetailPanel(
                                      isArabic: isArabic,
                                      sections: detailSections,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: width >= 960 ? 12 : 48),
                      if (width >= 960) const SizedBox(height: AppSpacing.sm),
                      if (width < 960)
                        _AdminDepartmentSection(
                          isArabic: isArabic,
                          cards: departmentSectionCards,
                        ),
                      if (width < 960) ...[
                        const SizedBox(height: 14),
                        _AdminTitledLaunchpad(
                          title: isArabic
                              ? 'Ù…ØªØ§Ø¨Ø¹Ø© Ø§Ù„ØªØ³Ø¬ÙŠÙ„Ø§Øª ÙˆØ§Ù„Ø­Ø³Ø§Ø¨Ø§Øª'
                              : 'Registration & Account Follow-up',
                          cards: registrationSectionCards,
                        ),
                      ],
                      const SizedBox(height: 2),
                      // This stream is intentionally left build-scoped for now;
                      // moving it needs a lifecycle refactor outside this cleanup.
                      _SystemAdvisoryCard(
                        advisoryStream: _systemAdvisoryStream(),
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

class _AdminDetailPanelSection {
  const _AdminDetailPanelSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.route,
    // ignore: unused_element_parameter
    this.missingRouteTodo,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? route;
  final String? missingRouteTodo;
}

class _AdminHubTopButton extends StatelessWidget {
  const _AdminHubTopButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 17),
      label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFE8D7A5),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(
            color: const Color(0xFFE0C174).withValues(alpha: 0.42),
          ),
        ),
        backgroundColor: const Color(0xFF11191E).withValues(alpha: 0.72),
      ),
    );
  }
}

class _AdminFixedDetailPanel extends StatelessWidget {
  const _AdminFixedDetailPanel({
    required this.isArabic,
    required this.sections,
  });

  final bool isArabic;
  final List<_AdminDetailPanelSection> sections;

  @override
  Widget build(BuildContext context) {
    final rows = [
      sections.take(3).toList(),
      sections.skip(3).take(2).toList(),
    ];

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int index = 0; index < rows.length; index++) ...[
            Transform.translate(
              offset: index == 1 ? const Offset(-56, 0) : Offset.zero,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection:
                    index == 1 ? TextDirection.ltr : TextDirection.rtl,
                children: [
                  for (int itemIndex = 0;
                      itemIndex < rows[index].length;
                      itemIndex++) ...[
                    _AdminDetailNavigationPill(section: rows[index][itemIndex]),
                    if (itemIndex != rows[index].length - 1)
                      const SizedBox(width: 4),
                  ],
                ],
              ),
            ),
            if (index != rows.length - 1) const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}

class _AdminDetailNavigationPill extends StatelessWidget {
  const _AdminDetailNavigationPill({
    required this.section,
  });

  final _AdminDetailPanelSection section;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: section.subtitle,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () {
          final route = section.route;
          if (route != null) {
            Navigator.of(context).pushNamed(route);
            return;
          }
          _showControlRoomSnackBar(
            context,
            section.missingRouteTodo ?? 'TODO: Add a dedicated route.',
          );
        },
        child: SizedBox(
          width: 112,
          height: 92,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF182126),
                  border: Border.all(
                    color: const Color(0xFFE0C174).withValues(alpha: 0.44),
                    width: 1.4,
                  ),
                  boxShadow: [
                    ...AppShadows.card,
                    BoxShadow(
                      color: const Color(0xFFE0C174).withValues(alpha: 0.20),
                      blurRadius: 16,
                      spreadRadius: 0.4,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF11191E),
                      border: Border.all(
                        color: const Color(0xFFE0C174).withValues(alpha: 0.50),
                        width: 1.1,
                      ),
                    ),
                    child: Icon(
                      section.icon,
                      color: const Color(0xFFE0C174),
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 104,
                child: Text(
                  section.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFF8EDD3),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    height: 1.08,
                  ),
                ),
              ),
            ],
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

class _AdminHeaderShortcutBar extends StatelessWidget {
  const _AdminHeaderShortcutBar({
    required this.isArabic,
    required this.governanceActions,
    required this.entryActions,
  });

  final bool isArabic;
  final List<_AdminQuickActionItem> governanceActions;
  final List<_AdminSectionLaunchCardData> entryActions;

  @override
  Widget build(BuildContext context) {
    final shortcuts = <Widget>[
      _AdminGovernanceToolsButton(
        isArabic: isArabic,
        actions: governanceActions,
      ),
      for (final action in entryActions)
        _AdminHeaderEntryShortcut(item: action),
    ];
    final rows = [
      shortcuts.take(3).toList(),
      shortcuts.skip(3).take(3).toList(),
      shortcuts.skip(6).take(2).toList(),
    ];

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (int rowIndex = 0; rowIndex < rows.length; rowIndex++) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  for (int index = 0;
                      index < rows[rowIndex].length;
                      index++) ...[
                    rows[rowIndex][index],
                    if (index != rows[rowIndex].length - 1)
                      const SizedBox(width: 10),
                  ],
                ],
              ),
              if (rowIndex != rows.length - 1) const SizedBox(height: 9),
            ],
          ],
        ),
      ),
    );
  }
}

class _AdminHeaderEntryShortcut extends StatelessWidget {
  const _AdminHeaderEntryShortcut({
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
          width: 112,
          height: 96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF182126),
                  border: Border.all(
                    color: const Color(0xFFE0C174).withValues(alpha: 0.44),
                    width: 1.4,
                  ),
                  boxShadow: [
                    ...AppShadows.card,
                    BoxShadow(
                      color: const Color(0xFFE0C174).withValues(alpha: 0.20),
                      blurRadius: 16,
                      spreadRadius: 0.4,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF11191E),
                      border: Border.all(
                        color: const Color(0xFFE0C174).withValues(alpha: 0.50),
                        width: 1.1,
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
              const SizedBox(height: 2),
              Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFF8EDD3),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  height: 1.12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminGovernanceToolsButton extends StatelessWidget {
  const _AdminGovernanceToolsButton({
    required this.isArabic,
    required this.actions,
  });

  final bool isArabic;
  final List<_AdminQuickActionItem> actions;

  void _showTools(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: const Color(0xFF10161A),
                borderRadius: BorderRadius.circular(AppRadii.lg),
                border: Border.all(
                  color: const Color(0xFFD8B26A).withValues(alpha: 0.24),
                ),
                boxShadow: AppShadows.card,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'Ø£Ø¯ÙˆØ§Øª Ø§Ù„Ø­ÙˆÙƒÙ…Ø©' : 'Governance Tools',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFF1E5C8),
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final action in actions)
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        action.icon,
                        color: _adminVisualGroupColor(action.group),
                      ),
                      title: Text(
                        action.label,
                        style: const TextStyle(
                          color: Color(0xFFF1E5C8),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFD8B26A),
                        size: 14,
                      ),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        Navigator.of(context).pushNamed(action.route);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isArabic ? 'Ø£Ø¯ÙˆØ§Øª Ø§Ù„Ø­ÙˆÙƒÙ…Ø©' : 'Governance Tools',
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showTools(context),
        child: SizedBox(
          width: 112,
          height: 96,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF182126),
                  border: Border.all(
                    color: const Color(0xFFE0C174).withValues(alpha: 0.44),
                    width: 1.4,
                  ),
                  boxShadow: [
                    ...AppShadows.card,
                    BoxShadow(
                      color: const Color(0xFFE0C174).withValues(alpha: 0.20),
                      blurRadius: 16,
                      spreadRadius: 0.4,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF11191E),
                      border: Border.all(
                        color: const Color(0xFFE0C174).withValues(alpha: 0.50),
                        width: 1.1,
                      ),
                    ),
                    child: const Icon(
                      Icons.admin_panel_settings_outlined,
                      color: Color(0xFFE0C174),
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isArabic ? 'Ø£Ø¯ÙˆØ§Øª Ø§Ù„Ø­ÙˆÙƒÙ…Ø©' : 'Governance Tools',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFF8EDD3),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  height: 1.12,
                ),
              ),
            ],
          ),
        ),
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
    final rows = [
      cards.take(3).toList(),
      cards.skip(3).take(3).toList(),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 16) / 3;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int rowIndex = 0; rowIndex < rows.length; rowIndex++) ...[
                Row(
                  textDirection: Directionality.of(context),
                  children: [
                    for (int index = 0;
                        index < rows[rowIndex].length;
                        index++) ...[
                      SizedBox(
                        width: itemWidth,
                        child: _AdminSectionLaunchCard(
                          item: rows[rowIndex][index],
                        ),
                      ),
                      if (index != rows[rowIndex].length - 1)
                        const SizedBox(width: 8),
                    ],
                  ],
                ),
                if (rowIndex != rows.length - 1) const SizedBox(height: 4),
              ],
            ],
          );
        },
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
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF182126),
                  border: Border.all(
                    color: const Color(0xFFE0C174).withValues(alpha: 0.44),
                    width: 1.6,
                  ),
                  boxShadow: [
                    ...AppShadows.card,
                    BoxShadow(
                      color: const Color(0xFFE0C174).withValues(alpha: 0.22),
                      blurRadius: 18,
                      spreadRadius: 0.6,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF11191E),
                      border: Border.all(
                        color: const Color(0xFFE0C174).withValues(alpha: 0.54),
                        width: 1.25,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withValues(alpha: 0.18),
                          border: Border.all(
                            color:
                                const Color(0xFF54A997).withValues(alpha: 0.34),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          item.icon,
                          color: color,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: double.infinity,
                child: Text(
                  item.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFE0C174),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdminDepartmentSection extends StatelessWidget {
  const _AdminDepartmentSection({
    required this.isArabic,
    required this.cards,
  });

  final bool isArabic;
  final List<_AdminSectionLaunchCardData> cards;

  @override
  Widget build(BuildContext context) {
    return _AdminSectionLaunchpad(cards: cards);
  }
}

class _AdminTitledLaunchpad extends StatelessWidget {
  const _AdminTitledLaunchpad({
    required this.title,
    required this.cards,
  });

  final String title;
  final List<_AdminSectionLaunchCardData> cards;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Column(
      crossAxisAlignment:
          isRtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            title,
            textAlign: isRtl ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              color: Color(0xFFE8D7A5),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 8),
        _AdminSectionLaunchpad(cards: cards),
      ],
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
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
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
                              color: const Color(0xFFD6D8DA)
                                  .withValues(alpha: 0.84),
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'This is an informational advisory. No actions are blocked.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFFD6D8DA)
                                  .withValues(alpha: 0.72),
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
      padding: const EdgeInsets.only(left: 18, top: 8, bottom: 2),
      child: Align(
        alignment: Alignment.topLeft,
        child: _buildCounterWrap(0, const []),
      ),
    );
  }

  Widget _buildCounterWrap(int index, List<int> counts) {
    if (index >= cards.length) {
      final maxCount =
          counts.isEmpty ? 0 : counts.reduce((a, b) => a > b ? a : b);
      final counterRows = [
        cards.take(4).toList(),
        cards.skip(4).take(4).toList(),
        cards.skip(8).take(3).toList(),
      ];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int rowIndex = 0; rowIndex < counterRows.length; rowIndex++) ...[
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  for (int i = 0; i < counterRows[rowIndex].length; i++) ...[
                    _QuickStatCard(
                      item: counterRows[rowIndex][i],
                      isArabic: isArabic,
                      maxCount: maxCount,
                    ),
                    if (i != counterRows[rowIndex].length - 1)
                      const SizedBox(width: 4),
                  ],
                ],
              ),
            ),
            if (rowIndex != counterRows.length - 1) const SizedBox(height: 4),
          ],
        ],
      );
    }

    final card = cards[index];
    if (card.staticCount != null) {
      return _buildCounterWrap(
        index + 1,
        [...counts, card.staticCount!],
      );
    }

    return StreamBuilder<int>(
      stream: card.stream!,
      builder: (context, snapshot) {
        return _buildCounterWrap(
          index + 1,
          [...counts, snapshot.data ?? 0],
        );
      },
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

class _QuickStatItem {
  final String title;
  final AdminVisualGroup? group;
  final Stream<int>? stream;
  final int? staticCount;
  final Stream<int>? crossSignalStream;
  final String route;

  const _QuickStatItem({
    required this.title,
    this.group,
    this.stream,
    this.staticCount,
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
    Widget buildCounterContent({
      required bool waiting,
      required bool hasError,
      required int? count,
    }) {
      final isOpenRequestsCounter = item.group == AdminVisualGroup.requests;
      final isSessionReadinessCounter = item.group == AdminVisualGroup.sessions;
      final isHumanReviewCounter = item.group == AdminVisualGroup.support;
      final isGatewaySignalsCounter = item.group == AdminVisualGroup.system;
      final openRequestsCountText =
          hasError ? 'â€”' : (waiting ? '...' : '${count ?? 0}');
      final countText = hasError ? '!' : (count == null ? 'â€”' : '$count');
      final humanReviewCountText =
          hasError ? 'â€”' : (waiting ? '...' : '${count ?? 0}');
      final sessionReadinessCountText =
          hasError ? 'â€”' : (waiting ? '...' : '${count ?? 0}');
      final gatewaySignalsCountText =
          hasError ? 'â€”' : (waiting ? '...' : '${count ?? 0}');
      final statusText = hasError
          ? (isArabic ? 'ÙØ´Ù„ Ø§Ù„ØªØ­Ù…ÙŠÙ„' : 'Load failed')
          : (waiting ? (isArabic ? 'Ø¬Ø§Ø±Ù Ø§Ù„ØªØ­Ø¯ÙŠØ«' : 'Updating') : item.title);
      final displayCountText = isOpenRequestsCounter
          ? openRequestsCountText
          : (isSessionReadinessCounter
              ? sessionReadinessCountText
              : (isHumanReviewCounter
                  ? humanReviewCountText
                  : (isGatewaySignalsCounter
                      ? gatewaySignalsCountText
                      : countText)));
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
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).pushNamed(item.route),
        child: SizedBox(
          width: 90,
          height: 104,
          child: item.staticCount != null
              ? buildCounterContent(
                  waiting: false,
                  hasError: false,
                  count: item.staticCount,
                )
              : StreamBuilder<int>(
                  stream: item.stream!,
                  builder: (context, snapshot) {
                    final waiting =
                        snapshot.connectionState == ConnectionState.waiting &&
                            !snapshot.hasData;
                    return buildCounterContent(
                      waiting: waiting,
                      hasError: snapshot.hasError,
                      count: snapshot.data,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
