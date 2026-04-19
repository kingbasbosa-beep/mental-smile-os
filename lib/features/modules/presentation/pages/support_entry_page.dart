import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class SupportEntryPage extends StatelessWidget {
  const SupportEntryPage.addiction({super.key})
      : _titleAr = 'دعم المدمن المتعافي',
        _titleEn = 'Recovered Addict Support',
        _subtitleAr =
            'مسار هادئ وآمن للدعم اليومي، طلب المساندة، والوصول إلى المختصين والمراكز بدون وصم أو تهويل.',
        _subtitleEn =
            'A calm, safe path for daily support, asking for help, and reaching specialists and centers without shame or alarm.',
        _accent = const Color(0xFFE58667),
        _heroAsset = 'c7_branding/home/hero_art.png',
        _cards = const [
          _SupportPathCard(
            titleAr: 'أخصائي السلوكيات الإدمانية',
            titleEn: 'Addiction counselor',
            bodyAr: 'ابدأ بطلب جلسة مع مختص مناسب لحالتك وخطتك الحالية.',
            bodyEn:
                'Start by requesting a session with a specialist suited to your current recovery stage.',
            icon: Icons.healing_outlined,
            route: Routes.specialistsList,
            arguments: {
              'category': 'addiction',
              'title': 'علاج السلوكيات الإدمانية',
            },
          ),
          _SupportPathCard(
            titleAr: 'المراكز وبرامج المتابعة',
            titleEn: 'Centers and follow-up',
            bodyAr:
                'استعرض المراكز المتاحة وخدمات الدعم أو الإقامة عند الحاجة.',
            bodyEn:
                'Browse available centers and support or residential care when needed.',
            icon: Icons.apartment_outlined,
            route: Routes.centers,
          ),
          _SupportPathCard(
            titleAr: 'مكتبة التعافي',
            titleEn: 'Recovery library',
            bodyAr: 'مواد توعوية وتمارين تساعد على الاستمرار واستعادة الاتزان.',
            bodyEn:
                'Guides and exercises to support stability and steady recovery.',
            icon: Icons.auto_stories_outlined,
            route: Routes.library,
          ),
          _SupportPathCard(
            titleAr: 'شات الدعم الهادئ',
            titleEn: 'Support chat',
            bodyAr:
                'ابدأ محادثة داعمة وآمنة، ومع ارتفاع الخطر يتم التصعيد للمراجعة البشرية.',
            bodyEn:
                'Start a safe supportive conversation, with human escalation when risk rises.',
            icon: Icons.chat_bubble_outline_rounded,
            route: Routes.chat,
          ),
        ];

  const SupportEntryPage.specialNeeds({super.key})
      : _titleAr = 'رعاية أسر ذوي الاحتياجات الخاصة',
        _titleEn = 'Special Needs Family Care',
        _subtitleAr =
            'مسار أسري داعم يساعد على الفهم، التنظيم، وطلب المساندة المناسبة للأسرة والطفل خطوة بخطوة.',
        _subtitleEn =
            'A family-aware support path for understanding, organizing, and requesting the right help for both family and child.',
        _accent = const Color(0xFF37B8B0),
        _heroAsset = 'c7_branding/home/hero_art.png',
        _cards = const [
          _SupportPathCard(
            titleAr: 'ابدأ مع الأخصائيين',
            titleEn: 'Start with specialists',
            bodyAr:
                'استعرض الأخصائيين المناسبين واختر المسار الأقرب لاحتياج الأسرة.',
            bodyEn:
                'Browse suitable specialists and choose the path closest to your family needs.',
            icon: Icons.psychology_alt_outlined,
            route: Routes.specialists,
          ),
          _SupportPathCard(
            titleAr: 'مراكز وخدمات مساندة',
            titleEn: 'Centers and support services',
            bodyAr:
                'اعرض المراكز والخدمات المتاحة للحالات التي تحتاج رعاية أوسع.',
            bodyEn:
                'Explore centers and services for cases that need broader support.',
            icon: Icons.local_hospital_outlined,
            route: Routes.centers,
          ),
          _SupportPathCard(
            titleAr: 'مواد إرشادية للأسرة',
            titleEn: 'Family guidance library',
            bodyAr: 'محتوى داعم يساعد الأسرة على الفهم والاتزان اليومي.',
            bodyEn:
                'Supportive content that helps families build clarity and daily stability.',
            icon: Icons.menu_book_outlined,
            route: Routes.library,
          ),
          _SupportPathCard(
            titleAr: 'شات للدعم والمتابعة',
            titleEn: 'Support and follow-up chat',
            bodyAr:
                'ابدأ محادثة داعمة لفهم الخطوة التالية وطلب المتابعة عند الحاجة.',
            bodyEn:
                'Start a supportive chat to clarify your next step and request follow-up when needed.',
            icon: Icons.support_agent_outlined,
            route: Routes.chat,
          ),
        ];

  final String _titleAr;
  final String _titleEn;
  final String _subtitleAr;
  final String _subtitleEn;
  final Color _accent;
  final String _heroAsset;
  final List<_SupportPathCard> _cards;

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final scheme = Theme.of(context).colorScheme;
    final title = isArabic ? _titleAr : _titleEn;
    final subtitle = isArabic ? _subtitleAr : _subtitleEn;

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
                            ? 'يمكنك البدء من الشات، المختصين، المراكز، أو المواد الإرشادية حسب احتياجك الحالي.'
                            : 'You can begin from chat, specialists, centers, or guidance content depending on your current need.',
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
                        label: isArabic ? 'فتح الشات' : 'Open chat',
                        asset: 'c7_branding/buttons/primary_button.png',
                        onTap: () =>
                            Navigator.of(context).pushNamed(Routes.chat),
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

class _SupportPathCard {
  const _SupportPathCard({
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    required this.icon,
    required this.route,
    this.arguments,
  });

  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final IconData icon;
  final String route;
  final Map<String, dynamic>? arguments;
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
    required this.isArabic,
    required this.accent,
  });

  final _SupportPathCard item;
  final bool isArabic;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = isArabic ? item.titleAr : item.titleEn;
    final body = isArabic ? item.bodyAr : item.bodyEn;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => Navigator.of(context).pushNamed(
        item.route,
        arguments: item.arguments,
      ),
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
