import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';
import 'package:flutterprojects/features/centers/data/services/centers_firestore_service.dart';

class CentersListPage extends StatelessWidget {
  final String category;

  const CentersListPage({
    super.key,
    required this.category,
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
      return c.coverImageAsset
          .trim()
          .replaceFirst('assets/assets/', 'assets/');
    }
    if (c.category == 'detox') return 'assets/c7_branding/home/home_bg.png';
    if (c.category == 'special_needs') {
      return 'assets/c7_branding/logo/logo_mark.png';
    }
    return 'assets/c7_branding/home/hero_art.png';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final service = CentersFirestoreService();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_categoryTitleAr(category)),
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: StreamBuilder<List<CenterModel>>(
          stream: service.streamActiveCentersByCategory(category),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('حدث خطأ أثناء تحميل المراكز'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final items = snapshot.data ?? const <CenterModel>[];
            if (items.isEmpty) {
              return const Center(
                child: Text('لا توجد مراكز متاحة في هذه الفئة حاليًا'),
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
                final hasPhone = c.phone.trim().isNotEmpty;
                final chips =
                    c.services.where((e) => e.trim().isNotEmpty).toList();

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
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
                        color: Colors.white.withValues(alpha: 0.88),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: scheme.outline.withValues(alpha: 0.12),
                        ),
                        boxShadow: AppShadows.card,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 180,
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
                                        Colors.black.withValues(alpha: 0.10),
                                        Colors.black.withValues(alpha: 0.52),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withValues(alpha: 0.18),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                            child: Text(
                                              _categoryBadge(category),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withValues(alpha: 0.18),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                            child: Text(
                                              _centerTypeBadge(c),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          _CenterLogoBubble(
                                            imageUrl: c.imageUrl,
                                            assetPath: _fallbackAsset(c),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        c.name.trim().isEmpty
                                            ? 'مركز'
                                            : c.name.trim(),
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
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
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.location_on_outlined,
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (desc.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    desc,
                                    textAlign: TextAlign.right,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                                if (hasPhone) ...[
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            c.phone.trim(),
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.phone_outlined, size: 18),
                                      const SizedBox(width: 6),
                                      const Text('هاتف'),
                                    ],
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
                                            textAlign: TextAlign.right,
                                          ),
                                          visualDensity: VisualDensity.compact,
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
                                      const _InfoChip(
                                        icon: Icons.local_hospital_outlined,
                                        label: 'يوجد قسم أعراض انسحاب',
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FilledButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            Routes.centerDetails,
                                            arguments: {
                                              'center': c,
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_outward_rounded,
                                        ),
                                        label: const Text('اضغط للمزيد'),
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
      ),
    );
  }
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
    if (trimmedUrl.isNotEmpty) {
      return Image.network(
        trimmedUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            normalizeAssetPath(assetPath),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const AppMissingAssetPlaceholder(),
          );
        },
      );
    }
    return Image.asset(
      normalizeAssetPath(assetPath),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const AppMissingAssetPlaceholder(),
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
    Widget child;
    if (trimmedUrl.isNotEmpty) {
      child = Image.network(
        trimmedUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            normalizeAssetPath(assetPath),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const AppMissingAssetPlaceholder(),
          );
        },
      );
    } else {
      child = Image.asset(
        normalizeAssetPath(assetPath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const AppMissingAssetPlaceholder(),
      );
    }

    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.mutedGold.withValues(alpha: 0.34),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: child,
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
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: scheme.primary),
          const SizedBox(width: 6),
          Text(
            label,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

