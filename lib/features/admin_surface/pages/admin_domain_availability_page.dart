import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminDomainAvailabilityPage extends StatelessWidget {
  const AdminDomainAvailabilityPage({super.key});

  static const String _maintenanceMessageEn =
      'This section is temporarily under maintenance. Please try again soon.';
  static const String _maintenanceMessageAr =
      'هذا القسم تحت الصيانة مؤقتًا. يرجى المحاولة لاحقًا.';

  static const List<_DomainAvailabilityItem> _domains = [
    _DomainAvailabilityItem(
      domainName: 'User Support',
      currentState: 'Active',
      severity: 'Low',
      owner: 'Support Oversight',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 09:10',
      relatedIssue: 'Support response continuity check',
    ),
    _DomainAvailabilityItem(
      domainName: 'Family Support',
      currentState: 'Under Review',
      severity: 'Medium',
      owner: 'Care Programs',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 09:25',
      relatedIssue: 'Follow-up messaging boundary review',
    ),
    _DomainAvailabilityItem(
      domainName: 'Library',
      currentState: 'Active',
      severity: 'Low',
      owner: 'Library Governance',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 09:40',
      relatedIssue: 'No active issue linked',
    ),
    _DomainAvailabilityItem(
      domainName: 'Clinician System',
      currentState: 'Limited',
      severity: 'Medium',
      owner: 'Clinician Operations',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 10:05',
      relatedIssue: 'Approval gate review backlog',
    ),
    _DomainAvailabilityItem(
      domainName: 'Centers',
      currentState: 'Active',
      severity: 'Low',
      owner: 'Center Operations',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 10:15',
      relatedIssue: 'No active issue linked',
    ),
    _DomainAvailabilityItem(
      domainName: 'Chat',
      currentState: 'Under Review',
      severity: 'Medium',
      owner: 'Communications',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 10:40',
      relatedIssue: 'Escalation path consistency review',
    ),
    _DomainAvailabilityItem(
      domainName: 'Booking',
      currentState: 'Active',
      severity: 'Low',
      owner: 'Operations',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 10:55',
      relatedIssue: 'No active issue linked',
    ),
    _DomainAvailabilityItem(
      domainName: 'Content Workspace',
      currentState: 'Limited',
      severity: 'Medium',
      owner: 'Content Operations',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 11:05',
      relatedIssue: 'Workspace density and link visibility review',
    ),
    _DomainAvailabilityItem(
      domainName: 'Employee System',
      currentState: 'Hidden',
      severity: 'Low',
      owner: 'Admin Control',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 11:20',
      relatedIssue: 'Future chassis only',
    ),
    _DomainAvailabilityItem(
      domainName: 'Maintenance & Diagnostics',
      currentState: 'Active',
      severity: 'Low',
      owner: 'Maintenance Lead',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 11:35',
      relatedIssue: 'Observation shell only',
    ),
    _DomainAvailabilityItem(
      domainName: 'AI DevOps',
      currentState: 'Under Review',
      severity: 'Medium',
      owner: 'Admin + QA',
      maintenanceMessage: _maintenanceMessageEn,
      lastUpdatedLabel: 'Today • 11:50',
      relatedIssue: 'Prompt and execution handoff visibility review',
    ),
  ];

  void _showPlaceholder(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(label)),
    );
  }

  Color _severityColor(String severity) {
    switch (severity) {
      case 'Low':
        return const Color(0xFF34D399);
      case 'Medium':
        return const Color(0xFFF59E0B);
      case 'High':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFFEAEAEA);
    }
  }

  Widget _buildDomainCard(BuildContext context, _DomainAvailabilityItem item) {
    final severityColor = _severityColor(item.severity);
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF0F172A),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.domainName,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _InfoBadge(
                  label: 'State: ${item.currentState}',
                  color: const Color(0xFFD8B26A)),
              _InfoBadge(
                  label: 'Severity: ${item.severity}', color: severityColor),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Owner: ${item.owner}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFEAEAEA),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Last updated: ${item.lastUpdatedLabel}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFEAEAEA),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Related issue: ${item.relatedIssue}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFEAEAEA),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.24),
              borderRadius: BorderRadius.circular(AppRadii.md),
              border: Border.all(
                color: const Color(0xFFD8B26A).withValues(alpha: 0.14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.maintenanceMessage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFEAEAEA),
                        height: 1.35,
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _maintenanceMessageAr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFEAEAEA),
                        height: 1.35,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              OutlinedButton(
                onPressed: () => _showPlaceholder(
                  context,
                  'Mark Maintenance is advisory only',
                ),
                child: const Text('Mark Maintenance'),
              ),
              OutlinedButton(
                onPressed: () => _showPlaceholder(
                  context,
                  'Restore Active is advisory only',
                ),
                child: const Text('Restore Active'),
              ),
              OutlinedButton(
                onPressed: () => _showPlaceholder(
                  context,
                  'Mark Limited is advisory only',
                ),
                child: const Text('Mark Limited'),
              ),
              OutlinedButton(
                onPressed: () => _showPlaceholder(
                  context,
                  'Related issue: ${item.relatedIssue}',
                ),
                child: const Text('View Related Issue'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Domain Availability Control',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppSectionPanel(
              padding: const EdgeInsets.all(AppSpacing.lg),
              color: const Color(0xFF020617),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Domain Availability Control',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'This page tracks availability of major domains and prepares future maintenance gating.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFEAEAEA),
                          height: 1.4,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'This page is advisory only. It does not block routes or change runtime access yet.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFD8B26A),
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: _domains
                  .map(
                    (item) => SizedBox(
                      width: 360,
                      child: _buildDomainCard(context, item),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _DomainAvailabilityItem {
  final String domainName;
  final String currentState;
  final String severity;
  final String owner;
  final String maintenanceMessage;
  final String lastUpdatedLabel;
  final String relatedIssue;

  const _DomainAvailabilityItem({
    required this.domainName,
    required this.currentState,
    required this.severity,
    required this.owner,
    required this.maintenanceMessage,
    required this.lastUpdatedLabel,
    required this.relatedIssue,
  });
}
