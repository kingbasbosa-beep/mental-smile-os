import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/specialists/data/clinician_specialty_catalog.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';

class SpecialistsCategoriesPage extends StatefulWidget {
  const SpecialistsCategoriesPage({super.key});

  @override
  State<SpecialistsCategoriesPage> createState() =>
      _SpecialistsCategoriesPageState();
}

class _SpecialistsCategoriesPageState extends State<SpecialistsCategoriesPage> {
  PageController? _pageController;
  double _viewportFraction = 0.82;
  double _page = 0;

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  @override
  void initState() {
    super.initState();
    _syncPageController(_viewportFraction);
  }

  @override
  void dispose() {
    _pageController?.removeListener(_handlePageChange);
    _pageController?.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    if (!mounted) return;
    setState(() => _page = _pageController?.page ?? 0);
  }

  void _syncPageController(double viewportFraction) {
    if (_pageController != null && _viewportFraction == viewportFraction) {
      return;
    }

    final oldPage = _pageController?.hasClients == true
        ? (_pageController?.page ?? _page)
        : _page;

    _pageController?.removeListener(_handlePageChange);
    _pageController?.dispose();
    _viewportFraction = viewportFraction;
    _pageController = PageController(
      initialPage: oldPage.round().clamp(0, 4).toInt(),
      viewportFraction: viewportFraction,
    )..addListener(_handlePageChange);
    _page = oldPage;
  }

  void _goToPage(int targetIndex, int itemCount) {
    final clamped = targetIndex.clamp(0, itemCount - 1).toInt();
    _pageController?.animateToPage(
      clamped,
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  void _nextPage(int itemCount) {
    _goToPage((_pageController?.page ?? _page).round() + 1, itemCount);
  }

  void _previousPage(int itemCount) {
    _goToPage((_pageController?.page ?? _page).round() - 1, itemCount);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    final items = ClinicianSpecialtyCatalog.categories.map((category) {
      return _SpecialistCategoryItem(
        title: category.label(isArabic),
        countLabel: category.description(isArabic),
        icon: _categoryIcon(category.key),
        color: _categoryColor(category.key),
        imageAsset: _categoryImage(category.key),
        route: Routes.specialistsList,
        arguments: {
          'category': category.key,
          'title': category.label(isArabic),
        },
      );
    }).toList();

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final isMobile = width < 700;
            final isTablet = width >= 700 && width < 1100;
            final viewportFraction = isMobile
                ? 0.82
                : isTablet
                    ? 0.56
                    : 0.31;
            _syncPageController(viewportFraction);
            final pageController = _pageController!;

            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  _backgroundAsset(width),
                  fit: BoxFit.cover,
                  alignment: isMobile ? Alignment.topCenter : Alignment.center,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.26),
                        Colors.black.withValues(alpha: 0.18),
                        Colors.black.withValues(alpha: 0.48),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          isMobile ? 18 : 34,
                          isMobile ? 18 : 28,
                          isMobile ? 18 : 34,
                          isMobile ? 10 : 18,
                        ),
                        child: _SpecialistsHeader(isArabic: isArabic),
                      ),
                      Expanded(
                        child: isMobile || isTablet
                            ? _SpecialistsCarousel(
                                controller: pageController,
                                page: _page,
                                items: items,
                                isArabic: isArabic,
                                height: height,
                              )
                            : _SpecialistsDesktopStage(
                                controller: pageController,
                                page: _page,
                                items: items,
                                isArabic: isArabic,
                              ),
                      ),
                      _CarouselLogoControls(
                        isArabic: isArabic,
                        compact: isMobile,
                        onPrevious: () => _previousPage(items.length),
                        onNext: () => _nextPage(items.length),
                      ),
                      SizedBox(height: isMobile ? 16 : 28),
                    ],
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: isMobile ? 14 : 22,
                        top: isMobile ? 12 : 18,
                      ),
                      child: _BackToMenuButton(compact: isMobile),
                    ),
                  ),
                ),
                const _ModuleEntryLogger(module: 'specialists'),
              ],
            );
          },
        ),
      ),
    );
  }

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  IconData _categoryIcon(String key) {
    switch (key) {
      case ClinicianSpecialtyCatalog.psychologists:
        return Icons.psychology_alt_outlined;
      case ClinicianSpecialtyCatalog.familyCounseling:
        return Icons.family_restroom_outlined;
      case ClinicianSpecialtyCatalog.speechSpecialists:
        return Icons.record_voice_over_outlined;
      case ClinicianSpecialtyCatalog.coaching:
        return Icons.rocket_launch_outlined;
      case ClinicianSpecialtyCatalog.addiction:
        return Icons.healing_outlined;
      default:
        return Icons.medical_services_outlined;
    }
  }

  Color _categoryColor(String key) {
    switch (key) {
      case ClinicianSpecialtyCatalog.psychologists:
        return const Color(0xFFD7A85C);
      case ClinicianSpecialtyCatalog.familyCounseling:
        return const Color(0xFFB98E52);
      case ClinicianSpecialtyCatalog.speechSpecialists:
        return const Color(0xFFCF9F61);
      case ClinicianSpecialtyCatalog.coaching:
        return const Color(0xFFE0B768);
      case ClinicianSpecialtyCatalog.addiction:
        return const Color(0xFFC47D47);
      default:
        return const Color(0xFFD7A85C);
    }
  }

  String _categoryImage(String key) {
    switch (key) {
      case ClinicianSpecialtyCatalog.psychologists:
        return 'assets/images/specialists/specialist_psychology.png';
      case ClinicianSpecialtyCatalog.familyCounseling:
        return 'assets/images/specialists/specialist_family.png';
      case ClinicianSpecialtyCatalog.speechSpecialists:
        return 'assets/images/specialists/specialist_speech.png';
      case ClinicianSpecialtyCatalog.coaching:
        return 'assets/images/specialists/specialist_coaching.png';
      case ClinicianSpecialtyCatalog.addiction:
        return 'assets/images/specialists/specialist_addiction.png';
      default:
        return 'assets/images/specialists/specialist_psychology.png';
    }
  }
}

class _BackToMenuButton extends StatefulWidget {
  const _BackToMenuButton({required this.compact});

  final bool compact;

  @override
  State<_BackToMenuButton> createState() => _BackToMenuButtonState();
}

class _BackToMenuButtonState extends State<_BackToMenuButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.compact ? 44.0 : 52.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => Navigator.of(context).pushNamed(Routes.menu),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1B1007).withValues(alpha: 0.50),
              border: Border.all(
                color: const Color(0xFFFFD98A).withValues(alpha: 0.56),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE7A94C).withValues(
                    alpha: _hovered ? 0.28 : 0.16,
                  ),
                  blurRadius: _hovered ? 18 : 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: const Color(0xFFFFE7B2),
              size: widget.compact ? 22 : 26,
            ),
          ),
        ),
      ),
    );
  }
}

class _SpecialistsHeader extends StatelessWidget {
  const _SpecialistsHeader({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? 'أخصائيين' : 'Specialists';
    final subtitle =
        isArabic ? 'موجودين دايمًا لدعمك' : 'Always here to support you';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFFFD47A),
            fontSize: MediaQuery.sizeOf(context).width < 700 ? 34 : 48,
            fontWeight: FontWeight.w900,
            height: 1,
            shadows: const [
              Shadow(
                color: Colors.black,
                blurRadius: 16,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFFFF0C8).withValues(alpha: 0.88),
              fontSize: MediaQuery.sizeOf(context).width < 700 ? 15 : 18,
              fontWeight: FontWeight.w800,
              height: 1.5,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 12,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CarouselLogoControls extends StatelessWidget {
  const _CarouselLogoControls({
    required this.isArabic,
    required this.compact,
    required this.onPrevious,
    required this.onNext,
  });

  final bool isArabic;
  final bool compact;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: compact ? 14 : 22,
        right: compact ? 14 : 22,
        top: compact ? 4 : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.ltr,
        children: [
          _LogoNavControl(
            icon: Icons.arrow_forward_ios_rounded,
            compact: compact,
            onTap: onNext,
          ),
          SizedBox(width: compact ? 18 : 26),
          _LogoNavControl(
            icon: Icons.arrow_back_ios_new_rounded,
            compact: compact,
            onTap: onPrevious,
          ),
        ],
      ),
    );
  }
}

class _LogoNavControl extends StatefulWidget {
  const _LogoNavControl({
    required this.icon,
    required this.compact,
    required this.onTap,
  });

  final IconData icon;
  final bool compact;
  final VoidCallback onTap;

  @override
  State<_LogoNavControl> createState() => _LogoNavControlState();
}

class _LogoNavControlState extends State<_LogoNavControl> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final logoSize = widget.compact ? 50.0 : 60.0;
    final arrowSize = widget.compact ? 30.0 : 36.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.06 : 1.0,
        duration: const Duration(milliseconds: 170),
        curve: Curves.easeOutCubic,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: widget.onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: arrowSize,
                height: arrowSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF1B1007).withValues(alpha: 0.42),
                  border: Border.all(
                    color: const Color(0xFFFFD98A).withValues(alpha: 0.38),
                  ),
                ),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFFFFE7B2),
                  size: widget.compact ? 15 : 17,
                  shadows: const [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 8,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(width: widget.compact ? 6 : 8),
              Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF1B1007).withValues(alpha: 0.48),
                  border: Border.all(
                    color: const Color(0xFFFFD98A).withValues(
                      alpha: _hovered ? 0.68 : 0.46,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE7A94C).withValues(
                        alpha: _hovered ? 0.20 : 0.10,
                      ),
                      blurRadius: _hovered ? 14 : 9,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(widget.compact ? 6 : 7),
                  child: Image.asset(
                    'assets/branding/logo_primary_dark.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecialistsCarousel extends StatelessWidget {
  const _SpecialistsCarousel({
    required this.controller,
    required this.page,
    required this.items,
    required this.isArabic,
    required this.height,
  });

  final PageController controller;
  final double page;
  final List<_SpecialistCategoryItem> items;
  final bool isArabic;
  final double height;

  @override
  Widget build(BuildContext context) {
    final cardHeight = math.min(height * 0.66, 580.0);

    return Center(
      child: SizedBox(
        height: cardHeight,
        child: PageView.builder(
          controller: controller,
          itemCount: items.length,
          padEnds: true,
          itemBuilder: (context, index) {
            final distance = (page - index).abs().clamp(0.0, 1.0);
            final scale = 1.0 - (distance * 0.075);
            return AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _SpecialistCategoryCard(
                  item: items[index],
                  isArabic: isArabic,
                  compact: MediaQuery.sizeOf(context).width < 700,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SpecialistsDesktopStage extends StatelessWidget {
  const _SpecialistsDesktopStage({
    required this.controller,
    required this.page,
    required this.items,
    required this.isArabic,
  });

  final PageController controller;
  final double page;
  final List<_SpecialistCategoryItem> items;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1360),
        child: SizedBox(
          height: 560,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            padEnds: true,
            itemBuilder: (context, index) {
              final distance = (page - index).abs().clamp(0.0, 1.0);
              final scale = 1.0 - (distance * 0.055);
              return AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: _SpecialistCategoryCard(
                    item: items[index],
                    isArabic: isArabic,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ModuleEntryLogger extends StatefulWidget {
  const _ModuleEntryLogger({required this.module});

  final String module;

  @override
  State<_ModuleEntryLogger> createState() => _ModuleEntryLoggerState();
}

class _ModuleEntryLoggerState extends State<_ModuleEntryLogger> {
  @override
  void initState() {
    super.initState();
    AppAnalytics.logModuleEntry(widget.module);
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _SpecialistCategoryItem {
  final String title;
  final String countLabel;
  final IconData icon;
  final Color color;
  final String imageAsset;
  final String route;
  final Map<String, dynamic>? arguments;

  const _SpecialistCategoryItem({
    required this.title,
    required this.countLabel,
    required this.icon,
    required this.color,
    required this.imageAsset,
    required this.route,
    this.arguments,
  });
}

class _SpecialistCategoryCard extends StatefulWidget {
  const _SpecialistCategoryCard({
    required this.item,
    required this.isArabic,
    this.compact = false,
  });

  final _SpecialistCategoryItem item;
  final bool isArabic;
  final bool compact;

  @override
  State<_SpecialistCategoryCard> createState() =>
      _SpecialistCategoryCardState();
}

class _SpecialistCategoryCardState extends State<_SpecialistCategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final radius = widget.compact ? 30.0 : 36.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.025 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () => Navigator.of(context).pushNamed(
            item.route,
            arguments: item.arguments,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: item.color.withValues(alpha: _hovered ? 0.42 : 0.28),
                  blurRadius: _hovered ? 34 : 24,
                  spreadRadius: _hovered ? 2 : 0,
                  offset: const Offset(0, 16),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.46),
                  blurRadius: 34,
                  offset: const Offset(0, 22),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item.imageAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.06),
                          Colors.black.withValues(alpha: 0.18),
                          Colors.black.withValues(alpha: 0.72),
                        ],
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFFFD98A).withValues(
                          alpha: _hovered ? 0.74 : 0.44,
                        ),
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                  Positioned(
                    left: 18,
                    top: 18,
                    child: Container(
                      width: widget.compact ? 50 : 62,
                      height: widget.compact ? 50 : 62,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            item.color.withValues(alpha: 0.70),
                            const Color(0xFF211408).withValues(alpha: 0.74),
                          ],
                        ),
                        border: Border.all(
                          color:
                              const Color(0xFFFFDA8C).withValues(alpha: 0.58),
                        ),
                      ),
                      child: Icon(
                        item.icon,
                        color: const Color(0xFFFFE7B2),
                        size: widget.compact ? 24 : 30,
                      ),
                    ),
                  ),
                  Positioned(
                    left: widget.compact ? 20 : 26,
                    right: widget.compact ? 20 : 26,
                    bottom: widget.compact ? 24 : 30,
                    child: Column(
                      crossAxisAlignment: widget.isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          textAlign: widget.isArabic
                              ? TextAlign.right
                              : TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xFFFFE7B2),
                            fontSize: widget.compact ? 25 : 32,
                            fontWeight: FontWeight.w900,
                            height: 1.02,
                            shadows: const [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 16,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.countLabel,
                          textAlign: widget.isArabic
                              ? TextAlign.right
                              : TextAlign.left,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                                const Color(0xFFFFF4D1).withValues(alpha: 0.88),
                            fontSize: widget.compact ? 14 : 16,
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                            shadows: const [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 12,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
