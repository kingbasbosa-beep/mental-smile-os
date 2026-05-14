class MockRuntimeConfig {
  const MockRuntimeConfig._();

  static const Map<String, Object?> disabled = {
    'fallbackOnlyMode': true,
    'escalationEnabled': false,
    'aiEnabled': false,
    'crisisDetectionEnabled': false,
    'loggingEnabled': false,
    'runtimeMode': 'disabled_placeholder',
  };
}
