import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class SpecialistsCategoriesPage extends StatelessWidget {
  const SpecialistsCategoriesPage({super.key});

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    final items = <_SpecialistCategoryItem>[
      _SpecialistCategoryItem(
        title: isArabic ? 'أخصائيون نفسيون' : 'Psychologists',
        countLabel: isArabic
            ? 'يشمل الأخصائي النفسي والدكتور الإكلينيكي'
            : 'Includes psychologists and clinical psychologists',
        icon: Icons.psychology_alt_outlined,
        color: const Color(0xFF7C6EF6),
        route: Routes.specialistsList,
        arguments: {
          'category': 'psychologists',
          'title': isArabic ? 'أخصائيون نفسيون' : 'Psychologists',
        },
      ),
      _SpecialistCategoryItem(
        title: isArabic ? 'مشورة أسرية' : 'Family Counseling',
        countLabel: isArabic
            ? 'متابعة أسرية ومشكلات العلاقات'
            : 'Family guidance and relationship support',
        icon: Icons.family_restroom_outlined,
        color: const Color(0xFF37B8B0),
        route: Routes.specialistsList,
        arguments: {
          'category': 'family_counseling',
          'title': isArabic ? 'مشورة أسرية' : 'Family Counseling',
        },
      ),
      _SpecialistCategoryItem(
        title: isArabic ? 'أخصائيون تخاطب' : 'Speech Specialists',
        countLabel: isArabic
            ? 'جلسات تخاطب وتواصل'
            : 'Speech and communication sessions',
        icon: Icons.record_voice_over_outlined,
        color: const Color(0xFFE2A067),
        route: Routes.specialistsList,
        arguments: {
          'category': 'speech_specialists',
          'title': isArabic ? 'أخصائيون تخاطب' : 'Speech Specialists',
        },
      ),
      _SpecialistCategoryItem(
        title: isArabic ? 'كوتشينج' : 'Coaching',
        countLabel: isArabic
            ? 'دعم تطوير وتحفيز'
            : 'Development and motivation support',
        icon: Icons.rocket_launch_outlined,
        color: const Color(0xFF6F9DC7),
        route: Routes.specialistsList,
        arguments: {
          'category': 'coaching',
          'title': isArabic ? 'كوتشينج' : 'Coaching',
        },
      ),
      _SpecialistCategoryItem(
        title: isArabic ? 'علاج السلوكيات الإدمانية' : 'Addiction Counseling',
        countLabel:
            isArabic ? 'جلسات دعم وتعافٍ' : 'Recovery and addiction support',
        icon: Icons.healing_outlined,
        color: const Color(0xFFE58667),
        route: Routes.specialistsList,
        arguments: {
          'category': 'addiction',
          'title':
              isArabic ? 'علاج السلوكيات الإدمانية' : 'Addiction Counseling',
        },
      ),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'الأخصائيون' : 'Specialists',
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            int crossAxisCount = 2;
            double childAspectRatio = 1.35;

            if (width < 760) {
              crossAxisCount = 1;
              childAspectRatio = 1.12;
            } else if (width > 1500) {
              crossAxisCount = 3;
              childAspectRatio = 1.45;
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return _SpecialistCategoryCard(
                  item: item,
                  isArabic: isArabic,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _SpecialistCategoryItem {
  final String title;
  final String countLabel;
  final IconData icon;
  final Color color;
  final String route;
  final Map<String, dynamic>? arguments;

  const _SpecialistCategoryItem({
    required this.title,
    required this.countLabel,
    required this.icon,
    required this.color,
    required this.route,
    this.arguments,
  });
}

class _SpecialistCategoryCard extends StatelessWidget {
  final _SpecialistCategoryItem item;
  final bool isArabic;

  const _SpecialistCategoryCard({
    required this.item,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () => Navigator.of(context).pushNamed(
        item.route,
        arguments: item.arguments,
      ),
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
              item.countLabel,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

