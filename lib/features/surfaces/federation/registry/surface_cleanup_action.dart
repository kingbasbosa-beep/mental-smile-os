class SurfaceCleanupAction {
  const SurfaceCleanupAction._();

  static const String keep = 'keep';
  static const String hide = 'hide';
  static const String freeze = 'freeze';
  static const String replace = 'replace';
  static const String removeLater = 'remove_later';

  static const Set<String> values = <String>{
    keep,
    hide,
    freeze,
    replace,
    removeLater,
  };
}
