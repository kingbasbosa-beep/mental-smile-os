class SignalFingerprintRegistry {
  const SignalFingerprintRegistry._();

  static const String registryName = 'signal_fingerprint_registry';
  static const String registryVersion = 'signal_fingerprint_registry_v1';

  static const List<String> requiredFields = <String>[
    'signalId',
    'signalCategory',
    'signalWeight',
    'signalTags',
    'signalPriority',
  ];
}
