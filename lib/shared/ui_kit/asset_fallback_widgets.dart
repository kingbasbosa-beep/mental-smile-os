import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class AppMissingAssetPlaceholder extends StatelessWidget {
  const AppMissingAssetPlaceholder({
    super.key,
    this.width,
    this.height,
    this.icon = Icons.image_not_supported_outlined,
  });

  final double? width;
  final double? height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

AssetImage safeAssetImageProvider(String path) {
  return AssetImage(normalizeAssetPath(path));
}
