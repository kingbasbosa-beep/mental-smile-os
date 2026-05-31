import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminOperationsPage extends StatelessWidget {
  const AdminOperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Operations',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: const [
            _OperationsIntroCard(),
            SizedBox(height: AppSpacing.md),
            _OperationsEntryCard(
              title: 'Legacy service request queue',
              summary: 'Review and route legacy request workflow signals.',
              route: Routes.adminBookingQueue,
            ),
            SizedBox(height: AppSpacing.md),
            _OperationsEntryCard(
              title: 'Legacy payment review',
              summary: 'Open legacy payment visibility and exception review.',
              route: Routes.adminPayments,
            ),
            SizedBox(height: AppSpacing.md),
            _OperationsEntryCard(
              title: 'Service coordination signals',
              summary:
                  'Open legacy coordination signals, links, and scheduling visibility.',
              route: Routes.adminSessions,
            ),
          ],
        ),
      ),
    );
  }
}

class _OperationsIntroCard extends StatelessWidget {
  const _OperationsIntroCard();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Operations',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'This landing page is an entry point for active business workflows only. It does not replace the deeper queue pages.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.72),
                ),
          ),
        ],
      ),
    );
  }
}

class _OperationsEntryCard extends StatelessWidget {
  const _OperationsEntryCard({
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
