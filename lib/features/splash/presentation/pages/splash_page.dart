import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scarabController;

  static const Color _colorWarmIvory = Color(0xFFFAF8F5);
  static const Color _colorSandstone = Color(0xFFEBE6D8);
  static const Color _colorMutedGold = Color(0xFFD4AF37);
  static const Color _colorDeepTeal = Color(0xFF1A4B4F);

  @override
  void initState() {
    super.initState();
    _scarabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
      lowerBound: 0.45,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scarabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode.toLowerCase() == 'ar';
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final scheme = Theme.of(context).colorScheme;
    final topButtonAlignment =
        isArabic ? Alignment.topLeft : Alignment.topRight;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.0, -0.25),
              radius: 1.28,
              colors: [_colorWarmIvory, _colorSandstone],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: 0.06,
                      child: CustomPaint(
                        painter: _BackgroundPatternPainter(
                          color: _colorDeepTeal,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Opacity(
                      opacity: 0.12,
                      child: CustomPaint(
                        size: Size(170, 90),
                        painter: _GeometricPortalPainter(_colorMutedGold),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: topButtonAlignment,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.language);
                      },
                      icon: const Icon(Icons.language_rounded),
                      label: Text(isArabic ? 'اللغة' : 'Language'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _colorDeepTeal,
                        side: const BorderSide(color: _colorDeepTeal, width: 1),
                        backgroundColor: Colors.white.withValues(alpha: 0.72),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.78,
                                child: Image.asset(
                                  'assets/c6_library/brand/logo_wordmark.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Text(
                                      'Mental Smile',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: _colorDeepTeal,
                                        fontSize: 44,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          AnimatedBuilder(
                            animation: _scarabController,
                            builder: (context, child) {
                              final t = _scarabController.value;
                              return Opacity(
                                opacity: t,
                                child: Transform.scale(
                                  scale: 0.92 + (t * 0.08),
                                  child: child,
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 42,
                              height: 42,
                              child: CustomPaint(
                                painter: _ScarabPainter(
                                  color: _colorDeepTeal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 230,
                            height: 56,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                  Routes.login,
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: _colorDeepTeal,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                isArabic ? 'دخول' : 'Enter',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isArabic ? 'مرحبًا بك' : 'Welcome',
                            style: TextStyle(
                              color: scheme.onSurface.withValues(alpha: 0.72),
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GeometricPortalPainter extends CustomPainter {
  final Color color;
  const _GeometricPortalPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, 0);
    path.quadraticBezierTo(w * 0.72, h * 0.30, w * 0.82, h * 0.55);
    path.quadraticBezierTo(w * 0.68, h * 0.58, w * 0.5, h);

    path.moveTo(w * 0.5, 0);
    path.quadraticBezierTo(w * 0.28, h * 0.30, w * 0.18, h * 0.55);
    path.quadraticBezierTo(w * 0.32, h * 0.58, w * 0.5, h);

    path.moveTo(w * 0.34, h * 0.48);
    path.quadraticBezierTo(w * 0.5, h * 0.16, w * 0.66, h * 0.48);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScarabPainter extends CustomPainter {
  final Color color;
  const _ScarabPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.1
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final body = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.56),
        width: w * 0.34,
        height: h * 0.38,
      ),
      Radius.circular(w * 0.10),
    );
    canvas.drawRRect(body, stroke);

    canvas.drawLine(
      Offset(w * 0.5, h * 0.38),
      Offset(w * 0.5, h * 0.74),
      stroke,
    );

    final headRect = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.24),
      width: w * 0.28,
      height: h * 0.18,
    );
    canvas.drawArc(headRect, 3.14, 3.14, false, stroke);

    final leftWing = Path()
      ..moveTo(w * 0.34, h * 0.42)
      ..quadraticBezierTo(w * 0.12, h * 0.36, w * 0.10, h * 0.58)
      ..quadraticBezierTo(w * 0.12, h * 0.76, w * 0.28, h * 0.88);

    final rightWing = Path()
      ..moveTo(w * 0.66, h * 0.42)
      ..quadraticBezierTo(w * 0.88, h * 0.36, w * 0.90, h * 0.58)
      ..quadraticBezierTo(w * 0.88, h * 0.76, w * 0.72, h * 0.88);

    canvas.drawPath(leftWing, stroke);
    canvas.drawPath(rightWing, stroke);

    canvas.drawLine(
      Offset(w * 0.38, h * 0.18),
      Offset(w * 0.28, h * 0.05),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.62, h * 0.18),
      Offset(w * 0.72, h * 0.05),
      stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BackgroundPatternPainter extends CustomPainter {
  final Color color;
  const _BackgroundPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6;

    const step = 110.0;
    const box = 46.0;

    for (double x = -20; x < size.width + step; x += step) {
      for (double y = 40; y < size.height + step; y += step) {
        final rect = Rect.fromLTWH(x, y, box, box);
        canvas.drawRect(rect, paint);

        final diamond = Path()
          ..moveTo(x + box / 2, y + 8)
          ..lineTo(x + box - 8, y + box / 2)
          ..lineTo(x + box / 2, y + box - 8)
          ..lineTo(x + 8, y + box / 2)
          ..close();
        canvas.drawPath(diamond, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
