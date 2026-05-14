import 'response_block_reason.dart';
import 'response_section_type.dart';

class ResponseFallback {
  const ResponseFallback({
    required this.reason,
    required this.sectionTypes,
    required this.messageKey,
  });

  static const ResponseFallback runtimeDisabled = ResponseFallback(
    reason: ResponseBlockReason.runtimeDisabled,
    sectionTypes: <ResponseSectionType>{
      ResponseSectionType.fallbackSupport,
      ResponseSectionType.runtimeBlockedNotice,
      ResponseSectionType.policyNotice,
    },
    messageKey: 'response_runtime_disabled',
  );

  final ResponseBlockReason reason;
  final Set<ResponseSectionType> sectionTypes;
  final String messageKey;
}
