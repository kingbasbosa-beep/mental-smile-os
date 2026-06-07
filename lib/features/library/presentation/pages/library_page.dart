import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/library/data/library_signal_metadata.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

/// C6 Library UI.
class LibraryPage extends StatefulWidget {
  const LibraryPage({
    super.key,
    this.initialCategoryKey,
    this.returnRoute = Routes.menu,
  });

  final String? initialCategoryKey;
  final String returnRoute;

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
    final selectedFeatured = _featuredLibraryEntry(widget.initialCategoryKey);

    final categories = <_LibCat>[
      const _LibCat(
        keyName: 'articles',
        titleAr: 'مقالات',
        titleEn: 'Articles',
        noteAr: 'مقالات تثقيفية وداعمة ستتوفر تدريجيًا.',
        noteEn: 'Educational and supportive articles will be added gradually.',
        asset: 'c6_library/categories/cat_articles.png',
      ),
      const _LibCat(
        keyName: 'exercises',
        titleAr: 'تمارين',
        titleEn: 'Exercises',
        noteAr: 'تمارين دعم خفيفة فقط، وليست بروتوكولًا علاجيًا.',
        noteEn: 'Light support exercises only, not a treatment protocol.',
        asset: 'c6_library/categories/cat_exercises.png',
      ),
      const _LibCat(
        keyName: 'audio',
        titleAr: 'صوتيات',
        titleEn: 'Audio',
        noteAr: 'صوتيات للتهدئة والدعم العام، وليست تدخلًا علاجيًا.',
        noteEn:
            'Calming and general support audio, not therapeutic intervention.',
        asset: 'c6_library/categories/cat_audio.png',
      ),
      const _LibCat(
        keyName: 'videos',
        titleAr: 'فيديو',
        titleEn: 'Videos',
        noteAr: 'موارد تعليمية مرئية، وأي روابط خارجية مستقبلًا ستحتاج مراجعة.',
        noteEn:
            'Educational video resources. Future external links will require review.',
        asset: 'c6_library/categories/cat_videos.png',
      ),
      const _LibCat(
        keyName: 'tools',
        titleAr: 'أدوات',
        titleEn: 'Tools',
        noteAr:
            'أدوات الدعم قيد التجهيز. الأدوات المهنية أو الحساسة تحتاج إشراف مختص.',
        noteEn:
            'Support tools are being prepared. Professional or sensitive tools require specialist supervision.',
        asset: 'c6_library/categories/cat_tools.png',
      ),
      const _LibCat(
        keyName: 'saved',
        titleAr: 'المحفوظات',
        titleEn: 'Saved',
        noteAr:
            'ميزة الحفظ غير مفعلة الآن، ولا يتم تخزين أي عناصر في هذه المرحلة.',
        noteEn: 'Saving is not active yet. No items are stored in this phase.',
        asset: 'c6_library/categories/cat_saved.png',
      ),
    ];
    final selectedCategory = _standardLibraryCategory(
      widget.initialCategoryKey,
      categories,
    );
    final showingCategory =
        selectedFeatured != null || selectedCategory != null;

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
                      alignment: _libraryBackgroundAlignment(width),
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
                          if (!showingCategory)
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                isMobile ? 18 : 34,
                                isMobile ? 18 : 28,
                                isMobile ? 18 : 34,
                                isMobile ? 10 : 18,
                              ),
                              child: _LibraryHeader(isAr: isAr),
                            ),
                          if (!showingCategory && _isWebLibraryRoute(context))
                            _LibraryPolicyLink(compact: isMobile),
                          if (!showingCategory)
                            _LibraryFeaturedEntries(
                              compact: isMobile ||
                                  (MediaQuery.sizeOf(context).width >
                                          MediaQuery.sizeOf(context).height &&
                                      MediaQuery.sizeOf(context).height < 520),
                              isAr: isAr,
                            ),
                          Expanded(
                            child: selectedFeatured != null
                                ? _LibraryFeaturedDetail(
                                    entry: selectedFeatured,
                                    isAr: isAr,
                                    compact: isMobile ||
                                        (MediaQuery.sizeOf(context).width >
                                                MediaQuery.sizeOf(context)
                                                    .height &&
                                            MediaQuery.sizeOf(context).height <
                                                520),
                                  )
                                : selectedCategory != null
                                    ? _LibraryStandardCategoryDetail(
                                        category: selectedCategory,
                                        isAr: isAr,
                                        compact: isMobile ||
                                            (MediaQuery.sizeOf(context).width >
                                                    MediaQuery.sizeOf(context)
                                                        .height &&
                                                MediaQuery.sizeOf(context)
                                                        .height <
                                                    520),
                                      )
                                    : isMobile || isTablet
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
                          if (!showingCategory)
                            _LibraryCarouselControls(
                              compact: isMobile ||
                                  (MediaQuery.sizeOf(context).width >
                                          MediaQuery.sizeOf(context).height &&
                                      MediaQuery.sizeOf(context).height < 520),
                              isAr: isAr,
                              onPrevious: () =>
                                  _previousPage(categories.length),
                              onNext: () => _nextPage(categories.length),
                            ),
                          SizedBox(
                            height: isMobile ||
                                    (MediaQuery.sizeOf(context).width >
                                            MediaQuery.sizeOf(context).height &&
                                        MediaQuery.sizeOf(context).height < 520)
                                ? 10
                                : 28,
                          ),
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
                          child: _LibraryBackButton(
                            compact: isMobile ||
                                (MediaQuery.sizeOf(context).width >
                                        MediaQuery.sizeOf(context).height &&
                                    MediaQuery.sizeOf(context).height < 520),
                            returnToLibraryHome: showingCategory,
                            returnRoute: widget.returnRoute,
                          ),
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
      return 'assets/branding/web/library/backgrounds/mobile/library_mobile_bg.png';
    }
    if (width < 1100) {
      return 'assets/branding/web/library/backgrounds/tablet/library_tablet_bg.png';
    }
    return 'assets/branding/web/library/backgrounds/desktop/library_desktop_bg.png';
  }

  Alignment _libraryBackgroundAlignment(double width) {
    if (width < 700) return Alignment.topCenter;
    if (width < 1100) return Alignment.center;
    return Alignment.center;
  }
}

class _LibraryHeader extends StatelessWidget {
  const _LibraryHeader({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final landscapeCompact = size.width > size.height && size.height < 520;
    if (landscapeCompact) {
      return const SizedBox.shrink();
    }
    return Text(
      isAr ? 'المكتبة' : 'Library',
      textAlign: landscapeCompact
          ? (isAr ? TextAlign.right : TextAlign.left)
          : TextAlign.center,
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

class _LibraryPolicyLink extends StatelessWidget {
  const _LibraryPolicyLink({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final isAr =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Transform.translate(
      offset: MediaQuery.sizeOf(context).width >
                  MediaQuery.sizeOf(context).height &&
              MediaQuery.sizeOf(context).height < 520
          ? const Offset(0, -8)
          : Offset.zero,
      child: Transform.scale(
        scale: MediaQuery.sizeOf(context).width >
                    MediaQuery.sizeOf(context).height &&
                MediaQuery.sizeOf(context).height < 520
            ? 0.88
            : 1,
        child: Padding(
          padding: EdgeInsets.only(bottom: compact ? 8 : 12),
          child: Center(
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(
                Routes.webLibraryPolicy,
              ),
              icon: const Icon(Icons.policy_outlined, size: 16),
              label: Text(
                isAr ? 'سياسة استخدام المكتبة' : 'Library usage policy',
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFFFE7B2),
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 10 : 14,
                  vertical: compact ? 4 : 6,
                ),
                textStyle: TextStyle(
                  fontSize: compact ? 12 : 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LibraryBackButton extends StatefulWidget {
  const _LibraryBackButton({
    required this.compact,
    required this.returnToLibraryHome,
    required this.returnRoute,
  });

  final bool compact;
  final bool returnToLibraryHome;
  final String returnRoute;

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
          onTap: () {
            if (widget.returnToLibraryHome) {
              Navigator.of(context).pushReplacementNamed(
                _currentLibraryRouteName(context),
                arguments: {'returnRoute': widget.returnRoute},
              );
            } else {
              Navigator.of(context).pushNamed(widget.returnRoute);
            }
          },
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
            child: Image.asset(
              Directionality.of(context) == TextDirection.rtl
                  ? 'assets/branding/shared/navigation/back/back_right_gold.png'
                  : 'assets/branding/shared/navigation/back/back_left_gold.png',
              width: widget.compact ? 22 : 26,
              height: widget.compact ? 22 : 26,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.arrow_back_rounded,
                  color: const Color(0xFFFFE7B2),
                  size: widget.compact ? 22 : 26,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LibraryFeaturedEntries extends StatelessWidget {
  const _LibraryFeaturedEntries({
    required this.compact,
    required this.isAr,
  });

  final bool compact;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final landscapeCompact = size.width > size.height && size.height < 520;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        compact ? 14 : 24,
        compact ? 2 : 4,
        compact ? 14 : 24,
        compact ? 6 : 12,
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: compact ? 10 : 16,
          runSpacing: compact ? 8 : 10,
          children: [
            for (final entry in _featuredLibraryEntries)
              _LibraryFeaturedHeartCard(
                entry: entry,
                compact: compact,
                isAr: isAr,
              ),
          ],
        ),
      ),
    );
  }
}

class _LibraryFeaturedHeartCard extends StatefulWidget {
  const _LibraryFeaturedHeartCard({
    required this.entry,
    required this.compact,
    required this.isAr,
  });

  final _FeaturedLibraryEntry entry;
  final bool compact;
  final bool isAr;

  @override
  State<_LibraryFeaturedHeartCard> createState() =>
      _LibraryFeaturedHeartCardState();
}

class _LibraryFeaturedHeartCardState extends State<_LibraryFeaturedHeartCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final routeName = _currentLibraryRouteName(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.035 : 1.0,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            AppAnalytics.logPathSelected('library', widget.entry.keyName);
            Navigator.of(context).pushNamed(
              routeName,
              arguments: {'categoryKey': widget.entry.keyName},
            );
          },
          child: Container(
            width: widget.compact ? 152 : 214,
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 12 : 16,
              vertical: widget.compact ? 10 : 14,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF120B05).withValues(alpha: 0.58),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFFFD98A).withValues(
                  alpha: _hovered ? 0.72 : 0.42,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE7A94C).withValues(
                    alpha: _hovered ? 0.20 : 0.10,
                  ),
                  blurRadius: _hovered ? 22 : 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.favorite_rounded,
                      color: const Color(0xFFD8A13F),
                      size: widget.compact ? 46 : 54,
                    ),
                    Text(
                      'قريبًا',
                      style: TextStyle(
                        color: const Color(0xFF1A1007),
                        fontSize: widget.compact ? 9 : 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    widget.isAr ? widget.entry.titleAr : widget.entry.titleEn,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFFFFE7B2),
                      fontSize: widget.compact ? 15 : 18,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
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

class _LibraryFeaturedDetail extends StatelessWidget {
  const _LibraryFeaturedDetail({
    required this.entry,
    required this.isAr,
    required this.compact,
  });

  final _FeaturedLibraryEntry entry;
  final bool isAr;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          compact ? 16 : 28,
          compact ? 8 : 14,
          compact ? 16 : 28,
          compact ? 18 : 24,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Container(
            padding: EdgeInsets.all(compact ? 18 : 28),
            decoration: BoxDecoration(
              color: const Color(0xFF080704).withValues(alpha: 0.68),
              borderRadius: BorderRadius.circular(compact ? 28 : 34),
              border: Border.all(
                color: const Color(0xFFFFD98A).withValues(alpha: 0.46),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE7A94C).withValues(alpha: 0.14),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LibraryFutureBackgroundSlot(
                  entry: entry,
                  compact: compact,
                ),
                SizedBox(height: compact ? 18 : 24),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8A13F).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: const Color(0xFFFFD98A).withValues(alpha: 0.42),
                    ),
                  ),
                  child: const Text(
                    'قريبًا',
                    style: TextStyle(
                      color: Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: compact ? 14 : 18),
                Text(
                  isAr ? entry.titleAr : entry.titleEn,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFFD47A),
                    fontSize: compact ? 30 : 44,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: compact ? 10 : 12),
                _LibrarySignalBadges(
                  keyName: entry.keyName,
                  isAr: isAr,
                  maxBadges: 3,
                ),
                SizedBox(height: compact ? 14 : 18),
                Text(
                  isAr
                      ? 'هذا المحتوى للتوعية ولا يغني عن استشارة مختص عند الحاجة.'
                      : 'This content is educational and does not replace consulting a specialist when needed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFFE7B2).withValues(alpha: 0.82),
                    fontSize: compact ? 13 : 15,
                    height: 1.4,
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

class _LibraryFutureBackgroundSlot extends StatelessWidget {
  const _LibraryFutureBackgroundSlot({
    required this.entry,
    required this.compact,
  });

  final _FeaturedLibraryEntry entry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isShortLandscape = size.width > size.height && size.height < 520;
    final imageHeight = isShortLandscape
        ? (compact ? 110.0 : 160.0)
        : (compact ? 150.0 : 230.0);

    return Container(
      height: imageHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(compact ? 24 : 30),
        border: Border.all(
          color: const Color(0xFFFFD98A).withValues(alpha: 0.34),
        ),
        gradient: RadialGradient(
          colors: [
            const Color(0xFFD8A13F).withValues(alpha: 0.18),
            const Color(0xFF080704).withValues(alpha: 0.72),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        entry.cardAsset,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.favorite_rounded,
              color: const Color(0xFFFFD47A).withValues(alpha: 0.72),
              size: compact ? 54 : 76,
            ),
          );
        },
      ),
    );
  }
}

class _LibraryStandardCategoryDetail extends StatelessWidget {
  const _LibraryStandardCategoryDetail({
    required this.category,
    required this.isAr,
    required this.compact,
  });

  final _LibCat category;
  final bool isAr;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          compact ? 16 : 28,
          compact ? 8 : 14,
          compact ? 16 : 28,
          compact ? 18 : 24,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Container(
            padding: EdgeInsets.all(compact ? 18 : 28),
            decoration: BoxDecoration(
              color: const Color(0xFF080704).withValues(alpha: 0.68),
              borderRadius: BorderRadius.circular(compact ? 28 : 34),
              border: Border.all(
                color: const Color(0xFFFFD98A).withValues(alpha: 0.46),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE7A94C).withValues(alpha: 0.14),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LibraryStandardCategoryImageSlot(
                  category: category,
                  compact: compact,
                  shortLandscape: MediaQuery.sizeOf(context).width >
                          MediaQuery.sizeOf(context).height &&
                      MediaQuery.sizeOf(context).height < 520,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).width >
                              MediaQuery.sizeOf(context).height &&
                          MediaQuery.sizeOf(context).height < 520
                      ? 6
                      : (compact ? 18 : 24),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8A13F).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: const Color(0xFFFFD98A).withValues(alpha: 0.42),
                    ),
                  ),
                  child: const Text(
                    'قريبًا',
                    style: TextStyle(
                      color: Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: compact ? 14 : 18),
                Text(
                  isAr ? category.titleAr : category.titleEn,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFFD47A),
                    fontSize: compact ? 30 : 44,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: compact ? 10 : 12),
                _LibrarySignalBadges(
                  keyName: category.keyName,
                  isAr: isAr,
                  maxBadges: 3,
                ),
                SizedBox(height: compact ? 10 : 12),
                Text(
                  isAr ? category.noteAr : category.noteEn,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFFE7B2).withValues(alpha: 0.88),
                    fontSize: compact ? 13 : 15,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: compact ? 14 : 18),
                Text(
                  isAr
                      ? 'هذا المحتوى للتوعية ولا يغني عن استشارة مختص عند الحاجة.'
                      : 'This content is educational and does not replace consulting a specialist when needed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFFFE7B2).withValues(alpha: 0.82),
                    fontSize: compact ? 13 : 15,
                    height: 1.4,
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

class _LibraryStandardCategoryImageSlot extends StatelessWidget {
  const _LibraryStandardCategoryImageSlot({
    required this.category,
    required this.compact,
    required this.shortLandscape,
  });

  final _LibCat category;
  final bool compact;
  final bool shortLandscape;

  @override
  Widget build(BuildContext context) {
    final imageHeight = shortLandscape ? 82.0 : (compact ? 150.0 : 230.0);

    return Container(
      height: imageHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(compact ? 24 : 30),
        border: Border.all(
          color: const Color(0xFFFFD98A).withValues(alpha: 0.34),
        ),
        gradient: RadialGradient(
          colors: [
            const Color(0xFFD8A13F).withValues(alpha: 0.18),
            const Color(0xFF080704).withValues(alpha: 0.72),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: Image.asset(
          normalizeAssetPath(category.asset),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.auto_stories_outlined,
              color: const Color(0xFFFFD47A).withValues(alpha: 0.72),
              size: compact ? 54 : 76,
            );
          },
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
            AppAnalytics.logPathSelected(
              'library',
              widget.category.keyName,
            );
            Navigator.of(context).pushNamed(
              _currentLibraryRouteName(context),
              arguments: {'categoryKey': widget.category.keyName},
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
                bottom: widget.compact ? 78 : 96,
                child: _LibrarySignalBadges(
                  keyName: widget.category.keyName,
                  isAr: widget.isAr,
                  maxBadges: 2,
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
    required this.isAr,
    required this.onPrevious,
    required this.onNext,
  });

  final bool compact;
  final bool isAr;
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
            icon: isAr
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_new_rounded,
            compact: compact,
            arrowOnLeft: false,
            onTap: isAr ? onNext : onPrevious,
          ),
          SizedBox(width: compact ? 18 : 26),
          _LibraryLogoNavControl(
            icon: isAr
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_forward_ios_rounded,
            compact: compact,
            arrowOnLeft: true,
            onTap: isAr ? onPrevious : onNext,
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
          'assets/branding/shared/logo/logo_primary_dark.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _LibrarySignalBadges extends StatelessWidget {
  const _LibrarySignalBadges({
    required this.keyName,
    required this.isAr,
    this.maxBadges = 3,
  });

  final String keyName;
  final bool isAr;
  final int maxBadges;

  @override
  Widget build(BuildContext context) {
    final metadata = LibrarySignalCatalog.forKey(keyName);
    if (metadata == null) return const SizedBox.shrink();

    final labels = metadata.displaySignalKeys
        .take(maxBadges)
        .map((key) => LibrarySignalLabels.label(key, isArabic: isAr))
        .where((label) => label.trim().isNotEmpty)
        .toList();
    if (labels.isEmpty) return const SizedBox.shrink();

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final label in labels)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFD8A13F).withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: const Color(0xFFFFD98A).withValues(alpha: 0.32),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFFE7B2),
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
      ],
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

_FeaturedLibraryEntry? _featuredLibraryEntry(String? keyName) {
  if (keyName == null || keyName.trim().isEmpty) return null;
  for (final entry in _featuredLibraryEntries) {
    if (entry.keyName == keyName.trim()) return entry;
  }
  return null;
}

_LibCat? _standardLibraryCategory(String? keyName, List<_LibCat> categories) {
  if (keyName == null || keyName.trim().isEmpty) return null;
  for (final category in categories) {
    if (category.keyName == keyName.trim()) return category;
  }
  return null;
}

String _currentLibraryRouteName(BuildContext context) {
  final routeName = ModalRoute.of(context)?.settings.name;
  if (_isWebLibraryRoute(context)) {
    return Routes.webLibrary;
  }
  return Routes.library;
}

bool _isWebLibraryRoute(BuildContext context) {
  final routeName = ModalRoute.of(context)?.settings.name;
  return routeName == Routes.webLibrary ||
      (routeName?.startsWith('/web/library') ?? false);
}

const _featuredLibraryEntries = <_FeaturedLibraryEntry>[
  _FeaturedLibraryEntry(
    keyName: 'family_awareness',
    titleAr: 'حضن آمن',
    titleEn: 'Safe embrace',
    icon: Icons.family_restroom_rounded,
    cardAsset: 'assets/branding/web/library/hodn_amen/hodn_amen_card.png',
  ),
  _FeaturedLibraryEntry(
    keyName: 'prevention_awareness',
    titleAr: 'بداية آمنة',
    titleEn: 'Safe start',
    icon: Icons.psychology_alt_rounded,
    cardAsset: 'assets/branding/web/library/bedaya_amena/bedaya_amena_card.png',
  ),
];

class _FeaturedLibraryEntry {
  const _FeaturedLibraryEntry({
    required this.keyName,
    required this.titleAr,
    required this.titleEn,
    required this.icon,
    required this.cardAsset,
  });

  final String keyName;
  final String titleAr;
  final String titleEn;
  final IconData icon;
  final String cardAsset;
}

class _LibCat {
  const _LibCat({
    required this.keyName,
    required this.titleAr,
    required this.titleEn,
    required this.noteAr,
    required this.noteEn,
    required this.asset,
  });

  final String keyName;
  final String titleAr;
  final String titleEn;
  final String noteAr;
  final String noteEn;
  final String asset;
}
