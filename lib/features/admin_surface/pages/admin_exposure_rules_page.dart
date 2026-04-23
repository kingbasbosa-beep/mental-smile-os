import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminExposureRulesPage extends StatelessWidget {
  const AdminExposureRulesPage({super.key});

  Widget _buildRuleCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
    String statusLabel = 'Policy blueprint',
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
        title: 'Ad / Awareness Exposure Rules',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Ad / Awareness Exposure Rules',
              summary:
                  'Supervise when awareness content or monetized promotional content may appear, and when it must be blocked, within a mental support product.',
              boundaryNote:
                  'This page defines policy and exposure boundaries only. It does not activate ad delivery, tracking, or runtime enforcement.',
              emphasis:
                  'Safety, support, and ethical safeguards always take priority over awareness or monetization concepts.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Exposure Eligibility',
              description:
                  'Eligibility rules define where supervised awareness or promotional exposure may even be considered.',
              children: [
                _buildRuleCard(
                  context,
                  title: 'Stable states only',
                  summary:
                      'Exposure may only be considered in stable user states that are not associated with acute distress, crisis, or escalation.',
                  boundaryNote:
                      'Separates safe awareness eligibility from emotionally vulnerable or high-risk support contexts.',
                  supervisionNote:
                      'This remains a blueprint rule only and does not perform runtime state detection.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Family-safe contexts',
                  summary:
                      'Any future awareness or promotional surface must remain appropriate for broad family-safe use.',
                  boundaryNote:
                      'Protects product trust and prevents unsafe or inappropriate exposure in sensitive wellbeing environments.',
                  supervisionNote:
                      'This defines content suitability boundaries without adding moderation or content review workflows.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Approved surfaces only',
                  summary:
                      'Exposure may only appear on surfaces explicitly approved for awareness or limited promotional visibility.',
                  boundaryNote:
                      'Prevents uncontrolled spread into support, clinical, or critical admin contexts.',
                  supervisionNote:
                      'This remains a blueprint approval boundary with no runtime placement activation.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Blocked States',
              description:
                  'Blocked states define where exposure must never appear, regardless of awareness or monetization intent.',
              children: [
                _buildRuleCard(
                  context,
                  title: 'Crisis states',
                  summary:
                      'No awareness or promotional content may appear in any crisis-related state.',
                  boundaryNote:
                      'Safety and intervention contexts must remain free of competing attention or commercial surfaces.',
                  supervisionNote:
                      'This rule exists as policy blueprint only and does not yet enforce runtime blocking.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Self-harm / suicide risk states',
                  summary:
                      'Exposure must be fully suppressed where self-harm or suicide risk is present or suspected.',
                  boundaryNote:
                      'Prevents any monetization or awareness content from intruding on life-safety contexts.',
                  supervisionNote:
                      'This remains conceptual policy guidance, not an active detection or intervention engine.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Vulnerable emotional states',
                  summary:
                      'Exposure must remain blocked where emotional vulnerability could make content coercive, manipulative, or harmful.',
                  boundaryNote:
                      'Separates supportive care from exploitative or poorly timed awareness exposure.',
                  supervisionNote:
                      'This defines a protective policy boundary without activating targeting or inference logic.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Escalation-active sessions',
                  summary:
                      'No awareness or monetized content may appear while escalation is active.',
                  boundaryNote:
                      'Ensures escalation handling remains focused on support and safety only.',
                  supervisionNote:
                      'This remains blueprint logic and does not connect to escalation runtime yet.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Active support intervention contexts',
                  summary:
                      'Any live support intervention surface must remain free of promotional interruption.',
                  boundaryNote:
                      'Protects direct help interactions from awareness or monetization competition.',
                  supervisionNote:
                      'This is a policy constraint only and does not modify Communications behavior.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Allowed Surfaces',
              description:
                  'Allowed surfaces define where limited, supervised exposure could be considered in the future.',
              children: [
                _buildRuleCard(
                  context,
                  title: 'Dashboard placements',
                  summary:
                      'Controlled dashboard placements may be considered where the context is stable and non-intrusive.',
                  boundaryNote:
                      'Only approved placements may carry awareness or promotional content.',
                  supervisionNote:
                      'This is a planning-only allowance with no rendering or delivery logic.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Library surfaces',
                  summary:
                      'Library-adjacent surfaces may host limited awareness content where educational context remains primary.',
                  boundaryNote:
                      'Prevents awareness exposure from overtaking educational or trusted guidance intent.',
                  supervisionNote:
                      'This defines a conceptual surface allowance only.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Limited awareness banners',
                  summary:
                      'Small, time-limited awareness banners may be considered on approved low-risk surfaces.',
                  boundaryNote:
                      'Exposure must remain secondary, controlled, and non-intrusive.',
                  supervisionNote:
                      'This stays at blueprint level and does not enable banners or placement logic.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Controlled temporary spotlight areas',
                  summary:
                      'Temporary spotlight surfaces may be considered only under strict supervisory constraints.',
                  boundaryNote:
                      'Spotlight exposure may never override user wellbeing, support visibility, or safety context.',
                  supervisionNote:
                      'This remains conceptual and does not create any active spotlight system.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Restricted / Disallowed Surfaces',
              description:
                  'Restricted and disallowed surfaces identify places where exposure should never appear.',
              children: [
                _buildRuleCard(
                  context,
                  title: 'Crisis chat',
                  summary:
                      'No awareness or monetized content may appear in crisis-oriented chat contexts.',
                  boundaryNote:
                      'Protects emergency-like support experiences from interruption or distraction.',
                  supervisionNote:
                      'Conceptual restriction only. No runtime chat integration or blocking exists here.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Active escalation threads',
                  summary:
                      'Escalation threads remain fully protected from awareness or promotional exposure.',
                  boundaryNote:
                      'Escalation handling must remain support-first and interruption-free.',
                  supervisionNote:
                      'This stays as a policy blueprint and does not alter escalation flows.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Emergency / safety contexts',
                  summary:
                      'Emergency-like or safety-critical contexts are always excluded from exposure.',
                  boundaryNote:
                      'Safety-related experiences must stay free of commercial or awareness competition.',
                  supervisionNote:
                      'This remains conceptual and adds no safety-state runtime logic.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Intrusive interruption points',
                  summary:
                      'Any placement that interrupts, blocks, or pressures the user is disallowed.',
                  boundaryNote:
                      'Prevents disruption-based monetization or awareness tactics inside a mental support environment.',
                  supervisionNote:
                      'This defines a design-policy boundary only, not an active UI validator.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Priority Logic',
              description:
                  'Priority rules define the order of values whenever awareness and wellbeing could conflict.',
              children: [
                _buildRuleCard(
                  context,
                  title: 'Awareness first, but never over safety',
                  summary:
                      'Awareness may be useful, but it must always remain subordinate to safety and support.',
                  boundaryNote:
                      'Prevents awareness planning from competing with protective care logic.',
                  supervisionNote:
                      'This defines conceptual priority ordering only.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Safety first',
                  summary:
                      'Safety always overrides awareness, visibility, and monetization considerations.',
                  boundaryNote:
                      'Any conflict between exposure and safety resolves in favor of safety.',
                  supervisionNote:
                      'This is a blueprint priority rule without runtime enforcement in this page.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Support first',
                  summary:
                      'Support presence and intervention clarity always take precedence over awareness or promotion.',
                  boundaryNote:
                      'Ensures help-oriented surfaces remain primary and unobstructed.',
                  supervisionNote:
                      'This remains conceptual policy and does not alter existing support workflows.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Monetization never overrides safety/support',
                  summary:
                      'Monetization may never outrank safety, support, or intervention needs.',
                  boundaryNote:
                      'Commercial logic must always defer to care-oriented priorities.',
                  supervisionNote:
                      'This is a policy blueprint only, with no monetization engine or override logic added.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Ethical Guard Rules',
              description:
                  'Ethical guard rules define the outer safety boundary for any future awareness or monetization direction.',
              children: [
                _buildRuleCard(
                  context,
                  title: 'No targeting based on vulnerability',
                  summary:
                      'Exposure may never be targeted using emotional fragility, distress, or dependence signals.',
                  boundaryNote:
                      'Prevents exploitative use of vulnerability in awareness or monetization planning.',
                  supervisionNote:
                      'This defines a firm ethical limit without any tracking or targeting system.',
                ),
                _buildRuleCard(
                  context,
                  title: 'No deceptive urgency',
                  summary:
                      'Promotional or awareness content may not use false urgency, pressure, or misleading scarcity tactics.',
                  boundaryNote:
                      'Protects users from manipulative decision pressure in a sensitive context.',
                  supervisionNote:
                      'This remains conceptual policy guidance only.',
                ),
                _buildRuleCard(
                  context,
                  title: 'No manipulative exposure',
                  summary:
                      'Exposure may never rely on emotional manipulation, coercive framing, or exploitative placement strategy.',
                  boundaryNote:
                      'Separates ethical awareness from manipulative commercial behavior.',
                  supervisionNote:
                      'This does not add ad controls or enforcement systems; it remains blueprint supervision only.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Family-safe only',
                  summary:
                      'Any future awareness or promotional content must remain suitable for family-safe contexts.',
                  boundaryNote:
                      'Maintains product trust and appropriateness across broad user contexts.',
                  supervisionNote:
                      'This is a conceptual content-safety boundary only.',
                ),
                _buildRuleCard(
                  context,
                  title: 'Time-limited, non-intrusive exposure',
                  summary:
                      'If exposure ever appears, it must be restrained, time-limited, and clearly secondary to user wellbeing.',
                  boundaryNote:
                      'Prevents persistent, aggressive, or overwhelming promotional presence.',
                  supervisionNote:
                      'This remains planning guidance without timers, rendering, or delivery controls.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
