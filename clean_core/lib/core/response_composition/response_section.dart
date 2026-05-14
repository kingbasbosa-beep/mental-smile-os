import 'response_section_type.dart';
import 'response_visibility_scope.dart';

class ResponseSection {
  const ResponseSection({
    required this.sectionType,
    required this.copyKey,
    required this.visibilityScope,
    required this.sanitizedPreview,
  });

  final ResponseSectionType sectionType;
  final String copyKey;
  final ResponseVisibilityScope visibilityScope;
  final String sanitizedPreview;

  Map<String, Object?> toMap() {
    return {
      'sectionType': sectionType.key,
      'copyKey': copyKey,
      'visibilityScope': visibilityScope.key,
      'sanitizedPreview': sanitizedPreview,
    };
  }
}
