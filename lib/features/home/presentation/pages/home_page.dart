import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Welcome/legacy entry surface. The operational shell entry is MenuPage,
  // reached through Routes.menu and the Routes.home alias in AppRouter.
  bool _isArabic(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode.toLowerCase() == 'ar';
  }

  void _goBack(BuildContext context) {
    AppShellActions.goBackOrMenu(context);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final l10n = AppLocalizations.of(context)!;
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final hasUser = FirebaseAuth.instance.currentUser != null;

    final description = l10n.homeStartJourney;

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
                                      if (!hasUser)
                                        OutlinedButton.icon(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed(Routes.login);
                                          },
                                          icon: const Icon(
                                            Icons.login_rounded,
                                            size: 18,
                                          ),
                                          label: Text(l10n.homeLogin),
                                        ),
                                      OutlinedButton.icon(
                                        onPressed: () => _goBack(context),
                                        icon: Image.asset(
                                          Directionality.of(context) ==
                                                  TextDirection.rtl
                                              ? 'assets/branding/navigation/back/back_right_gold.png'
                                              : 'assets/branding/navigation/back/back_left_gold.png',
                                          width: 18,
                                          height: 18,
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.arrow_back_rounded,
                                              size: 18,
                                            );
                                          },
                                        ),
                                        label: Text(l10n.homeBack),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.lg),
                                AppLogoWordmark(
                                  width: isMobile ? 154 : 240,
                                  height: isMobile ? 90 : 140,
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
