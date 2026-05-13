import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojects/app/locale_provider.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/storage/locale_storage.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

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

  Future<void> _setEnglish(WidgetRef ref) async {
    await LocaleStorage().write('en');
    ref.read(localeProvider.notifier).state = const Locale('en');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bg = _backgroundAsset(context);
    final languageIconSize =
        MediaQuery.sizeOf(context).width < 700 ? 46.0 : 60.0;

    return Directionality(
      textDirection: TextDirection.rtl,
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
              child: GestureDetector(
                onTap: () => _setEnglish(ref),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: const Color(0xFFFFE8A3).withValues(alpha: 0.22),
                    ),
                    boxShadow: [
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
                      return const Text(
                        'EN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFE8A3),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 92),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 14),
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
                          color:
                              const Color(0xFFD4AF37).withValues(alpha: 0.65),
                          blurRadius: 24,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'ابدأ الرحلة',
                          style: TextStyle(
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
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFFFFF4C2),
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
