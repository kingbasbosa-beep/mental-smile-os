import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Future<bool> _isAdminResolved() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid == null || uid.isEmpty || user?.isAnonymous == true) return false;

    if (uid == kKnownPrimaryAdminUid) return true;

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

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }

  void _goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).maybePop();
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.home,
        (route) => false,
      );
    }
  }

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
        appBar: AppBar(
          title: const Text('Mental Smile'),
          leading: IconButton(
            tooltip: isArabic ? 'رجوع' : 'Back',
            onPressed: () => _goBack(context),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            FutureBuilder<({String label, IconData icon, String route})?>(
              future: _resolvePrimaryAction(isArabic),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  if (!_isClientLoggedIn()) {
                    return const SizedBox.shrink();
                  }

                  return const Padding(
                    padding: EdgeInsetsDirectional.only(end: 8),
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final action = snapshot.data;
                if (action == null) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(action.route);
                    },
                    icon: Icon(action.icon),
                    label: Text(action.label),
                  ),
                );
              },
            ),
            IconButton(
              tooltip: isArabic ? 'اللغة' : 'Language',
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.language);
              },
              icon: const Icon(Icons.language_outlined),
            ),
            IconButton(
              tooltip: isArabic ? 'تسجيل الخروج' : 'Logout',
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'c7_branding/home/home_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(decoration: AppDecorations.pageBackground());
              },
            ),
            Container(
              color: AppColors.warmIvory.withValues(alpha: 0.56),
            ),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1240),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: () {
                            AppAnalytics.logChatOpened('general');
                            Navigator.of(context).pushNamed(Routes.chat);
                          },
                          child: CircleAvatar(
                            radius: 36,
                            backgroundColor:
                                AppColors.deepTeal.withValues(alpha: 0.10),
                            child: ClipOval(
                              child: Image.asset(
                                normalizeAssetPath(
                                  'assets/c5/avatars/avatar_admin_support.png',
                                ),
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 72,
                                    height: 72,
                                    color: AppColors.deepTeal
                                        .withValues(alpha: 0.10),
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
                        const SizedBox(height: AppSpacing.md),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final width = constraints.maxWidth;
                              final isMobile = width < 620;
                              final itemWidth = isMobile
                                  ? ((width - AppSpacing.lg) / 2)
                                      .clamp(112.0, 150.0)
                                  : width < 980
                                      ? 138.0
                                      : 146.0;
                              final spacing = isMobile
                                  ? AppSpacing.md
                                  : width < 980
                                      ? AppSpacing.lg
                                      : AppSpacing.xl;

                              return Center(
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    spacing: spacing,
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
                            },
                          ),
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
