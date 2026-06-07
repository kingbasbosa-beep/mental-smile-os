class StorageVersion {
  const StorageVersion({
    required this.major,
    required this.minor,
    required this.patch,
  });

  final int major;
  final int minor;
  final int patch;

  static const StorageVersion v1 = StorageVersion(
    major: 1,
    minor: 0,
    patch: 0,
  );

  String get label => '$major.$minor.$patch';
}
