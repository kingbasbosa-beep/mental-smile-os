class MockPolicySnapshot {
  const MockPolicySnapshot._();

  static const Map<String, Object?> fallbackOnly = {
    'policyVersion': 'test-policy-v1',
    'createdBy': 'trusted_server',
    'hashPlaceholder': 'hash_placeholder_test',
    'runtimeMode': 'fallback_only',
    'enabledSafetyModules': <String>[
      'input_filter_placeholder',
      'output_validator_placeholder',
      'fail_safe_placeholder',
    ],
  };
}
