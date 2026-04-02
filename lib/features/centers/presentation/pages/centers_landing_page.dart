import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';

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
        color: const Color(0xFF56C3B3),
        route: Routes.centersList,
        arguments: {'category': 'recovery'},
      ),
      _CenterCategoryItem(
        title: isArabic ? 'مراكز سحب السموم' : 'Detox Centers',
        subtitle:
            isArabic ? 'مراكز متخصصة لسحب السموم' : 'Specialized detox centers',
        icon: Icons.auto_awesome_mosaic_outlined,
        color: const Color(0xFF7C6EF6),
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
        color: const Color(0xFF7FA8D1),
        route: Routes.centersList,
        arguments: {'category': 'special_needs'},
      ),
      _CenterCategoryItem(
        title: isArabic ? 'المستشفيات' : 'Hospitals',
        subtitle: isArabic
            ? 'مستشفيات ومؤسسات علاجية'
            : 'Hospitals and treatment institutions',
        icon: Icons.local_hospital_outlined,
        color: const Color(0xFFE4A76D),
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
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withValues(alpha: 0.12),
                    ),
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
  final String route;
  final Map<String, dynamic> arguments;

  const _CenterCategoryItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
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
          color: item.color,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Align(
              alignment: isArabic ? Alignment.topLeft : Alignment.topRight,
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  color: Colors.white,
                  size: 36,
                ),
              ),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                isArabic ? 'فتح الفئة' : 'Open category',
                style: const TextStyle(
                  color: Colors.white,
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
