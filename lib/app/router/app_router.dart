import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/core/auth/presentation/pages/account_blocked_page.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

import 'routes.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_register_portal_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_profile_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_media_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_pricing_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_documents_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_clinician_profile_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_clinician_documents_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_registration_success_page.dart';
import 'package:flutterprojects/features/web_portal/presentation/pages/portal_skeleton_pages.dart';
import 'package:flutterprojects/features/s_capital/presentation/pages/s_admin_operations_office_page.dart';
import 'package:flutterprojects/features/s_capital/presentation/pages/s_signal_control_room_page.dart';
import 'package:flutterprojects/features/s_city/presentation/pages/s_city_district_page.dart';
import 'package:flutterprojects/features/s_owner/presentation/pages/s_owner_district_page.dart';
import 'package:flutterprojects/features/s_web_surfaces/presentation/pages/s_web_surface_pages.dart';
import 'package:flutterprojects/features/s_personal_space/presentation/pages/s_personal_space_page.dart';

import 'package:flutterprojects/features/booking/presentation/pages/clinician_inbox_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_inbox_page.dart';

import 'package:flutterprojects/features/library/presentation/pages/library_page.dart';
import 'package:flutterprojects/features/library/presentation/pages/library_policy_page.dart';
import 'package:flutterprojects/features/splash/presentation/pages/splash_page.dart';
import 'package:flutterprojects/features/language/presentation/pages/language_page.dart';
import 'package:flutterprojects/features/modules/presentation/pages/module_placeholder_page.dart';
import 'package:flutterprojects/features/modules/presentation/pages/support_entry_page.dart';
import 'package:flutterprojects/features/modules/presentation/pages/support_issue_selector_page.dart';
import 'package:flutterprojects/features/home/presentation/pages/menu_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialists_categories_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialists_list_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialist_details_page.dart';
import 'package:flutterprojects/features/auth/presentation/pages/login_page.dart';
import 'package:flutterprojects/features/auth/presentation/pages/client_register_page.dart';
import 'package:flutterprojects/features/external_follow_up/presentation/pages/follow_up_registration_page.dart';
import 'package:flutterprojects/features/external_follow_up/presentation/pages/external_follow_up_workspace_page.dart';
import 'package:flutterprojects/features/external_follow_up/presentation/pages/follow_up_templates_page.dart';
import 'package:flutterprojects/features/external_follow_up/presentation/pages/follow_up_campaigns_page.dart';
import 'package:flutterprojects/features/external_follow_up/presentation/pages/follow_up_campaign_details_page.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_campaign.dart';
import 'package:flutterprojects/features/chat/presentation/pages/chat_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/chat_escalations_page.dart';
import 'package:flutterprojects/features/chat/presentation/pages/chat_escalation_report_page.dart';
import 'package:flutterprojects/features/chat/presentation/pages/clinician_chat_inbox_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/centers_landing_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/centers_list_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_details_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_center_details_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_centers_page.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_hub_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_control_room_placeholder_pages.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_blueprint_handoff_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_clients_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_registration_maintenance_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_clinician_workspace_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_content_care_programs_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_ai_followup_boundaries_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_ai_devops_center_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_ai_policy_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_compliance_checkpoints_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_domain_status_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_domain_availability_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_employee_system_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_functional_workspaces_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_maintenance_system_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/customer_follow_up_workspace_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_library_governance_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/marketing_workspace_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_exposure_rules_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_gateway_layer_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_growth_layer_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/technical_support_workspace_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_workspace_command_center_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/content_workspace_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_support_messaging_governance_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_communication_gateway_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_engineering_gateway_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_device_storage_gateway_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_followup_care_governance_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_activation_readiness_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_system_activation_pack_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_operations_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_communications_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_archive_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_alerts_review_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_centers_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_clinicians_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_archive_support_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_archive_reports_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_clinician_profile_requests_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_clinician_requests_page.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_support_chat_page.dart';
import 'package:flutterprojects/features/clinician/presentation/pages/clinician_operations_page.dart';
import 'package:flutterprojects/features/client/presentation/pages/client_dashboard_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_dashboard_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_operations_page.dart';

const String _roleAdmin = 'admin';
const String _roleClinician = 'clinician';
const String _roleCenter = 'center';
const String _roleClient = 'client';

class AppRouter {
  static const Set<String> _adminOnlyRoutes = {
    Routes.adminHub,
    Routes.adminOperations,
    Routes.adminCommunications,
    Routes.adminClinicianRequests,
    Routes.adminClinicianWorkspace,
    Routes.adminClinicianProfileRequests,
    Routes.adminClients,
    Routes.adminRegistrationMaintenance,
    Routes.adminSupportChats,
    Routes.adminAlertsReview,
    Routes.adminAiPolicies,
    Routes.adminDomainStatus,
    Routes.adminDomainAvailability,
    Routes.adminFunctionalWorkspaces,
    Routes.externalFollowUpWorkspace,
    Routes.followUpTemplates,
    Routes.followUpCampaigns,
    Routes.followUpCampaignDetails,
    Routes.customerFollowUpWorkspace,
    Routes.technicalSupportWorkspace,
    Routes.marketingWorkspace,
    Routes.adminContentCarePrograms,
    Routes.adminLibraryGovernance,
    Routes.adminSupportMessagingGovernance,
    Routes.adminFollowupCareGovernance,
    Routes.adminAiFollowupBoundaries,
    Routes.adminGrowthLayer,
    Routes.adminAiDevOpsCenter,
    Routes.adminWorkspaceCommandCenter,
    Routes.contentWorkspace,
    Routes.adminGuidedWorkflows,
    Routes.adminReferences,
    Routes.adminDetailedMonitoring,
    Routes.adminAnalyticsDetails,
    Routes.adminBlueprintHandoff,
    Routes.adminComplianceCheckpoints,
    Routes.adminExposureRules,
    Routes.adminActivationReadiness,
    Routes.adminSystemActivationPack,
    Routes.adminGatewayLayer,
    Routes.adminCommunicationGateway,
    Routes.adminEngineeringGateway,
    Routes.adminDeviceStorageGateway,
    Routes.adminArchive,
    Routes.adminArchiveReports,
    Routes.adminArchiveClinicians,
    Routes.adminArchiveCenters,
    Routes.adminArchiveSupport,
    Routes.adminCenters,
    Routes.adminCenterDetails,
    Routes.chatEscalations,
    Routes.chatEscalationReport,
  };

  static const Set<String> _clinicianOnlyRoutes = {
    Routes.clinicianOperations,
    Routes.clinicianProfileEditRequest,
    Routes.clinicianInbox,
    Routes.clinicianChatInbox,
    Routes.clinicianChatInboxLegacy,
  };

  static const Set<String> _centerOnlyRoutes = {
    Routes.centerDashboard,
    Routes.centerOperations,
    Routes.centerProfileEditRequest,
    Routes.centerInbox,
  };

  static const Set<String> _clientOnlyRoutes = {
    Routes.sPersonalSpace,
    Routes.clientDashboard,
  };

  static bool _isAdminRoute(String? routeName) {
    if (routeName == null) return false;
    return _adminOnlyRoutes.contains(routeName);
  }

  static bool _requiresSignedInNonAnonymous(RouteSettings settings) {
    if (_isAdminRoute(settings.name)) {
      return true;
    }

    switch (settings.name) {
      case Routes.centerDashboard:
      case Routes.centerOperations:
      case Routes.centerProfileEditRequest:
      case Routes.centerInbox:
      case Routes.clinicianOperations:
      case Routes.clinicianProfileEditRequest:
      case Routes.clinicianInbox:
      case Routes.clinicianChatInbox:
      case Routes.clinicianChatInboxLegacy:
      case Routes.blockedAccount:
      case Routes.clientDashboard:
      case Routes.sPersonalSpace:
        return true;
      default:
        return false;
    }
  }

  static Set<String>? _requiredRoles(String? routeName) {
    if (routeName == null) return null;
    if (_isAdminRoute(routeName)) return {_roleAdmin};
    if (_clinicianOnlyRoutes.contains(routeName)) return {_roleClinician};
    if (_centerOnlyRoutes.contains(routeName)) return {_roleCenter};
    if (_clientOnlyRoutes.contains(routeName)) return {_roleClient};
    return null;
  }

  static Route<dynamic> _redirectToLogin(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const LoginPage(),
      settings: const RouteSettings(name: Routes.login),
    );
  }

  static String? _libraryCategoryKey(RouteSettings settings) {
    final args = settings.arguments;
    if (args is Map) {
      final value = args['categoryKey'];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return null;
  }

  static Route<dynamic> _protectedRoute({
    required Widget child,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      builder: (_) => _RouteAccessGate(
        routeName: settings.name,
        allowedRoles: _requiredRoles(settings.name),
        child: child,
      ),
      settings: settings,
    );
  }

  static Route<dynamic> _adminProtectedRoute({
    required Widget child,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      builder: (_) => _RouteAccessGate(
        routeName: settings.name,
        allowedRoles: const {_roleAdmin},
        child: child,
      ),
      settings: settings,
    );
  }

  static Route<dynamic>? adminSurfaceRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.adminHub:
        return _adminProtectedRoute(
          child: const AdminHubPage(),
          settings: settings,
        );

      case Routes.adminClinicianRequests:
        return _adminProtectedRoute(
          child: const AdminClinicianRequestsPage(),
          settings: settings,
        );

      case Routes.adminClinicianWorkspace:
        return _adminProtectedRoute(
          child: const AdminClinicianWorkspacePage(),
          settings: settings,
        );

      case Routes.adminOperations:
        return _adminProtectedRoute(
          child: const AdminOperationsPage(),
          settings: settings,
        );

      case Routes.adminCommunications:
        return _adminProtectedRoute(
          child: const AdminCommunicationsPage(),
          settings: settings,
        );

      case Routes.adminClinicianProfileRequests:
        return _adminProtectedRoute(
          child: const AdminClinicianProfileRequestsPage(),
          settings: settings,
        );

      case Routes.adminClients:
        return _adminProtectedRoute(
          child: const AdminClientsPage(),
          settings: settings,
        );

      case Routes.adminRegistrationMaintenance:
        return _adminProtectedRoute(
          child: const AdminRegistrationMaintenancePage(),
          settings: settings,
        );

      case Routes.adminSupportChats:
        return _adminProtectedRoute(
          child: const AdminSupportChatPage(),
          settings: settings,
        );

      case Routes.adminAiPolicies:
        return _adminProtectedRoute(
          child: const AdminAiPolicyPage(),
          settings: settings,
        );

      case Routes.adminDomainStatus:
        return _adminProtectedRoute(
          child: const AdminDomainStatusPage(),
          settings: settings,
        );

      case Routes.adminDomainAvailability:
        return _adminProtectedRoute(
          child: const AdminDomainAvailabilityPage(),
          settings: settings,
        );

      case Routes.adminFunctionalWorkspaces:
        return _adminProtectedRoute(
          child: const AdminFunctionalWorkspacesPage(),
          settings: settings,
        );

      case Routes.externalFollowUpWorkspace:
        return _adminProtectedRoute(
          child: const ExternalFollowUpWorkspacePage(),
          settings: settings,
        );

      case Routes.followUpTemplates:
        return _adminProtectedRoute(
          child: const FollowUpTemplatesPage(),
          settings: settings,
        );

      case Routes.followUpCampaigns:
        return _adminProtectedRoute(
          child: const FollowUpCampaignsPage(),
          settings: settings,
        );

      case Routes.followUpCampaignDetails:
        final args = settings.arguments;
        if (args is! FollowUpCampaign) {
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(ctx)!.routeNotFound),
              ),
            ),
            settings: settings,
          );
        }
        return _adminProtectedRoute(
          child: FollowUpCampaignDetailsPage(campaign: args),
          settings: settings,
        );

      case Routes.customerFollowUpWorkspace:
        return _adminProtectedRoute(
          child: const CustomerFollowUpWorkspacePage(),
          settings: settings,
        );

      case Routes.technicalSupportWorkspace:
        return _adminProtectedRoute(
          child: const TechnicalSupportWorkspacePage(),
          settings: settings,
        );

      case Routes.marketingWorkspace:
        return _adminProtectedRoute(
          child: const MarketingWorkspacePage(),
          settings: settings,
        );

      case Routes.adminContentCarePrograms:
        return _adminProtectedRoute(
          child: const AdminContentCareProgramsPage(),
          settings: settings,
        );

      case Routes.adminLibraryGovernance:
        return _adminProtectedRoute(
          child: const AdminLibraryGovernancePage(),
          settings: settings,
        );

      case Routes.adminSupportMessagingGovernance:
        return _adminProtectedRoute(
          child: const AdminSupportMessagingGovernancePage(),
          settings: settings,
        );

      case Routes.adminFollowupCareGovernance:
        return _adminProtectedRoute(
          child: const AdminFollowupCareGovernancePage(),
          settings: settings,
        );

      case Routes.adminAiFollowupBoundaries:
        return _adminProtectedRoute(
          child: const AdminAiFollowupBoundariesPage(),
          settings: settings,
        );

      case Routes.adminGrowthLayer:
        return _adminProtectedRoute(
          child: const AdminGrowthLayerPage(),
          settings: settings,
        );

      case Routes.adminEmployeeSystem:
        return _adminProtectedRoute(
          child: const AdminEmployeeSystemPage(),
          settings: settings,
        );

      case Routes.adminMaintenanceSystem:
        return _adminProtectedRoute(
          child: const AdminMaintenanceSystemPage(),
          settings: settings,
        );

      case Routes.adminAiDevOpsCenter:
        return _adminProtectedRoute(
          child: const AdminAiDevOpsCenterPage(),
          settings: settings,
        );

      case Routes.adminWorkspaceCommandCenter:
        return _adminProtectedRoute(
          child: const AdminWorkspaceCommandCenterPage(),
          settings: settings,
        );

      case Routes.contentWorkspace:
        return _adminProtectedRoute(
          child: const ContentWorkspacePage(),
          settings: settings,
        );

      case Routes.adminGuidedWorkflows:
        return _adminProtectedRoute(
          child: const AdminGuidedWorkflowsPage(),
          settings: settings,
        );

      case Routes.adminReferences:
        return _adminProtectedRoute(
          child: const AdminReferencesPage(),
          settings: settings,
        );

      case Routes.adminDetailedMonitoring:
        return _adminProtectedRoute(
          child: const AdminDetailedMonitoringPage(),
          settings: settings,
        );

      case Routes.adminAnalyticsDetails:
        return _adminProtectedRoute(
          child: const AdminAnalyticsDetailsPage(),
          settings: settings,
        );

      case Routes.adminBlueprintHandoff:
        return _adminProtectedRoute(
          child: const AdminBlueprintHandoffPage(),
          settings: settings,
        );

      case Routes.adminComplianceCheckpoints:
        return _adminProtectedRoute(
          child: const AdminComplianceCheckpointsPage(),
          settings: settings,
        );

      case Routes.adminExposureRules:
        return _adminProtectedRoute(
          child: const AdminExposureRulesPage(),
          settings: settings,
        );

      case Routes.adminActivationReadiness:
        return _adminProtectedRoute(
          child: const AdminActivationReadinessPage(),
          settings: settings,
        );

      case Routes.adminSystemActivationPack:
        return _adminProtectedRoute(
          child: const AdminSystemActivationPackPage(),
          settings: settings,
        );

      case Routes.adminGatewayLayer:
        return _adminProtectedRoute(
          child: const AdminGatewayLayerPage(),
          settings: settings,
        );

      case Routes.adminCommunicationGateway:
        return _adminProtectedRoute(
          child: const AdminCommunicationGatewayPage(),
          settings: settings,
        );

      case Routes.adminEngineeringGateway:
        return _adminProtectedRoute(
          child: const AdminEngineeringGatewayPage(),
          settings: settings,
        );

      case Routes.adminDeviceStorageGateway:
        return _adminProtectedRoute(
          child: const AdminDeviceStorageGatewayPage(),
          settings: settings,
        );

      case Routes.adminAlertsReview:
        return _adminProtectedRoute(
          child: const AdminAlertsReviewPage(),
          settings: settings,
        );

      case Routes.adminArchiveClinicians:
        return _adminProtectedRoute(
          child: const AdminArchiveCliniciansPage(),
          settings: settings,
        );

      case Routes.adminArchiveCenters:
        return _adminProtectedRoute(
          child: const AdminArchiveCentersPage(),
          settings: settings,
        );

      case Routes.adminArchiveSupport:
        return _adminProtectedRoute(
          child: const AdminArchiveSupportPage(),
          settings: settings,
        );

      case Routes.adminArchiveReports:
        return _adminProtectedRoute(
          child: const AdminArchiveReportsPage(),
          settings: settings,
        );

      case Routes.adminArchive:
        return _adminProtectedRoute(
          child: const AdminArchivePage(),
          settings: settings,
        );

      default:
        return null;
    }
  }

  static Route<dynamic> _sWebSurfaceRoute({
    required RouteSettings settings,
    required String surfaceName,
    required String surfaceType,
    required String description,
    required List<String> items,
  }) {
    return MaterialPageRoute(
      builder: (_) => SWebSurfacePage(
        surfaceName: surfaceName,
        surfaceType: surfaceType,
        routeName: settings.name ?? '',
        description: description,
        items: items,
      ),
      settings: settings,
    );
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final needsNonAnonymous = _requiresSignedInNonAnonymous(settings);
    if (needsNonAnonymous && (currentUser == null || currentUser.isAnonymous)) {
      return _redirectToLogin(settings);
    }

    final adminSurfaceRoute = adminSurfaceRoutes(settings);
    if (adminSurfaceRoute != null) {
      return adminSurfaceRoute;
    }

    switch (settings.name) {
      case Routes.sIndex:
        return MaterialPageRoute(
          builder: (_) => const SSurfaceIndexPage(),
          settings: settings,
        );

      case Routes.sPersonalSpace:
        return _protectedRoute(
          child: const SPersonalSpacePage(),
          settings: settings,
        );

      case Routes.sCityHome:
        return MaterialPageRoute(
          builder: (_) => const SCityDistrictPage(),
          settings: settings,
        );

      case Routes.sCityServices:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'City Services',
          surfaceType: 'Public City Web [S]',
          description:
              'Future public service catalog surface. This is not booking and does not submit operational requests.',
          items: const <String>[
            'Professional Services',
            'Education Services',
            'Marketing Services',
            'Technical Services',
          ],
        );

      case Routes.sCityTools:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'City Tools',
          surfaceType: 'Public City Web [S]',
          description:
              'Future public tool catalog for discoverable tools and destinations.',
          items: const <String>[
            'Support Tools',
            'Learning Tools',
            'Family Tools',
            'Provider Tools',
            'Center Tools',
          ],
        );

      case Routes.sCityLibrary:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'City Library',
          surfaceType: 'Public City Web [S]',
          description:
              'Future public knowledge and library discovery surface separated from the personal app room.',
          items: const <String>[
            'Public Knowledge',
            'Guides',
            'Exercises',
            'Videos',
            'Audio',
            'Saved destination targets',
          ],
        );

      case Routes.sCityProviders:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Provider Directory',
          surfaceType: 'Public City Web [S]',
          description:
              'Future provider discovery surface. Matching and personal recommendations remain outside this placeholder.',
          items: const <String>[
            'Provider Profiles',
            'Capability Labels',
            'Accessibility Labels',
            'Public Discovery',
          ],
        );

      case Routes.sCityCenters:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Center Directory',
          surfaceType: 'Public City Web [S]',
          description:
              'Future center and institution discovery surface without legacy booking movement.',
          items: const <String>[
            'Center Profiles',
            'Programs',
            'Capability Labels',
            'Accessibility Labels',
          ],
        );

      case Routes.sCityOrganizations:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Organization Directory',
          surfaceType: 'Public City Web [S]',
          description:
              'Future organizations surface for NGOs, community groups, institutions, and human impact networks.',
          items: const <String>[
            'NGOs',
            'Foundations',
            'Community Groups',
            'Educational Institutions',
            'Accessibility Organizations',
          ],
        );

      case Routes.sCityPrograms:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Programs',
          surfaceType: 'Public City Web [S]',
          description:
              'Future public program catalog for education, awareness, recovery, accessibility, and family support programs.',
          items: const <String>[
            'Education Programs',
            'Awareness Programs',
            'Recovery Programs',
            'Family Programs',
            'Accessibility Programs',
          ],
        );

      case Routes.sCityMarketplace:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Marketplace',
          surfaceType: 'Public City Web [S]',
          description:
              'Future marketplace surface for catalogs and service discovery. This placeholder does not create purchases, payments, or subscriptions.',
          items: const <String>[
            'Service Catalog',
            'Tool Catalog',
            'Course Catalog',
            'Professional Services',
          ],
        );

      case Routes.sCapitalHome:
        return MaterialPageRoute(
          builder: (_) => const SAdminOperationsOfficePage(),
          settings: settings,
        );

      case Routes.sCapitalAdminOffice:
        return MaterialPageRoute(
          builder: (_) => const SAdminOperationsOfficePage(
            focus: SCapitalOfficeFocus.adminOffice,
          ),
          settings: settings,
        );

      case Routes.sCapitalIncidents:
        return MaterialPageRoute(
          builder: (_) => const SAdminOperationsOfficePage(
            focus: SCapitalOfficeFocus.incidents,
          ),
          settings: settings,
        );

      case Routes.sCapitalMaintenance:
        return MaterialPageRoute(
          builder: (_) => const SAdminOperationsOfficePage(
            focus: SCapitalOfficeFocus.maintenance,
          ),
          settings: settings,
        );

      case Routes.sCapitalBroadcasts:
        return MaterialPageRoute(
          builder: (_) => const SAdminOperationsOfficePage(
            focus: SCapitalOfficeFocus.broadcasts,
          ),
          settings: settings,
        );

      case Routes.sCapitalEmergencyBrief:
        return MaterialPageRoute(
          builder: (_) => const SAdminOperationsOfficePage(
            focus: SCapitalOfficeFocus.emergencyBrief,
          ),
          settings: settings,
        );

      case Routes.sSignalControlRoom:
        return MaterialPageRoute(
          builder: (_) => const SSignalControlRoomPage(),
          settings: settings,
        );

      case Routes.sCapitalDepartments:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Departments',
          surfaceType: 'Administrative Capital Web [S]',
          description:
              'Future department operating surface for non-sovereign execution units.',
          items: const <String>[
            'Marketing Studio',
            'Technical Studio',
            'Education Services',
            'Provider Operations',
            'Center Operations',
            'Partnership Office',
          ],
        );

      case Routes.sTrustSafety:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Trust & Safety',
          surfaceType: 'Administrative Capital Web [S]',
          description:
              'Future trust, safety, complaints, and escalation monitoring surface. Not a legacy admin queue.',
          items: const <String>[
            'Safety Signals',
            'Complaint Patterns',
            'Escalation Visibility',
            'Policy References',
          ],
        );

      case Routes.sFollowUpContinuity:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Follow-up Continuity',
          surfaceType: 'Administrative Capital Web [S]',
          description:
              'Future continuity surface for non-diagnostic support follow-up signals and outreach visibility.',
          items: const <String>[
            'Continuity Signals',
            'Check-in Visibility',
            'Support Handoffs',
            'Human Review Notes',
          ],
        );

      case Routes.sCapitalReports:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Reports',
          surfaceType: 'Administrative Capital Web [S]',
          description:
              'Future reporting surface for department, signal, content, and operational reports.',
          items: const <String>[
            'Signal Reports',
            'Department Reports',
            'Content Reports',
            'Support Reports',
          ],
        );

      case Routes.sAdministrativeArchive:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Administrative Archive',
          surfaceType: 'Administrative Capital Web [S]',
          description:
              'Administrative memory surface for non-sovereign operational records and references.',
          items: const <String>[
            'Operational Records',
            'Reports Archive',
            'Incident References',
            'Department Memory',
          ],
        );

      case Routes.sOwnerHome:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(),
          settings: settings,
        );

      case Routes.sOwnerRoom:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.ownerRoom,
          ),
          settings: settings,
        );

      case Routes.sSovereignIntelligence:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.executiveIntelligence,
          ),
          settings: settings,
        );

      case Routes.sStrategicArchive:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.strategicArchive,
          ),
          settings: settings,
        );

      case Routes.sSovereignVault:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.sovereignVault,
          ),
          settings: settings,
        );

      case Routes.sConstitutionalMemory:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.constitutionalMemory,
          ),
          settings: settings,
        );

      case Routes.sRecoveryConsole:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.recoveryConsole,
          ),
          settings: settings,
        );

      case Routes.sOwnerCapsules:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.survivalCapsules,
          ),
          settings: settings,
        );

      case Routes.sOwnerRegeneration:
        return MaterialPageRoute(
          builder: (_) => const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.regenerationBoard,
          ),
          settings: settings,
        );

      case Routes.menu:
        return MaterialPageRoute(
          builder: (_) => const MenuPage(),
          settings: settings,
        );

      case Routes.portalHome:
        return MaterialPageRoute(
          builder: (_) => const PortalHomePage(),
          settings: settings,
        );

      case Routes.portalAbout:
        return MaterialPageRoute(
          builder: (_) => const PortalAboutPage(),
          settings: settings,
        );

      case Routes.portalLibrary:
        return MaterialPageRoute(
          builder: (_) => LibraryPage(
            initialCategoryKey: _libraryCategoryKey(settings),
            returnRoute: Routes.portalHome,
          ),
          settings: settings,
        );

      case Routes.portalProviderRegister:
        return MaterialPageRoute(
          builder: (_) => const WebClinicianRegisterPortalPage(),
          settings: settings,
        );

      case Routes.portalServiceRequest:
        return MaterialPageRoute(
          builder: (_) => const PortalServiceRequestPage(),
          settings: settings,
        );

      case Routes.portalPackageRequest:
        return MaterialPageRoute(
          builder: (_) => const PortalPackageRequestPage(),
          settings: settings,
        );

      case Routes.portalContact:
        return MaterialPageRoute(
          builder: (_) => const PortalContactPage(),
          settings: settings,
        );

      case Routes.clinicianOperations:
        return _protectedRoute(
          child: const ClinicianOperationsPage(),
          settings: settings,
        );

      case Routes.clinicianProfileEditRequest:
        return _protectedRoute(
          child: const ClinicianProfileEditRequestPage(),
          settings: settings,
        );

      case Routes.clientDashboard:
        return _protectedRoute(
          child: const ClientDashboardPage(),
          settings: settings,
        );

      case Routes.webCenterRegister:
        return MaterialPageRoute(
          builder: (_) => const WebCenterRegisterPortalPage(),
          settings: settings,
        );

      case Routes.webCenterProfile:
        return MaterialPageRoute(
          builder: (_) => const WebCenterProfilePage(),
          settings: settings,
        );

      case Routes.webCenterMedia:
        return MaterialPageRoute(
          builder: (_) => const WebCenterMediaPage(),
          settings: settings,
        );

      case Routes.webCenterPricing:
        return MaterialPageRoute(
          builder: (_) => const WebCenterPricingPage(),
          settings: settings,
        );

      case Routes.webCenterDocuments:
        return MaterialPageRoute(
          builder: (_) => const WebCenterDocumentsPage(),
          settings: settings,
        );

      case Routes.webRegistrationSuccess:
        return MaterialPageRoute(
          builder: (_) => const WebRegistrationSuccessPage(),
          settings: settings,
        );

      case Routes.webClinicianRegister:
        return MaterialPageRoute(
          builder: (_) => const WebClinicianRegisterPortalPage(),
          settings: settings,
        );

      case Routes.webClinicianProfile:
        return MaterialPageRoute(
          builder: (_) => const WebClinicianProfilePage(),
          settings: settings,
        );

      case Routes.webClinicianDocuments:
        return MaterialPageRoute(
          builder: (_) => const WebClinicianDocumentsPage(),
          settings: settings,
        );

      case Routes.webLibrary:
        return MaterialPageRoute(
          builder: (_) => LibraryPage(
            initialCategoryKey: _libraryCategoryKey(settings),
          ),
          settings: settings,
        );

      case Routes.webLibraryPolicy:
        return MaterialPageRoute(
          builder: (_) => const LibraryPolicyPage(),
          settings: settings,
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      case Routes.blockedAccount:
        final args = settings.arguments;
        final reason = args is String ? args : null;
        return MaterialPageRoute(
          builder: (_) => AccountBlockedPage(reason: reason),
          settings: settings,
        );

      case Routes.centerRegister:
        return MaterialPageRoute(
          builder: (_) => const WebCenterRegisterPortalPage(),
          settings: settings,
        );

      case Routes.centerDashboard:
        return _protectedRoute(
          child: const CenterDashboardPage(),
          settings: settings,
        );

      case Routes.centerOperations:
        return _protectedRoute(
          child: const CenterOperationsPage(),
          settings: settings,
        );

      case Routes.centerProfileEditRequest:
        return _protectedRoute(
          child: const CenterProfileEditRequestPage(),
          settings: settings,
        );

      case Routes.centerInbox:
        return _protectedRoute(
          child: const CenterInboxPage(),
          settings: settings,
        );

      case Routes.clientRegister:
        return MaterialPageRoute(
          builder: (_) => const ClientRegisterPage(),
          settings: settings,
        );

      case Routes.followUpRegistration:
        return MaterialPageRoute(
          builder: (_) => const FollowUpRegistrationPage(),
          settings: settings,
        );

      case Routes.clinicianRegister:
        return MaterialPageRoute(
          builder: (_) => const WebClinicianRegisterPortalPage(),
          settings: settings,
        );

      case Routes.chat:
        // Current doctrine: /chat remains a public/support entry route. Admin
        // support mode is argument-driven; role hardening needs a separate
        // MASTER CORE decision.
        final args = settings.arguments;
        String? threadId;
        String? entryContext;
        bool adminSupportMode = false;
        if (args is Map && args['threadId'] != null) {
          threadId = args['threadId'].toString();
        }
        if (args is Map && args['mode']?.toString() == 'admin_support') {
          adminSupportMode = true;
        }
        if (args is Map && args['adminSupport'] == true) {
          adminSupportMode = true;
        }
        if (!adminSupportMode && threadId == null && args is Map) {
          final value = args['entryContext']?.toString();
          if (value == 'family_support' || value == 'recovery_support') {
            entryContext = value;
          }
        }

        return MaterialPageRoute(
          builder: (_) => ChatPage(
            initialThreadId: threadId,
            adminSupportMode: adminSupportMode,
            entryContext: entryContext,
          ),
          settings: settings,
        );

      case Routes.chatEscalations:
        return _protectedRoute(
          child: const ChatEscalationsPage(),
          settings: settings,
        );

      case Routes.chatEscalationReport:
        final args = settings.arguments;
        final escalationId =
            args is Map ? args['escalationId']?.toString() : null;
        if (escalationId == null || escalationId.isEmpty) {
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(ctx)!.routeNotFound),
              ),
            ),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => _RouteAccessGate(
            routeName: settings.name,
            allowedRoles: _requiredRoles(settings.name),
            child: ChatEscalationReportPage(escalationId: escalationId),
          ),
          settings: settings,
        );

      case Routes.clinicianChatInbox:
      case Routes.clinicianChatInboxLegacy:
        return MaterialPageRoute(
          builder: (_) => _RouteAccessGate(
            routeName: settings.name,
            allowedRoles: _requiredRoles(settings.name),
            child: Builder(
              builder: (context) {
                final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
                return ClinicianChatInboxPage(clinicianUid: uid);
              },
            ),
          ),
          settings: settings,
        );

      case Routes.clinicianInbox:
        final authUid = FirebaseAuth.instance.currentUser?.uid;
        String clinicianId =
            (authUid != null && authUid.isNotEmpty) ? authUid : '';
        String clinicianName = 'DEV Clinician';

        final a = settings.arguments;
        if (a is Map) {
          final cid = a['clinicianId'];
          final cname = a['clinicianName'];
          if (cid != null && cid.toString().trim().isNotEmpty) {
            clinicianId = cid.toString();
          }
          if (cname != null) clinicianName = cname.toString();
        }

        if (clinicianId.isEmpty) {
          return _redirectToLogin(settings);
        }

        return _protectedRoute(
          child: ClinicianInboxPage(
            clinicianId: clinicianId,
            clinicianName: clinicianName,
          ),
          settings: settings,
        );
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );

      case Routes.language:
        return MaterialPageRoute(
          builder: (_) => const MkLanguagePage(),
          settings: settings,
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const MenuPage(),
          settings: settings,
        );

      case Routes.addiction:
        return MaterialPageRoute(
          builder: (_) => const SupportEntryPage.addiction(),
          settings: settings,
        );

      case Routes.specialNeeds:
        return MaterialPageRoute(
          builder: (_) => const SupportEntryPage.specialNeeds(),
          settings: settings,
        );

      case Routes.supportIssueSelector:
        final args = settings.arguments;
        final supportType =
            args is Map ? args['supportType']?.toString() : null;
        if (supportType != 'recovery_support' &&
            supportType != 'family_support' &&
            supportType != 'client_support' &&
            supportType != 'center_support' &&
            supportType != 'clinician_support') {
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(ctx)!.routeNotFound),
              ),
            ),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => SupportIssueSelectorPage(supportType: supportType!),
          settings: settings,
        );

      case Routes.familyStress:
        return MaterialPageRoute(
          builder: (context) => ModulePlaceholderPage(
            title: AppLocalizations.of(context)!.moduleFamilyStress,
          ),
          settings: settings,
        );

      case Routes.specialists:
        final args = settings.arguments;
        final returnRoute =
            args is Map ? args['returnRoute']?.toString() : null;
        return MaterialPageRoute(
          builder: (_) => SpecialistsCategoriesPage(
            returnRoute: (returnRoute == null || returnRoute.isEmpty)
                ? Routes.menu
                : returnRoute,
          ),
          settings: settings,
        );

      case Routes.specialistsList:
        final args = settings.arguments;
        if (args is! Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(ctx)!.routeNotFound),
              ),
            ),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => SpecialistsListPage(args: args),
          settings: settings,
        );

      case Routes.specialistDetails:
        final args = settings.arguments;
        if (args is! Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(ctx)!.routeNotFound),
              ),
            ),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => SpecialistDetailsPage(args: args),
          settings: settings,
        );

      case Routes.centers:
        final args = settings.arguments;
        final returnRoute =
            args is Map ? args['returnRoute']?.toString() : null;
        return MaterialPageRoute(
          builder: (_) => CentersLandingPage(
            returnRoute: (returnRoute == null || returnRoute.isEmpty)
                ? Routes.menu
                : returnRoute,
          ),
          settings: settings,
        );

      case Routes.centersList:
        final args = settings.arguments;
        final category = args is Map ? args['category']?.toString() : null;
        final returnRoute =
            args is Map ? args['returnRoute']?.toString() : null;
        if (category == null || category.isEmpty) {
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(ctx)!.routeNotFound),
              ),
            ),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => CentersListPage(
            category: category,
            returnRoute: (returnRoute == null || returnRoute.isEmpty)
                ? Routes.menu
                : returnRoute,
          ),
          settings: settings,
        );

      case Routes.centerDetails:
        final args = settings.arguments;
        CenterModel? center;
        String? centerId;

        if (args is Map) {
          final aCenter = args['center'];
          if (aCenter is CenterModel) center = aCenter;
          centerId = args['centerId']?.toString();
        } else if (args is CenterModel) {
          center = args;
        }

        return MaterialPageRoute(
          builder: (_) => CenterDetailsPage(
            center: center,
            centerId: centerId,
          ),
          settings: settings,
        );

      case Routes.adminCenters:
        final uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid == null || uid.isEmpty) {
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(ctx)!.routeNotFound),
              ),
            ),
            settings: settings,
          );
        }
        return _adminProtectedRoute(
          child: const AdminCentersPage(),
          settings: settings,
        );

      case Routes.adminCenterDetails:
        final args = settings.arguments;
        final centerId = args is String
            ? args
            : args is Map
                ? args['centerId']?.toString()
                : null;
        if (centerId == null || centerId.isEmpty) {
          return MaterialPageRoute(
            builder: (ctx) => const Scaffold(
              body: Center(child: Text('Missing center id')),
            ),
            settings: settings,
          );
        }
        return _adminProtectedRoute(
          child: AdminCenterDetailsPage(centerId: centerId),
          settings: settings,
        );

      case Routes.library:
        final args = settings.arguments;
        final returnRoute =
            args is Map ? args['returnRoute']?.toString() : null;
        return MaterialPageRoute(
          builder: (_) => LibraryPage(
            initialCategoryKey: _libraryCategoryKey(settings),
            returnRoute: (returnRoute == null || returnRoute.isEmpty)
                ? Routes.menu
                : returnRoute,
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(AppLocalizations.of(context)!.routeNotFound),
            ),
          ),
          settings: settings,
        );
    }
  }
}

class _RouteAccessGate extends StatelessWidget {
  const _RouteAccessGate({
    required this.routeName,
    required this.allowedRoles,
    required this.child,
  });

  final String? routeName;
  final Set<String>? allowedRoles;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_RouteAccessDecision>(
      future: _resolveRouteAccess(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final decision = snapshot.data!;
        _adminGuardTrace(
          'route=$routeName '
          'isAdminRoute=${AppRouter._isAdminRoute(routeName)} '
          'signedIn=${FirebaseAuth.instance.currentUser != null && !FirebaseAuth.instance.currentUser!.isAnonymous} '
          'isAdmin=${decision.isAdmin} '
          'allowed=${decision.allowed} '
          'redirect=${decision.redirectTarget}',
        );
        if (decision.redirectToLogin) {
          return const LoginPage();
        }

        if (decision.isBlocked) {
          return AccountBlockedPage(reason: decision.blockReason);
        }

        if (!decision.allowed) {
          final isArabic =
              Localizations.localeOf(context).languageCode.toLowerCase() ==
                  'ar';
          return Scaffold(
            appBar: AppBar(
              title: Text(isArabic ? 'الوصول غير متاح' : 'Access unavailable'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_outline, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      isArabic
                          ? 'هذه الصفحة غير متاحة لهذا الحساب.'
                          : 'This page is not available for this account.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.menu,
                          (route) => false,
                        );
                      },
                      child: Text(isArabic ? 'العودة للقائمة' : 'Back to menu'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return child;
      },
    );
  }

  Future<_RouteAccessDecision> _resolveRouteAccess() async {
    final user = FirebaseAuth.instance.currentUser;
    final isAdminRoute = AppRouter._isAdminRoute(routeName);
    if (user == null || user.isAnonymous) {
      _adminGuardTrace(
        'route=$routeName '
        'isAdminRoute=$isAdminRoute '
        'signedIn=false '
        'isAdmin=false '
        'allowed=false '
        'redirect=${Routes.login}',
      );
      return const _RouteAccessDecision(
        allowed: false,
        redirectToLogin: true,
        redirectTarget: Routes.login,
      );
    }

    final access = await AccountAccessService().resolve(user);
    final isAdmin = access.isAdmin;
    if (access.isBlocked && !access.isAdmin) {
      _adminGuardTrace(
        'route=$routeName '
        'isAdminRoute=$isAdminRoute '
        'signedIn=true '
        'isAdmin=$isAdmin '
        'allowed=false '
        'redirect=blocked_account',
      );
      return _RouteAccessDecision(
        allowed: false,
        isBlocked: true,
        blockReason: access.blockReason,
        isAdmin: isAdmin,
        redirectTarget: 'blocked_account',
      );
    }

    final normalizedApprovalStatus = access.approvalStatus.trim().toLowerCase();
    final protectsCenterOrClinician =
        allowedRoles?.contains(_roleClinician) == true ||
            allowedRoles?.contains(_roleCenter) == true;
    final needsApproval = protectsCenterOrClinician &&
        (access.role == _roleClinician || access.role == _roleCenter);
    if (needsApproval &&
        (normalizedApprovalStatus != 'approved' || !access.isActive)) {
      final rejectedStates = {
        'rejected',
        'rejected_admin',
        'denied',
        'declined',
      };
      final isRejected = rejectedStates.contains(normalizedApprovalStatus);
      _adminGuardTrace(
        'route=$routeName '
        'isAdminRoute=$isAdminRoute '
        'signedIn=true '
        'isAdmin=$isAdmin '
        'allowed=false '
        'redirect=${isRejected ? 'approval_rejected' : 'approval_required'} '
        'role=${access.role} '
        'approvalStatus=${access.approvalStatus} '
        'isActive=${access.isActive}',
      );
      return _RouteAccessDecision(
        allowed: false,
        isBlocked: true,
        blockReason: isRejected
            ? 'Account approval was rejected. Please contact support.'
            : 'Account is pending admin approval or inactive.',
        isAdmin: isAdmin,
        redirectTarget: isRejected ? 'approval_rejected' : 'approval_required',
      );
    }

    if (allowedRoles == null || allowedRoles!.isEmpty) {
      return _RouteAccessDecision(
        allowed: true,
        isAdmin: isAdmin,
        redirectTarget: 'none',
      );
    }

    final role = access.role;
    final isAllowed = role != null && allowedRoles!.contains(role);
    return _RouteAccessDecision(
      allowed: isAllowed,
      isAdmin: isAdmin,
      redirectTarget: isAllowed ? 'none' : Routes.menu,
    );
  }
}

void _adminGuardTrace(String message) {
  if (!kDebugMode) return;
  debugPrint('ADMIN_GUARD $message');
}

class _RouteAccessDecision {
  const _RouteAccessDecision({
    required this.allowed,
    this.redirectToLogin = false,
    this.isBlocked = false,
    this.blockReason = '',
    this.isAdmin = false,
    this.redirectTarget = 'none',
  });

  final bool allowed;
  final bool redirectToLogin;
  final bool isBlocked;
  final String blockReason;
  final bool isAdmin;
  final String redirectTarget;
}
