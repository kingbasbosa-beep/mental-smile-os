import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/core/auth/presentation/pages/account_blocked_page.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

import 'routes.dart';

import 'package:flutterprojects/features/booking/presentation/pages/booking_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/booking_request_page.dart';
import 'package:flutterprojects/features/clinician/presentation/pages/clinician_sessions_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_booking_request_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/my_bookings_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/clinician_inbox_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_inbox_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/admin_booking_queue_page.dart';

import 'package:flutterprojects/features/library/presentation/pages/library_page.dart';
import 'package:flutterprojects/features/splash/presentation/pages/splash_page.dart';
import 'package:flutterprojects/features/language/presentation/pages/language_page.dart';
import 'package:flutterprojects/features/modules/presentation/pages/module_placeholder_page.dart';
import 'package:flutterprojects/features/modules/presentation/pages/support_entry_page.dart';
import 'package:flutterprojects/features/home/presentation/pages/home_page.dart';
import 'package:flutterprojects/features/home/presentation/pages/menu_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialists_categories_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialists_list_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialist_details_page.dart';
import 'package:flutterprojects/features/auth/presentation/pages/login_page.dart';
import 'package:flutterprojects/features/auth/presentation/pages/client_register_page.dart';
import 'package:flutterprojects/features/auth/presentation/pages/clinician_register_page.dart';
import 'package:flutterprojects/features/chat/presentation/pages/chat_page.dart';
import 'package:flutterprojects/features/chat/presentation/pages/chat_escalations_page.dart';
import 'package:flutterprojects/features/chat/presentation/pages/chat_escalation_report_page.dart';
import 'package:flutterprojects/features/chat/presentation/pages/clinician_chat_inbox_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/centers_landing_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/centers_list_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_details_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/admin_centers_page.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_hub_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_clients_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_centers_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_clinicians_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_support_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_accounting_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_sessions_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_payments_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_archive_reports_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_session_report_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_clinician_profile_requests_page.dart';
import 'package:flutterprojects/features/reviews/presentation/pages/session_review_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_payments_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_sessions_page.dart';
import 'package:flutterprojects/features/client/presentation/pages/client_payment_proof_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_clinician_requests_page.dart';
import 'package:flutterprojects/features/admin/presentation/pages/admin_support_chat_page.dart';
import 'package:flutterprojects/features/clinician/presentation/pages/clinician_operations_page.dart';
import 'package:flutterprojects/features/client/presentation/pages/client_dashboard_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_register_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_dashboard_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_operations_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_residencies_page.dart';
import 'package:flutterprojects/features/client/presentation/pages/client_sessions_page.dart';

const String _adminBookingQueueRoute = '/admin/booking-queue';
const String _roleAdmin = 'admin';
const String _roleClinician = 'clinician';
const String _roleCenter = 'center';
const String _roleClient = 'client';

class AppRouter {
  static const Set<String> _adminOnlyRoutes = {
    Routes.adminHub,
    Routes.adminClinicianRequests,
    Routes.adminClinicianProfileRequests,
    Routes.adminClients,
    Routes.adminPayments,
    Routes.adminSessions,
    Routes.adminSupportChats,
    _adminBookingQueueRoute,
    Routes.adminArchive,
    Routes.adminArchiveSessions,
    Routes.adminArchivePayments,
    Routes.adminArchiveReports,
    Routes.adminArchiveClinicians,
    Routes.adminArchiveCenters,
    Routes.adminArchiveSupport,
    Routes.adminArchiveAccounting,
    Routes.adminSessionReport,
    Routes.adminCenters,
    Routes.chatEscalations,
    Routes.chatEscalationReport,
  };

  static const Set<String> _clinicianOnlyRoutes = {
    Routes.clinicianOperations,
    Routes.clinicianInbox,
    Routes.clinicianChatInbox,
    Routes.clinicianChatInboxLegacy,
    Routes.clinicianSessions,
  };

  static const Set<String> _centerOnlyRoutes = {
    Routes.centerDashboard,
    Routes.centerOperations,
    Routes.centerInbox,
    Routes.centerResidencies,
  };

  static const Set<String> _clientOnlyRoutes = {
    Routes.clientDashboard,
    Routes.clientPaymentProof,
    Routes.clientSessions,
    Routes.myBookings,
    Routes.bookingRequest,
    Routes.centerBookingRequest,
  };

  static bool _requiresSignedInNonAnonymous(RouteSettings settings) {
    switch (settings.name) {
      case Routes.adminHub:
      case Routes.adminClinicianRequests:
      case Routes.adminClinicianProfileRequests:
      case Routes.adminClients:
      case Routes.adminPayments:
      case Routes.adminSessions:
      case Routes.adminSupportChats:
      case _adminBookingQueueRoute:
      case Routes.adminArchive:
      case Routes.adminArchiveSessions:
      case Routes.adminArchivePayments:
      case Routes.adminSessionReport:
      case Routes.adminCenters:
      case Routes.chatEscalations:
      case Routes.chatEscalationReport:
      case Routes.centerDashboard:
      case Routes.centerOperations:
      case Routes.centerInbox:
      case Routes.centerResidencies:
      case Routes.clinicianOperations:
      case Routes.clinicianInbox:
      case Routes.clinicianChatInbox:
      case Routes.clinicianChatInboxLegacy:
      case Routes.clinicianSessions:
      case Routes.blockedAccount:
      case Routes.clientDashboard:
      case Routes.clientPaymentProof:
      case Routes.clientSessions:
      case Routes.myBookings:
      case Routes.bookingRequest:
      case Routes.centerBookingRequest:
      case Routes.sessionReview:
        return true;
      default:
        return false;
    }
  }

  static Set<String>? _requiredRoles(String? routeName) {
    if (routeName == null) return null;
    if (_adminOnlyRoutes.contains(routeName)) return {_roleAdmin};
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

  static Route<dynamic>? adminSurfaceRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.adminHub:
        return _protectedRoute(
          child: const AdminHubPage(),
          settings: settings,
        );

      case Routes.adminClinicianRequests:
        return _protectedRoute(
          child: const AdminClinicianRequestsPage(),
          settings: settings,
        );

      case Routes.adminClinicianProfileRequests:
        return _protectedRoute(
          child: const AdminClinicianProfileRequestsPage(),
          settings: settings,
        );

      case Routes.adminClients:
        return _protectedRoute(
          child: const AdminClientsPage(),
          settings: settings,
        );

      case Routes.adminSupportChats:
        return _protectedRoute(
          child: const AdminSupportChatPage(),
          settings: settings,
        );

      case Routes.adminArchivePayments:
        return _protectedRoute(
          child: const AdminArchivePaymentsPage(),
          settings: settings,
        );

      case Routes.adminArchiveClinicians:
        return _protectedRoute(
          child: const AdminArchiveCliniciansPage(),
          settings: settings,
        );

      case Routes.adminArchiveCenters:
        return _protectedRoute(
          child: const AdminArchiveCentersPage(),
          settings: settings,
        );

      case Routes.adminArchiveSupport:
        return _protectedRoute(
          child: const AdminArchiveSupportPage(),
          settings: settings,
        );

      case Routes.adminArchiveAccounting:
        return _protectedRoute(
          child: const AdminArchiveAccountingPage(),
          settings: settings,
        );

      case Routes.adminArchiveReports:
        return _protectedRoute(
          child: const AdminArchiveReportsPage(),
          settings: settings,
        );

      case Routes.adminArchiveSessions:
        return _protectedRoute(
          child: const AdminArchiveSessionsPage(),
          settings: settings,
        );

      case Routes.adminArchive:
        return _protectedRoute(
          child: const AdminArchivePage(),
          settings: settings,
        );

      default:
        return null;
    }
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
      case Routes.menu:
        return MaterialPageRoute(
          builder: (_) => const MenuPage(),
          settings: settings,
        );

      case Routes.adminPayments:
        return _protectedRoute(
          child: const AdminPaymentsPage(),
          settings: settings,
        );

      case Routes.adminSessions:
        return _protectedRoute(
          child: const AdminSessionsPage(),
          settings: settings,
        );

      case Routes.clinicianOperations:
        return _protectedRoute(
          child: const ClinicianOperationsPage(),
          settings: settings,
        );

      case Routes.clientDashboard:
        return _protectedRoute(
          child: const ClientDashboardPage(),
          settings: settings,
        );

      case _adminBookingQueueRoute:
        return _protectedRoute(
          child: const AdminBookingQueuePage(),
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
          builder: (_) => const CenterRegisterPage(),
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

      case Routes.centerInbox:
        return _protectedRoute(
          child: const CenterInboxPage(),
          settings: settings,
        );

      case Routes.centerResidencies:
        return _protectedRoute(
          child: const CenterResidenciesPage(),
          settings: settings,
        );

      case Routes.clientRegister:
        return MaterialPageRoute(
          builder: (_) => const ClientRegisterPage(),
          settings: settings,
        );

      case Routes.clinicianRegister:
        return MaterialPageRoute(
          builder: (_) => const ClinicianRegisterPage(),
          settings: settings,
        );

      case Routes.chat:
        final args = settings.arguments;
        String? threadId;
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

        return MaterialPageRoute(
          builder: (_) => ChatPage(
            initialThreadId: threadId,
            adminSupportMode: adminSupportMode,
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
        return MaterialPageRoute(
          builder: (_) => _RouteAccessGate(
            routeName: settings.name,
            allowedRoles: _requiredRoles(settings.name),
            child: ClinicianChatInboxPage(clinicianUid: uid),
          ),
          settings: settings,
        );

      case Routes.clinicianInbox:
        String clinicianId = 'DEV_NO_UID';
        String clinicianName = 'DEV Clinician';

        final a = settings.arguments;
        if (a is Map) {
          final cid = a['clinicianId'];
          final cname = a['clinicianName'];
          if (cid != null) clinicianId = cid.toString();
          if (cname != null) clinicianName = cname.toString();
        } else {
          final uid = FirebaseAuth.instance.currentUser?.uid;
          if (uid != null && uid.isNotEmpty) clinicianId = uid;
        }

        return _protectedRoute(
          child: ClinicianInboxPage(
            clinicianId: clinicianId,
            clinicianName: clinicianName,
          ),
          settings: settings,
        );

      case Routes.bookingRequest:
        final rawArgs = settings.arguments;
        if (rawArgs is! BookingRequestArgs) {
          return MaterialPageRoute(
            builder: (ctx) => Scaffold(
              appBar: AppBar(
                title: Text(
                  Localizations.localeOf(ctx).languageCode.toLowerCase() == 'ar'
                      ? 'طلب حجز'
                      : 'Booking request',
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    Localizations.localeOf(ctx).languageCode.toLowerCase() ==
                            'ar'
                        ? 'تعذر فتح صفحة الحجز مباشرة. ارجع إلى صفحة الأخصائيين ثم اختر الأخصائي مرة أخرى.'
                        : 'Unable to open the booking page directly. Please go back to specialists and choose the specialist again.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            settings: settings,
          );
        }

        return _protectedRoute(
          child: BookingRequestPage(args: rawArgs),
          settings: settings,
        );

      case Routes.centerBookingRequest:
        final args = settings.arguments as CenterBookingRequestArgs;
        return _protectedRoute(
          child: CenterBookingRequestPage(args: args),
          settings: settings,
        );

      case Routes.adminSessionReport:
        return _protectedRoute(
          child: const AdminSessionReportPage(),
          settings: settings,
        );

      case Routes.sessionReview:
        final rawArgs = settings.arguments;
        final args =
            rawArgs is Map<String, dynamic> ? rawArgs : <String, dynamic>{};
        final reviewerType = (args['reviewerType'] ?? '').toString();
        Set<String>? allowedRoles;
        if (reviewerType == _roleClient) {
          allowedRoles = {_roleClient};
        } else if (reviewerType == _roleClinician) {
          allowedRoles = {_roleClinician, _roleCenter};
        } else if (reviewerType == _roleCenter) {
          allowedRoles = {_roleCenter};
        }
        final requestId = (args['requestId'] ?? '').toString();
        if (requestId.isEmpty || reviewerType.isEmpty) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text(
                  'Missing session review arguments',
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => _RouteAccessGate(
            routeName: settings.name,
            allowedRoles: allowedRoles,
            child: SessionReviewPage(
              requestId: requestId,
              reviewerType: reviewerType,
            ),
          ),
          settings: settings,
        );

      case Routes.clientSessions:
        return _protectedRoute(
          child: const ClientSessionsPage(),
          settings: settings,
        );

      case Routes.clinicianSessions:
        return _protectedRoute(
          child: const ClinicianSessionsPage(),
          settings: settings,
        );

      case Routes.clientPaymentProof:
        return _protectedRoute(
          child: const ClientPaymentProofPage(),
          settings: settings,
        );

      case Routes.myBookings:
        return _protectedRoute(
          child: const MyBookingsPage(),
          settings: settings,
        );

      case Routes.booking:
        return MaterialPageRoute(
          builder: (_) => const BookingPage(),
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
          builder: (_) => const HomePage(),
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

      case Routes.familyStress:
        return MaterialPageRoute(
          builder: (context) => ModulePlaceholderPage(
            title: AppLocalizations.of(context)!.moduleFamilyStress,
          ),
          settings: settings,
        );

      case Routes.specialists:
        return MaterialPageRoute(
          builder: (_) => const SpecialistsCategoriesPage(),
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
        return MaterialPageRoute(
          builder: (_) => const CentersLandingPage(),
          settings: settings,
        );

      case Routes.centersList:
        final args = settings.arguments;
        final category = args is Map ? args['category']?.toString() : null;
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
          builder: (_) => CentersListPage(category: category),
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
        return _protectedRoute(
          child: const AdminCentersPage(),
          settings: settings,
        );

      case Routes.library:
        return MaterialPageRoute(
          builder: (_) => const LibraryPage(),
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
    if (user == null || user.isAnonymous) {
      return const _RouteAccessDecision(
        allowed: false,
        redirectToLogin: true,
      );
    }

    final access = await AccountAccessService().resolve(user);
    if (access.isBlocked && !access.isAdmin) {
      return _RouteAccessDecision(
        allowed: false,
        isBlocked: true,
        blockReason: access.blockReason,
      );
    }

    if (allowedRoles == null || allowedRoles!.isEmpty) {
      return const _RouteAccessDecision(allowed: true);
    }

    final role = access.role;
    final isAllowed = role != null && allowedRoles!.contains(role);
    return _RouteAccessDecision(allowed: isAllowed);
  }
}

class _RouteAccessDecision {
  const _RouteAccessDecision({
    required this.allowed,
    this.redirectToLogin = false,
    this.isBlocked = false,
    this.blockReason = '',
  });

  final bool allowed;
  final bool redirectToLogin;
  final bool isBlocked;
  final String blockReason;
}
