import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

/// C6 Library UI (Hero + Categories + Buttons + States)
/// DEV hooks are hidden behind: --dart-define=MK_DEV=true
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  static const bool _isDev = bool.fromEnvironment(
    'MK_DEV',
    defaultValue: false,
  );

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode.toLowerCase();
    final isAr = lang == 'ar';

    final title = isAr ? 'مكتبة الإرشاد والتأهيل' : 'Mental Smile Guide';
    final subtitle = isAr
        ? 'دليل عام يساعد الأخصائيين والمراكز على فهم خطوات التسجيل والاستعداد للمراجعة.'
        : 'A public onboarding guide for clinicians and centers preparing for registration review.';

    final categories = <_LibCat>[
      const _LibCat(
        keyName: 'articles',
        titleAr: 'مقالات',
        titleEn: 'Articles',
        asset: 'c6_library/categories/cat_articles.png',
      ),
      const _LibCat(
        keyName: 'exercises',
        titleAr: 'تمارين',
        titleEn: 'Exercises',
        asset: 'c6_library/categories/cat_exercises.png',
      ),
      const _LibCat(
        keyName: 'audio',
        titleAr: 'صوتيات',
        titleEn: 'Audio',
        asset: 'c6_library/categories/cat_audio.png',
      ),
      const _LibCat(
        keyName: 'videos',
        titleAr: 'فيديو',
        titleEn: 'Videos',
        asset: 'c6_library/categories/cat_videos.png',
      ),
      const _LibCat(
        keyName: 'tools',
        titleAr: 'أدوات',
        titleEn: 'Tools',
        asset: 'c6_library/categories/cat_tools.png',
      ),
      const _LibCat(
        keyName: 'saved',
        titleAr: 'المحفوظات',
        titleEn: 'Saved',
        asset: 'c6_library/categories/cat_saved.png',
      ),
    ];

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              normalizeAssetPath('c7_branding/home/home_bg.png'),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const ColoredBox(color: Color(0xFF03080D)),
            ),
            const ColoredBox(color: Color(0xB303080D)),
            const _ModuleEntryLogger(module: 'library'),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final isWide = width >= 980;
                  final gridColumns = width >= 1080
                      ? 3
                      : width >= 680
                          ? 2
                          : 1;
                  final gridAspect = width >= 1080
                      ? 1.35
                      : width >= 680
                          ? 1.25
                          : 2.35;

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 42 : 18,
                      vertical: isWide ? 28 : 18,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1220),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _LibraryTopBar(isAr: isAr),
                            const SizedBox(height: 22),
                            if (isWide)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: _HeroCard(
                                      title: title,
                                      subtitle: subtitle,
                                      isAr: isAr,
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  Expanded(
                                    flex: 4,
                                    child: _RegistrationCtaPanel(isAr: isAr),
                                  ),
                                ],
                              )
                            else ...[
                              _HeroCard(
                                title: title,
                                subtitle: subtitle,
                                isAr: isAr,
                              ),
                              const SizedBox(height: 14),
                              _RegistrationCtaPanel(isAr: isAr),
                            ],
                            const SizedBox(height: 22),
                            Row(
                              children: [
                                Text(
                                  isAr
                                      ? 'أدلة ومسارات مساعدة'
                                      : 'Guides and resources',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: const Color(0xFF7DF9FF),
                                        fontWeight: FontWeight.w900,
                                        shadows: _webTextShadows,
                                      ),
                                ),
                                const Spacer(),
                                const _Badge(
                                  labelAr: 'جديد',
                                  labelEn: 'New',
                                  asset: 'c6_library/ui/badges/badge_new.png',
                                ),
                                const SizedBox(width: 8),
                                const _Badge(
                                  labelAr: 'برو',
                                  labelEn: 'Pro',
                                  asset: 'c6_library/ui/badges/badge_pro.png',
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: categories.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: gridColumns,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: gridAspect,
                              ),
                              itemBuilder: (context, i) {
                                final cat = categories[i];
                                return _CategoryTile(
                                  title: isAr ? cat.titleAr : cat.titleEn,
                                  asset: cat.asset,
                                  onTap: () {
                                    AppAnalytics.logPathSelected(
                                      'library',
                                      'open_content',
                                    );
                                    _showSnack(
                                      context,
                                      isAr
                                          ? 'فتح: ${cat.titleAr}'
                                          : 'Open: ${cat.titleEn}',
                                    );
                                  },
                                );
                              },
                            ),
                            if (_isDev) ...[
                              const SizedBox(height: 18),
                              Text(
                                'States (DEV preview)',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: const Color(0xFF7DF9FF),
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              const _StatePreview(
                                titleAr: 'مكتبة فارغة',
                                titleEn: 'Empty library',
                                asset: 'c6_library/states/empty_library.png',
                              ),
                              const SizedBox(height: 12),
                              const _StatePreview(
                                titleAr: 'الأطباء مقفولين',
                                titleEn: 'Locked clinicians',
                                asset:
                                    'c6_library/states/locked_clinicians.png',
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

const List<Shadow> _webTextShadows = [
  Shadow(
    color: Colors.black,
    blurRadius: 8,
    offset: Offset(0, 1),
  ),
];

class _LibraryTopBar extends StatelessWidget {
  const _LibraryTopBar({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          normalizeAssetPath('c6_library/brand/logo_mark.png'),
          height: 34,
          errorBuilder: (context, error, stackTrace) =>
              const SizedBox(height: 34, width: 34),
        ),
        const SizedBox(width: 10),
        Text(
          isAr ? 'دليل منصة Mental Smile' : 'Mental Smile Guide',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFFE7C766),
                fontWeight: FontWeight.w900,
                shadows: _webTextShadows,
              ),
        ),
        const Spacer(),
        if (LibraryPage._isDev) const _DevPill(),
      ],
    );
  }
}

class _RegistrationCtaPanel extends StatelessWidget {
  const _RegistrationCtaPanel({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        crossAxisAlignment:
            isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isAr ? 'ابدأ من المسار المناسب' : 'Start with the right path',
            textAlign: isAr ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFFE7C766),
                  fontWeight: FontWeight.w900,
                  shadows: _webTextShadows,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            isAr
                ? 'المكتبة تساعدك على فهم متطلبات التسجيل قبل إرسال الطلب للمراجعة.'
                : 'Use the library to understand onboarding requirements before review.',
            textAlign: isAr ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF7DF9FF),
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                  shadows: _webTextShadows,
                ),
          ),
          const SizedBox(height: 16),
          _GlassCtaButton(
            label: isAr ? 'تسجيل أخصائي' : 'Clinician registration',
            icon: Icons.psychology_alt_outlined,
            onTap: () => Navigator.of(context).pushNamed(
              Routes.webClinicianRegister,
            ),
          ),
          const SizedBox(height: 10),
          _GlassCtaButton(
            label: isAr ? 'تسجيل مركز' : 'Center registration',
            icon: Icons.business_outlined,
            onTap: () => Navigator.of(context).pushNamed(
              Routes.webCenterRegister,
            ),
          ),
          const SizedBox(height: 10),
          _GlassCtaButton(
            label: isAr ? 'العودة للمنيو' : 'Back to menu',
            icon: Icons.apps_rounded,
            onTap: () => Navigator.of(context).pushNamed(Routes.menu),
            secondary: true,
          ),
        ],
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xCC061A26),
        borderRadius: BorderRadius.circular(18),
        border:
            Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.42)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.24),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _GlassCtaButton extends StatelessWidget {
  const _GlassCtaButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.secondary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    final fg = secondary ? const Color(0xFF7DF9FF) : const Color(0xFF061A26);
    final bg = secondary ? const Color(0x2200E5FF) : const Color(0xFFE7C766);

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          side: BorderSide(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.44)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
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

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.isAr,
  });

  final String title;
  final String subtitle;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          // Mobile-ish hero height even on desktop/web
          LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final h = (w * 0.52).clamp(210.0, 280.0);
              return SizedBox(
                height: h,
                child: Image.asset(
                  normalizeAssetPath('c6_library/hero/library_hero.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.bottomStart,
                  end: AlignmentDirectional.topEnd,
                  colors: [
                    Colors.black.withValues(alpha: 0.65),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 14,
            end: 14,
            bottom: 14,
            child: Column(
              crossAxisAlignment:
                  isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.92),
                        height: 1.2,
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

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.title,
    required this.asset,
    required this.onTap,
  });

  final String title;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xCC061A26),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.32),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    normalizeAssetPath(asset),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(
                      color: const Color(0xFF7DF9FF),
                      fontWeight: FontWeight.w900,
                      shadows: _webTextShadows,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.labelAr,
    required this.labelEn,
    required this.asset,
  });

  final String labelAr;
  final String labelEn;
  final String asset;

  @override
  Widget build(BuildContext context) {
    final isAr =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final label = isAr ? labelAr : labelEn;

    return Tooltip(
      message: label,
      child: Image.asset(
        normalizeAssetPath(asset),
        height: 26,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const SizedBox(height: 26, width: 26),
      ),
    );
  }
}

class _StatePreview extends StatelessWidget {
  const _StatePreview({
    required this.titleAr,
    required this.titleEn,
    required this.asset,
  });

  final String titleAr;
  final String titleEn;
  final String asset;

  @override
  Widget build(BuildContext context) {
    final isAr =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final title = isAr ? titleAr : titleEn;

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 140,
              height: 80,
              child: Image.asset(
                normalizeAssetPath(asset),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DevPill extends StatelessWidget {
  const _DevPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        'DEV',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _LibCat {
  const _LibCat({
    required this.keyName,
    required this.titleAr,
    required this.titleEn,
    required this.asset,
  });

  final String keyName;
  final String titleAr;
  final String titleEn;
  final String asset;
}
