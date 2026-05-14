import 'safety_memory_preview.dart';

class SafetyMemoryReference {
  const SafetyMemoryReference({
    required this.referenceId,
    required this.sourceId,
    required this.preview,
  });

  final String referenceId;
  final String sourceId;
  final SafetyMemoryPreview preview;

  Map<String, Object?> toMap() {
    return {
      'referenceId': referenceId,
      'sourceId': sourceId,
      'preview': preview.toMap(),
    };
  }
}
