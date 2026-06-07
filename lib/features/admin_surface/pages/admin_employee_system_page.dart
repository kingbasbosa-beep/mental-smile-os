import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminEmployeeSystemPage extends StatelessWidget {
  const AdminEmployeeSystemPage({super.key});

  static const List<_EmployeeTaskItem> _sampleTasks = [
    _EmployeeTaskItem(
      title: 'Create Reel: AI بدون نظام = خطر',
      workspace: 'Content',
      status: 'In Progress',
      owner: 'Content Operator',
      priority: 'High',
      notes: 'Finalize concept framing and handoff structure before export.',
      outputLink: 'Not added yet',
    ),
    _EmployeeTaskItem(
      title: 'Design Post: بداية الرحلة',
      workspace: 'Content',
      status: 'To Do',
      owner: 'Design Queue',
      priority: 'Medium',
      notes: 'Prepare visual direction and first copy-safe layout draft.',
      outputLink: '',
    ),
    _EmployeeTaskItem(
      title: 'Review Content: Family Awareness',
      workspace: 'QA',
      status: 'Review',
      owner: 'QA Workspace',
      priority: 'Review',
      notes: 'Check final wording, CTA clarity, and safe audience framing.',
      outputLink: 'Not added yet',
    ),
  ];

  static const List<_EmployeeReviewItem> _sampleReviewItems = [
    _EmployeeReviewItem(
      title: 'Reel Ready for Review: AI بدون نظام = خطر',
      sourceWorkspace: 'Content Workspace',
      submittedBy: 'Content Operator',
      reviewType: 'Creative Review',
      priority: 'High',
      status: 'Awaiting Review',
      outputLink: '',
      notes: 'Confirm final framing, wording safety, and export readiness.',
    ),
    _EmployeeReviewItem(
      title: 'Post Review: Family Awareness',
      sourceWorkspace: 'Content Workspace',
      submittedBy: 'Design Queue',
      reviewType: 'Content Review',
      priority: 'Medium',
      status: 'Needs Notes',
      outputLink: 'Not added yet',
      notes: 'Review visual hierarchy and CTA clarity before release prep.',
    ),
    _EmployeeReviewItem(
      title: 'QA Finding: Content workflow visibility',
      sourceWorkspace: 'QA Workspace',
      submittedBy: 'QA Workspace',
      reviewType: 'QA Finding',
      priority: 'Review',
      status: 'Open',
      outputLink: '',
      notes:
          'Flag visibility gaps in handoff steps and workspace traceability.',
    ),
  ];

  static const List<_EmployeeActivityItem> _sampleActivityItems = [
    _EmployeeActivityItem(
      actionTitle: 'Content task moved to Review',
      actor: 'Content Operator',
      workspace: 'Content Workspace',
      actionType: 'Status Update',
      timestampLabel: 'Today • 10:20',
      relatedItem: 'Create Reel: AI بدون نظام = خطر',
      notes:
          'The reel draft was moved from In Progress to Review for QA visibility.',
    ),
    _EmployeeActivityItem(
      actionTitle: 'Output link added to reel task',
      actor: 'Content Operator',
      workspace: 'Content Workspace',
      actionType: 'Link Update',
      timestampLabel: 'Today • 11:05',
      relatedItem: 'Create Reel: AI بدون نظام = خطر',
      notes:
          'A manual output link placeholder was attached for final review follow-up.',
    ),
    _EmployeeActivityItem(
      actionTitle: 'QA note added to content workflow',
      actor: 'QA Workspace',
      workspace: 'QA Workspace',
      actionType: 'Review Note',
      timestampLabel: 'Today • 12:10',
      relatedItem: 'Content workflow visibility',
      notes:
          'Added a visibility note around handoff traceability and review-step clarity.',
    ),
  ];

  static const List<_EmployeeRoleBoundaryItem> _roleBoundaries = [
    _EmployeeRoleBoundaryItem(
      role: 'Admin',
      workspaceAccess: 'All admin and employee surfaces',
      canViewSensitiveData: 'Yes',
      canControlCoreFlows: 'Yes',
      canPublishOrApprove: 'Yes',
      notes:
          'Full control-plane role with governance, approvals, and core flow ownership.',
    ),
    _EmployeeRoleBoundaryItem(
      role: 'Content Operator',
      workspaceAccess: 'Content Workspace',
      canViewSensitiveData: 'No',
      canControlCoreFlows: 'No',
      canPublishOrApprove: 'No',
      notes:
          'Prepares content operations only; escalates for review and publishing decisions.',
    ),
    _EmployeeRoleBoundaryItem(
      role: 'Support Agent',
      workspaceAccess: 'Support Workspace',
      canViewSensitiveData: 'Limited',
      canControlCoreFlows: 'No',
      canPublishOrApprove: 'No',
      notes:
          'Handles supervised support follow-up without domain-wide admin controls.',
    ),
    _EmployeeRoleBoundaryItem(
      role: 'QA Reviewer',
      workspaceAccess: 'QA Workspace',
      canViewSensitiveData: 'Limited',
      canControlCoreFlows: 'No',
      canPublishOrApprove: 'Review only',
      notes:
          'Flags quality findings and review notes without final approval authority.',
    ),
    _EmployeeRoleBoundaryItem(
      role: 'Finance Assistant',
      workspaceAccess: 'Finance Assistant Workspace',
      canViewSensitiveData: 'Limited',
      canControlCoreFlows: 'No',
      canPublishOrApprove: 'No',
      notes:
          'Prepares scoped follow-through surfaces without lifecycle approval ownership.',
    ),
    _EmployeeRoleBoundaryItem(
      role: 'Operations Assistant',
      workspaceAccess: 'Operations Assistant Workspace',
      canViewSensitiveData: 'Limited',
      canControlCoreFlows: 'No',
      canPublishOrApprove: 'No',
      notes:
          'Coordinates operational movement and blockers without controlling core system flows.',
    ),
  ];

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String summary,
    List<Widget> children = const [],
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
            if (children.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              ...children,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWorkspaceCard(
    BuildContext context, {
    required String title,
    required String summary,
    String? route,
  }) {
    final cardChild = AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF151C21).withValues(alpha: 0.96),
      borderColor: const Color(0xFF3E9B90).withValues(alpha: 0.16),
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
            summary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD8B26A).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(
                color: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              ),
            ),
            child: Text(
              route == null ? 'Chassis only' : 'Open workspace',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );

    if (route == null) return cardChild;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () => Navigator.of(context).pushNamed(route),
      child: cardChild,
    );
  }

  Widget _buildTaskCard(BuildContext context, _EmployeeTaskItem task) {
    final hasOutputLink = task.outputLink.trim().isNotEmpty &&
        task.outputLink.trim() != 'Not added yet';
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF151C21).withValues(alpha: 0.96),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF1E5C8),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${task.workspace} • ${task.status}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF73C1B8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Owner: ${task.owner}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                ),
          ),
          if ((task.priority ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Priority: ${task.priority}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
          const SizedBox(height: AppSpacing.xs),
          Text(
            task.notes,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.80),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            hasOutputLink
                ? 'Output link available'
                : 'Output link: Not added yet',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: hasOutputLink
                      ? const Color(0xFFC9A75B)
                      : const Color(0xFFD9DDE2).withValues(alpha: 0.72),
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskColumn(
    BuildContext context, {
    required String status,
    required List<_EmployeeTaskItem> tasks,
  }) {
    return SizedBox(
      width: 260,
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        color: const Color(0xFF11181D).withValues(alpha: 0.96),
        borderColor: const Color(0xFF3E9B90).withValues(alpha: 0.14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status,
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
            if (tasks.isEmpty)
              Text(
                'No tasks yet.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFFD9DDE2).withValues(alpha: 0.70),
                    ),
              )
            else
              ...tasks.map((task) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _buildTaskCard(context, task),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, _EmployeeReviewItem item) {
    final hasOutputLink = item.outputLink.trim().isNotEmpty &&
        item.outputLink.trim() != 'Not added yet';
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
            '${item.sourceWorkspace} • ${item.status}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF73C1B8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Submitted by: ${item.submittedBy}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Review type: ${item.reviewType}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Priority: ${item.priority}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFC9A75B),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.notes,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.80),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            hasOutputLink
                ? 'Output link available'
                : 'Output link: Not added yet',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: hasOutputLink
                      ? const Color(0xFFC9A75B)
                      : const Color(0xFFD9DDE2).withValues(alpha: 0.72),
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    _EmployeeActivityItem item,
  ) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF151C21).withValues(alpha: 0.96),
      borderColor: const Color(0xFF3E9B90).withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.actionTitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF1E5C8),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${item.workspace} • ${item.actionType}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF73C1B8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Actor: ${item.actor}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Timestamp: ${item.timestampLabel}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFC9A75B),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Related item: ${item.relatedItem}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.notes,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.80),
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleBoundaryCard(
    BuildContext context,
    _EmployeeRoleBoundaryItem item,
  ) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF151C21).withValues(alpha: 0.96),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.role,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFF1E5C8),
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRoleBoundaryLine(
            context,
            label: 'Workspace Access',
            value: item.workspaceAccess,
          ),
          _buildRoleBoundaryLine(
            context,
            label: 'Can View Sensitive Data',
            value: item.canViewSensitiveData,
          ),
          _buildRoleBoundaryLine(
            context,
            label: 'Can Control Core Flows',
            value: item.canControlCoreFlows,
          ),
          _buildRoleBoundaryLine(
            context,
            label: 'Can Publish/Approve',
            value: item.canPublishOrApprove,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.notes,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFD9DDE2).withValues(alpha: 0.80),
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleBoundaryLine(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFFD9DDE2).withValues(alpha: 0.82),
                height: 1.35,
              ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                color: Color(0xFFC9A75B),
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: future role guard -> content_operator / content_editor
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Employee System',
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
                    'Employee System',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFF1E5C8),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E9B90).withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                      border: Border.all(
                        color: const Color(0xFF3E9B90).withValues(alpha: 0.24),
                      ),
                    ),
                    child: Text(
                      'Controlled staff layer',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF73C1B8),
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Employee System is a controlled staff layer, not full admin access.',
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
            _buildSectionCard(
              context,
              title: 'Employee Directory',
              summary:
                  'Future staff roster surface for content, support, QA, and operations assistants.',
            ),
            _buildSectionCard(
              context,
              title: 'Workspaces',
              summary:
                  'Launch controlled staff workspaces without exposing full admin navigation.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    SizedBox(
                      width: 280,
                      child: _buildWorkspaceCard(
                        context,
                        title: 'Content Workspace',
                        summary:
                            'Creative operations surface for content planning, production links, and publish-prep tracking.',
                        route: Routes.contentWorkspace,
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: _buildWorkspaceCard(
                        context,
                        title: 'Support Workspace',
                        summary:
                            'Planned staff layer for supervised support workflows and escalation handling.',
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: _buildWorkspaceCard(
                        context,
                        title: 'QA Workspace',
                        summary:
                            'Planned staff layer for review checks, operational validation, and handoff inspection.',
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: _buildWorkspaceCard(
                        context,
                        title: 'Finance Assistant Workspace',
                        summary:
                            'Planned staff layer for operational readiness and support follow-through.',
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: _buildWorkspaceCard(
                        context,
                        title: 'Operations Assistant Workspace',
                        summary:
                            'Planned staff layer for coordination, blockers follow-up, and request movement.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _buildSectionCard(
              context,
              title: 'Task Board',
              summary:
                  'Static task structure showing how staff work can be assigned, tracked, and reviewed without backend wiring yet.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    _buildTaskColumn(
                      context,
                      status: 'To Do',
                      tasks: _sampleTasks
                          .where((task) => task.status == 'To Do')
                          .toList(),
                    ),
                    _buildTaskColumn(
                      context,
                      status: 'In Progress',
                      tasks: _sampleTasks
                          .where((task) => task.status == 'In Progress')
                          .toList(),
                    ),
                    _buildTaskColumn(
                      context,
                      status: 'Review',
                      tasks: _sampleTasks
                          .where((task) => task.status == 'Review')
                          .toList(),
                    ),
                    _buildTaskColumn(
                      context,
                      status: 'Done',
                      tasks: _sampleTasks
                          .where((task) => task.status == 'Done')
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
            _buildSectionCard(
              context,
              title: 'Review Queue',
              summary:
                  'Review Queue is placeholder only and does not approve or publish anything yet.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: _sampleReviewItems
                      .map(
                        (item) => SizedBox(
                          width: 320,
                          child: _buildReviewCard(context, item),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            _buildSectionCard(
              context,
              title: 'Activity Log',
              summary:
                  'Activity Log is placeholder only and does not track live user actions yet.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: _sampleActivityItems
                      .map(
                        (item) => SizedBox(
                          width: 320,
                          child: _buildActivityCard(context, item),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            _buildSectionCard(
              context,
              title: 'Role Boundaries',
              summary:
                  'This matrix is architectural guidance only and does not enforce permissions yet.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: _roleBoundaries
                      .map(
                        (item) => SizedBox(
                          width: 340,
                          child: _buildRoleBoundaryCard(context, item),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmployeeTaskItem {
  final String title;
  final String workspace;
  final String status;
  final String owner;
  final String? priority;
  final String notes;
  final String outputLink;

  const _EmployeeTaskItem({
    required this.title,
    required this.workspace,
    required this.status,
    required this.owner,
    this.priority,
    required this.notes,
    required this.outputLink,
  });
}

class _EmployeeReviewItem {
  final String title;
  final String sourceWorkspace;
  final String submittedBy;
  final String reviewType;
  final String priority;
  final String status;
  final String outputLink;
  final String notes;

  const _EmployeeReviewItem({
    required this.title,
    required this.sourceWorkspace,
    required this.submittedBy,
    required this.reviewType,
    required this.priority,
    required this.status,
    required this.outputLink,
    required this.notes,
  });
}

class _EmployeeActivityItem {
  final String actionTitle;
  final String actor;
  final String workspace;
  final String actionType;
  final String timestampLabel;
  final String relatedItem;
  final String notes;

  const _EmployeeActivityItem({
    required this.actionTitle,
    required this.actor,
    required this.workspace,
    required this.actionType,
    required this.timestampLabel,
    required this.relatedItem,
    required this.notes,
  });
}

class _EmployeeRoleBoundaryItem {
  final String role;
  final String workspaceAccess;
  final String canViewSensitiveData;
  final String canControlCoreFlows;
  final String canPublishOrApprove;
  final String notes;

  const _EmployeeRoleBoundaryItem({
    required this.role,
    required this.workspaceAccess,
    required this.canViewSensitiveData,
    required this.canControlCoreFlows,
    required this.canPublishOrApprove,
    required this.notes,
  });
}
