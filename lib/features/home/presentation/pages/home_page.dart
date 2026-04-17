import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  bool _isArabic(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode.toLowerCase() == 'ar';
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }

  void _goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).maybePop();
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.menu,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final hasUser = FirebaseAuth.instance.currentUser != null;

    final description =
        isArabic ? 'ابدأ رحلتك نحو التعافي' : 'Start your healing journey';

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              normalizeAssetPath('assets/c7_branding/home/home_bg.png'),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(decoration: AppDecorations.pageBackground());
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.warmIvory.withValues(alpha: 0.18),
                    AppColors.warmIvory.withValues(alpha: 0.46),
                    AppColors.warmIvory.withValues(alpha: 0.78),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 700;

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1180),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? AppSpacing.md : AppSpacing.xxl,
                          vertical: isMobile ? AppSpacing.md : AppSpacing.lg,
                        ),
                        child: Column(
                          children: [
                            Row(
                              textDirection: textDirection,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    alignment: isArabic
                                        ? WrapAlignment.start
                                        : WrapAlignment.start,
                                    spacing: AppSpacing.sm,
                                    runSpacing: AppSpacing.sm,
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(Routes.language);
                                        },
                                        icon: const Icon(
                                          Icons.language_rounded,
                                          size: 16,
                                        ),
                                        label: Text(
                                            isArabic ? 'اللغة' : 'Language'),
                                      ),
                                      OutlinedButton.icon(
                                        onPressed: hasUser
                                            ? () => _logout(context)
                                            : () {
                                                Navigator.of(context)
                                                    .pushNamed(Routes.login);
                                              },
                                        icon: Icon(
                                          hasUser
                                              ? Icons.logout_rounded
                                              : Icons.login_rounded,
                                          size: 18,
                                        ),
                                        label: Text(
                                          hasUser
                                              ? (isArabic
                                                  ? 'تسجيل الخروج'
                                                  : 'Logout')
                                              : (isArabic
                                                  ? 'تسجيل الدخول'
                                                  : 'Login'),
                                        ),
                                      ),
                                      OutlinedButton.icon(
                                        onPressed: () => _goBack(context),
                                        icon: const Icon(
                                          Icons.arrow_back_rounded,
                                          size: 18,
                                        ),
                                        label: Text(isArabic ? 'رجوع' : 'Back'),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.lg),
                                const AppLogoWordmark(
                                  width: 240,
                                  height: 140,
                                ),
                              ],
                            ),
                            const Spacer(),
                            AppSurfaceCard(
                              color: Colors.white.withValues(alpha: 0.70),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.lg,
                                  vertical: AppSpacing.xl,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      description,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                        fontSize: isMobile ? 28 : 40,
                                        color: const Color(0xFF6E4E0E),
                                        shadows: const [
                                          Shadow(
                                            blurRadius: 12,
                                            color: Color(0xCCFFFFFF),
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Text(
                                      isArabic
                                          ? 'واجهة هادئة وواضحة تساعدك على الوصول السريع للدعم والمسارات المناسبة.'
                                          : 'A calm, clear entry point to support, guidance, and the right care path.',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: AppColors.obsidian
                                                .withValues(alpha: 0.78),
                                          ),
                                    ),
                                    const SizedBox(height: AppSpacing.xl),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: isMobile ? 320 : 420,
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 58,
                                        child: FilledButton.icon(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed(Routes.menu);
                                          },
                                          icon: const Icon(Icons.apps_rounded),
                                          label: Text(
                                            isArabic
                                                ? 'ابدأ الآن'
                                                : 'Start now',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

