import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class SupportEntryPage extends StatelessWidget {
  const SupportEntryPage.addiction({super.key})
      : _titleAr = 'ابدأ مسار دعم التعافي',
        _titleEn = 'Start Recovery Support',
        _subtitleAr =
            'نقطة بداية هادئة لاختيار الدعم المناسب: مختص، مركز، مواد مفيدة، أو طلب دعم منظم عند الحاجة.',
        _subtitleEn =
            'A calm starting point to choose support: specialist, center, helpful materials, or a structured support request when needed.',
        _chatEntryContext = 'recovery_support',
        _accent = const Color(0xFFE58667),
        _heroAsset = 'c7_branding/home/hero_art.png',
        _cards = const [
          _SupportPathCard(
            titleAr: 'ابحث عن مختص',
            titleEn: 'Find a specialist',
            bodyAr: 'استعرض مختصين مناسبين واختر ما يلائم احتياجك الحالي.',
            bodyEn:
                'Browse suitable specialists and choose what fits your current need.',
            icon: Icons.healing_outlined,
            route: Routes.specialistsList,
            analyticsPath: 'specialist',
            arguments: {
              'category': 'addiction',
              'returnRoute': Routes.addiction,
              'title': 'علاج السلوكيات الإدمانية',
            },
          ),
          _SupportPathCard(
            titleAr: 'استكشف المراكز',
            titleEn: 'Explore centers',
            bodyAr:
                'استعرض المراكز المتاحة وخيارات الدعم أو الإقامة عند الحاجة.',
            bodyEn:
                'Browse available centers and support or residential options when needed.',
            icon: Icons.apartment_outlined,
            route: Routes.centers,
            analyticsPath: 'center',
            arguments: {'returnRoute': Routes.addiction},
          ),
          _SupportPathCard(
            titleAr: 'مواد مفيدة',
            titleEn: 'Helpful materials',
            bodyAr: 'مواد توعوية وتمارين بسيطة تساعدك على الفهم والاتزان.',
            bodyEn:
                'Guides and simple exercises that support clarity and stability.',
            icon: Icons.auto_stories_outlined,
            route: Routes.library,
            analyticsPath: 'library',
            arguments: {'returnRoute': Routes.addiction},
          ),
          _SupportPathCard(
            titleAr: 'تحدث مع الدعم عند الحاجة',
            titleEn: 'Talk to support when needed',
            bodyAr: 'ابدأ طلب دعم منظم إذا احتجت إلى توجيه أو مساندة.',
            bodyEn:
                'Start a structured support request if you need guidance or help.',
            icon: Icons.chat_bubble_outline_rounded,
            route: Routes.supportIssueSelector,
            analyticsPath: 'issue_selector',
            arguments: {'supportType': 'recovery_support'},
          ),
        ];

  const SupportEntryPage.specialNeeds({super.key})
      : _titleAr = 'ابدأ مسار دعم الأسرة',
        _titleEn = 'Start Family Support',
        _subtitleAr =
            'نقطة بداية للأسرة لاختيار الدعم المناسب: مختص، مركز، مواد مفيدة، أو طلب دعم منظم عند الحاجة.',
        _subtitleEn =
            'A starting point for families to choose support: specialist, center, helpful materials, or a structured support request when needed.',
        _chatEntryContext = 'family_support',
        _accent = const Color(0xFF37B8B0),
        _heroAsset = 'c7_branding/home/hero_art.png',
        _cards = const [
          _SupportPathCard(
            titleAr: 'ابحث عن مختص',
            titleEn: 'Find a specialist',
            bodyAr: 'استعرض مختصين مناسبين واختر ما يلائم احتياج الأسرة الآن.',
            bodyEn:
                'Browse suitable specialists and choose what fits your family needs now.',
            icon: Icons.psychology_alt_outlined,
            route: Routes.specialists,
            analyticsPath: 'specialist',
            arguments: {'returnRoute': Routes.specialNeeds},
          ),
          _SupportPathCard(
            titleAr: 'استكشف المراكز',
            titleEn: 'Explore centers',
            bodyAr:
                'استعرض المراكز والخدمات المتاحة إذا كانت الأسرة تحتاج خيارات أوسع.',
            bodyEn:
                'Explore centers and services when the family needs broader options.',
            icon: Icons.local_hospital_outlined,
            route: Routes.centers,
            analyticsPath: 'center',
            arguments: {'returnRoute': Routes.specialNeeds},
          ),
          _SupportPathCard(
            titleAr: 'مواد مفيدة',
            titleEn: 'Helpful materials',
            bodyAr: 'محتوى داعم يساعد الأسرة على الفهم والاتزان.',
            bodyEn:
                'Supportive content that helps families build clarity and stability.',
            icon: Icons.menu_book_outlined,
            route: Routes.library,
            analyticsPath: 'library',
            arguments: {'returnRoute': Routes.specialNeeds},
          ),
          _SupportPathCard(
            titleAr: 'تحدث مع الدعم عند الحاجة',
            titleEn: 'Talk to support when needed',
            bodyAr:
                'اختر نوع طلب الدعم لفهم الخطوة التالية أو طلب مساندة بسيطة.',
            bodyEn:
                'Choose a support request type to clarify your next step or ask for simple help.',
            icon: Icons.support_agent_outlined,
            route: Routes.supportIssueSelector,
            analyticsPath: 'issue_selector',
            arguments: {'supportType': 'family_support'},
          ),
        ];

  final String _titleAr;
  final String _titleEn;
  final String _subtitleAr;
  final String _subtitleEn;
  final String _chatEntryContext;
  final Color _accent;
  final String _heroAsset;
  final List<_SupportPathCard> _cards;

  Map<String, dynamic> get _issueSelectorArguments => {
        'supportType': _chatEntryContext,
      };

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final scheme = Theme.of(context).colorScheme;
    final title = isArabic ? _titleAr : _titleEn;
    final subtitle = isArabic ? _subtitleAr : _subtitleEn;

    if (_chatEntryContext == 'recovery_support') {
      return _AddictionSupportEntryScaffold(
        cards: _cards,
        module: _chatEntryContext,
        isArabic: isArabic,
        reversedControls: true,
      );
    }

    if (_chatEntryContext == 'family_support') {
      return _AddictionSupportEntryScaffold(
        cards: [_cards[0], _cards[1], _cards[3], _cards[2]],
        module: _chatEntryContext,
        isArabic: isArabic,
        reversedControls: true,
      );
    }

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(context, title: title),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              normalizeAssetPath('assets/c7_branding/home/home_bg.png'),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: const Color(0xFFF4EFF6));
              },
            ),
            Container(color: Colors.white.withValues(alpha: 0.36)),
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _ModuleEntryLogger(module: _chatEntryContext),
                _ModuleHero(
                  title: title,
                  subtitle: subtitle,
                  accent: _accent,
                  heroAsset: _heroAsset,
                ),
                const SizedBox(height: 14),
                Container(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 28),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        _accent.withValues(alpha: 0.34),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: scheme.outline.withValues(alpha: 0.10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic
                            ? 'اختر نقطة البداية'
                            : 'Choose a starting point',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isArabic
                            ? 'اختر المسار الأنسب الآن: طلب دعم، مختص، مركز، أو مواد مفيدة.'
                            : 'Choose the most helpful path now: support request, specialist, center, or helpful materials.',
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2;
                    double childAspectRatio = 1.18;

                    if (constraints.maxWidth < 760) {
                      crossAxisCount = 1;
                      childAspectRatio = 1.08;
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _cards.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final item = _cards[index];
                        return _PathCardTile(
                          item: item,
                          module: _chatEntryContext,
                          isArabic: isArabic,
                          accent: _accent,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _HeroActionButton(
                        label: isArabic
                            ? 'اختيار نوع المساعدة'
                            : 'Choose Support Type',
                        asset: 'c7_branding/buttons/primary_button.png',
                        onTap: () {
                          AppAnalytics.logPathSelected(
                            _chatEntryContext,
                            'issue_selector',
                          );
                          Navigator.of(context).pushNamed(
                            Routes.supportIssueSelector,
                            arguments: _issueSelectorArguments,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _HeroActionButton(
                        label: isArabic
                            ? 'استعرض الأخصائيين'
                            : 'Browse specialists',
                        asset: 'c7_branding/buttons/secondary_button.png',
                        onTap: () =>
                            Navigator.of(context).pushNamed(Routes.specialists),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddictionSupportEntryScaffold extends StatefulWidget {
  const _AddictionSupportEntryScaffold({
    required this.cards,
    required this.module,
    required this.isArabic,
    required this.reversedControls,
  });

  final List<_SupportPathCard> cards;
  final String module;
  final bool isArabic;
  final bool reversedControls;

  @override
  State<_AddictionSupportEntryScaffold> createState() =>
      _AddictionSupportEntryScaffoldState();
}

class _AddictionSupportEntryScaffoldState
    extends State<_AddictionSupportEntryScaffold> {
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
      initialPage: oldPage.round().clamp(0, widget.cards.length - 1).toInt(),
      viewportFraction: viewportFraction,
    )..addListener(_handlePageChange);
    _page = oldPage;
  }

  void _goToPage(int targetIndex) {
    final clamped = targetIndex.clamp(0, widget.cards.length - 1).toInt();
    _pageController?.animateToPage(
      clamped,
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  void _nextPage() {
    _goToPage((_pageController?.page ?? _page).round() + 1);
  }

  void _previousPage() {
    _goToPage((_pageController?.page ?? _page).round() - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
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
                  _addictionBackgroundAsset(width),
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
                        child: _AddictionHeader(
                          isArabic: widget.isArabic,
                          module: widget.module,
                        ),
                      ),
                      Expanded(
                        child: isMobile || isTablet
                            ? _AddictionCarousel(
                                controller: pageController,
                                page: _page,
                                cards: widget.cards,
                                module: widget.module,
                                isArabic: widget.isArabic,
                                height: height,
                              )
                            : _AddictionDesktopStage(
                                controller: pageController,
                                page: _page,
                                cards: widget.cards,
                                module: widget.module,
                                isArabic: widget.isArabic,
                              ),
                      ),
                      _CarouselLogoControls(
                        compact: isMobile,
                        onPrevious: _previousPage,
                        onNext: _nextPage,
                        reversed: widget.reversedControls,
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
                _ModuleEntryLogger(module: widget.module),
              ],
            );
          },
        ),
      ),
    );
  }

  String _addictionBackgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
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
            child: Image.asset(
              Directionality.of(context) == TextDirection.rtl
                  ? 'assets/branding/navigation/back/back_right_gold.png'
                  : 'assets/branding/navigation/back/back_left_gold.png',
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

class _AddictionHeader extends StatelessWidget {
  const _AddictionHeader({
    required this.isArabic,
    required this.module,
  });

  final bool isArabic;
  final String module;

  @override
  Widget build(BuildContext context) {
    final isFamily = module == 'family_support';
    final title = isFamily
        ? (isArabic ? 'دعم الأسر' : 'Family Support')
        : (isArabic ? 'دعم المتعافي' : 'Recovery Support');
    final subtitle = isFamily
        ? (isArabic
            ? 'إرشاد هادئ يساندك في كل خطوة'
            : 'Calm guidance supporting every step')
        : (isArabic
            ? 'كل خطوة نحو التعافي لها سند'
            : 'Every step toward recovery has support');

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
    required this.compact,
    required this.onPrevious,
    required this.onNext,
    this.reversed = false,
  });

  final bool compact;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool reversed;

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
        children: reversed
            ? [
                _LogoNavControl(
                  icon: Icons.arrow_forward_ios_rounded,
                  compact: compact,
                  arrowOnLeft: false,
                  onTap: onNext,
                ),
                SizedBox(width: compact ? 18 : 26),
                _LogoNavControl(
                  icon: Icons.arrow_back_ios_new_rounded,
                  compact: compact,
                  arrowOnLeft: true,
                  onTap: onPrevious,
                ),
              ]
            : [
                _LogoNavControl(
                  icon: Icons.arrow_back_ios_new_rounded,
                  compact: compact,
                  arrowOnLeft: true,
                  onTap: onPrevious,
                ),
                SizedBox(width: compact ? 18 : 26),
                _LogoNavControl(
                  icon: Icons.arrow_forward_ios_rounded,
                  compact: compact,
                  arrowOnLeft: false,
                  onTap: onNext,
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
    required this.arrowOnLeft,
    required this.onTap,
  });

  final IconData icon;
  final bool compact;
  final bool arrowOnLeft;
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
    final arrow = _ArrowCircle(
      icon: widget.icon,
      size: arrowSize,
      compact: widget.compact,
    );
    final logo = _LogoCircle(
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

class _ArrowCircle extends StatelessWidget {
  const _ArrowCircle({
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

class _LogoCircle extends StatelessWidget {
  const _LogoCircle({
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

class _AddictionCarousel extends StatelessWidget {
  const _AddictionCarousel({
    required this.controller,
    required this.page,
    required this.cards,
    required this.module,
    required this.isArabic,
    required this.height,
  });

  final PageController controller;
  final double page;
  final List<_SupportPathCard> cards;
  final String module;
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
          itemCount: cards.length,
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
                child: _AddictionCard(
                  item: cards[index],
                  module: module,
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

class _AddictionDesktopStage extends StatelessWidget {
  const _AddictionDesktopStage({
    required this.controller,
    required this.page,
    required this.cards,
    required this.module,
    required this.isArabic,
  });

  final PageController controller;
  final double page;
  final List<_SupportPathCard> cards;
  final String module;
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
            itemCount: cards.length,
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
                  child: _AddictionCard(
                    item: cards[index],
                    module: module,
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

class _AddictionCard extends StatefulWidget {
  const _AddictionCard({
    required this.item,
    required this.module,
    required this.isArabic,
    this.compact = false,
  });

  final _SupportPathCard item;
  final String module;
  final bool isArabic;
  final bool compact;

  @override
  State<_AddictionCard> createState() => _AddictionCardState();
}

class _AddictionCardState extends State<_AddictionCard> {
  bool _hovered = false;

  String get _imageAsset {
    if (widget.module == 'family_support') {
      switch (widget.item.analyticsPath) {
        case 'specialist':
          return 'assets/images/family_support/family_find_specialist.png';
        case 'center':
          return 'assets/images/family_support/family_explore_centers.png';
        case 'issue_selector':
          return 'assets/images/family_support/family_contact_support.png';
        case 'library':
          return 'assets/images/family_support/family_library.png';
        default:
          return 'assets/images/family_support/family_library.png';
      }
    }

    switch (widget.item.analyticsPath) {
      case 'specialist':
        return 'assets/images/addiction/addiction_find_specialist.png';
      case 'center':
        return 'assets/images/addiction/addiction_explore_centers.png';
      case 'library':
        return 'assets/images/addiction/addiction_library.png';
      case 'issue_selector':
        return 'assets/images/addiction/addiction_contact_support.png';
      default:
        return 'assets/images/addiction/addiction_library.png';
    }
  }

  String _title(bool isArabic) {
    if (!isArabic) return widget.item.titleEn;
    if (widget.module == 'family_support') {
      switch (widget.item.analyticsPath) {
        case 'specialist':
          return 'البحث عن أخصائي';
        case 'center':
          return 'استكشف مراكز متخصصة';
        case 'issue_selector':
          return 'الدعم عند الحاجة';
        case 'library':
          return 'مواد مفيدة';
        default:
          return widget.item.titleAr;
      }
    }

    switch (widget.item.analyticsPath) {
      case 'specialist':
        return 'ابحث عن مختص';
      case 'center':
        return 'استكشف المراكز';
      case 'library':
        return 'مواد مفيدة';
      case 'issue_selector':
        return 'تحدث مع الدعم';
      default:
        return widget.item.titleAr;
    }
  }

  String _subtitle(bool isArabic) {
    if (!isArabic) return widget.item.bodyEn;
    if (widget.module == 'family_support') {
      switch (widget.item.analyticsPath) {
        case 'specialist':
          return 'مختصون لدعم الأسرة والاحتياجات الخاصة';
        case 'center':
          return 'مراكز قريبة ومناسبة لاحتياجات أسرتك';
        case 'issue_selector':
          return 'نحن هنا لدعمك وقت احتياجك';
        case 'library':
          return 'معلومات ونصائح تدعم رحلتك مع أسرتك';
        default:
          return widget.item.bodyAr;
      }
    }

    switch (widget.item.analyticsPath) {
      case 'specialist':
        return 'مختصون معتمدون لدعم رحلتك';
      case 'center':
        return 'مراكز وبرامج مناسبة للتعافي';
      case 'library':
        return 'محتوى داعم وموثوق لرحلتك';
      case 'issue_selector':
        return 'مساعدة آمنة وقت الحاجة';
      default:
        return widget.item.bodyAr;
    }
  }

  Color get _accent {
    if (widget.module == 'family_support') {
      switch (widget.item.analyticsPath) {
        case 'specialist':
          return const Color(0xFF67B7C8);
        case 'center':
          return const Color(0xFFD8A75F);
        case 'issue_selector':
          return const Color(0xFFC68C5A);
        case 'library':
          return const Color(0xFFE0B86E);
        default:
          return const Color(0xFFD8A75F);
      }
    }

    switch (widget.item.analyticsPath) {
      case 'specialist':
        return const Color(0xFFD9A85F);
      case 'center':
        return const Color(0xFFC98E52);
      case 'library':
        return const Color(0xFFE0B86E);
      case 'issue_selector':
        return const Color(0xFFE58667);
      default:
        return const Color(0xFFD9A85F);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.compact ? 30.0 : 36.0;
    final title = _title(widget.isArabic);
    final subtitle = _subtitle(widget.isArabic);

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
                widget.module, widget.item.analyticsPath);
            if (widget.item.route == Routes.chat) {
              AppAnalytics.logChatOpened(widget.module);
            }
            Navigator.of(context).pushNamed(
              widget.item.route,
              arguments: widget.item.arguments,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: _accent.withValues(alpha: _hovered ? 0.42 : 0.28),
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
                    _imageAsset,
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
                          Colors.black.withValues(alpha: 0.74),
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
                            _accent.withValues(alpha: 0.70),
                            const Color(0xFF211408).withValues(alpha: 0.74),
                          ],
                        ),
                        border: Border.all(
                          color:
                              const Color(0xFFFFDA8C).withValues(alpha: 0.58),
                        ),
                      ),
                      child: Icon(
                        widget.item.icon,
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
                          title,
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
                          subtitle,
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

class _SupportPathCard {
  const _SupportPathCard({
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    required this.icon,
    required this.route,
    required this.analyticsPath,
    this.arguments,
  });

  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final IconData icon;
  final String route;
  final String analyticsPath;
  final Map<String, dynamic>? arguments;
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

class _ModuleHero extends StatelessWidget {
  const _ModuleHero({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.heroAsset,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final String heroAsset;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        children: [
          SizedBox(
            height: 270,
            width: double.infinity,
            child: Image.asset(
              normalizeAssetPath(heroAsset),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accent.withValues(alpha: 0.18),
                        const Color(0xFFF4EFF6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.42),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 18,
            end: 18,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.94),
                        height: 1.35,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PathCardTile extends StatelessWidget {
  const _PathCardTile({
    required this.item,
    required this.module,
    required this.isArabic,
    required this.accent,
  });

  final _SupportPathCard item;
  final String module;
  final bool isArabic;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = isArabic ? item.titleAr : item.titleEn;
    final body = isArabic ? item.bodyAr : item.bodyEn;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        AppAnalytics.logPathSelected(module, item.analyticsPath);
        if (item.route == Routes.chat) {
          AppAnalytics.logChatOpened(module);
        }
        Navigator.of(context).pushNamed(
          item.route,
          arguments: item.arguments,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: scheme.outline.withValues(alpha: 0.10),
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 16,
              color: Color(0x12000000),
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Align(
              alignment:
                  isArabic ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: accent, size: 31),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.35,
                  ),
            ),
            const Spacer(),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                isArabic ? 'افتح المسار' : 'Open path',
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroActionButton extends StatelessWidget {
  const _HeroActionButton({
    required this.label,
    required this.asset,
    required this.onTap,
  });

  final String label;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 58,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    normalizeAssetPath(asset),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(context).colorScheme.primary,
                      );
                    },
                  ),
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
