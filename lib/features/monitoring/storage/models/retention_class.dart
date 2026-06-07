class RetentionClass {
  const RetentionClass._();

  static const String ephemeral = 'ephemeral';
  static const String operational = 'operational';
  static const String annual = 'annual';
  static const String historical = 'historical';
  static const String constitutional = 'constitutional';
  static const String sovereign = 'sovereign';

  static const Set<String> values = <String>{
    ephemeral,
    operational,
    annual,
    historical,
    constitutional,
    sovereign,
  };
}
