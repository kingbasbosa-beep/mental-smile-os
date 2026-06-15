import 'package:flutter/material.dart';
import 'package:mental_smile_os/core/branding/app_assets.dart';
import 'package:mental_smile_os/shared/utils/asset_path_utils.dart';

enum MentalSmileLogoVariant {
  iconOnly,
  wordmark,
  primary,
}

enum MentalSmileLogoSize {
  small,
  medium,
  large,
}

class MentalSmileLogo extends StatelessWidget {
  const MentalSmileLogo({
    super.key,
    this.variant = MentalSmileLogoVariant.primary,
    this.size = MentalSmileLogoSize.medium,
    this.light = false,
    this.width,
    this.height,
  });

  final MentalSmileLogoVariant variant;
  final MentalSmileLogoSize size;
  final bool light;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final dimensions = _dimensionsForSize(size, variant);
    final resolvedWidth = width ?? dimensions.width;
    final resolvedHeight = height ?? dimensions.height;

    return Image.asset(
      normalizeAssetPath(_assetPath),
      width: resolvedWidth,
      height: resolvedHeight,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        if (variant == MentalSmileLogoVariant.iconOnly) {
          return Icon(
            Icons.sentiment_satisfied_alt_outlined,
            size: resolvedHeight,
            color: Theme.of(context).colorScheme.primary,
          );
        }

        return Text(
          'Mental Smile',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
        );
      },
    );
  }

  String get _assetPath {
    switch (variant) {
      case MentalSmileLogoVariant.iconOnly:
        return light ? AppAssets.logoIconLight : AppAssets.logoIcon;
      case MentalSmileLogoVariant.wordmark:
        return light ? AppAssets.logoLight : AppAssets.logoTransparent;
      case MentalSmileLogoVariant.primary:
        return light ? AppAssets.logoLight : AppAssets.logoPrimary;
    }
  }

  Size _dimensionsForSize(
    MentalSmileLogoSize size,
    MentalSmileLogoVariant variant,
  ) {
    final iconOnly = variant == MentalSmileLogoVariant.iconOnly;

    switch (size) {
      case MentalSmileLogoSize.small:
        return iconOnly ? const Size(36, 36) : const Size(140, 42);
      case MentalSmileLogoSize.medium:
        return iconOnly ? const Size(56, 56) : const Size(220, 66);
      case MentalSmileLogoSize.large:
        return iconOnly ? const Size(84, 84) : const Size(320, 96);
    }
  }
}
