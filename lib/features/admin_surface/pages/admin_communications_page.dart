import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminCommunicationsPage extends StatelessWidget {
  const AdminCommunicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Control Room Communications (Historical)',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: const [
            _CommunicationsIntroCard(),
            SizedBox(height: AppSpacing.md),
            _CommunicationsEntryCard(
              title: 'Legacy Support Threads',
              summary:
                  'This section shows historical chat threads. New support requests are handled via structured support requests.',
              route: Routes.adminSupportChats,
            ),
            SizedBox(height: AppSpacing.md),
            _CommunicationsEntryCard(
              title: 'Escalated Cases (Historical)',
              summary:
                  'This section shows historical escalated cases only. New support requests are handled via structured support requests.',
              route: Routes.chatEscalations,
            ),
          ],
        ),
      ),
    );
  }
}

class _CommunicationsIntroCard extends StatelessWidget {
  const _CommunicationsIntroCard();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Control Room Communications (Historical)',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'This section monitors historical communication records only. New support requests are handled via structured support requests, and actions here are exception-based rather than normal workflow ownership.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.72),
                ),
          ),
        ],
      ),
    );
  }
}

class _CommunicationsEntryCard extends StatelessWidget {
  const _CommunicationsEntryCard({
    required this.title,
    required this.summary,
    required this.route,
  });

  final String title;
  final String summary;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () => Navigator.of(context).pushNamed(route),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(summary),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            const Icon(Icons.open_in_new),
          ],
        ),
      ),
    );
  }
}
