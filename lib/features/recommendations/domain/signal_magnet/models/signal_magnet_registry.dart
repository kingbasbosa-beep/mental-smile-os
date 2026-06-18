class SignalMagnetRegistry {
  const SignalMagnetRegistry({
    required this.registryVersion,
    required this.registryMetadata,
    required this.signalRegistryReference,
    required this.resourceRegistryReference,
  });

  static const String currentVersion = 'signal_magnet_registry_v1';

  final String registryVersion;
  final Map<String, dynamic> registryMetadata;
  final String signalRegistryReference;
  final String resourceRegistryReference;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registryVersion': registryVersion,
      'registryMetadata': registryMetadata,
      'signalRegistryReference': signalRegistryReference,
      'resourceRegistryReference': resourceRegistryReference,
    };
  }

  factory SignalMagnetRegistry.fromMap(Map<String, dynamic> map) {
    return SignalMagnetRegistry(
      registryVersion: (map['registryVersion'] ?? currentVersion).toString(),
      registryMetadata: _mapValue(map['registryMetadata']),
      signalRegistryReference:
          (map['signalRegistryReference'] ?? '').toString(),
      resourceRegistryReference:
          (map['resourceRegistryReference'] ?? '').toString(),
    );
  }

  static Map<String, dynamic> _mapValue(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return const <String, dynamic>{};
  }
}
