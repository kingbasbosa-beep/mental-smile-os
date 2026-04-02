import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';

class AppShellActions {
  static PreferredSizeWidget buildAppBar(
    BuildContext context, {
    required String title,
    bool canLogout = true,
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
    );
  }
}
