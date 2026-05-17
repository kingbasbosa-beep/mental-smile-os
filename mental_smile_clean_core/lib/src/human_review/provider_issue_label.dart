/// Passive provider issue vocabulary.
///
/// This label records a reported provider-related issue only. It does not
/// diagnose provider causality, prove runtime state, enforce backend policy, or
/// activate provider escalation.
enum ProviderIssueLabel {
  providerIssueReported,
}

extension ProviderIssueLabelKey on ProviderIssueLabel {
  String get key {
    switch (this) {
      case ProviderIssueLabel.providerIssueReported:
        return 'provider_issue_reported';
    }
  }
}
