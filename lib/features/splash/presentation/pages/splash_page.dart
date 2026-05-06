import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class SplashPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final bg = _backgroundAsset(context);

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
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.language);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8A3).withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFFFF4C2),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
                        blurRadius: 14,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'اللغة',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5B3A0E),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.language,
                        size: 18,
                        color: Color(0xFF5B3A0E),
                      ),
                    ],
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
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
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
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.65),
                          blurRadius: 24,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
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
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xFFFFF4C2),
                          size: 28,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ],
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
