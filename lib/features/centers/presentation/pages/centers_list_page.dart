import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/l10n/app_localizations.dart';
import 'package:mental_smile_os/shared/analytics/app_analytics.dart';
import 'package:mental_smile_os/shared/ui_kit/app_design_system.dart';
import 'package:mental_smile_os/shared/utils/asset_path_utils.dart';
import 'package:mental_smile_os/features/centers/data/models/center_model.dart';
import 'package:mental_smile_os/features/centers/data/services/centers_firestore_service.dart';

const String _centerLogoMarkAsset = 'assets/c7_branding/logo/logo_mark.png';

class CentersListPage extends StatelessWidget {
  final String category;
  final String returnRoute;

  const CentersListPage({
    super.key,
    required this.category,
    this.returnRoute = Routes.menu,
  });

  String _categoryTitleAr(String key) {
    switch (key) {
      case 'recovery':
        return 'مراكز التعافي';
      case 'detox':
        return 'مراكز سحب السموم';
      case 'hospital':
      case 'hospitals':
        return 'المستشفيات';
      case 'special_needs':
        return 'مراكز رعاية ذوي الاحتياجات الخاصة';
      default:
        return 'المراكز';
    }
  }

  String _locationLine(CenterModel c) {
    final parts = <String>[];
    if (c.city.trim().isNotEmpty) parts.add(c.city.trim());
    if (c.area.trim().isNotEmpty) parts.add(c.area.trim());
    return parts.join(' / ');
  }

  String _shortDescription(String text) {
    final t = text.trim();
    if (t.isEmpty) return '';
    if (t.length <= 120) return t;
    return '${t.substring(0, 120)}…';
  }

  String _categoryBadge(String key) {
    switch (key) {
      case 'recovery':
        return 'التعافي';
      case 'detox':
        return 'سحب السموم';
      case 'hospital':
      case 'hospitals':
        return 'مستشفى';
      case 'special_needs':
        return 'احتياجات خاصة';
      default:
        return 'مركز';
    }
  }

  String _centerTypeBadge(CenterModel c) {
    switch (c.centerType.trim()) {
      case 'detox':
        return 'ديتوكس';
      case 'hospital':
        return 'مستشفى';
      case 'special_needs_care':
        return 'رعاية خاصة';
      case 'halfway_house':
      default:
        return 'هاف واي';
    }
  }

  String _fallbackAsset(CenterModel c) {
    if (c.coverImageAsset.trim().isNotEmpty) {
      final normalized =
          c.coverImageAsset.trim().replaceFirst('assets/assets/', 'assets/');
      final lower = normalized.toLowerCase();
      if (lower.contains('enter') || lower.contains('c7_branding/home/')) {
        return _centerLogoMarkAsset;
      }
      return normalized;
    }
    return _centerLogoMarkAsset;
  }

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  @override
  Widget build(BuildContext context) {
    final service = CentersFirestoreService();
    final l10n = AppLocalizations.of(context)!;
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  _backgroundAsset(constraints.maxWidth),
                  fit: BoxFit.cover,
                  alignment: constraints.maxWidth < 700
                      ? Alignment.topCenter
                      : Alignment.center,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.50),
                        Colors.black.withValues(alpha: 0.30),
                        Colors.black.withValues(alpha: 0.66),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<List<CenterModel>>(
                  stream: service.streamActiveCentersByCategory(category),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(l10n.centersLoadError),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final items = snapshot.data ?? const <CenterModel>[];
                    if (items.isEmpty) {
                      return Center(
                        child: Text(l10n.centersEmpty),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final c = items[index];
                        final loc = _locationLine(c);
                        final desc = _shortDescription(c.description);
                        final chips = c.services
                            .where((e) => e.trim().isNotEmpty)
                            .toList();

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(22),
                            onTap: () {
                              AppAnalytics.logPathSelected(
                                'centers',
                                'view_center',
                              );
                              Navigator.of(context).pushNamed(
                                Routes.centerDetails,
                                arguments: {
                                  'center': c,
                                },
                              );
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.34),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: const Color(0xFFE7C766)
                                      .withValues(alpha: 0.34),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE7C766)
                                        .withValues(alpha: 0.12),
                                    blurRadius: 26,
                                    offset: const Offset(0, 12),
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.34),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 250,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        _CenterCover(
                                          imageUrl: c.coverImageUrl,
                                          assetPath: _fallbackAsset(c),
                                        ),
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.black
                                                    .withValues(alpha: 0.10),
                                                Colors.black
                                                    .withValues(alpha: 0.52),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  _CenterLogoBubble(
                                                    imageUrl: c.imageUrl,
                                                    assetPath:
                                                        _fallbackAsset(c),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                c.name.trim().isEmpty
                                                    ? l10n.centerDefaultName
                                                    : c.name.trim(),
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                  color:
                                                      const Color(0xFFFFE7B2),
                                                  fontWeight: FontWeight.w900,
                                                  shadows: const [
                                                    Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (loc.isNotEmpty) ...[
                                                const SizedBox(height: 6),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      loc,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFFFF4D4),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (desc.isNotEmpty) ...[
                                          const SizedBox(height: 2),
                                          Text(
                                            desc,
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: const Color(0xFFFFF4D4)
                                                      .withValues(alpha: 0.86),
                                                  height: 1.35,
                                                ),
                                          ),
                                        ],
                                        if (chips.isNotEmpty) ...[
                                          const SizedBox(height: 12),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            alignment: WrapAlignment.end,
                                            children: [
                                              for (final s in chips.take(10))
                                                Chip(
                                                  label: Text(
                                                    s,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  backgroundColor: Colors.black
                                                      .withValues(alpha: 0.24),
                                                  side: BorderSide(
                                                    color:
                                                        const Color(0xFFE7C766)
                                                            .withValues(
                                                                alpha: 0.24),
                                                  ),
                                                  labelStyle: const TextStyle(
                                                    color: Color(0xFFFFE7B2),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                        const SizedBox(height: 12),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          alignment: WrapAlignment.end,
                                          children: [
                                            _InfoChip(
                                              icon: Icons.account_tree_outlined,
                                              label: _centerTypeBadge(c),
                                            ),
                                            if (c.hasDetoxUnit &&
                                                c.centerType != 'detox')
                                              _InfoChip(
                                                icon: Icons
                                                    .local_hospital_outlined,
                                                label: l10n
                                                    .centerDetoxUnitAvailable,
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: FilledButton.icon(
                                                onPressed: () {
                                                  AppAnalytics.logPathSelected(
                                                    'centers',
                                                    'view_center',
                                                  );
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    Routes.centerDetails,
                                                    arguments: {
                                                      'center': c,
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_outward_rounded,
                                                ),
                                                label: Text(
                                                  l10n.centersReadMore,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SafeArea(
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: constraints.maxWidth < 700 ? 14 : 22,
                        top: constraints.maxWidth < 700 ? 12 : 18,
                      ),
                      child: _BackToMenuButton(
                        compact: constraints.maxWidth < 700,
                        returnRoute: returnRoute,
                      ),
                    ),
                  ),
                ),
                const _PathSelectionLogger(
                  module: 'centers',
                  path: 'browse',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BackToMenuButton extends StatelessWidget {
  const _BackToMenuButton({
    required this.compact,
    required this.returnRoute,
  });

  final bool compact;
  final String returnRoute;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 44.0 : 52.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.of(context).pushNamed(
          Routes.centers,
          arguments: {'returnRoute': returnRoute},
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1B1007).withValues(alpha: 0.50),
            border: Border.all(
              color: const Color(0xFFFFD98A).withValues(alpha: 0.56),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE7A94C).withValues(alpha: 0.18),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Image.asset(
            Directionality.of(context) == TextDirection.rtl
                ? 'assets/branding/navigation/back/back_right_gold.png'
                : 'assets/branding/navigation/back/back_left_gold.png',
            width: compact ? 22 : 26,
            height: compact ? 22 : 26,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return IconTheme(
                data: IconThemeData(
                  color: const Color(0xFFFFE7B2),
                  size: compact ? 22 : 26,
                ),
                child: const BackButtonIcon(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PathSelectionLogger extends StatefulWidget {
  const _PathSelectionLogger({
    required this.module,
    required this.path,
  });

  final String module;
  final String path;

  @override
  State<_PathSelectionLogger> createState() => _PathSelectionLoggerState();
}

class _PathSelectionLoggerState extends State<_PathSelectionLogger> {
  @override
  void initState() {
    super.initState();
    AppAnalytics.logPathSelected(widget.module, widget.path);
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _CenterCover extends StatelessWidget {
  const _CenterCover({
    required this.imageUrl,
    required this.assetPath,
  });

  final String imageUrl;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = imageUrl.trim();
    final normalizedAsset = normalizeAssetPath(assetPath);
    final lowerAsset = normalizedAsset.toLowerCase();
    final useFallbackAsset = normalizedAsset.isNotEmpty &&
        !lowerAsset.contains('enter') &&
        !lowerAsset.contains('c7_branding/home/') &&
        !lowerAsset.contains('logo_mark');

    if (trimmedUrl.isNotEmpty) {
      return Image.network(
        trimmedUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          if (!useFallbackAsset) return const _CenterCoverFallback();
          return Image.asset(
            normalizedAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const _CenterCoverFallback(),
          );
        },
      );
    }
    if (!useFallbackAsset) return const _CenterCoverFallback();
    return Image.asset(
      normalizedAsset,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const _CenterCoverFallback(),
    );
  }
}

class _CenterCoverFallback extends StatelessWidget {
  const _CenterCoverFallback();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF061413).withValues(alpha: 0.94),
            const Color(0xFF120D05).withValues(alpha: 0.90),
            Colors.black.withValues(alpha: 0.96),
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final panelWidth =
              constraints.maxWidth < 520 ? constraints.maxWidth * 0.72 : 420.0;
          return Center(
            child: Container(
              width: panelWidth,
              height: 168,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.24),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE7C766).withValues(alpha: 0.42),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 34,
                    color: const Color(0xFFE7C766).withValues(alpha: 0.78),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'واجهة المركز',
                    style: TextStyle(
                      color: const Color(0xFFFFE7B2).withValues(alpha: 0.88),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CenterLogoBubble extends StatelessWidget {
  const _CenterLogoBubble({
    required this.imageUrl,
    required this.assetPath,
  });

  final String imageUrl;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = imageUrl.trim();
    final normalizedAsset = normalizeAssetPath(assetPath);
    final lowerAsset = normalizedAsset.toLowerCase();
    final useFallbackAsset = normalizedAsset.isNotEmpty &&
        !lowerAsset.contains('enter') &&
        !lowerAsset.contains('c7_branding/home/') &&
        !lowerAsset.contains('logo_mark');
    Widget child;
    if (trimmedUrl.isNotEmpty) {
      child = Image.network(
        trimmedUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          if (!useFallbackAsset) return const _CenterLogoFallback();
          return Image.asset(
            normalizedAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const _CenterLogoFallback(),
          );
        },
      );
    } else if (!useFallbackAsset) {
      child = const _CenterLogoFallback();
    } else {
      child = Image.asset(
        normalizedAsset,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const _CenterLogoFallback(),
      );
    }

    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.mutedGold.withValues(alpha: 0.62),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.mutedGold.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: child,
      ),
    );
  }
}

class _CenterLogoFallback extends StatelessWidget {
  const _CenterLogoFallback();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.business_rounded,
        size: 30,
        color: AppColors.mutedGold.withValues(alpha: 0.80),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFFE7C766)),
          const SizedBox(width: 6),
          Text(
            label,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFFFFE7B2),
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
