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
        title: 'Communications',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: const [
            _CommunicationsIntroCard(),
            SizedBox(height: AppSpacing.md),
            _CommunicationsEntryCard(
              title: 'Support Inbox',
              summary: 'Open human support chats and active admin conversations.',
              route: Routes.adminSupportChats,
            ),
            SizedBox(height: AppSpacing.md),
            _CommunicationsEntryCard(
              title: 'Escalations',
              summary: 'Open escalated conversations and review routed cases.',
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
            'Communications',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'This landing page is an entry point for human conversations and escalations only. External channel connectors remain under Gateway Layer.',
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
