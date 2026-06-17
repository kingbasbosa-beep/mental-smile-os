import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/core/auth/account_access_service.dart';
import 'package:mental_smile_os/shared/ui_kit/app_design_system.dart';

class AppShellActions {
  static void goBackOrMenu(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).maybePop();
    } else {
      returnToMenu(context);
    }
  }

  static void returnToMenu(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.menu,
      (route) => false,
    );
  }

  static Future<void> signOutToLogin(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.exitSocialLinks,
      (route) => false,
    );
  }

  static Widget buildOverlayActions({
    Key? key,
    VoidCallback? onBack,
    VoidCallback? onLogout,
    bool showBack = true,
    bool showLogout = false,
    bool showLogoutLabel = true,
    EdgeInsetsGeometry padding = const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.md,
      AppSpacing.xs,
      AppSpacing.md,
      0,
    ),
  }) {
    return Align(
      key: key,
      alignment: Alignment.topCenter,
      child: SafeArea(
        bottom: false,
        child: Transform.translate(
          offset: const Offset(0, -6),
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                if (showBack)
                  _GoldShellActionButton(
                    tooltip: 'رجوع',
                    onPressed: onBack,
                    child: const _GoldBackIcon(compact: true),
                  )
                else
                  const SizedBox(width: 48, height: 48),
                const Spacer(),
                if (showLogout)
                  _GoldLogoutAction(
                    onPressed: onLogout,
                    showLabel: showLogoutLabel,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static PreferredSizeWidget buildAppBar(
    BuildContext context, {
    required String title,
    bool canLogout = false,
    bool showAccountBadge = true,
    bool showTitle = true,
  }) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return AppBar(
      title: showTitle
          ? Text(
              title,
              style: const TextStyle(
                color: Color(0xFFC9A75B),
                fontWeight: FontWeight.w800,
              ),
            )
          : const SizedBox.shrink(),
      backgroundColor: const Color(0xFF0F1316).withValues(alpha: 0.96),
      foregroundColor: const Color(0xFFC9A75B),
      elevation: 0,
      leading: IconButton(
        onPressed: () => goBackOrMenu(context),
        icon: const _GoldBackIcon(compact: true),
        tooltip: isArabic ? 'رجوع' : 'Back',
      ),
      actions: [
        if (canLogout)
          IconButton(
            tooltip: isArabic ? 'تسجيل الخروج' : 'Logout',
            onPressed: () => signOutToLogin(context),
            icon: const Icon(Icons.logout_rounded, color: Color(0xFFC9A75B)),
          ),
      ],
      bottom: showAccountBadge
          ? PreferredSize(
              preferredSize: const Size.fromHeight(34),
              child: const _AccountRoleBanner(),
            )
          : null,
    );
  }
}

class _GoldShellActionButton extends StatelessWidget {
  const _GoldShellActionButton({
    required this.child,
    required this.tooltip,
    this.onPressed,
  });

  final Widget child;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: child,
        ),
      ),
    );
  }
}

class _GoldLogoutAction extends StatelessWidget {
  const _GoldLogoutAction({
    required this.showLabel,
    this.onPressed,
  });

  final bool showLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'تسجيل الخروج',
      child: Tooltip(
        message: 'تسجيل الخروج',
        child: GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF1B1007).withValues(alpha: 0.50),
                  border: Border.all(
                    color: const Color(0xFFFFD98A).withValues(alpha: 0.48),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD98A).withValues(alpha: 0.26),
                      blurRadius: 14,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: onPressed == null
                      ? const Color(0xFFFFE7B2).withValues(alpha: 0.46)
                      : const Color(0xFFFFE7B2),
                  size: 21,
                ),
              ),
              if (showLabel) ...[
                const SizedBox(height: 3),
                Text(
                  'خروج',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xFFFFD98A),
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        color: const Color(0xFFE7A94C).withValues(alpha: 0.30),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GoldBackIcon extends StatelessWidget {
  const _GoldBackIcon({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 44.0 : 52.0;
    final iconSize = compact ? 22.0 : 26.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1B1007).withValues(alpha: 0.50),
        border: Border.all(
          color: const Color(0xFFFFD98A).withValues(alpha: 0.56),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD98A).withValues(alpha: 0.34),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: const Color(0xFFE7A94C).withValues(alpha: 0.24),
            blurRadius: 26,
            spreadRadius: 2,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Image.asset(
        Directionality.of(context) == TextDirection.rtl
            ? 'assets/branding/navigation/back/back_right_gold.png'
            : 'assets/branding/navigation/back/back_left_gold.png',
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Directionality.of(context) == TextDirection.rtl
                ? Icons.arrow_forward_rounded
                : Icons.arrow_back_rounded,
            color: const Color(0xFFFFE7B2),
            size: iconSize,
          );
        },
      ),
    );
  }
}

class _AccountRoleBanner extends StatelessWidget {
  const _AccountRoleBanner();

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, authSnapshot) {
        final user = authSnapshot.data;
        if (user == null || user.isAnonymous) {
          return const SizedBox(height: 8);
        }

        return FutureBuilder<SignedInAccessState>(
          future: AccountAccessService().resolve(user),
          builder: (context, accessSnapshot) {
            final access = accessSnapshot.data;
            final role = _roleLabel(isArabic, access?.role);
            final identity = (user.email ?? '').trim().isNotEmpty
                ? user.email!.trim()
                : user.uid;
            final identityMaxWidth = (MediaQuery.sizeOf(context).width - 32)
                .clamp(120.0, 420.0)
                .toDouble();

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              color: const Color(0xFF0F1316).withValues(alpha: 0.96),
              alignment:
                  isArabic ? Alignment.centerRight : Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12181D).withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: const Color(0xFFD8B26A).withValues(alpha: 0.18),
                      ),
                    ),
                    child: Text(
                      isArabic
                          ? 'الحساب الحالي: $role'
                          : 'Current account: $role',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFFC9A75B),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: identityMaxWidth),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        identity,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: const Color(0xFF314A5C)
                                      .withValues(alpha: 0.88),
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _roleLabel(bool isArabic, String? role) {
    switch (role) {
      case 'owner':
        return isArabic ? 'Owner' : 'Owner';
      case 'monitoring_operator':
        return isArabic ? 'Monitoring' : 'Monitoring';
      case 'registry_steward':
        return isArabic ? 'Registry' : 'Registry';
      case 'declaration_reviewer':
        return isArabic ? 'Review' : 'Review';
      case 'support_observer':
        return isArabic ? 'Support' : 'Support';
      case 'client':
        return isArabic ? 'عميل' : 'Client';
      case 'center':
        return isArabic ? 'مركز' : 'Center';
      case 'clinician':
        return isArabic ? 'أخصائي' : 'Clinician';
      default:
        return isArabic ? 'غير معروف' : 'Unknown';
    }
  }
}
