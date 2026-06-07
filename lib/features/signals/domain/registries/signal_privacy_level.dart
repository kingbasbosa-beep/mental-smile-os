class SignalPrivacyLevel {
  const SignalPrivacyLevel._();

  static const String publicAggregate = 'public_aggregate';
  static const String internalAggregate = 'internal_aggregate';
  static const String restricted = 'restricted';
  static const String sovereign = 'sovereign';

  static const List<String> values = <String>[
    publicAggregate,
    internalAggregate,
    restricted,
    sovereign,
  ];
}
