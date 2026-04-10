import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class AppShellActions {
  static PreferredSizeWidget buildAppBar(
    BuildContext context, {
    required String title,
    bool canLogout = true,
    bool showAccountBadge = true,
  }) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return AppBar(
      title: Text(title),
      backgroundColor: Colors.white.withValues(alpha: 0.90),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).maybePop();
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.menu,
              (route) => false,
            );
          }
        },
        icon: const Icon(Icons.arrow_back),
        tooltip: isArabic ? 'رجوع' : 'Back',
      ),
      actions: [
        if (canLogout)
          IconButton(
            tooltip: isArabic ? 'تسجيل الخروج' : 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.login,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded, color: AppColors.deepTeal),
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
            final identity =
                (user.email ?? '').trim().isNotEmpty ? user.email!.trim() : user.uid;

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              alignment: Alignment.centerRight,
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
                      color: AppColors.deepTeal.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.deepTeal.withValues(alpha: 0.22),
                      ),
                    ),
                    child: Text(
                      isArabic ? 'الحساب الحالي: $role' : 'Current account: $role',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.deepTeal,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Text(
                    identity,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black54,
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
      case 'admin':
        return isArabic ? 'أدمن' : 'Admin';
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
