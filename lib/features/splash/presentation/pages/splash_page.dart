import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_smile_os/app/locale_provider.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/core/storage/locale_storage.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool _languagePressed = false;

  String _backgroundAsset(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return 'assets/branding/splash/splash_mobile_v1.jpg';
    }

    if (width < 1100) {
      return 'assets/branding/splash/splash_tablet_v1.jpg';
    }

    return 'assets/branding/splash/splash_web_v1.jpg';
  }

  Future<void> _toggleLocale(Locale locale) async {
    final nextCode = locale.languageCode.toLowerCase() == 'ar' ? 'en' : 'ar';
    await LocaleStorage().write(nextCode);
    ref.read(localeProvider.notifier).state = Locale(nextCode);
  }

  @override
  Widget build(BuildContext context) {
    final bg = _backgroundAsset(context);
    final languageIconSize =
        MediaQuery.sizeOf(context).width < 700 ? 46.0 : 60.0;
    final locale = ref.watch(localeProvider);
    final activeLocale = locale ?? Localizations.localeOf(context);
    final isArabic = activeLocale.languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                bg,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.25),
              ),
            ),
            Positioned(
              top: 20,
              right: 96,
              child: Tooltip(
                message: isArabic ? 'English' : 'العربية',
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _languagePressed = true),
                  onTapCancel: () => setState(() => _languagePressed = false),
                  onTapUp: (_) => setState(() => _languagePressed = false),
                  onTap: () => _toggleLocale(activeLocale),
                  child: AnimatedScale(
                    scale: _languagePressed ? 0.96 : 1,
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOutCubic,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 140),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(
                          alpha: _languagePressed ? 0.24 : 0.14,
                        ),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: const Color(0xFFFFE8A3).withValues(
                            alpha: _languagePressed ? 0.56 : 0.34,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withValues(
                              alpha: _languagePressed ? 0.34 : 0.18,
                            ),
                            blurRadius: _languagePressed ? 20 : 12,
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.22),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/branding/language/en_gold.png',
                        width: languageIconSize,
                        height: languageIconSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Text(
                            isArabic ? 'EN' : 'AR',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFE8A3),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 92),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(Routes.login);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFFFF4C2),
                              Color(0xFFD4AF37),
                              Color(0xFF7A4E12),
                            ],
                          ),
                          border: Border.all(
                            color: const Color(0xFFFFE8A3),
                            width: 1.3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD4AF37)
                                  .withValues(alpha: 0.65),
                              blurRadius: 24,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isArabic ? 'ابدأ الرحلة' : 'Start Journey',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFFF4F1E8),
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.3,
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 6,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.portalHome);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFFFE8A3),
                        backgroundColor: Colors.black.withValues(alpha: 0.18),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                          side: BorderSide(
                            color: const Color(0xFFFFE8A3)
                                .withValues(alpha: 0.34),
                          ),
                        ),
                      ),
                      child: Text(
                        isArabic
                            ? 'العودة إلى بوابة الويب'
                            : 'Back to Web Portal',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
