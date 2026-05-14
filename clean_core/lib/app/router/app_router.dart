import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/core/auth/presentation/pages/account_blocked_page.dart';

import 'routes.dart';

const String _roleAdmin = 'admin';
const String _roleClinician = 'clinician';
const String _roleCenter = 'center';
const String _roleClient = 'client';

class AppRouter {
  static const Set<String> _clinicianOnlyRoutes = {
    Routes.clinicianOperations,
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
    Routes.myBookings,
    Routes.bookingRequest,
    Routes.centerBookingRequest,
  };

  static Set<String>? _requiredRoles(String? routeName) {
    if (routeName == null) return null;
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
      case Routes.home:
      case Routes.menu:
        return const _FoundationPlaceholderPage(title: 'Mental Smile');
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
