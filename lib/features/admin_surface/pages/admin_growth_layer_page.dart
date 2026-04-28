import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminGrowthLayerPage extends StatelessWidget {
  const AdminGrowthLayerPage({super.key});

  Widget _buildLauncherCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String route,
    String? statusLabel,
    String? counterLabel,
    int? counterValue,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () => Navigator.of(context).pushNamed(route),
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
              'Operational launcher',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            if ((statusLabel ?? '').trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                statusLabel!.trim(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.obsidian.withValues(alpha: 0.84),
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.84),
                  ),
            ),
            if (counterLabel != null && counterValue != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFC9A75B).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(
                    color: const Color(0xFFC9A75B).withValues(alpha: 0.22),
                  ),
                ),
                child: Text(
                  '$counterLabel: $counterValue',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFC9A75B),
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Open workspace',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFC9A75B),
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Color(0xFFC9A75B),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
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
              'Planned boundary',
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
        title: 'Growth & Awareness Layer',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Growth & Awareness Layer',
              summary:
                  'Supervise growth, awareness, and monetization concepts without turning them into live ad systems or active campaign tooling.',
              boundaryNote:
                  'This layer exists to define safe planning boundaries for creation, distribution, monetization, and ethics.',
              emphasis:
                  'No ad delivery, tracking, backend logic, or monetization automation is active here.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Workspace Command Center',
              description:
                  'Manual command surface for creative workspaces, content board visibility, and publish-prep context actions.',
              children: [
                _buildLauncherCard(
                  context,
                  title: 'Employee System',
                  summary:
                      'Future-ready staff layer chassis for directory, workspaces, task queues, and review surfaces without full admin access.',
                  route: Routes.adminEmployeeSystem,
                  statusLabel:
                      'Controlled staff layer • no employee auth active yet',
                ),
                const SizedBox(height: AppSpacing.md),
                _buildLauncherCard(
                  context,
                  title: 'Maintenance & Diagnostics',
                  summary:
                      'Future-ready monitoring and diagnostics surface for issue visibility, investigation tools, and escalation guidance.',
                  route: Routes.adminMaintenanceSystem,
                  statusLabel:
                      'Monitoring chassis • no active fixing system yet',
                ),
                const SizedBox(height: AppSpacing.md),
                _buildLauncherCard(
                  context,
                  title: 'Workspace Command Center',
                  summary:
                      'Open workspace tools, track content progress, and use manual context actions without API integration or publishing automation.',
                  route: Routes.adminWorkspaceCommandCenter,
                ),
                const SizedBox(height: AppSpacing.md),
                _buildLauncherCard(
                  context,
                  title: 'Content Workspace',
                  summary:
                      'Standalone content operations surface for tools, board tracking, content cards, and production links.',
                  route: Routes.contentWorkspace,
                  statusLabel: 'Future employee-ready surface • no admin controls',
                  counterLabel: 'Pending Content',
                  counterValue: 6,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Creation Workspace',
              description:
                  'Planned creative surfaces for preparing awareness materials without activating any publishing or campaign system.',
              children: [
                _buildConceptCard(
                  context,
                  title: 'Canva',
                  summary:
                      'Reserved for supervised visual content preparation and branded awareness assets.',
                  boundaryNote:
                      'Supports content creation planning only, separate from campaign execution or publishing.',
                  supervisionNote:
                      'Supervises future creative tooling boundaries without mixing them into daily admin workflows.',
                ),
                _buildConceptCard(
                  context,
                  title: 'AI Content Generation',
                  summary:
                      'Reserved for supervised idea drafting, campaign copy preparation, and awareness content planning.',
                  boundaryNote:
                      'Supports preparation only and does not publish, target, or automate audience delivery.',
                  supervisionNote:
                      'Supervises creative-assistance boundaries without becoming a live content engine.',
                ),
                _buildConceptCard(
                  context,
                  title: 'Reports / Presentations',
                  summary:
                      'Reserved for awareness decks, growth reporting, and planning presentations.',
                  boundaryNote:
                      'Supports internal planning and reporting boundaries, separate from public campaign delivery.',
                  supervisionNote:
                      'Supervises planning outputs without turning this page into a reporting workflow workspace.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Distribution Boundaries',
              description:
                  'Planned surfaces for controlled distribution channels, kept separate from support and direct case handling.',
              children: [
                _buildConceptCard(
                  context,
                  title: 'Email Campaigns',
                  summary:
                      'Reserved for planned outbound awareness messaging boundaries.',
                  boundaryNote:
                      'Separate from support email and separate from direct human communications handling.',
                  supervisionNote:
                      'Supervises outreach planning without enabling campaign execution or inbox automation.',
                ),
                _buildConceptCard(
                  context,
                  title: 'In-app Placements',
                  summary:
                      'Reserved for controlled in-app awareness surfaces and educational placements.',
                  boundaryNote:
                      'Separate from core support, clinical, and operational workflows.',
                  supervisionNote:
                      'Supervises placement planning only, without activating rendering, delivery, or targeting.',
                ),
                _buildConceptCard(
                  context,
                  title: 'Messaging Channels',
                  summary:
                      'Reserved for future awareness distribution through messaging channels.',
                  boundaryNote:
                      'Separate from support channels and separate from Communications workspace case handling.',
                  supervisionNote:
                      'Supervises awareness-channel planning without overlapping with support intake boundaries.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Monetization Surfaces',
              description:
                  'Conceptual placement boundaries for controlled exposure models, without activating ads or sponsorship systems.',
              children: [
                _buildConceptCard(
                  context,
                  title: 'Chat Spotlight',
                  summary:
                      'Reserved for temporary, controlled visibility surfaces inside chat-adjacent contexts.',
                  boundaryNote:
                      'Separate from support conversations, case handling, and clinical flows.',
                  supervisionNote:
                      'Supervises exposure planning without enabling ad serving or ranking manipulation.',
                ),
                _buildConceptCard(
                  context,
                  title: 'Dashboard Placements',
                  summary:
                      'Reserved for controlled awareness or monetization placements in dashboard contexts.',
                  boundaryNote:
                      'Separate from operational decision cards and separate from critical support surfaces.',
                  supervisionNote:
                      'Supervises placement concepts only, without rendering or tracking exposure.',
                ),
                _buildConceptCard(
                  context,
                  title: 'Sponsored Content',
                  summary:
                      'Reserved for future sponsored awareness boundaries under explicit administrative control.',
                  boundaryNote:
                      'Separate from editorial support content and separate from trusted guidance surfaces.',
                  supervisionNote:
                      'Supervises monetization concepts without activating sponsorship workflows or delivery logic.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Ethical Guard Layer',
              description:
                  'Non-negotiable safety boundaries for any future awareness or monetization direction.',
              children: [
                _buildConceptCard(
                  context,
                  title: 'No ads in crisis states',
                  summary:
                      'Any future growth or monetization surface must remain disabled in crisis-related contexts.',
                  boundaryNote:
                      'Protects vulnerable states from commercial exposure or competing attention demands.',
                  supervisionNote:
                      'Supervises ethical suppression rules conceptually without implementing runtime policy logic here.',
                ),
                _buildConceptCard(
                  context,
                  title: 'No targeting based on vulnerability',
                  summary:
                      'Targeting strategies must not exploit emotional distress, fragility, or dependency.',
                  boundaryNote:
                      'Separates ethical planning from manipulative monetization or exposure design.',
                  supervisionNote:
                      'Supervises ethical targeting limits without enabling segmentation or tracking systems.',
                ),
                _buildConceptCard(
                  context,
                  title: 'Non-intrusive exposure',
                  summary:
                      'Any future placements must remain quiet, controlled, and subordinate to user wellbeing.',
                  boundaryNote:
                      'Separates awareness planning from intrusive interruption-based growth tactics.',
                  supervisionNote:
                      'Supervises acceptable exposure boundaries without activating delivery or UI injection.',
                ),
                _buildConceptCard(
                  context,
                  title: 'Family-safe guidelines',
                  summary:
                      'Any future awareness or sponsorship layer must remain appropriate for broad family-safe use.',
                  boundaryNote:
                      'Separates brand safety and wellbeing commitments from aggressive commercial behavior.',
                  supervisionNote:
                      'Supervises content-safety planning without introducing moderation or ad review workflows here.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
