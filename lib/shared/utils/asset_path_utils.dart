String normalizeAssetPath(String path) {
  if (path.isEmpty) return path;

  var normalized = path.trim();

  while (normalized.contains('assets/assets/')) {
    normalized = normalized.replaceAll('assets/assets/', 'assets/');
  }

  final hasScheme = RegExp(r'^[a-zA-Z]+://').hasMatch(normalized);
  if (!hasScheme &&
      normalized.isNotEmpty &&
      !normalized.startsWith('assets/')) {
    normalized = 'assets/$normalized';
  }

  while (normalized.contains('assets/assets/')) {
    normalized = normalized.replaceAll('assets/assets/', 'assets/');
  }

  return normalized;
}
