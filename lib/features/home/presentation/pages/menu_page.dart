import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode.toLowerCase() == 'ar';
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    final cards = <_MenuCardData>[
      _MenuCardData(
        title: isArabic ? 'الأخصائيون' : 'Specialists',
        subtitle: isArabic
            ? 'استعرض التخصصات وابدأ طلب الحجز'
            : 'Browse specialists and request a booking',
        icon: Icons.psychology_alt_outlined,
        route: Routes.specialists,
        accent: AppColors.accentLavender,
      ),
      _MenuCardData(
        title: isArabic ? 'المراكز' : 'Centers',
        subtitle: isArabic
            ? 'استعرض المراكز والخدمات المتاحة'
            : 'Browse centers and available services',
        icon: Icons.apartment_outlined,
        route: Routes.centers,
        accent: AppColors.mutedGold,
      ),
      _MenuCardData(
        title: isArabic ? 'المكتبة' : 'Library',
        subtitle: isArabic
            ? 'مواد ومحتوى داعم وإرشادي'
            : 'Supportive and educational content',
        icon: Icons.auto_stories_outlined,
        route: Routes.library,
        accent: AppColors.softTerracotta,
      ),
      _MenuCardData(
        title: isArabic ? 'دعم المتعافي' : 'Recovered Support',
        subtitle: isArabic
            ? 'دعم هادئ للتعافي مع المختصين والمراكز وطلب دعم منظم'
            : 'A calm recovery path across specialists, centers, and structured support',
        icon: Icons.healing_outlined,
        route: Routes.addiction,
        accent: AppColors.success,
      ),
      _MenuCardData(
        title: isArabic
            ? 'رعاية أسر ذوي الاحتياجات الخاصة'
            : 'Special Needs Families',
        subtitle: isArabic
            ? 'مسار أسري داعم وخطوات واضحة للوصول للمساندة المناسبة'
            : 'A family-aware support path with clear next steps',
        icon: Icons.family_restroom_outlined,
        route: Routes.specialNeeds,
        accent: AppColors.info,
      ),
    ];

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _menuBackgroundAsset(context),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(color: Color(0xFF02070C));
              },
            ),
            ColoredBox(
              color: Colors.black.withValues(alpha: 0.36),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = constraints.maxHeight;
                  final isMobile = width < 700;
                  final usePentagon = width >= 700 && height >= 420;
                  final avatarSize = isMobile ? 74.0 : 90.0;
                  final avatarTop = isMobile ? 54.0 : height * 0.13;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: avatarTop,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: () {
                            AppAnalytics.logChatOpened('general');
                            Navigator.of(context).pushNamed(Routes.chat);
                          },
                          child: CircleAvatar(
                            radius: avatarSize / 2,
                            backgroundColor: AppColors.mutedGold.withValues(
                              alpha: 0.34,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                normalizeAssetPath(
                                  'assets/c5/avatars/avatar_admin_support.png',
                                ),
                                width: avatarSize,
                                height: avatarSize,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: avatarSize,
                                    height: avatarSize,
                                    color: AppColors.deepTeal.withValues(
                                      alpha: 0.20,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.support_agent_rounded,
                                      color: AppColors.deepTeal,
                                      size: 28,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          isMobile ? 16 : 32,
                          isMobile ? 140 : 110,
                          isMobile ? 16 : 32,
                          24,
                        ),
                        child: usePentagon
                            ? _MenuPentagonLayout(
                                cards: cards,
                                compact: width < 1100,
                              )
                            : _MenuWrapLayout(cards: cards),
                      ),
                    ],
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

class _MenuCardData {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final Color accent;

  const _MenuCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.accent,
  });
}

String _menuBackgroundAsset(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width >= 1100) {
    return 'assets/branding/menu/desktop/menu_desktop_bg.png';
  }
  if (width >= 700) {
    return 'assets/branding/menu/tablet/menu_tablet_bg.png';
  }
  return 'assets/branding/menu/mobile/menu_mobile_bg.png';
}

class _MenuPentagonLayout extends StatelessWidget {
  const _MenuPentagonLayout({
    required this.cards,
    required this.compact,
  });

  final List<_MenuCardData> cards;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final layoutWidth = compact ? 620.0 : 760.0;
    final layoutHeight = compact ? 390.0 : 430.0;
    final itemWidth = compact ? 132.0 : 150.0;

    return Center(
      child: SizedBox(
        width: layoutWidth,
        height: layoutHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _MenuNode(
              item: cards[2],
              width: itemWidth,
              left: (layoutWidth - itemWidth) / 2,
              top: 0,
            ),
            _MenuNode(
              item: cards[0],
              width: itemWidth,
              left: layoutWidth * 0.10,
              top: layoutHeight * 0.34,
            ),
            _MenuNode(
              item: cards[1],
              width: itemWidth,
              left: layoutWidth * 0.70,
              top: layoutHeight * 0.34,
            ),
            _MenuNode(
              item: cards[4],
              width: itemWidth,
              left: layoutWidth * 0.22,
              top: layoutHeight * 0.68,
            ),
            _MenuNode(
              item: cards[3],
              width: itemWidth,
              left: layoutWidth * 0.58,
              top: layoutHeight * 0.68,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuNode extends StatelessWidget {
  const _MenuNode({
    required this.item,
    required this.width,
    required this.left,
    required this.top,
  });

  final _MenuCardData item;
  final double width;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      child: _MenuCircleButton(item: item),
    );
  }
}

class _MenuWrapLayout extends StatelessWidget {
  const _MenuWrapLayout({required this.cards});

  final List<_MenuCardData> cards;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final itemWidth = width < 420 ? 124.0 : 140.0;

    return Center(
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.lg,
          children: [
            for (final item in cards)
              SizedBox(
                width: itemWidth,
                child: _MenuCircleButton(item: item),
              ),
          ],
        ),
      ),
    );
  }
}

class _MenuCircleButton extends StatefulWidget {
  const _MenuCircleButton({required this.item});

  final _MenuCardData item;

  @override
  State<_MenuCircleButton> createState() => _MenuCircleButtonState();
}

class _MenuCircleButtonState extends State<_MenuCircleButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Tooltip(
      message: item.subtitle,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedScale(
          scale: _hovered ? 1.06 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: () => Navigator.of(context).pushNamed(item.route),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.mutedGold.withValues(alpha: 0.96),
                        item.accent.withValues(alpha: 0.62),
                        AppColors.deepTeal.withValues(alpha: 0.34),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.72),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: item.accent.withValues(
                          alpha: _hovered ? 0.46 : 0.26,
                        ),
                        blurRadius: _hovered ? 26 : 18,
                        spreadRadius: _hovered ? 2 : 0,
                      ),
                      BoxShadow(
                        color: AppColors.deepTeal.withValues(alpha: 0.24),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    item.icon,
                    color: AppColors.deepTeal,
                    size: 31,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.deepTeal,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow(
                        color: Colors.white.withValues(alpha: 0.44),
                        blurRadius: 8,
                      ),
                    ],
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
