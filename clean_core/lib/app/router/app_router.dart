import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/core/auth/presentation/pages/account_blocked_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/booking_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/booking_request_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_inbox_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_booking_request_page.dart';
import 'package:flutterprojects/features/booking/presentation/pages/my_bookings_page.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_dashboard_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_details_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/center_residencies_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/centers_landing_page.dart';
import 'package:flutterprojects/features/centers/presentation/pages/centers_list_page.dart';
import 'package:flutterprojects/features/client/presentation/pages/client_dashboard_page.dart';
import 'package:flutterprojects/features/client/presentation/pages/client_sessions_page.dart';
import 'package:flutterprojects/features/clinician/presentation/pages/clinician_operations_page.dart';
import 'package:flutterprojects/features/clinician/presentation/pages/clinician_sessions_page.dart';
import 'package:flutterprojects/features/home/presentation/pages/home_page.dart';
import 'package:flutterprojects/features/home/presentation/pages/menu_page.dart';
import 'package:flutterprojects/features/library/presentation/pages/library_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialist_details_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialists_categories_page.dart';
import 'package:flutterprojects/features/specialists/presentation/specialists_list_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_documents_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_media_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_pricing_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_profile_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_center_register_portal_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_clinician_documents_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_clinician_profile_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_clinician_sessions_page.dart';
import 'package:flutterprojects/features/web_registration/presentation/pages/web_registration_success_page.dart';

import 'routes.dart';

const String _roleAdmin = 'admin';
const String _roleClinician = 'clinician';
const String _roleCenter = 'center';
const String _roleClient = 'client';

class AppRouter {
  static const Set<String> _adminOnlyRoutes = {
    Routes.adminHub,
  };

  static const Set<String> _clinicianOnlyRoutes = {
    Routes.clinicianOperations,
    Routes.clinicianSessions,
    Routes.clinicianChatInbox,
    Routes.clinicianProfileEditRequest,
  };

  static const Set<String> _centerOnlyRoutes = {
    Routes.centerDashboard,
    Routes.centerOperations,
    Routes.centerInbox,
    Routes.centerResidencies,
  };

  static const Set<String> _clientOnlyRoutes = {
    Routes.clientDashboard,
    Routes.clientSessions,
    Routes.clientPaymentProof,
    Routes.followUpRegistration,
    Routes.myBookings,
    Routes.bookingRequest,
    Routes.centerBookingRequest,
  };

  static Set<String>? _requiredRoles(String? routeName) {
    if (routeName == null) return null;
    if (_adminOnlyRoutes.contains(routeName)) return {_roleAdmin};
    if (routeName == Routes.supportIssueSelector ||
        routeName == Routes.sessionReview) {
      return {_roleClient, _roleCenter, _roleClinician};
    }
    if (_clinicianOnlyRoutes.contains(routeName)) return {_roleClinician};
    if (_centerOnlyRoutes.contains(routeName)) return {_roleCenter};
    if (_clientOnlyRoutes.contains(routeName)) return {_roleClient};
    return null;
  }

  static bool _requiresSignedInNonAnonymous(RouteSettings settings) {
    return _requiredRoles(settings.name) != null ||
        settings.name == Routes.blockedAccount;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final child = _foundationPageFor(settings);
    if (_requiresSignedInNonAnonymous(settings)) {
      return _protectedRoute(child: child, settings: settings);
    }
    return MaterialPageRoute(builder: (_) => child, settings: settings);
  }

  static Widget _foundationPageFor(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return const _FoundationPlaceholderPage(title: 'Login');
      case Routes.blockedAccount:
        return const AccountBlockedPage();
      case Routes.splash:
      case Routes.language:
        return const HomePage();
      case Routes.home:
        return const MenuPage();
      case Routes.menu:
        return const MenuPage();
      case Routes.library:
      case Routes.webLibrary:
        final args = settings.arguments;
        final categoryKey =
            args is Map ? args['categoryKey']?.toString() : null;
        final returnRoute =
            args is Map ? args['returnRoute']?.toString() : null;
        return LibraryPage(
          initialCategoryKey:
              categoryKey == null || categoryKey.isEmpty ? null : categoryKey,
          returnRoute: (returnRoute == null || returnRoute.isEmpty)
              ? Routes.menu
              : returnRoute,
        );
      case Routes.webCenterRegister:
        return const WebCenterRegisterPortalPage();
      case Routes.webCenterProfile:
        return const WebCenterProfilePage();
      case Routes.webCenterMedia:
        return const WebCenterMediaPage();
      case Routes.webCenterPricing:
        return const WebCenterPricingPage();
      case Routes.webCenterDocuments:
        return const WebCenterDocumentsPage();
      case Routes.webClinicianRegister:
        return const WebClinicianRegisterPortalPage();
      case Routes.webClinicianProfile:
        return const WebClinicianProfilePage();
      case Routes.webClinicianSessions:
        return const WebClinicianSessionsPage();
      case Routes.webClinicianDocuments:
        return const WebClinicianDocumentsPage();
      case Routes.webRegistrationSuccess:
        return const WebRegistrationSuccessPage();
      case Routes.booking:
        return const BookingPage();
      case Routes.clientDashboard:
        return const ClientDashboardPage();
      case Routes.clientSessions:
        return const ClientSessionsPage();
      case Routes.centerDashboard:
        return const CenterDashboardPage();
      case Routes.centerInbox:
        return const CenterInboxPage();
      case Routes.centerResidencies:
        return const CenterResidenciesPage();
      case Routes.clinicianOperations:
        return const ClinicianOperationsPage();
      case Routes.clinicianSessions:
        return const ClinicianSessionsPage();
      case Routes.bookingRequest:
        final args = settings.arguments;
        BookingRequestArgs? requestArgs;
        if (args is BookingRequestArgs) {
          requestArgs = args;
        } else if (args is Map) {
          final clinicianId = args['clinicianId']?.toString() ?? '';
          final clinicianName = args['clinicianName']?.toString() ?? '';
          if (clinicianId.isNotEmpty && clinicianName.isNotEmpty) {
            requestArgs = BookingRequestArgs(
              clinicianId: clinicianId,
              clinicianName: clinicianName,
            );
          }
        }
        if (requestArgs == null) {
          return const _FoundationPlaceholderPage(title: 'Route not found');
        }
        return BookingRequestPage(args: requestArgs);
      case Routes.centerBookingRequest:
        final args = settings.arguments;
        CenterBookingRequestArgs? requestArgs;
        if (args is CenterBookingRequestArgs) {
          requestArgs = args;
        } else if (args is Map) {
          final centerId = args['centerId']?.toString() ?? '';
          final centerName = args['centerName']?.toString() ?? '';
          if (centerId.isNotEmpty && centerName.isNotEmpty) {
            requestArgs = CenterBookingRequestArgs(
              centerId: centerId,
              centerName: centerName,
              centerType: args['centerType']?.toString() ?? '',
              hasDetoxUnit: args['hasDetoxUnit'] == true,
            );
          }
        }
        if (requestArgs == null) {
          return const _FoundationPlaceholderPage(title: 'Route not found');
        }
        return CenterBookingRequestPage(args: requestArgs);
      case Routes.myBookings:
        return const MyBookingsPage();
      case Routes.centers:
        final args = settings.arguments;
        final returnRoute =
            args is Map ? args['returnRoute']?.toString() : null;
        return CentersLandingPage(
          returnRoute: (returnRoute == null || returnRoute.isEmpty)
              ? Routes.menu
              : returnRoute,
        );
      case Routes.centersList:
        final args = settings.arguments;
        final category = args is Map ? args['category']?.toString() : null;
        final returnRoute =
            args is Map ? args['returnRoute']?.toString() : null;
        if (category == null || category.isEmpty) {
          return const _FoundationPlaceholderPage(title: 'Route not found');
        }
        return CentersListPage(
          category: category,
          returnRoute: (returnRoute == null || returnRoute.isEmpty)
              ? Routes.menu
              : returnRoute,
        );
      case Routes.centerDetails:
        final args = settings.arguments;
        CenterModel? center;
        String? centerId;
        if (args is Map) {
          final rawCenter = args['center'];
          if (rawCenter is CenterModel) center = rawCenter;
          centerId = args['centerId']?.toString();
        } else if (args is CenterModel) {
          center = args;
        }
        return CenterDetailsPage(center: center, centerId: centerId);
      case Routes.specialists:
        final args = settings.arguments;
        final returnRoute =
            args is Map ? args['returnRoute']?.toString() : null;
        return SpecialistsCategoriesPage(
          returnRoute: (returnRoute == null || returnRoute.isEmpty)
              ? Routes.menu
              : returnRoute,
        );
      case Routes.specialistsList:
        final args = settings.arguments;
        if (args is! Map<String, dynamic>) {
          return const _FoundationPlaceholderPage(title: 'Route not found');
        }
        return SpecialistsListPage(args: args);
      case Routes.specialistDetails:
        final args = settings.arguments;
        if (args is! Map<String, dynamic>) {
          return const _FoundationPlaceholderPage(title: 'Route not found');
        }
        return SpecialistDetailsPage(args: args);
      default:
        return _FoundationPlaceholderPage(
          title: settings.name ?? 'Route not found',
        );
    }
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
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final decision = snapshot.data!;
        if (decision.redirectToLogin) {
          return const _FoundationPlaceholderPage(title: 'Login');
        }
        if (decision.isBlocked) {
          return AccountBlockedPage(reason: decision.blockReason);
        }
        if (!decision.allowed) {
          return const _FoundationPlaceholderPage(title: 'Access unavailable');
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

    final protectsProvider =
        allowedRoles?.contains(_roleClinician) == true ||
            allowedRoles?.contains(_roleCenter) == true;
    final needsApproval = protectsProvider &&
        (access.role == _roleClinician || access.role == _roleCenter);
    if (needsApproval &&
        (access.approvalStatus.trim().toLowerCase() != 'approved' ||
            !access.isActive)) {
      return const _RouteAccessDecision(
        allowed: false,
        isBlocked: true,
        blockReason: 'Account is pending admin approval or inactive.',
      );
    }

    if (allowedRoles == null || allowedRoles!.isEmpty) {
      return const _RouteAccessDecision(allowed: true);
    }

    final role = access.role;
    return _RouteAccessDecision(
      allowed: role != null && allowedRoles!.contains(role),
    );
  }
}

class _FoundationPlaceholderPage extends StatelessWidget {
  const _FoundationPlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              isArabic
                  ? 'تم تجهيز أساس clean-core. لم يتم نقل صفحات المنتج بعد.'
                  : 'Clean-core foundation is prepared. Product pages are not migrated yet.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
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
