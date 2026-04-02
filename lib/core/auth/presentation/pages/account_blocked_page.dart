import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';

class AccountBlockedPage extends StatelessWidget {
  const AccountBlockedPage({super.key, this.reason});

  final String? reason;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final trimmedReason = (reason ?? '').trim();

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: AppPageBackground(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: AppSurfaceCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.block_rounded,
                        size: 56,
                        color: AppColors.danger,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        isArabic
                            ? 'تم تقييد هذا الحساب'
                            : 'This account is blocked',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        isArabic
                            ? 'تم تسجيل الدخول بنجاح، لكن لا يمكن متابعة استخدام الحساب حاليًا. يرجى التواصل مع الإدارة.'
                            : 'You signed in successfully, but this account cannot continue into the app right now. Please contact support or admin.',
                        textAlign: TextAlign.center,
                      ),
                      if (trimmedReason.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.md),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.danger.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: AppColors.danger.withValues(alpha: 0.22),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                isArabic ? 'سبب التقييد' : 'Reason',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                trimmedReason,
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            if (!context.mounted) return;
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.login,
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.logout_rounded),
                          label: Text(
                            isArabic ? 'تسجيل الخروج' : 'Sign out',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
