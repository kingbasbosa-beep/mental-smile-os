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
          ),
          _SupportPathCard(
            titleAr: 'تحدث مع الدعم عند الحاجة',
            titleEn: 'Talk to support when needed',
            bodyAr:
                'ابدأ طلب دعم منظم إذا احتجت إلى توجيه أو مساندة.',
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
            bodyAr:
                'استعرض مختصين مناسبين واختر ما يلائم احتياج الأسرة الآن.',
            bodyEn:
                'Browse suitable specialists and choose what fits your family needs now.',
            icon: Icons.psychology_alt_outlined,
            route: Routes.specialists,
            analyticsPath: 'specialist',
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
