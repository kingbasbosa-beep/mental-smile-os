class LaunchStatus {
  const LaunchStatus._();

  static const String ready = 'ready';
  static const String conditional = 'conditional';
  static const String blocked = 'blocked';

  static const Set<String> values = <String>{
    ready,
    conditional,
    blocked,
  };
}
