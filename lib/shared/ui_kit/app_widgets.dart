import 'package:flutter/material.dart';
import 'package:mental_smile_os/shared/utils/asset_path_utils.dart';

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
    this.showDecorativeLayers = true,
  });

  final Widget child;
  final bool showPattern;
  final bool topAccent;
  final bool showDecorativeLayers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: AppDecorations.pageBackground(),
      child: Stack(
        children: [
          if (showDecorativeLayers)
            Positioned(
              top: -40,
              left: -20,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.10,
                  child: Image.asset(
                    normalizeAssetPath('c7_branding/home/hero_art.png'),
                    width: 260,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          if (showDecorativeLayers)
            Positioned(
              right: -30,
              bottom: -10,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.08,
                  child: Image.asset(
                    normalizeAssetPath('c7_branding/home/home_bg.png'),
                    width: 300,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          if (showDecorativeLayers && showPattern)
            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.045,
                  child: const CustomPaint(
                    painter: _PagePatternPainter(
                      color: AppColors.deepTeal,
                    ),
                  ),
                ),
              ),
            ),
          if (showDecorativeLayers && topAccent)
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
        normalizeAssetPath('c6_library/brand/logo_wordmark.png'),
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
    return AppSurfaceCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xl,
      ),
      color: Colors.white.withValues(alpha: 0.76),
      borderColor: AppColors.mutedGold.withValues(alpha: 0.18),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.mutedGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(
                color: AppColors.mutedGold.withValues(alpha: 0.18),
              ),
            ),
            child: Text(
              'Mental Smile',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.deepTeal,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
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
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.mist,
                      height: 1.65,
                    ),
              ),
            ),
          ],
        ],
      ),
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
      clipBehavior: Clip.antiAlias,
      decoration: AppDecorations.surfaceCard(
        color: color,
        borderColor: borderColor,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white.withValues(alpha: 0.96),
                    (color ?? Colors.white).withValues(alpha: 0.86),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -18,
            right: -18,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mutedGold.withValues(alpha: 0.09),
              ),
              child: const SizedBox(width: 88, height: 88),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              color: AppColors.mutedGold.withValues(alpha: 0.20),
            ),
          ),
          Positioned(
            top: 18,
            right: 18,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  normalizeAssetPath('c7_branding/logo/logo_mark.png'),
                  width: 58,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.025,
                child: const CustomPaint(
                  painter: _PagePatternPainter(color: AppColors.deepTeal),
                ),
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: child,
          ),
        ],
      ),
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
      clipBehavior: Clip.antiAlias,
      decoration: AppDecorations.softPanel(
        color: color,
        borderColor: borderColor,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white.withValues(alpha: 0.92),
                    (color ?? Colors.white).withValues(alpha: 0.84),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 3,
              color: AppColors.mutedGold.withValues(alpha: 0.15),
            ),
          ),
          Positioned(
            bottom: -16,
            left: -16,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.deepTeal.withValues(alpha: 0.05),
              ),
              child: const SizedBox(width: 72, height: 72),
            ),
          ),
          Padding(
            padding: padding,
            child: child,
          ),
        ],
      ),
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

class GoldPageTitle extends StatelessWidget {
  const GoldPageTitle({
    super.key,
    required this.title,
    this.padding = const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.lg,
      AppSpacing.sm,
      AppSpacing.lg,
      AppSpacing.md,
    ),
  });

  final String title;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: padding,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.mutedGold,
              fontWeight: FontWeight.w900,
              height: 1.2,
              shadows: [
                Shadow(
                  color: AppColors.mutedGold.withValues(alpha: 0.24),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
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

class PremiumEmptyState extends StatelessWidget {
  const PremiumEmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
  });

  final String title;
  final String? message;
  final IconData? icon;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: padding,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.xxl,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1316).withValues(alpha: 0.84),
                borderRadius: BorderRadius.circular(AppRadii.lg),
                border: Border.all(
                  color: AppColors.mutedGold.withValues(alpha: 0.24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mutedGold.withValues(alpha: 0.12),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                  ...AppShadows.card,
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 34,
                      color: AppColors.mutedGold.withValues(alpha: 0.88),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFFFF4DA),
                      fontWeight: FontWeight.w900,
                      height: 1.35,
                    ),
                  ),
                  if (message != null && message!.trim().isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.76),
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoldTabItem {
  const GoldTabItem({
    required this.key,
    required this.label,
  });

  final String key;
  final String label;
}

class GoldTabBar extends StatelessWidget {
  const GoldTabBar({
    super.key,
    required this.items,
    required this.selectedKey,
    required this.onSelected,
    this.padding = const EdgeInsets.fromLTRB(12, 12, 12, 8),
  });

  final List<GoldTabItem> items;
  final String selectedKey;
  final ValueChanged<String> onSelected;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Wrap(
        spacing: 13,
        runSpacing: 8,
        children: [
          for (final item in items)
            _GoldTabButton(
              label: item.label,
              selected: selectedKey == item.key,
              onTap: () => onSelected(item.key),
            ),
        ],
      ),
    );
  }
}

class _GoldTabButton extends StatelessWidget {
  const _GoldTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const gold = AppColors.mutedGold;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: Duration.zero,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF1B1007).withValues(alpha: 0.62)
                : Colors.black.withValues(alpha: 0.26),
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(
              color: selected
                  ? gold.withValues(alpha: 0.72)
                  : gold.withValues(alpha: 0.26),
              width: selected ? 1.2 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: gold.withValues(alpha: 0.16),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selected
                      ? const Color(0xFFFFE8A6)
                      : const Color(0xFFFFF4D4).withValues(alpha: 0.82),
                  fontWeight: FontWeight.w900,
                  shadows: selected
                      ? [
                          Shadow(
                            color: gold.withValues(alpha: 0.27),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
          ),
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
