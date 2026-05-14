import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Future<bool> _isAdminResolved() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid == null || uid.isEmpty || user?.isAnonymous == true) return false;

    try {
      final adminDoc =
          await FirebaseFirestore.instance.collection('admins').doc(uid).get();
      final data = adminDoc.data();
      if (data != null && (data['active'] ?? false) == true) {
        return true;
      }
    } on FirebaseException {
      return false;
    }
    return false;
  }

  Future<bool> _isClinicianResolved() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    final email = (user?.email ?? '').trim().toLowerCase();
    if (uid == null || uid.isEmpty || user?.isAnonymous == true) return false;

    try {
      final clinicianDoc = await FirebaseFirestore.instance
          .collection('clinicians')
          .doc(uid)
          .get();
      final data = clinicianDoc.data();
      if (data != null) {
        return (data['role'] ?? '') == 'clinician';
      }
    } on FirebaseException {
      return false;
    }

    if (email.isEmpty) return false;

    try {
      final byEmail = await FirebaseFirestore.instance
          .collection('clinicians')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (byEmail.docs.isEmpty) return false;
      final emailData = byEmail.docs.first.data();
      return (emailData['role'] ?? '') == 'clinician';
    } on FirebaseException {
      return false;
    }
  }

  Future<bool> _isCenterResolved() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid == null || uid.isEmpty || user?.isAnonymous == true) return false;

    try {
      final doc =
          await FirebaseFirestore.instance.collection('centers').doc(uid).get();
      final data = doc.data();
      if (data == null) return false;
      return (data['role'] ?? '') == 'center';
    } on FirebaseException {
      return false;
    }
  }

  Future<({String label, IconData icon, String route})?> _resolvePrimaryAction(
    bool isArabic,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final isAdmin = await _isAdminResolved();
    if (isAdmin) {
      return (
        label: isArabic ? 'لوحة الإدارة' : 'Admin Hub',
        icon: Icons.admin_panel_settings_outlined,
        route: Routes.adminHub,
      );
    }

    final isClinician = await _isClinicianResolved();
    if (isClinician) {
      return (
        label: isArabic ? 'غرفة العمليات' : 'Operations Room',
        icon: Icons.medical_services_outlined,
        route: Routes.clinicianOperations,
      );
    }

    final isCenter = await _isCenterResolved();
    if (isCenter) {
      return (
        label: isArabic ? 'صفحة المركز' : 'Center Dashboard',
        icon: Icons.business_outlined,
        route: Routes.centerDashboard,
      );
    }

    if (_isClientLoggedIn()) {
      return (
        label: isArabic ? 'صفحتي الشخصية' : 'My Dashboard',
        icon: Icons.person_outline_rounded,
        route: Routes.clientDashboard,
      );
    }

    return null;
  }

  bool _isClientLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final email = (user.email ?? '').trim();
    return email.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode.toLowerCase() == 'ar';
    final l10n = AppLocalizations.of(context)!;
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    final cards = <_MenuCardData>[
      _MenuCardData(
        title: l10n.menuSpecialists,
        subtitle: isArabic
            ? 'استعرض التخصصات وابدأ طلب الحجز'
            : 'Browse specialists and request a booking',
        icon: Icons.psychology_alt_outlined,
        route: Routes.specialists,
        accent: AppColors.accentLavender,
      ),
      _MenuCardData(
        title: l10n.menuCenters,
        subtitle: isArabic
            ? 'استعرض المراكز والخدمات المتاحة'
            : 'Browse centers and available services',
        icon: Icons.apartment_outlined,
        route: Routes.centers,
        accent: AppColors.mutedGold,
      ),
      _MenuCardData(
        title: l10n.menuLibrary,
        subtitle: isArabic
            ? 'مواد ومحتوى داعم وإرشادي'
            : 'Supportive and educational content',
        icon: Icons.auto_stories_outlined,
        route: Routes.library,
        accent: AppColors.softTerracotta,
      ),
      _MenuCardData(
        title: l10n.menuAddictionSupport,
        subtitle: isArabic
            ? 'دعم هادئ للتعافي مع المختصين والمراكز وطلب دعم منظم'
            : 'A calm recovery path across specialists, centers, and structured support',
        icon: Icons.healing_outlined,
        route: Routes.addiction,
        accent: AppColors.success,
      ),
      _MenuCardData(
        title: l10n.menuSpecialNeedsFamilies,
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
            Positioned.fill(
              child: Transform.scale(
                scale: 1.0,
                child: Image.asset(
                  _menuBackgroundAsset(context),
                  fit: BoxFit.cover,
                  alignment: _menuBackgroundAlignment(context),
                  errorBuilder: (context, error, stackTrace) {
                    return const ColoredBox(color: Color(0xFF02070C));
                  },
                ),
              ),
            ),
            ColoredBox(
              color: Colors.black.withValues(alpha: 0.28),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    FutureBuilder<
                        ({String label, IconData icon, String route})?>(
                      future: _resolvePrimaryAction(isArabic),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          if (!_isClientLoggedIn()) {
                            return const SizedBox.shrink();
                          }

                          return const _FloatingMenuSpinner();
                        }

                        final action = snapshot.data;
                        if (action == null) {
                          return const SizedBox.shrink();
                        }

                        return Transform.translate(
                          offset: const Offset(38, 0),
                          child: _FloatingProfileButton(
                            label: action.label,
                            icon: action.icon,
                            onPressed: () {
                              Navigator.of(context).pushNamed(action.route);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = constraints.maxHeight;
                  final isMobile = width < 700;
                  final usePentagon = width >= 700 && height >= 420;
                  final avatarSize = isMobile ? 74.0 : 90.0;
                  final avatarTop = isMobile ? 66.0 : 72.0;
                  final avatarLeft = isMobile ? 78.0 : 82.0;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: avatarTop,
                        left: avatarLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: () {
                            AppAnalytics.logChatOpened('general');
                            Navigator.of(context).pushNamed(Routes.chat);
                          },
                          child: CircleAvatar(
                            radius: avatarSize / 2,
                            backgroundColor:
                                const Color(0xFFE7B75F).withValues(alpha: 0.42),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE9C878)
                                      .withValues(alpha: 0.86),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFFB347)
                                        .withValues(alpha: 0.28),
                                    blurRadius: 24,
                                    spreadRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF5A2D0C)
                                        .withValues(alpha: 0.34),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  normalizeAssetPath(
                                    'assets/images/avatar_clinician_male.png',
                                  ),
                                  width: avatarSize,
                                  height: avatarSize,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: avatarSize,
                                      height: avatarSize,
                                      color: const Color(0xFF2D2114)
                                          .withValues(alpha: 0.72),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.support_agent_rounded,
                                        color: Color(0xFFE9C878),
                                        size: 28,
                                      ),
                                    );
                                  },
                                ),
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
                      Positioned(
                        top: isMobile ? 128 : 74,
                        left: isMobile ? 18 : null,
                        right: isMobile ? 18 : null,
                        child: _MenuLibraryTeaserHearts(
                          compact: isMobile,
                          isArabic: isArabic,
                        ),
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

Alignment _menuBackgroundAlignment(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 700) return Alignment.topCenter;
  return Alignment.center;
}

class _FloatingProfileButton extends StatelessWidget {
  const _FloatingProfileButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.obsidian.withValues(alpha: 0.48),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.mutedGold.withValues(alpha: 0.58),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepTeal.withValues(alpha: 0.18),
                blurRadius: 14,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.mutedGold, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.mutedGold,
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

class _FloatingMenuSpinner extends StatelessWidget {
  const _FloatingMenuSpinner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.obsidian.withValues(alpha: 0.48),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.mutedGold.withValues(alpha: 0.58),
        ),
      ),
      child: const Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _MenuLibraryTeaserHearts extends StatelessWidget {
  const _MenuLibraryTeaserHearts({
    required this.compact,
    required this.isArabic,
  });

  final bool compact;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final entries = [
      (
        keyName: 'family_awareness',
        title: isArabic ? 'حضن آمن' : 'Safe embrace',
      ),
      (
        keyName: 'prevention_awareness',
        title: isArabic ? 'بداية آمنة' : 'Safe start',
      ),
    ];

    return IgnorePointer(
      ignoring: false,
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: compact ? 10 : 14,
          runSpacing: compact ? 8 : 10,
          children: [
            for (final entry in entries)
              _MenuComingSoonHeart(
                compact: compact,
                title: entry.title,
                onTap: () {
                  AppAnalytics.logPathSelected('menu', entry.keyName);
                  Navigator.of(context).pushNamed(
                    Routes.library,
                    arguments: {'categoryKey': entry.keyName},
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _MenuComingSoonHeart extends StatefulWidget {
  const _MenuComingSoonHeart({
    required this.compact,
    required this.title,
    required this.onTap,
  });

  final bool compact;
  final String title;
  final VoidCallback onTap;

  @override
  State<_MenuComingSoonHeart> createState() => _MenuComingSoonHeartState();
}

class _MenuComingSoonHeartState extends State<_MenuComingSoonHeart> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final heartSize = widget.compact ? 58.0 : 70.0;

    return Tooltip(
      message: widget.title,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedScale(
          scale: _hovered ? 1.06 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: widget.onTap,
            child: SizedBox(
              width: widget.compact ? 58 : 70,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: heartSize,
                    height: heartSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: const Color(0xFFD9A640),
                          size: heartSize,
                          shadows: [
                            Shadow(
                              color: const Color(0xFFFFD98A).withValues(
                                alpha: _hovered ? 0.42 : 0.22,
                              ),
                              blurRadius: _hovered ? 18 : 12,
                            ),
                            const Shadow(
                              color: Colors.black,
                              blurRadius: 12,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        Text(
                          'قريبًا',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: const Color(0xFF1A1007),
                                    fontSize: widget.compact ? 10 : 11,
                                    fontWeight: FontWeight.w900,
                                    height: 1,
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
                        const Color(0xFFFFE8A3).withValues(alpha: 0.92),
                        const Color(0xFFD79B36).withValues(alpha: 0.76),
                        const Color(0xFF4A2A12).withValues(alpha: 0.58),
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xFFFFD98B).withValues(alpha: 0.62),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFB347).withValues(
                          alpha: _hovered ? 0.34 : 0.20,
                        ),
                        blurRadius: _hovered ? 24 : 16,
                        spreadRadius: _hovered ? 1.4 : 0,
                      ),
                      BoxShadow(
                        color: const Color(0xFF3A1E0B).withValues(alpha: 0.30),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2D2114).withValues(alpha: 0.34),
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFFFFD98B).withValues(alpha: 0.14),
                          blurRadius: 12,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: Icon(
                      item.icon,
                      color: const Color(0xFF153E3B),
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: const Color(0xFFFFE8B8),
                    fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow(
                        color: const Color(0xFF2D1304).withValues(alpha: 0.90),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                      Shadow(
                        color: const Color(0xFFFFB347).withValues(alpha: 0.22),
                        blurRadius: 12,
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
