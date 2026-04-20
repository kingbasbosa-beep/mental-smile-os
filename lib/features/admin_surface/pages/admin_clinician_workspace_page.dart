import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminClinicianWorkspacePage extends StatelessWidget {
  const AdminClinicianWorkspacePage({super.key});

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toLocal().toString().split('.').first;
    }
    return (value ?? '').toString().trim();
  }

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
              title: 'Incoming Requests Preview',
              description:
                  'A read-only preview of clinician-related requests using the existing clinician collection without activating any assignment or workflow behavior.',
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('clinicians')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const GatewaySupervisionNote(
                        text:
                            'Preview unavailable right now. The workspace shell remains read-only and inactive until a later approved activation path exists.',
                      );
                    }

                    if (!snapshot.hasData) {
                      return const GatewaySupervisionNote(
                        text:
                            'Loading a read-only preview of incoming clinician-side requests.',
                      );
                    }

                    final pendingDocs = snapshot.data!.docs.where((doc) {
                      final data = doc.data();
                      final isBlocked = (data['isBlocked'] ?? false) == true;
                      if (isBlocked) return false;
                      final status =
                          (data['approvalStatus'] ?? 'pending_review')
                              .toString();
                      return status == 'pending_review';
                    }).toList();

                    final previewDocs = pendingDocs.take(3).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pending preview count: ${pendingDocs.length}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        if (previewDocs.isEmpty)
                          const GatewaySupervisionNote(
                            text:
                                'No pending clinician-side requests are being previewed right now. This surface stays read-only and does not activate any workflow.',
                          )
                        else
                          ...previewDocs.map(
                            (doc) {
                              final data = doc.data();
                              final name =
                                  (data['displayName'] ?? data['name'] ?? '')
                                      .toString()
                                      .trim();
                              final email =
                                  (data['email'] ?? '').toString().trim();
                              final createdAt = _dateText(data['createdAt']);

                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: AppSpacing.md),
                                child: AppSectionPanel(
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name.isEmpty ? 'Unnamed clinician' : name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        'Status: Pending review',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: const Color(0xFF2E5AAC),
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: AppSpacing.sm),
                                      Text(
                                        email.isEmpty
                                            ? 'Email not available'
                                            : email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: AppColors.obsidian
                                                  .withValues(alpha: 0.84),
                                            ),
                                      ),
                                      if (createdAt.isNotEmpty) ...[
                                        const SizedBox(height: AppSpacing.xs),
                                        Text(
                                          'Created: $createdAt',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppColors.obsidian
                                                    .withValues(alpha: 0.70),
                                              ),
                                        ),
                                      ],
                                      const SizedBox(height: AppSpacing.xs),
                                      const GatewaySupervisionNote(
                                        text:
                                            'Read-only preview only. No assignment, approval, scheduling, or state transition is available from this shell.',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    );
                  },
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
