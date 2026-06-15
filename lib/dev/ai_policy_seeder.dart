import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_smile_os/features/chat/data/services/chat_ai_policy.dart';

// [S] AI Policy Asset
// Approved by Wave S-3 Classification Board.
// Seeds AI policy documents only; not booking/session/payment logic.
Map<String, dynamic> _serializeAiPolicy(ChatAiPolicy policy) {
  return {
    'policyVersion': policy.policyVersion,
    'responseTemplates': Map<String, String>.from(policy.responseTemplates),
    'rolePhrasePacks': {
      for (final entry in policy.rolePhrasePacks.entries)
        entry.key: List<String>.from(entry.value),
    },
    'statePhrasePacks': {
      for (final entry in policy.statePhrasePacks.entries)
        entry.key: List<String>.from(entry.value),
    },
    'stateScores': Map<String, int>.from(policy.stateScores),
    'lossOfControlPhrases': List<String>.from(policy.lossOfControlPhrases),
    'selfHarmPhrases': List<String>.from(policy.selfHarmPhrases),
    'lossOfControlScore': policy.lossOfControlScore,
    'explicitSelfHarmScore': policy.explicitSelfHarmScore,
    'thresholds': {
      'mediumRiskThreshold': policy.mediumRiskThreshold,
      'highRiskThreshold': policy.highRiskThreshold,
      'criticalRiskThreshold': policy.criticalRiskThreshold,
    },
    'strategyByRiskLevel': Map<String, String>.from(policy.strategyByRiskLevel),
    'needsHumanSupportLevels':
        List<String>.from(policy.needsHumanSupportLevels.toList()..sort()),
    'containsEscalationSignalLevels': List<String>.from(
      policy.containsEscalationSignalLevels.toList()..sort(),
    ),
    'safetyTriggeredLevels':
        List<String>.from(policy.safetyTriggeredLevels.toList()..sort()),
  };
}

Map<String, dynamic> _seedPayloadForStatus(
  ChatAiPolicy policy,
  String status,
) {
  return {
    ..._serializeAiPolicy(policy),
    'status': status,
    'basedOnVersion': policy.policyVersion,
    'updatedAt': FieldValue.serverTimestamp(),
    'updatedBy': 'system_seed',
    'notes': 'initial seed from local policy',
  };
}

Future<void> seedAiPolicyToFirestore({
  FirebaseFirestore? firestore,
}) async {
  final db = firestore ?? FirebaseFirestore.instance;
  const policy = ChatAiPolicyProvider.currentLocal;

  final batch = db.batch();
  final policies = db.collection('ai_policies');

  batch.set(
    policies.doc('draft'),
    _seedPayloadForStatus(policy, 'draft'),
    SetOptions(merge: true),
  );

  batch.set(
    policies.doc('published'),
    _seedPayloadForStatus(policy, 'published'),
    SetOptions(merge: true),
  );

  await batch.commit();
}

/// Temporary manual trigger for debug use only.
/// Can be invoked from the debug console or wired to a local debug hook later.
Future<void> seedAiPolicyToFirestoreDebug() async {
  await seedAiPolicyToFirestore();
}
