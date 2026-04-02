import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const Set<String> _knownAdminEmails = {
    'kingbasbosa@gmail.com',
    'kingbasbosa@hotmail.com',
  };

  Future<bool> _isAdminResolved() async {
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
      if (data != null && (data['isAdmin'] ?? false) == true) {
        return true;
      }
    } on FirebaseException {
      return false;
    }

    if (_knownAdminEmails.contains(email)) {
      return true;
    }

    if (email.isEmpty) return false;

    try {
      final byEmail = await FirebaseFirestore.instance
          .collection('clinicians')
          .where('email', isEqualTo: email)
          .where('isAdmin', isEqualTo: true)
          .limit(1)
          .get();

      return byEmail.docs.isNotEmpty;
    } on FirebaseException {
      return false;
    }
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
        return (data['role'] ?? '') == 'clinician' &&
            (data['isAdmin'] ?? false) != true;
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
      return (emailData['role'] ?? '') == 'clinician' &&
          (emailData['isAdmin'] ?? false) != true;
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
        title: isArabic ? 'المراكز' : 'Centers',
        subtitle: isArabic
            ? 'استعرض المراكز والخدمات المتاحة'
            : 'Browse centers and available services',
        icon: Icons.apartment_outlined,
        route: Routes.centers,
      ),
      _MenuCardData(
        title: isArabic ? 'الأخصائيون' : 'Specialists',
        subtitle: isArabic
            ? 'استعرض التخصصات وابدأ طلب الحجز'
            : 'Browse specialists and request a booking',
        icon: Icons.psychology_alt_outlined,
        route: Routes.specialists,
      ),
      _MenuCardData(
        title: isArabic ? 'المكتبة' : 'Library',
        subtitle: isArabic
            ? 'مواد ومحتوى داعم وإرشادي'
            : 'Supportive and educational content',
        icon: Icons.auto_stories_outlined,
        route: Routes.library,
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
      ),
      _MenuCardData(
        title: isArabic ? 'دعم المدمن المتعافي' : 'Recovered Addict Support',
        subtitle: isArabic
            ? 'دعم هادئ للتعافي مع المختصين والمراكز والشات'
            : 'A calm recovery path across specialists, centers, and support chat',
        icon: Icons.healing_outlined,
        route: Routes.addiction,
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
              'assets/c7_branding/home/home_bg.png',
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
                        Row(
                          textDirection: textDirection,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: isArabic
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.start,
                                children: [
                                  const AppLogoWordmark(width: 170, height: 72),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    isArabic
                                        ? 'اختر المسار المناسب للبدء. جميع الطلبات تمر عبر الإدارة لضمان المتابعة والتنظيم.'
                                        : 'Choose the right path to begin. All requests go through admins for safe coordination.',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppColors.obsidian,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        InkWell(
                          borderRadius: BorderRadius.circular(AppRadii.xl),
                          onTap: () =>
                              Navigator.of(context).pushNamed(Routes.chat),
                          child: AppSurfaceCard(
                            color: Colors.white.withValues(alpha: 0.84),
                            child: Row(
                              textDirection: textDirection,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: isArabic
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isArabic
                                            ? 'شات Mental Smile'
                                            : 'Mental Smile Chat',
                                        textAlign: isArabic
                                            ? TextAlign.right
                                            : TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        isArabic
                                            ? 'ابدأ محادثة دعم أولي آمنة، مع تصعيد بشري عند الحاجة.'
                                            : 'Start a safe first-line support chat with human escalation when needed.',
                                        textAlign: isArabic
                                            ? TextAlign.right
                                            : TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor: AppColors.deepTeal
                                      .withValues(alpha: 0.10),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/c5/avatars/avatar_admin_support.png',
                                      width: 72,
                                      height: 72,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final width = constraints.maxWidth;
                              int crossAxisCount = 2;
                              double childAspectRatio = 1.55;

                              if (width < 920) {
                                crossAxisCount = 1;
                                childAspectRatio = 2.0;
                              }

                              return GridView.builder(
                                itemCount: cards.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: AppSpacing.md,
                                  mainAxisSpacing: AppSpacing.md,
                                  childAspectRatio: childAspectRatio,
                                ),
                                itemBuilder: (context, index) {
                                  final item = cards[index];
                                  return _MenuCard(
                                    item: item,
                                    isArabic: isArabic,
                                  );
                                },
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

  const _MenuCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.item,
    required this.isArabic,
  });

  final _MenuCardData item;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () => Navigator.of(context).pushNamed(item.route),
      child: AppSurfaceCard(
        color: Colors.white.withValues(alpha: 0.82),
        child: Row(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.deepTeal.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: AppColors.deepTeal,
                size: 31,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    item.subtitle,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
