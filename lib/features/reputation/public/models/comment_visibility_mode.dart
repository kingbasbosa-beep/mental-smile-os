class CommentVisibilityMode {
  const CommentVisibilityMode._();

  static const String collapsed = 'collapsed';
  static const String preview = 'preview';
  static const String expanded = 'expanded';

  static const Set<String> values = <String>{
    collapsed,
    preview,
    expanded,
  };
}
