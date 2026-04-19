import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_entry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminEngineeringGatewayPage extends StatelessWidget {
  const AdminEngineeringGatewayPage({super.key});

  String _supervisionNote(String entryId) {
    return switch (entryId) {
      'chatgpt' =>
        'Supervises AI collaboration support boundaries. It does not directly run business workflows or replace admin decision-making.',
      'codex' =>
        'Supervises AI-assisted development and maintenance boundaries. It remains separate from live admin operations and client-facing flows.',
      'browser_workspace' =>
        'Supervises browser-based tool boundaries. It keeps maintenance workspaces visible without turning this page into a working console.',
      'firebase' =>
        'Supervises backend console boundaries only. It does not perform backend writes or replace operational workflow pages.',
      'github' =>
        'Supervises repository and source-control boundaries. It remains separate from daily business workflow handling.',
      'qa_logs' =>
        'Supervises diagnostics and maintenance-observability boundaries. It does not replace Control Room awareness or business processing.',
      _ =>
        'Supervises this technical boundary without mixing it into direct business workflow handling.',
    };
  }

  Widget _buildEntryBlock(BuildContext context, GatewayEntry entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GatewayEntryCard(entry: entry),
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Text(
              _supervisionNote(entry.id),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.70),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGatewayGroup(
    BuildContext context, {
    required String title,
    required String description,
    required List<GatewayEntry> entries,
  }) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.70),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...entries.map((entry) => _buildEntryBlock(context, entry)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final aiWorkspaceEntries = engineeringGatewayEntries
        .where((entry) =>
            entry.id == 'chatgpt' ||
            entry.id == 'codex' ||
            entry.id == 'browser_workspace')
        .toList();
    final backendEntries = engineeringGatewayEntries
        .where((entry) => entry.id == 'firebase' || entry.id == 'github')
        .toList();
    final diagnosticsEntries = engineeringGatewayEntries
        .where((entry) => entry.id == 'qa_logs')
        .toList();

    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Engineering / Maintenance Gateway',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Engineering / Maintenance Gateway',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'A shell for technical tools, maintenance boundaries, and smart development support surfaces.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.72),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'This page is for technical supervision only: what each tool boundary is for, what is merely planned, and what is being monitored as a shell.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.70),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Business workflows remain in Operations and Communications. This page only clarifies technical compartments and maintenance boundaries.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.70),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'AI / Workspace',
              description:
                  'AI-assisted tools and browser-based workspaces that support maintenance and development awareness.',
              entries: aiWorkspaceEntries,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Backend / Source Control',
              description:
                  'Technical boundaries for backend consoles, repositories, and source-control supervision.',
              entries: backendEntries,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Diagnostics / Maintenance',
              description:
                  'Diagnostics, logs, and maintenance-observability boundaries used for supervised technical follow-up.',
              entries: diagnosticsEntries,
            ),
          ],
        ),
      ),
    );
  }
}
