import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

/// C6 Library UI.
class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  static void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  PageController? _pageController;
  double _viewportFraction = 0.82;
  double _page = 0;

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
      initialPage: oldPage.round().clamp(0, 5).toInt(),
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
    final lang = Localizations.localeOf(context).languageCode.toLowerCase();
    final isAr = lang == 'ar';

    final categories = <_LibCat>[
      const _LibCat(
        keyName: 'articles',
        titleAr: 'مقالات',
        titleEn: 'Articles',
        asset: 'c6_library/categories/cat_articles.png',
      ),
      const _LibCat(
        keyName: 'exercises',
        titleAr: 'تمارين',
        titleEn: 'Exercises',
        asset: 'c6_library/categories/cat_exercises.png',
      ),
      const _LibCat(
        keyName: 'audio',
        titleAr: 'صوتيات',
        titleEn: 'Audio',
        asset: 'c6_library/categories/cat_audio.png',
      ),
      const _LibCat(
        keyName: 'videos',
        titleAr: 'فيديو',
        titleEn: 'Videos',
        asset: 'c6_library/categories/cat_videos.png',
      ),
      const _LibCat(
        keyName: 'tools',
        titleAr: 'أدوات',
        titleEn: 'Tools',
        asset: 'c6_library/categories/cat_tools.png',
      ),
      const _LibCat(
        keyName: 'saved',
        titleAr: 'المحفوظات',
        titleEn: 'Saved',
        asset: 'c6_library/categories/cat_saved.png',
      ),
    ];

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            LayoutBuilder(
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
                      _libraryBackgroundAsset(width),
                      fit: BoxFit.cover,
                      alignment:
                          isMobile ? Alignment.topCenter : Alignment.center,
                      errorBuilder: (context, error, stackTrace) =>
                          const ColoredBox(color: Color(0xFF03080D)),
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
                            child: _LibraryHeader(isAr: isAr),
                          ),
                          Expanded(
                            child: isMobile || isTablet
                                ? _LibraryCarousel(
                                    controller: pageController,
                                    page: _page,
                                    categories: categories,
                                    isAr: isAr,
                                    height: height,
                                  )
                                : _LibraryDesktopStage(
                                    controller: pageController,
                                    page: _page,
                                    categories: categories,
                                    isAr: isAr,
                                  ),
                          ),
                          _LibraryCarouselControls(
                            compact: isMobile,
                            onPrevious: () => _previousPage(categories.length),
                            onNext: () => _nextPage(categories.length),
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
                          child: _LibraryBackButton(compact: isMobile),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const _ModuleEntryLogger(module: 'library'),
          ],
        ),
      ),
    );
  }

  String _libraryBackgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }
}

class _LibraryHeader extends StatelessWidget {
  const _LibraryHeader({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Text(
      isAr ? 'المكتبة' : 'Library',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: const Color(0xFFFFD47A),
        fontSize: MediaQuery.sizeOf(context).width < 700 ? 38 : 56,
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
    );
  }
}

class _LibraryBackButton extends StatefulWidget {
  const _LibraryBackButton({required this.compact});

  final bool compact;

  @override
  State<_LibraryBackButton> createState() => _LibraryBackButtonState();
}

class _LibraryBackButtonState extends State<_LibraryBackButton> {
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

class _LibraryCarousel extends StatelessWidget {
  const _LibraryCarousel({
    required this.controller,
    required this.page,
    required this.categories,
    required this.isAr,
    required this.height,
  });

  final PageController controller;
  final double page;
  final List<_LibCat> categories;
  final bool isAr;
  final double height;

  @override
  Widget build(BuildContext context) {
    final cardHeight = math.min(height * 0.66, 580.0);

    return Center(
      child: SizedBox(
        height: cardHeight,
        child: PageView.builder(
          controller: controller,
          itemCount: categories.length,
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
                child: _LibraryCarouselCard(
                  category: categories[index],
                  isAr: isAr,
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

class _LibraryDesktopStage extends StatelessWidget {
  const _LibraryDesktopStage({
    required this.controller,
    required this.page,
    required this.categories,
    required this.isAr,
  });

  final PageController controller;
  final double page;
  final List<_LibCat> categories;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1360),
        child: SizedBox(
          height: 560,
          child: PageView.builder(
            controller: controller,
            itemCount: categories.length,
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
                  child: _LibraryCarouselCard(
                    category: categories[index],
                    isAr: isAr,
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

class _LibraryCarouselCard extends StatefulWidget {
  const _LibraryCarouselCard({
    required this.category,
    required this.isAr,
    this.compact = false,
  });

  final _LibCat category;
  final bool isAr;
  final bool compact;

  @override
  State<_LibraryCarouselCard> createState() => _LibraryCarouselCardState();
}

class _LibraryCarouselCardState extends State<_LibraryCarouselCard> {
  bool _hovered = false;

  Color get _accent {
    switch (widget.category.keyName) {
      case 'audio':
        return const Color(0xFF67B7C8);
      case 'exercises':
        return const Color(0xFFD8A75F);
      case 'articles':
        return const Color(0xFFE0B86E);
      case 'saved':
        return const Color(0xFFBBA2FF);
      case 'tools':
        return const Color(0xFF7DF9FF);
      case 'videos':
        return const Color(0xFFE58667);
      default:
        return const Color(0xFFD8A75F);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.compact ? 30.0 : 36.0;
    final title =
        widget.isAr ? widget.category.titleAr : widget.category.titleEn;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.025 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            AppAnalytics.logPathSelected('library', 'open_content');
            LibraryPage._showSnack(
              context,
              widget.isAr
                  ? 'فتح: ${widget.category.titleAr}'
                  : 'Open: ${widget.category.titleEn}',
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOutCubic,
                  width: widget.compact ? 230 : 300,
                  height: widget.compact ? 230 : 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _accent.withValues(
                          alpha: _hovered ? 0.26 : 0.16,
                        ),
                        blurRadius: _hovered ? 34 : 24,
                        spreadRadius: _hovered ? 1 : 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(widget.compact ? 12 : 16),
                    child: Image.asset(
                      normalizeAssetPath(widget.category.asset),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.auto_stories_outlined,
                        color: const Color(0xFFFFE7B2),
                        size: widget.compact ? 72 : 92,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: widget.compact ? 14 : 20,
                right: widget.compact ? 14 : 20,
                bottom: widget.compact ? 18 : 26,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFFFFE7B2),
                    fontSize: widget.compact ? 27 : 34,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LibraryCarouselControls extends StatelessWidget {
  const _LibraryCarouselControls({
    required this.compact,
    required this.onPrevious,
    required this.onNext,
  });

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
          _LibraryLogoNavControl(
            icon: Icons.arrow_forward_ios_rounded,
            compact: compact,
            arrowOnLeft: false,
            onTap: onNext,
          ),
          SizedBox(width: compact ? 18 : 26),
          _LibraryLogoNavControl(
            icon: Icons.arrow_back_ios_new_rounded,
            compact: compact,
            arrowOnLeft: true,
            onTap: onPrevious,
          ),
        ],
      ),
    );
  }
}

class _LibraryLogoNavControl extends StatefulWidget {
  const _LibraryLogoNavControl({
    required this.icon,
    required this.compact,
    required this.arrowOnLeft,
    required this.onTap,
  });

  final IconData icon;
  final bool compact;
  final bool arrowOnLeft;
  final VoidCallback onTap;

  @override
  State<_LibraryLogoNavControl> createState() => _LibraryLogoNavControlState();
}

class _LibraryLogoNavControlState extends State<_LibraryLogoNavControl> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final logoSize = widget.compact ? 50.0 : 60.0;
    final arrowSize = widget.compact ? 30.0 : 36.0;
    final arrow = _LibraryArrowCircle(
      icon: widget.icon,
      size: arrowSize,
      compact: widget.compact,
    );
    final logo = _LibraryLogoCircle(
      size: logoSize,
      compact: widget.compact,
      hovered: _hovered,
    );
    final gap = SizedBox(width: widget.compact ? 6 : 8);

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
            children:
                widget.arrowOnLeft ? [arrow, gap, logo] : [logo, gap, arrow],
          ),
        ),
      ),
    );
  }
}

class _LibraryArrowCircle extends StatelessWidget {
  const _LibraryArrowCircle({
    required this.icon,
    required this.size,
    required this.compact,
  });

  final IconData icon;
  final double size;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1B1007).withValues(alpha: 0.42),
        border: Border.all(
          color: const Color(0xFFFFD98A).withValues(alpha: 0.38),
        ),
      ),
      child: Icon(
        icon,
        color: const Color(0xFFFFE7B2),
        size: compact ? 15 : 17,
        shadows: const [
          Shadow(
            color: Colors.black,
            blurRadius: 8,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class _LibraryLogoCircle extends StatelessWidget {
  const _LibraryLogoCircle({
    required this.size,
    required this.compact,
    required this.hovered,
  });

  final double size;
  final bool compact;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1B1007).withValues(alpha: 0.48),
        border: Border.all(
          color: const Color(0xFFFFD98A).withValues(
            alpha: hovered ? 0.68 : 0.46,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7A94C).withValues(
              alpha: hovered ? 0.20 : 0.10,
            ),
            blurRadius: hovered ? 14 : 9,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? 6 : 7),
        child: Image.asset(
          'assets/branding/logo_primary_dark.png',
          fit: BoxFit.contain,
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

class _LibCat {
  const _LibCat({
    required this.keyName,
    required this.titleAr,
    required this.titleEn,
    required this.asset,
  });

  final String keyName;
  final String titleAr;
  final String titleEn;
  final String asset;
}
