import 'governance_compliance_block_reason.dart';
import 'governance_compliance_state.dart';

class GovernanceComplianceFallback {
  const GovernanceComplianceFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const GovernanceComplianceFallback restricted =
      GovernanceComplianceFallback(
    reason: GovernanceComplianceBlockReason.complianceRestricted,
    state: GovernanceComplianceState.restricted,
    messageKey: 'governance_compliance_restricted',
  );

  final GovernanceComplianceBlockReason reason;
  final GovernanceComplianceState state;
  final String messageKey;
}
