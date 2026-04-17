import 'package:flutter/material.dart';
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

    final title = isAr ? 'المكتبة' : 'Library';
    final subtitle = isAr
        ? 'محتوى مختار لمساعدتك خطوة بخطوة'
        : 'Curated content to help you step by step';

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
        appBar: AppBar(
          titleSpacing: 12,
          title: Row(
            children: [
              Image.asset(
                normalizeAssetPath('c6_library/brand/logo_mark.png'),
                height: 26,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox(height: 26, width: 26),
              ),
              const SizedBox(width: 10),
              Text(title),
              const Spacer(),
              if (_isDev) const _DevPill(),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
          children: [
            _HeroCard(title: title, subtitle: subtitle, isAr: isAr),
            const SizedBox(height: 14),

            // Quick actions (visual buttons)
            Row(
              children: [
                Expanded(
                  child: _ImageButton(
                    label: isAr ? 'ابدأ الآن' : 'Start Now',
                    asset: 'c6_library/ui/buttons/btn_primary.png',
                    onTap: () =>
                        _showSnack(context, isAr ? 'قريباً…' : 'Coming soon…'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ImageButton(
                    label: isAr ? 'استكشف' : 'Explore',
                    asset: 'c6_library/ui/buttons/btn_secondary.png',
                    onTap: () =>
                        _showSnack(context, isAr ? 'قريباً…' : 'Coming soon…'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Ornament divider
            Center(
              child: Image.asset(
                normalizeAssetPath(
                  'c6_library/ui/ornaments/ornament_divider_1.png',
                ),
                height: 46,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox(height: 10),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Text(
                  isAr ? 'التصنيفات' : 'Categories',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
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

            LayoutBuilder(
              builder: (context, c) {
                final w = c.maxWidth;
                final crossAxisCount = w >= 900 ? 3 : 2;
                const childAspectRatio = 1.15;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, i) {
                    final cat = categories[i];
                    return _CategoryTile(
                      title: isAr ? cat.titleAr : cat.titleEn,
                      asset: cat.asset,
                      onTap: () => _showSnack(
                        context,
                        isAr ? 'فتح: ${cat.titleAr}' : 'Open: ${cat.titleEn}',
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 18),

            // Example states (kept as visual assets, shown in dev)
            if (_isDev) ...[
              Text(
                isAr ? 'States (DEV preview)' : 'States (DEV preview)',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
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
                asset: 'c6_library/states/locked_clinicians.png',
              ),
            ],
          ],
        ),
      ),
    );
  }

  static void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
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
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageButton extends StatelessWidget {
  const _ImageButton({
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
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    normalizeAssetPath(asset),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black.withValues(alpha: 0.35),
                    ),
                  ],
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
