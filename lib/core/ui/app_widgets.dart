import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppDecorations {
  static BoxDecoration pageBackground() {
    return const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(0.0, -0.22),
        radius: 1.3,
        colors: [
          AppColors.warmIvory,
          AppColors.sandstone,
        ],
      ),
    );
  }

  static BoxDecoration surfaceCard({
    Color? color,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white.withValues(alpha: 0.78),
      borderRadius: BorderRadius.circular(AppRadii.xl),
      border: Border.all(
        color: borderColor ?? AppColors.mutedGold.withValues(alpha: 0.18),
      ),
      boxShadow: AppShadows.card,
    );
  }

  static BoxDecoration softPanel({
    Color? color,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white.withValues(alpha: 0.88),
      borderRadius: BorderRadius.circular(AppRadii.lg),
      border: Border.all(
        color: borderColor ?? AppColors.mutedGold.withValues(alpha: 0.14),
      ),
    );
  }
}

class AppPageBackground extends StatelessWidget {
  const AppPageBackground({
    super.key,
    required this.child,
    this.showPattern = true,
    this.topAccent = true,
  });

  final Widget child;
  final bool showPattern;
  final bool topAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppDecorations.pageBackground(),
      child: Stack(
        children: [
          if (showPattern)
            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.045,
                  child: CustomPaint(
                    painter: const _PagePatternPainter(
                      color: AppColors.deepTeal,
                    ),
                  ),
                ),
              ),
            ),
          if (topAccent)
            const Positioned(
              top: 6,
              left: 0,
              right: 0,
              child: Center(
                child: Opacity(
                  opacity: 0.11,
                  child: CustomPaint(
                    size: Size(160, 84),
                    painter: _PortalPainter(AppColors.mutedGold),
                  ),
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class AppLogoWordmark extends StatelessWidget {
  const AppLogoWordmark({
    super.key,
    this.width = 320,
    this.height,
  });

  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/c6_library/brand/logo_wordmark.png',
        width: width,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Text(
            'Mental Smile',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.deepTeal,
                  fontWeight: FontWeight.w800,
                ),
          );
        },
      ),
    );
  }
}

class AppHeroHeader extends StatelessWidget {
  const AppHeroHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.logoWidth = 320,
  });

  final String title;
  final String? subtitle;
  final double logoWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppLogoWordmark(width: logoWidth),
        const SizedBox(height: AppSpacing.md),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.mist,
                  height: 1.55,
                ),
          ),
        ],
      ],
    );
  }
}

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
    this.color,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: AppDecorations.surfaceCard(
        color: color,
        borderColor: borderColor,
      ),
      child: child,
    );
  }
}

class AppSectionPanel extends StatelessWidget {
  const AppSectionPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.color,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: AppDecorations.softPanel(
        color: color,
        borderColor: borderColor,
      ),
      child: child,
    );
  }
}

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    this.color = AppColors.deepTeal,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class AppMessageBanner extends StatelessWidget {
  const AppMessageBanner({
    super.key,
    required this.message,
    this.color = AppColors.softTerracotta,
  });

  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.sm),
        border: Border.all(
          color: color.withValues(alpha: 0.24),
        ),
      ),
      child: Text(
        message,
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF8A4330),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: AppSurfaceCard(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 34,
                color: AppColors.deepTeal,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.obsidian,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration appInputDecoration({
  required BuildContext context,
  required String label,
  required IconData icon,
  String? hintText,
  Widget? suffixIcon,
}) {
  final theme = Theme.of(context);
  return InputDecoration(
    labelText: label,
    hintText: hintText,
    prefixIcon: Icon(
      icon,
      color: theme.colorScheme.primary,
    ),
    suffixIcon: suffixIcon,
  );
}

ButtonStyle appDestructiveButtonStyle() {
  return OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF9E3B3B),
    side: const BorderSide(
      color: Color(0xFFD9A6A6),
    ),
    backgroundColor: Colors.white.withValues(alpha: 0.82),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.md),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
  );
}

class _PortalPainter extends CustomPainter {
  const _PortalPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.85;

    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(w * 0.5, 0)
      ..quadraticBezierTo(w * 0.72, h * 0.28, w * 0.82, h * 0.54)
      ..quadraticBezierTo(w * 0.67, h * 0.60, w * 0.5, h)
      ..moveTo(w * 0.5, 0)
      ..quadraticBezierTo(w * 0.28, h * 0.28, w * 0.18, h * 0.54)
      ..quadraticBezierTo(w * 0.33, h * 0.60, w * 0.5, h)
      ..moveTo(w * 0.36, h * 0.48)
      ..quadraticBezierTo(w * 0.5, h * 0.18, w * 0.64, h * 0.48);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PagePatternPainter extends CustomPainter {
  const _PagePatternPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.55;

    const step = 120.0;
    const box = 42.0;

    for (double x = -20; x < size.width + step; x += step) {
      for (double y = 36; y < size.height + step; y += step) {
        final rect = Rect.fromLTWH(x, y, box, box);
        canvas.drawRect(rect, paint);

        final diamond = Path()
          ..moveTo(x + box / 2, y + 7)
          ..lineTo(x + box - 7, y + box / 2)
          ..lineTo(x + box / 2, y + box - 7)
          ..lineTo(x + 7, y + box / 2)
          ..close();
        canvas.drawPath(diamond, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
