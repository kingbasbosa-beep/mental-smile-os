import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';
import 'package:flutterprojects/core/ui/app_design_system.dart';

class CentersLandingPage extends StatelessWidget {
  const CentersLandingPage({super.key});

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    final items = <_CenterCategoryItem>[
      _CenterCategoryItem(
        title: isArabic ? 'مراكز التعافي' : 'Recovery Centers',
        subtitle: isArabic
            ? 'اعرض مراكز التعافي والدعم'
            : 'Browse recovery and support centers',
        icon: Icons.volunteer_activism_outlined,
        color: const Color(0xFF2F6B5F),
        accent: const Color(0xFFE2B65B),
        assetPath: 'assets/c7_branding/home/hero_art.png',
        route: Routes.centersList,
        arguments: {'category': 'recovery'},
      ),
      _CenterCategoryItem(
        title: isArabic ? 'مراكز سحب السموم' : 'Detox Centers',
        subtitle:
            isArabic ? 'مراكز متخصصة لسحب السموم' : 'Specialized detox centers',
        icon: Icons.auto_awesome_mosaic_outlined,
        color: const Color(0xFF6D5542),
        accent: const Color(0xFFD4AF37),
        assetPath: 'assets/c7_branding/home/home_bg.png',
        route: Routes.centersList,
        arguments: {'category': 'detox'},
      ),
      _CenterCategoryItem(
        title: isArabic
            ? 'مراكز رعاية ذوي الاحتياجات الخاصة'
            : 'Special Needs Centers',
        subtitle: isArabic
            ? 'رعاية ومتابعة للحالات الخاصة'
            : 'Care and support for special needs',
        icon: Icons.accessibility_new_outlined,
        color: const Color(0xFF4E6A7D),
        accent: const Color(0xFFCBB88A),
        assetPath: 'assets/c7_branding/logo/logo_mark.png',
        route: Routes.centersList,
        arguments: {'category': 'special_needs'},
      ),
      _CenterCategoryItem(
        title: isArabic ? 'المستشفيات' : 'Hospitals',
        subtitle: isArabic
            ? 'مستشفيات ومؤسسات علاجية'
            : 'Hospitals and treatment institutions',
        icon: Icons.local_hospital_outlined,
        color: const Color(0xFF7B5C41),
        accent: const Color(0xFFE0B97B),
        assetPath: 'assets/c7_branding/home/hero_art.png',
        route: Routes.centersList,
        arguments: {'category': 'hospital'},
      ),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'المراكز' : 'Centers',
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            int crossAxisCount = 2;
            double childAspectRatio = 1.55;

            if (width < 760) {
              crossAxisCount = 1;
              childAspectRatio = 1.30;
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.84),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.mutedGold.withValues(alpha: 0.14),
                    ),
                    boxShadow: AppShadows.card,
                  ),
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic
                            ? 'اختر فئة المراكز'
                            : 'Choose a center category',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isArabic
                            ? 'اضغط مباشرة على أي بطاقة لفتح الجريد الخاص بالمراكز داخل هذه الفئة.'
                            : 'Tap any card directly to open centers in that category.',
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _CenterCategoryCard(
                      item: item,
                      isArabic: isArabic,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CenterCategoryItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color accent;
  final String assetPath;
  final String route;
  final Map<String, dynamic> arguments;

  const _CenterCategoryItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.accent,
    required this.assetPath,
    required this.route,
    required this.arguments,
  });
}

class _CenterCategoryCard extends StatelessWidget {
  final _CenterCategoryItem item;
  final bool isArabic;

  const _CenterCategoryCard({
    required this.item,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () {
        Navigator.of(context).pushNamed(
          item.route,
          arguments: item.arguments,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              item.color,
              Color.lerp(item.color, Colors.black, 0.12)!,
            ],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment:
                        isArabic ? Alignment.topRight : Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: item.accent.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                      ),
                      child: Text(
                        isArabic ? 'فئة علاجية' : 'Care Track',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Opacity(
                          opacity: 0.22,
                          child: Image.asset(
                            item.assetPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          item.icon,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              item.title,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                height: 1.08,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.subtitle,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.18,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment:
                  isArabic ? MainAxisAlignment.start : MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    isArabic ? 'افتح الفئة' : 'Open category',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  isArabic ? Icons.arrow_back_rounded : Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Opacity(
                opacity: 0.18,
                child: Image.asset(
                  item.assetPath,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
