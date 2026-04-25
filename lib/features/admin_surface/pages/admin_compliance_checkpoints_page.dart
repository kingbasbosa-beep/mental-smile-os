import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminComplianceCheckpointsPage extends StatelessWidget {
  const AdminComplianceCheckpointsPage({super.key});

  Widget _buildCheckpointCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSectionPanel(
        color: const Color(0xFF10161A).withValues(alpha: 0.94),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        padding: const EdgeInsets.all(AppSpacing.md),
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
              'Compliance checkpoint',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Boundary: $boundaryNote',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
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
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Compliance-to-Code Checkpoints',
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF13191D),
              Color(0xFF0F1316),
              Color(0xFF151B1F),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Compliance-to-Code Checkpoints',
              summary:
                  'Supervise how product architecture, safety constraints, gateway boundaries, growth limits, and non-medical positioning should translate into future implementation checkpoints.',
              boundaryNote:
                  'This page is a blueprint surface only. It does not activate policy enforcement, integrations, tracking, or business logic.',
              emphasis:
                  'Architecture, safety, support, and compliance must remain aligned before any real activation or automation happens.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Product Positioning Checkpoints',
              description:
                  'Core positioning rules that must remain explicit in both architecture and future implementation.',
              children: [
                _buildCheckpointCard(
                  context,
                  title: 'Non-medical support only',
                  summary:
                      'The product must remain positioned as a support and wellbeing platform, not as a medical treatment system.',
                  boundaryNote:
                      'Prevents architecture, UX, and messaging from drifting into regulated medical-service claims.',
                  supervisionNote:
                      'This is a conceptual checkpoint only and does not alter runtime copy or enforcement yet.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Non-diagnostic AI',
                  summary:
                      'AI components must remain non-diagnostic and must not present themselves as a medical evaluator.',
                  boundaryNote:
                      'Separates assistant guidance and support logic from diagnosis-oriented behavior.',
                  supervisionNote:
                      'This remains a blueprint checkpoint without model-policy enforcement logic here.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Not a substitute for clinician care',
                  summary:
                      'The product must not imply that support flows replace licensed clinician care when that care is needed.',
                  boundaryNote:
                      'Protects user understanding and keeps support surfaces distinct from formal care responsibilities.',
                  supervisionNote:
                      'This remains a supervision checkpoint only, not a runtime disclaimer engine.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Safety Checkpoints',
              description:
                  'Safety checkpoints define the minimum architectural and behavioral safeguards before future activations.',
              children: [
                _buildCheckpointCard(
                  context,
                  title: 'Escalation required states',
                  summary:
                      'High-risk or escalation-required states must remain clearly separated from ordinary support, awareness, or monetization contexts.',
                  boundaryNote:
                      'Protects crisis-sensitive flows from distraction, misclassification, or automation creep.',
                  supervisionNote:
                      'Conceptual checkpoint only. No escalation runtime logic is added here.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Blocked exposure states',
                  summary:
                      'Any future awareness or monetization exposure must remain blocked in states already designated as sensitive or high-risk.',
                  boundaryNote:
                      'Ensures exposure rules stay subordinate to user safety and support conditions.',
                  supervisionNote:
                      'This page defines checkpoint intent only, not active blocking logic.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Crisis-safe handling',
                  summary:
                      'Crisis-related contexts must always preserve clear, interruption-free support behavior.',
                  boundaryNote:
                      'Prevents architecture drift toward blended support/commercial surfaces in crisis states.',
                  supervisionNote:
                      'This remains a blueprint requirement without crisis-detection implementation here.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Support-first logic',
                  summary:
                      'Whenever support and any secondary system conflict, support logic must take priority.',
                  boundaryNote:
                      'Protects the core support purpose of the product against operational or commercial pressure.',
                  supervisionNote:
                      'This is a conceptual guardrail, not a runtime prioritization engine in this page.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Gateway Checkpoints',
              description:
                  'Gateway checkpoints define what the current supervised boundaries mean before any real integration is allowed.',
              children: [
                _buildCheckpointCard(
                  context,
                  title: 'Communication boundaries only',
                  summary:
                      'Communication Gateway must remain a channel-boundary supervision layer until explicit integrations are approved later.',
                  boundaryNote:
                      'Prevents communication channels from bypassing Communications workflows or support safeguards.',
                  supervisionNote:
                      'Checkpoint only. No connector activation or inbox sync is added here.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Engineering supervision only',
                  summary:
                      'Engineering Gateway must remain a supervised technical boundary and not become a direct execution console by default.',
                  boundaryNote:
                      'Protects admin clarity and avoids mixing technical tool surfaces into business workflows.',
                  supervisionNote:
                      'This remains a blueprint rule with no automation or tool execution added.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Device / storage supervision only',
                  summary:
                      'Device / Storage Gateway must remain a boundary and visibility layer unless explicit device/storage integrations are approved later.',
                  boundaryNote:
                      'Prevents hidden hardware dependencies from being treated as active system guarantees.',
                  supervisionNote:
                      'No device probing, sync automation, or storage control is added here.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'No active integrations unless explicitly approved later',
                  summary:
                      'All gateway families must stay in shell/supervision mode until explicit activation checkpoints are met.',
                  boundaryNote:
                      'Ensures future integrations are gated by architecture, compliance, and safety readiness.',
                  supervisionNote:
                      'This is a planning checkpoint only and does not change current gateway behavior.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Growth / Exposure Checkpoints',
              description:
                  'Growth and exposure checkpoints align awareness planning with ethical and safety boundaries.',
              children: [
                _buildCheckpointCard(
                  context,
                  title: 'Awareness before monetization',
                  summary:
                      'If any future exposure exists, supportive awareness should be considered before monetization-oriented placements.',
                  boundaryNote:
                      'Prevents the growth layer from drifting too quickly into commercial behavior.',
                  supervisionNote:
                      'Conceptual priority only. No growth engine or monetization logic exists here.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'No ads in blocked states',
                  summary:
                      'Exposure must remain fully blocked anywhere safety, escalation, or emotional vulnerability rules require it.',
                  boundaryNote:
                      'Keeps monetization and awareness subordinate to safety-state boundaries.',
                  supervisionNote:
                      'This remains a checkpoint without runtime enforcement.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'No targeting by vulnerability',
                  summary:
                      'Future exposure systems must not target distress, fragility, or dependency signals.',
                  boundaryNote:
                      'Prevents exploitative growth or monetization strategies in a mental support environment.',
                  supervisionNote:
                      'This is a conceptual checkpoint only and adds no targeting or analytics capability.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Family-safe placements only',
                  summary:
                      'Any future awareness or promotional placement must remain family-safe and context-appropriate.',
                  boundaryNote:
                      'Protects trust, safety, and product tone across all approved surfaces.',
                  supervisionNote:
                      'This remains blueprint guidance without any live placement system.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Admin Surface Checkpoints',
              description:
                  'Admin checkpoints protect the information architecture already established across the admin experience.',
              children: [
                _buildCheckpointCard(
                  context,
                  title: 'Home = launchpad, not workbench',
                  summary:
                      'Admin home must remain a supervision-first launch surface rather than a crowded operational workspace.',
                  boundaryNote:
                      'Protects clarity and keeps deep operations inside dedicated sections.',
                  supervisionNote:
                      'This is an architectural checkpoint only and does not introduce UI enforcement here.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Control Room = awareness only',
                  summary:
                      'Control Room must remain focused on awareness, health, alerts, and status rather than doing operational work.',
                  boundaryNote:
                      'Prevents awareness surfaces from becoming overloaded with workflow execution.',
                  supervisionNote:
                      'This remains a blueprint reminder, not a runtime UI guard.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Operations / Communications separate from Gateway / Growth',
                  summary:
                      'Business workflows must remain clearly separated from technical gateways and future growth/exposure layers.',
                  boundaryNote:
                      'Protects the modular architecture and keeps responsibilities legible inside admin.',
                  supervisionNote:
                      'This is a conceptual architectural checkpoint only.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Future Activation Checkpoints',
              description:
                  'Activation checkpoints define what must exist before any major system moves from concept into real execution.',
              children: [
                _buildCheckpointCard(
                  context,
                  title: 'Before real integrations',
                  summary:
                      'Explicit approval, safety review, architecture review, and boundary ownership must exist before any live integration is activated.',
                  boundaryNote:
                      'Prevents shell/supervision pages from quietly becoming active systems without readiness gates.',
                  supervisionNote:
                      'This remains a conceptual activation requirement only.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Before monetized placements',
                  summary:
                      'Exposure rules, ethical guardrails, blocked-state handling, and approved-surface controls must be defined first.',
                  boundaryNote:
                      'Ensures monetization can never outrun safety or ethical readiness.',
                  supervisionNote:
                      'No monetization system is activated here.',
                ),
                _buildCheckpointCard(
                  context,
                  title: 'Before channel automation',
                  summary:
                      'Channel automation requires explicit routing rules, supervision ownership, safety controls, and clear separation from human support handling.',
                  boundaryNote:
                      'Protects support quality and prevents unsafe automation creep in communications channels.',
                  supervisionNote:
                      'This is a blueprint checkpoint only with no automation logic added.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
