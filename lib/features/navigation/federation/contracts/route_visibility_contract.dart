class RouteVisibilityContract {
  const RouteVisibilityContract._();

  static const String visible = 'visible';
  static const String restricted = 'restricted';
  static const String hidden = 'hidden';
  static const String ghostOnly = 'ghost_only';

  static const Set<String> values = <String>{
    visible,
    restricted,
    hidden,
    ghostOnly,
  };
}
