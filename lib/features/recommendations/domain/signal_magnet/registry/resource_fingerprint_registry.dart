class ResourceFingerprintRegistry {
  const ResourceFingerprintRegistry._();

  static const String registryName = 'resource_fingerprint_registry';
  static const String registryVersion = 'resource_fingerprint_registry_v1';

  static const List<String> requiredFields = <String>[
    'resourceId',
    'resourceType',
    'resourceSignals',
    'resourceFingerprintIds',
    'resourcePriority',
    'resourceStatus',
  ];
}
