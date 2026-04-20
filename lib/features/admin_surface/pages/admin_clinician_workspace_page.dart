import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminClinicianWorkspacePage extends StatelessWidget {
  const AdminClinicianWorkspacePage({super.key});

  Widget _buildWorkspaceCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
    String statusLabel = 'Parallel workspace shell',
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              statusLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF2E5AAC),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.84),
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Boundary: $boundaryNote',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.70),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            GatewaySupervisionNote(text: supervisionNote),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Clinician Workspace Shell',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Clinician Workspace Shell',
              summary:
                  'This page establishes a clean parallel shell for the future clinician workspace without activating any clinician workflow.',
              boundaryNote:
                  'It does not replace the old clinician-related admin page and does not connect to live assignment, booking, or scheduling behavior.',
              emphasis:
                  'This workspace is a future-ready shell only: safety-sensitive, staged, and intentionally inactive in the current phase.',
            ),
            const SizedBox(height: AppSpacing.md),
            const GatewaySectionCard(
              title: 'Workspace Scope',
              description:
                  'This compact section defines what belongs inside the future clinician workspace and what must stay outside until a later approved activation.',
              children: [
                GatewaySupervisionNote(
                  text:
                      'Belongs here: clinician-facing request readiness, assignment readiness framing, prepared case visibility, and future workspace coordination boundaries.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Does not belong here yet: live assignment, booking orchestration, scheduling engine behavior, or any user-facing activation.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Workspace Blocks',
              description:
                  'These blocks define the clean shell structure for the future clinician workspace without turning it into a live operational surface yet.',
              children: [
                _buildWorkspaceCard(
                  context,
                  title: 'Incoming Requests',
                  summary:
                      'A future area for reviewing incoming clinician-side workload boundaries once a clean activation path is approved.',
                  boundaryNote:
                      'No active request orchestration, intake engine, or assignment behavior is enabled here now.',
                  supervisionNote:
                      'This block exists as structure only, not as a live workflow.',
                ),
                _buildWorkspaceCard(
                  context,
                  title: 'Assignment Readiness',
                  summary:
                      'A future area for determining whether a case is even eligible to move toward clinician handling under approved rules.',
                  boundaryNote:
                      'No live assignment, no automatic matching, and no current connection to older clinician flow behavior.',
                  supervisionNote:
                      'Eligibility framing may live here later, but activation is not allowed now.',
                ),
                _buildWorkspaceCard(
                  context,
                  title: 'Scheduled / Prepared Cases',
                  summary:
                      'A future area for viewing cases that become prepared for clinician-side handling after staged activation later on.',
                  boundaryNote:
                      'No scheduling engine, no live case preparation workflow, and no session orchestration is active in this shell.',
                  supervisionNote:
                      'This block is intentionally descriptive only in the current phase.',
                ),
                _buildWorkspaceCard(
                  context,
                  title: 'Boundaries & Activation Notes',
                  summary:
                      'A standing area for future activation notes, safety boundaries, and staged rollout constraints for the clinician layer.',
                  boundaryNote:
                      'No user-facing activation, no workflow expansion, and no integration into other layers until explicit approval later.',
                  supervisionNote:
                      'This remains a safety-sensitive workspace shell that must be activated deliberately and in stages only.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
