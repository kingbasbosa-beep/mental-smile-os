import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_smile_os/core/auth/account_access_service.dart';
import 'package:mental_smile_os/core/auth/presentation/pages/account_blocked_page.dart';
import 'package:mental_smile_os/core/visibility/visibility_readiness.dart';
import 'package:mental_smile_os/features/accessibility/domain/models/accessibility_category.dart';
import 'package:mental_smile_os/features/accessibility/presentation/pages/accessibility_hub_page.dart';
import 'package:mental_smile_os/features/accessibility/presentation/pages/accessibility_organizations_page.dart';
import 'package:mental_smile_os/features/accessibility/presentation/pages/accessibility_resource_list_page.dart';
import 'package:mental_smile_os/l10n/app_localizations.dart';

import 'routes.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_center_register_portal_page.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_center_profile_page.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_center_media_page.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_center_pricing_page.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_center_documents_page.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_clinician_profile_page.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_clinician_documents_page.dart';
import 'package:mental_smile_os/features/web_registration/presentation/pages/web_registration_success_page.dart';
import 'package:mental_smile_os/features/web_portal/presentation/pages/portal_skeleton_pages.dart';
import 'package:mental_smile_os/features/s_capital/presentation/pages/s_capital_operations_office_page.dart';
import 'package:mental_smile_os/features/s_capital/presentation/pages/s_signal_monitoring_room_page.dart';
import 'package:mental_smile_os/features/sovereign_construction/presentation/pages/sovereign_construction_workbench_page.dart';
import 'package:mental_smile_os/features/s_city/presentation/pages/s_city_district_page.dart';
import 'package:mental_smile_os/features/s_owner/presentation/pages/s_owner_district_page.dart';
import 'package:mental_smile_os/features/s_web_surfaces/presentation/pages/s_web_surface_pages.dart';
import 'package:mental_smile_os/features/s_personal_space/presentation/pages/s_personal_space_page.dart';
import 'package:mental_smile_os/features/s_support_room/presentation/pages/s_support_room_page.dart';
import 'package:mental_smile_os/features/s_registry_room/presentation/pages/s_registry_room_page.dart';
import 'package:mental_smile_os/features/s_declaration_review_room/presentation/pages/s_declaration_review_room_page.dart';

import 'package:mental_smile_os/features/library/presentation/pages/library_page.dart';
import 'package:mental_smile_os/features/library/presentation/pages/library_policy_page.dart';
import 'package:mental_smile_os/features/splash/presentation/pages/splash_page.dart';
import 'package:mental_smile_os/features/language/presentation/pages/language_page.dart';
import 'package:mental_smile_os/features/modules/presentation/pages/support_entry_page.dart';
import 'package:mental_smile_os/features/modules/presentation/pages/support_issue_selector_page.dart';
import 'package:mental_smile_os/features/home/presentation/pages/menu_page.dart';
import 'package:mental_smile_os/features/specialists/presentation/specialists_categories_page.dart';
import 'package:mental_smile_os/features/specialists/presentation/specialists_list_page.dart';
import 'package:mental_smile_os/features/specialists/presentation/specialist_details_page.dart';
import 'package:mental_smile_os/features/auth/presentation/pages/login_page.dart';
import 'package:mental_smile_os/features/app_exit/presentation/pages/app_exit_social_links_page.dart';
import 'package:mental_smile_os/features/chat/presentation/pages/chat_page.dart';
import 'package:mental_smile_os/features/safety/presentation/pages/chat_escalations_page.dart';
import 'package:mental_smile_os/features/chat/presentation/pages/chat_escalation_report_page.dart';
import 'package:mental_smile_os/features/chat/presentation/pages/clinician_chat_inbox_page.dart';
import 'package:mental_smile_os/features/centers/presentation/pages/centers_landing_page.dart';
import 'package:mental_smile_os/features/centers/presentation/pages/centers_list_page.dart';
import 'package:mental_smile_os/features/centers/presentation/pages/center_details_page.dart';
import 'package:mental_smile_os/features/centers/data/models/center_model.dart';
import 'package:mental_smile_os/features/clinician/presentation/pages/clinician_room_page.dart';
import 'package:mental_smile_os/features/client/presentation/pages/client_session_room_page.dart';
import 'package:mental_smile_os/features/centers/presentation/pages/center_dashboard_page.dart';
import 'package:mental_smile_os/features/centers/presentation/pages/center_room_page.dart';

const String _roleOwner = 'owner';
const String _roleMonitoringOperator = 'monitoring_operator';
const String _roleRegistrySteward = 'registry_steward';
const String _roleDeclarationReviewer = 'declaration_reviewer';
const String _roleSupportObserver = 'support_observer';
const String _roleClinician = 'clinician';
const String _roleCenter = 'center';
const String _roleClient = 'client';

class AppRouter {
  static const Set<String> _ownerOnlyRoutes = {
    Routes.sOwnerHome,
    Routes.sOwnerRoom,
    Routes.sSovereignIntelligence,
    Routes.sStrategicMemory,
    Routes.sSovereignVault,
    Routes.sConstitutionalMemory,
    Routes.sRecoveryConsole,
    Routes.sOwnerCapsules,
    Routes.sOwnerRegeneration,
    Routes.ownerConstructionWorkbench,
  };

  static const Set<String> _monitoringOperatorRoutes = {
    Routes.sSignalMonitoringRoom,
    Routes.sCapitalReports,
  };

  static const Set<String> _supportObserverRoutes = {
    Routes.sTrustSafety,
    Routes.chatEscalations,
    Routes.chatEscalationReport,
  };

  static const Set<String> _ownerAndSupportObserverRoutes = {
    Routes.sSupportRoom,
  };

  static const Set<String> _ownerAndRegistryStewardRoutes = {
    Routes.sRegistryRoom,
  };

  static const Set<String> _ownerAndDeclarationReviewerRoutes = {
    Routes.sDeclarationReviewRoom,
  };

  static const Set<String> _clinicianOnlyRoutes = {
    Routes.clinicianRoom,
    Routes.clinicianProfileEditRequest,
    Routes.clinicianChatInbox,
  };

  static const Set<String> _centerOnlyRoutes = {
    Routes.centerDashboard,
    Routes.centerRoom,
    Routes.centerProfileEditRequest,
  };

  static const Set<String> _clientOnlyRoutes = {
    Routes.sPersonalSpace,
  };

  static bool _isScopedProtectedRoute(String? routeName) {
    if (routeName == null) return false;
    return _ownerOnlyRoutes.contains(routeName) ||
        _monitoringOperatorRoutes.contains(routeName) ||
        _supportObserverRoutes.contains(routeName) ||
        _ownerAndSupportObserverRoutes.contains(routeName) ||
        _ownerAndRegistryStewardRoutes.contains(routeName) ||
        _ownerAndDeclarationReviewerRoutes.contains(routeName);
  }

  static bool _requiresSignedInNonAnonymous(RouteSettings settings) {
    if (_isScopedProtectedRoute(settings.name)) {
      return true;
    }

    switch (settings.name) {
      case Routes.centerDashboard:
      case Routes.centerRoom:
      case Routes.centerProfileEditRequest:
      case Routes.clinicianRoom:
      case Routes.clinicianProfileEditRequest:
      case Routes.clinicianChatInbox:
      case Routes.blockedAccount:
      case Routes.sPersonalSpace:
        return true;
      default:
        return false;
    }
  }

  static Set<String>? _requiredRoles(String? routeName) {
    if (routeName == null) return null;
    if (_ownerOnlyRoutes.contains(routeName)) return {_roleOwner};
    if (_monitoringOperatorRoutes.contains(routeName)) {
      return {_roleMonitoringOperator};
    }
    if (_supportObserverRoutes.contains(routeName)) {
      return {_roleSupportObserver};
    }
    if (_ownerAndSupportObserverRoutes.contains(routeName)) {
      return {_roleOwner, _roleSupportObserver};
    }
    if (_ownerAndRegistryStewardRoutes.contains(routeName)) {
      return {_roleOwner, _roleRegistrySteward};
    }
    if (_ownerAndDeclarationReviewerRoutes.contains(routeName)) {
      return {_roleOwner, _roleDeclarationReviewer};
    }
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

  static AccessibilityCategory? _accessibilityCategory(
    RouteSettings settings,
  ) {
    final args = settings.arguments;
    if (args is Map) {
      final value = args['category'];
      if (value is String && value.trim().isNotEmpty) {
        return AccessibilityCategory.fromValue(value.trim());
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

  static Route<dynamic> _scopedProtectedRoute({
    required Widget child,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      builder: (_) => _RouteAccessGate(
        routeName: settings.name,
        allowedRoles: _requiredRoles(settings.name) ?? const {_roleOwner},
        child: child,
      ),
      settings: settings,
    );
  }

  static Route<dynamic> _sWebSurfaceRoute({
    required RouteSettings settings,
    required String surfaceName,
    required String surfaceType,
    required String description,
    required List<String> items,
  }) {
    final page = SWebSurfacePage(
      surfaceName: surfaceName,
      surfaceType: surfaceType,
      routeName: settings.name ?? '',
      description: description,
      items: items,
    );
    return MaterialPageRoute(
      builder: (_) {
        final allowedRoles = _requiredRoles(settings.name);
        if (allowedRoles == null) return page;
        return _RouteAccessGate(
          routeName: settings.name,
          allowedRoles: allowedRoles,
          child: page,
        );
      },
      settings: settings,
    );
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final needsNonAnonymous = _requiresSignedInNonAnonymous(settings);
    if (needsNonAnonymous && (currentUser == null || currentUser.isAnonymous)) {
      return _redirectToLogin(settings);
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

      case Routes.sSupportRoom:
        return _scopedProtectedRoute(
          child: const SSupportRoomPage(),
          settings: settings,
        );

      case Routes.sRegistryRoom:
        return _scopedProtectedRoute(
          child: const SRegistryRoomPage(),
          settings: settings,
        );

      case Routes.sDeclarationReviewRoom:
        return _scopedProtectedRoute(
          child: const SDeclarationReviewRoomPage(),
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
              'Future public service catalog surface for discovery signals and resource cards.',
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
              'Future center and institution discovery surface for readiness-visible center cards.',
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
              'Future marketplace surface for catalogs and service discovery.',
          items: const <String>[
            'Service Catalog',
            'Tool Catalog',
            'Course Catalog',
            'Professional Services',
          ],
        );

      case Routes.sCapitalHome:
        return MaterialPageRoute(
          builder: (_) => const SCapitalOperationsOfficePage(),
          settings: settings,
        );

      case Routes.sCapitalOperationsOffice:
        return MaterialPageRoute(
          builder: (_) => const SCapitalOperationsOfficePage(
            focus: SCapitalOfficeFocus.operationsOffice,
          ),
          settings: settings,
        );

      case Routes.sCapitalIncidents:
        return MaterialPageRoute(
          builder: (_) => const SCapitalOperationsOfficePage(
            focus: SCapitalOfficeFocus.incidents,
          ),
          settings: settings,
        );

      case Routes.sCapitalMaintenance:
        return MaterialPageRoute(
          builder: (_) => const SCapitalOperationsOfficePage(
            focus: SCapitalOfficeFocus.maintenance,
          ),
          settings: settings,
        );

      case Routes.sCapitalBroadcasts:
        return MaterialPageRoute(
          builder: (_) => const SCapitalOperationsOfficePage(
            focus: SCapitalOfficeFocus.broadcasts,
          ),
          settings: settings,
        );

      case Routes.sCapitalEmergencyBrief:
        return MaterialPageRoute(
          builder: (_) => const SCapitalOperationsOfficePage(
            focus: SCapitalOfficeFocus.emergencyBrief,
          ),
          settings: settings,
        );

      case Routes.sSignalMonitoringRoom:
        return _protectedRoute(
          child: const SSignalMonitoringRoomPage(),
          settings: settings,
        );

      case Routes.sCapitalDepartments:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Departments',
          surfaceType: 'Federation Capital Web [S]',
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
          surfaceType: 'Federation Capital Web [S]',
          description:
              'Future trust, safety, complaints, and escalation signal surface.',
          items: const <String>[
            'Safety Signals',
            'Complaint Patterns',
            'Escalation Visibility',
            'Policy References',
          ],
        );

      case Routes.sCapitalReports:
        return _sWebSurfaceRoute(
          settings: settings,
          surfaceName: 'Reports',
          surfaceType: 'Federation Capital Web [S]',
          description:
              'Future reporting surface for department, signal, content, and operational reports.',
          items: const <String>[
            'Signal Reports',
            'Department Reports',
            'Content Reports',
            'Support Reports',
          ],
        );

      case Routes.sOwnerHome:
        return _protectedRoute(
          child: const SOwnerDistrictPage(),
          settings: settings,
        );

      case Routes.sOwnerRoom:
        return _protectedRoute(
          child: const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.ownerRoom,
          ),
          settings: settings,
        );

      case Routes.sSovereignIntelligence:
        return _protectedRoute(
          child: const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.executiveIntelligence,
          ),
          settings: settings,
        );

      case Routes.sStrategicMemory:
        return _protectedRoute(
          child: const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.strategicArchive,
          ),
          settings: settings,
        );

      case Routes.sSovereignVault:
        return _protectedRoute(
          child: const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.sovereignVault,
          ),
          settings: settings,
        );

      case Routes.sConstitutionalMemory:
        return _protectedRoute(
          child: const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.constitutionalMemory,
          ),
          settings: settings,
        );

      case Routes.sRecoveryConsole:
        return _protectedRoute(
          child: const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.recoveryConsole,
          ),
          settings: settings,
        );

      case Routes.sOwnerCapsules:
        return _protectedRoute(
          child: const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.survivalCapsules,
          ),
          settings: settings,
        );

      case Routes.sOwnerRegeneration:
        return _protectedRoute(
          child: const SOwnerDistrictPage(
            focus: SOwnerDistrictFocus.regenerationBoard,
          ),
          settings: settings,
        );

      case Routes.ownerConstructionWorkbench:
        return _protectedRoute(
          child: const SovereignConstructionWorkbenchPage(),
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

      case Routes.clinicianRoom:
        return _protectedRoute(
          child: const ClinicianRoomPage(),
          settings: settings,
        );

      case Routes.clinicianProfileEditRequest:
        return _protectedRoute(
          child: const ClinicianProfileEditRequestPage(),
          settings: settings,
        );

      case Routes.clientSessionRoom:
        return MaterialPageRoute(
          builder: (_) => const ClientSessionRoomPage(),
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

      case Routes.exitSocialLinks:
        return MaterialPageRoute(
          builder: (_) => const AppExitSocialLinksPage(),
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

      case Routes.centerRoom:
        return _protectedRoute(
          child: const CenterRoomPage(),
          settings: settings,
        );

      case Routes.centerProfileEditRequest:
        return _protectedRoute(
          child: const CenterProfileEditRequestPage(),
          settings: settings,
        );

      case Routes.clinicianRegister:
        return MaterialPageRoute(
          builder: (_) => const WebClinicianRegisterPortalPage(),
          settings: settings,
        );

      case Routes.chat:
        // Current doctrine: /chat remains a public/support entry route.
        // Support room mode is argument-driven and scoped by support authority.
        final args = settings.arguments;
        String? threadId;
        String? entryContext;
        bool supportRoomMode = false;
        if (args is Map && args['threadId'] != null) {
          threadId = args['threadId'].toString();
        }
        if (args is Map && args['mode']?.toString() == 'support_room') {
          supportRoomMode = true;
        }
        if (args is Map && args['supportRoom'] == true) {
          supportRoomMode = true;
        }
        if (!supportRoomMode && threadId == null && args is Map) {
          final value = args['entryContext']?.toString();
          if (value == 'family_support' || value == 'recovery_support') {
            entryContext = value;
          }
        }

        return MaterialPageRoute(
          builder: (_) => ChatPage(
            initialThreadId: threadId,
            supportRoomMode: supportRoomMode,
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

      case Routes.accessibility:
        final category = _accessibilityCategory(settings);
        return MaterialPageRoute(
          builder: (_) => category == null
              ? const AccessibilityHubPage()
              : AccessibilityResourceListPage(category: category),
          settings: settings,
        );

      case Routes.accessibilityOrganizations:
        return MaterialPageRoute(
          builder: (_) => const AccessibilityOrganizationsPage(),
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
        _roleGuardTrace(
          'route=$routeName '
          'signedIn=${FirebaseAuth.instance.currentUser != null && !FirebaseAuth.instance.currentUser!.isAnonymous} '
          'role=${decision.role ?? 'none'} '
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
              title: Text(isArabic
                  ? 'Ø§Ù„ÙˆØµÙˆÙ„ ØºÙŠØ± Ù…ØªØ§Ø­'
                  : 'Access unavailable'),
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
                          ? 'Ù‡Ø°Ù‡ Ø§Ù„ØµÙØ­Ø© ØºÙŠØ± Ù…ØªØ§Ø­Ø© Ù„Ù‡Ø°Ø§ Ø§Ù„Ø­Ø³Ø§Ø¨.'
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
                      child: Text(isArabic
                          ? 'Ø§Ù„Ø¹ÙˆØ¯Ø© Ù„Ù„Ù‚Ø§Ø¦Ù…Ø©'
                          : 'Back to menu'),
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
    if (user == null || user.isAnonymous) {
      _roleGuardTrace(
        'route=$routeName '
        'signedIn=false '
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
    final role = access.role;
    if (access.isBlocked) {
      _roleGuardTrace(
        'route=$routeName '
        'signedIn=true '
        'role=${role ?? 'none'} '
        'allowed=false '
        'redirect=blocked_account',
      );
      return _RouteAccessDecision(
        allowed: false,
        isBlocked: true,
        blockReason: access.blockReason,
        role: role,
        redirectTarget: 'blocked_account',
      );
    }

    final protectsCenterOrClinician =
        allowedRoles?.contains(_roleClinician) == true ||
            allowedRoles?.contains(_roleCenter) == true;
    final needsReadiness = protectsCenterOrClinician &&
        (access.role == _roleClinician || access.role == _roleCenter);
    if (needsReadiness &&
        access.visibilityReadiness != VisibilityReadiness.ready) {
      _roleGuardTrace(
        'route=$routeName '
        'signedIn=true '
        'role=${role ?? 'none'} '
        'allowed=false '
        'redirect=visibility_incomplete '
        'role=${access.role} '
        'visibilityReadiness=${access.visibilityReadiness} '
        'readiness=${access.visibilityReadiness}',
      );
      return _RouteAccessDecision(
        allowed: false,
        isBlocked: true,
        blockReason:
            'Required declaration signals are incomplete. Visibility is not ready.',
        role: role,
        redirectTarget: 'visibility_incomplete',
      );
    }

    if (allowedRoles == null || allowedRoles!.isEmpty) {
      return _RouteAccessDecision(
        allowed: true,
        role: role,
        redirectTarget: 'none',
      );
    }

    final isAllowed = role != null && allowedRoles!.contains(role);
    return _RouteAccessDecision(
      allowed: isAllowed,
      role: role,
      redirectTarget: isAllowed ? 'none' : Routes.menu,
    );
  }
}

void _roleGuardTrace(String message) {
  if (!kDebugMode) return;
  debugPrint('ROLE_GUARD $message');
}

class _RouteAccessDecision {
  const _RouteAccessDecision({
    required this.allowed,
    this.redirectToLogin = false,
    this.isBlocked = false,
    this.blockReason = '',
    this.role,
    this.redirectTarget = 'none',
  });

  final bool allowed;
  final bool redirectToLogin;
  final bool isBlocked;
  final String blockReason;
  final String? role;
  final String redirectTarget;
}
