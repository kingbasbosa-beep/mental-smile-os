class ResponseConfidenceMarker {
  const ResponseConfidenceMarker({
    required this.level,
    required this.failClosed,
  });

  static const ResponseConfidenceMarker unknown = ResponseConfidenceMarker(
    level: 'unknown',
    failClosed: true,
  );

  final String level;
  final bool failClosed;

  Map<String, Object?> toMap() {
    return {
      'level': level,
      'failClosed': failClosed,
    };
  }
}
