import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminMaintenanceSystemPage extends StatelessWidget {
  const AdminMaintenanceSystemPage({super.key});

  static const List<_MaintenanceIssueItem> _issues = [
    _MaintenanceIssueItem(
      title: 'Content workspace visibility drift',
      affectedArea: 'Content',
      severity: 'Medium',
      status: 'Under observation',
      notes:
          'Static board and workspace visibility need periodic UX review before future staff rollout.',
    ),
    _MaintenanceIssueItem(
      title: 'Support escalation trace consistency',
      affectedArea: 'Chat',
      severity: 'Low',
      status: 'Monitoring',
      notes:
          'Manual escalation surfaces exist, but long-term trace consistency still needs structured planning.',
    ),
    _MaintenanceIssueItem(
      title: 'Admin shell polish debt',
      affectedArea: 'Admin',
      severity: 'Low',
      status: 'Backlog',
      notes:
          'Minor UI cleanup and consistency checks remain across new operational shells.',
    ),
  ];

  static const List<_DiagnosticsToolItem> _tools = [
    _DiagnosticsToolItem(
      title: 'Firebase Console',
      summary:
          'Reference console for project services and operational snapshots.',
      url: 'https://console.firebase.google.com/',
    ),
    _DiagnosticsToolItem(
      title: 'Firestore Viewer',
      summary:
          'Direct data inspection surface for manual review and schema awareness.',
      url: 'https://console.firebase.google.com/project/_/firestore',
    ),
    _DiagnosticsToolItem(
      title: 'Chrome DevTools',
      summary:
          'Browser inspection tool for layout, console, and runtime diagnostics.',
      url: 'https://developer.chrome.com/docs/devtools/',
    ),
    _DiagnosticsToolItem(
      title: 'GitHub Repository',
      summary:
          'Code review and issue-tracking entry for repository history and diffs.',
      url: 'https://github.com/',
    ),
    _DiagnosticsToolItem(
      title: 'Local Project Folder',
      summary:
          'Manual reminder for local workspace inspection and file-level diagnostics.',
      url: 'file:///C:/mental_smile_workspace/app/mental-smile-app',
    ),
  ];

  static const List<_IssueTaskItem> _issueTasks = [
    _IssueTaskItem(
      title: 'Review admin shell consistency',
      owner: 'Maintenance Lead',
      status: 'To Investigate',
      notes:
          'Inspect new operational surfaces for visual and structural drift.',
    ),
    _IssueTaskItem(
      title: 'Check content workspace rollout risks',
      owner: 'Operations Review',
      status: 'In Progress',
      notes:
          'Map future staff exposure risks before any permission activation.',
    ),
    _IssueTaskItem(
      title: 'Observe support escalation path',
      owner: 'Chat Oversight',
      status: 'Monitoring',
      notes:
          'Continue reviewing manual escalation surfaces and intervention clarity.',
    ),
  ];

  static const List<_FixLogItem> _fixLog = [
    _FixLogItem(
      title: 'Admin Hub content signal introduced',
      summary:
          'Pending content signal was surfaced for direct Control Room visibility.',
    ),
    _FixLogItem(
      title: 'Workspace Command Center extracted',
      summary:
          'Standalone content workspace route prepared without activating staff auth.',
    ),
    _FixLogItem(
      title: 'Employee System chassis prepared',
      summary:
          'Staff-layer shells were added as static architecture guidance only.',
    ),
  ];

  Future<void> _openTool(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (launched || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open: $url')),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String summary,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        color: const Color(0xFF10161A).withValues(alpha: 0.94),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFC9A75B),
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFFF1E5C8).withValues(alpha: 0.86),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildIssueCard(BuildContext context, _MaintenanceIssueItem item) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF151C21).withValues(alpha: 0.96),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF1E5C8),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${item.affectedArea} • ${item.severity} • ${item.status}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF73C1B8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.notes,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, _DiagnosticsToolItem item) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF151C21).withValues(alpha: 0.96),
      borderColor: const Color(0xFF3E9B90).withValues(alpha: 0.16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF1E5C8),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.summary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: () => _openTool(context, item.url),
            icon: const Icon(Icons.open_in_new, size: 18),
            label: const Text('Open Tool'),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueTaskColumn(
    BuildContext context, {
    required String title,
    required List<_IssueTaskItem> tasks,
  }) {
    return SizedBox(
      width: 280,
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        color: const Color(0xFF11181D).withValues(alpha: 0.96),
        borderColor: const Color(0xFF3E9B90).withValues(alpha: 0.14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFF1E5C8),
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${tasks.length} tasks',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...tasks.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppSectionPanel(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  color: const Color(0xFF151C21).withValues(alpha: 0.96),
                  borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFFF1E5C8),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Owner: ${task.owner}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFFD9DDE2)
                                  .withValues(alpha: 0.80),
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        task.notes,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFFD9DDE2)
                                  .withValues(alpha: 0.78),
                              height: 1.35,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixLogCard(BuildContext context, _FixLogItem item) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF151C21).withValues(alpha: 0.96),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF1E5C8),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.summary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLauncherCard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () => Navigator.of(context).pushNamed(Routes.adminAiDevOpsCenter),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        color: const Color(0xFF151C21).withValues(alpha: 0.96),
        borderColor: const Color(0xFF3E9B90).withValues(alpha: 0.16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI & DevOps Center',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFF1E5C8),
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Manual coordination surface for AI planning, Codex execution handoff, local validation, and QA follow-through.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Open center',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDomainAvailabilityLauncher(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.adminDomainAvailability),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        color: const Color(0xFF151C21).withValues(alpha: 0.96),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Domain Availability',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFF1E5C8),
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Advisory control surface for future maintenance isolation states across major domains.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Open control',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Maintenance & Diagnostics',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppSectionPanel(
              padding: const EdgeInsets.all(AppSpacing.lg),
              color: const Color(0xFF10161A).withValues(alpha: 0.94),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maintenance & Diagnostics',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFF1E5C8),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'This is a monitoring and diagnostics surface, not an active fixing system yet.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              const Color(0xFFD9DDE2).withValues(alpha: 0.84),
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildSection(
              context,
              title: 'AI & DevOps Center',
              summary:
                  'Manual launcher for coordinating AI planning, code execution, local validation, and QA review without automation.',
              children: [
                _buildLauncherCard(context),
              ],
            ),
            _buildSection(
              context,
              title: 'Domain Availability',
              summary:
                  'Future maintenance-isolation advisory surface for major system domains without runtime enforcement.',
              children: [
                _buildDomainAvailabilityLauncher(context),
              ],
            ),
            _buildSection(
              context,
              title: 'System Health Overview',
              summary:
                  'Placeholder signals only. The system currently appears stable and remains under observation.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: const [
                    _StatusSignalChip(label: 'Frontend Shell', value: 'Stable'),
                    _StatusSignalChip(
                        label: 'Admin Surface', value: 'Observed'),
                    _StatusSignalChip(
                        label: 'Content Tools', value: 'Observed'),
                    _StatusSignalChip(
                        label: 'Operational Traces', value: 'Stable'),
                  ],
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Active Issues',
              summary:
                  'Static issue cards outlining current areas under observation without live debugging logic.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: _issues
                      .map(
                        (item) => SizedBox(
                          width: 320,
                          child: _buildIssueCard(context, item),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Diagnostics Tools',
              summary:
                  'External reference tools for monitoring and inspection only.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: _tools
                      .map(
                        (item) => SizedBox(
                          width: 320,
                          child: _buildToolCard(context, item),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Issue Tasks',
              summary:
                  'Static work buckets showing how maintenance investigation can be staged later.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    _buildIssueTaskColumn(
                      context,
                      title: 'To Investigate',
                      tasks: _issueTasks
                          .where((task) => task.status == 'To Investigate')
                          .toList(),
                    ),
                    _buildIssueTaskColumn(
                      context,
                      title: 'In Progress',
                      tasks: _issueTasks
                          .where((task) => task.status == 'In Progress')
                          .toList(),
                    ),
                    _buildIssueTaskColumn(
                      context,
                      title: 'Monitoring',
                      tasks: _issueTasks
                          .where((task) => task.status == 'Monitoring')
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Fix Log',
              summary:
                  'Static observations and past fixes for future diagnostics traceability.',
              children: _fixLog
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _buildFixLogCard(context, item),
                    ),
                  )
                  .toList(),
            ),
            _buildSection(
              context,
              title: 'Escalation Rules',
              summary:
                  'Static guidance for when operational issues should be escalated to admin ownership.',
              children: [
                Text(
                  'Escalate to admin when an issue affects core system trust, blocks supervised workflows, touches sensitive data visibility, or suggests a wider control-plane regression.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFD9DDE2).withValues(alpha: 0.84),
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusSignalChip extends StatelessWidget {
  const _StatusSignalChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF151C21).withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: const Color(0xFFD8B26A).withValues(alpha: 0.16),
        ),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFFF1E5C8),
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _MaintenanceIssueItem {
  final String title;
  final String affectedArea;
  final String severity;
  final String status;
  final String notes;

  const _MaintenanceIssueItem({
    required this.title,
    required this.affectedArea,
    required this.severity,
    required this.status,
    required this.notes,
  });
}

class _DiagnosticsToolItem {
  final String title;
  final String summary;
  final String url;

  const _DiagnosticsToolItem({
    required this.title,
    required this.summary,
    required this.url,
  });
}

class _IssueTaskItem {
  final String title;
  final String owner;
  final String status;
  final String notes;

  const _IssueTaskItem({
    required this.title,
    required this.owner,
    required this.status,
    required this.notes,
  });
}

class _FixLogItem {
  final String title;
  final String summary;

  const _FixLogItem({
    required this.title,
    required this.summary,
  });
}
