import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminFunctionalWorkspacesPage extends StatelessWidget {
  const AdminFunctionalWorkspacesPage({super.key});

  Widget _buildDepartmentCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String arabicTitle,
    required String mission,
    required String route,
  }) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: const Color(0xFF0F172A),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFD8B26A).withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFD8B26A).withValues(alpha: 0.24),
                  ),
                ),
                child: Icon(icon, color: const Color(0xFFC9A75B)),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      arabicTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFFEAEAEA),
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
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
              'Manual • Future-ready • No automation',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF73C1B8),
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            mission,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEAEAEA),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(route),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('Open'),
            ),
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
        title: 'Functional Workspaces',
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
                    'Functional Workspaces',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Directory of independent operational departments, ready for future staff assignment without exposing full Control Room access.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFEAEAEA),
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDepartmentCard(
              context,
              icon: Icons.support_agent_outlined,
              title: 'Customer Follow-up Workspace',
              arabicTitle: 'قسم المتابعة وخدمة العملاء',
              mission:
                  'Handles WhatsApp, web requests, emails, customer communication, follow-up, and request tracking.',
              route: Routes.customerFollowUpWorkspace,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDepartmentCard(
              context,
              icon: Icons.build_circle_outlined,
              title: 'Technical Support Workspace',
              arabicTitle: 'قسم الدعم التقني والصيانة',
              mission:
                  'Handles diagnostics, issues, maintenance, system health, AI DevOps, and problem isolation.',
              route: Routes.technicalSupportWorkspace,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDepartmentCard(
              context,
              icon: Icons.campaign_outlined,
              title: 'Marketing Workspace',
              arabicTitle: 'قسم الدعاية والمحتوى',
              mission:
                  'Handles content, campaigns, Canva/CapCut workflows, publishing preparation, and educational material.',
              route: Routes.marketingWorkspace,
            ),
            const SizedBox(height: AppSpacing.md),
            AppSectionPanel(
              padding: const EdgeInsets.all(AppSpacing.md),
              color: const Color(0xFF0F172A),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Future Smart Assistant / Daily Reports',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Bot is not active. A future role may summarize each workspace every 12h/24h and may assist only when an employee is absent. No auto replies now.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFEAEAEA),
                          height: 1.35,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
