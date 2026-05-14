import 'conversation_audit_link.dart';
import 'conversation_interaction_type.dart';
import 'conversation_message_reference.dart';
import 'conversation_sanitized_preview.dart';

class ConversationInteraction {
  const ConversationInteraction({
    required this.interactionId,
    required this.interactionType,
    required this.messageReference,
    required this.sanitizedPreview,
    required this.auditLink,
  });

  final String interactionId;
  final ConversationInteractionType interactionType;
  final ConversationMessageReference messageReference;
  final ConversationSanitizedPreview sanitizedPreview;
  final ConversationAuditLink auditLink;

  Map<String, Object?> toMap() {
    return {
      'interactionId': interactionId,
      'interactionType': interactionType.key,
      'messageReference': messageReference.toMap(),
      'sanitizedPreview': sanitizedPreview.toMap(),
      'auditLink': auditLink.toMap(),
    };
  }
}
