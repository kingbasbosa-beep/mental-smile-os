import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminAiDevOpsCenterPage extends StatelessWidget {
  const AdminAiDevOpsCenterPage({super.key});

  static const Color _sectionBackground = Color(0xFF020617);
  static const Color _cardBackground = Color(0xFF0F172A);
  static const Color _secondaryCardBackground = Color(0xFF111827);
  static const Color _primaryText = Colors.white;
  static const Color _secondaryText = Color(0xFFEAEAEA);
  static const Color _goldText = Color(0xFFD8B26A);

  static const List<_AiAssistantItem> _assistants = [
    _AiAssistantItem(
      title: 'ChatGPT Brain / Planning',
      summary:
          'Used for planning, task shaping, review framing, and structured decision support.',
      status: 'Manual / External Tool',
      url: 'https://chatgpt.com/',
    ),
    _AiAssistantItem(
      title: 'ChatGPT Operations',
      summary:
          'Used for operational summaries, workflow guidance, and structured follow-up drafting.',
      status: 'Manual / External Tool',
      url: 'https://chatgpt.com/',
    ),
    _AiAssistantItem(
      title: 'Codex Execution',
      summary:
          'Used for code-task execution, scoped patches, and implementation delivery outside the app.',
      status: 'Manual / External Tool',
      url: 'https://chatgpt.com/codex',
    ),
    _AiAssistantItem(
      title: 'Codex Review / Fix',
      summary:
          'Used for targeted reviews, bug isolation, and controlled fix passes before local validation.',
      status: 'Manual / External Tool',
      url: 'https://chatgpt.com/codex',
    ),
  ];

  static const List<_DevToolItem> _devTools = [
    _DevToolItem(
      title: 'Android Studio',
      summary:
          'Primary local IDE for Android/Flutter project inspection and build validation.',
      url: 'https://developer.android.com/studio',
    ),
    _DevToolItem(
      title: 'Flutter CLI',
      summary:
          'Local command-line entry for run, build, and validation workflows.',
      url: 'https://docs.flutter.dev/reference/flutter-cli',
    ),
    _DevToolItem(
      title: 'Firebase Console',
      summary:
          'Manual operational console for project services, auth, and Firestore visibility.',
      url: 'https://console.firebase.google.com/',
    ),
    _DevToolItem(
      title: 'GitHub Repository',
      summary: 'Repository history, issue context, and code review surface.',
      url: 'https://github.com/',
    ),
    _DevToolItem(
      title: 'Local Project Folder',
      summary:
          'Reference path for manual local inspection and workspace navigation.',
      url: 'file:///C:/mental_smile_workspace/app/mental-smile-app',
    ),
    _DevToolItem(
      title: 'Chrome DevTools',
      summary:
          'Browser diagnostics surface for layout, console, and runtime checks.',
      url: 'https://developer.chrome.com/docs/devtools/',
    ),
  ];

  static const List<_PromptQueueItem> _promptQueue = [
    _PromptQueueItem(
      title: 'Audit admin shell regression',
      targetArea: 'Admin Hub',
      priority: 'High',
      status: 'Queued',
      promptSummary:
          'Review latest Control Room UI changes and isolate any visual or route regressions.',
      expectedReturn:
          'Scoped findings list or minimal patch plan with affected files only.',
      fullPrompt:
          'Review Admin Hub for regressions. Scope: UI/layout/route visibility only. Find visual issues, route dead-ends, or unsafe recent changes. Return the smallest safe patch plan with exact files and risks only.',
    ),
    _PromptQueueItem(
      title: 'Refine content workspace card density',
      targetArea: 'Content Workspace',
      priority: 'Medium',
      status: 'Draft',
      promptSummary:
          'Tighten card readability and visibility for production links without changing workflow meaning.',
      expectedReturn: 'Small layout/styling patch and visual-risk notes.',
      fullPrompt:
          'Refine Content Workspace card density. Scope: UI only. Reduce wasted vertical space, keep links and context buttons visible, and avoid changing workflow meaning. Return exact file changes and the smallest safe patch.',
    ),
    _PromptQueueItem(
      title: 'Review maintenance launcher flow',
      targetArea: 'Maintenance & Diagnostics',
      priority: 'Low',
      status: 'Planned',
      promptSummary:
          'Check launcher discoverability and whether issue surfaces are grouped clearly.',
      expectedReturn:
          'Short recommendation set and smallest safe adjustment if needed.',
      fullPrompt:
          'Review Maintenance & Diagnostics launcher discoverability. Scope: route visibility and section grouping only. Recommend the smallest safe UI adjustment if needed, without adding new backend or automation.',
    ),
  ];

  static const List<_PromptIntakeItem> _promptIntake = [
    _PromptIntakeItem(
      sourceChat: 'Operations Room',
      promptTitle: 'Employee System Chassis v0',
      purpose: 'Prepare staff layer structure',
      targetSystem: 'Admin / Employee System',
      readinessStatus: 'Ready for Codex',
      fullPrompt:
          'Create an Employee System chassis inside Admin/Control Room. Scope: UI only. Add route, page shell, directory/workspaces/task board/review queue/activity log/role boundaries sections. No auth, no persistence, no Firestore, no API, no automation.',
      notes: 'Prepared for Codex execution as a safe static architecture step.',
    ),
    _PromptIntakeItem(
      sourceChat: 'QA Chat',
      promptTitle: 'Fix AI DevOps contrast',
      purpose: 'Improve UI readability',
      targetSystem: 'AI DevOps Center',
      readinessStatus: 'Ready for Codex',
      fullPrompt:
          'Improve text contrast inside AI & DevOps Interaction Center. Scope: styling only. Increase text readability, darken card backgrounds, and preserve the Control Room dark/gold style without changing layout or logic.',
      notes: 'Ready for direct copy into Codex with no backend implications.',
    ),
  ];

  static const List<_ExecutionResultItem> _executionResults = [
    _ExecutionResultItem(
      title: 'Workspace Command Center UI Fix',
      relatedPromptTitle: 'Scroll Fix',
      filesChanged: [
        'admin_workspace_command_center_page.dart',
      ],
      resultSummary: 'Fixed horizontal scroll issue and improved card layout.',
      riskLevel: 'Low',
      qaStatus: 'Pending QA',
      notes: 'Execution Results are manual entries based on Codex outputs.',
    ),
    _ExecutionResultItem(
      title: 'Pending Content Counter Fix',
      relatedPromptTitle: 'Remove Stream',
      filesChanged: [
        'admin_hub_page.dart',
      ],
      resultSummary: 'Replaced Stream with static counter.',
      riskLevel: 'Low',
      qaStatus: 'Approved',
      notes:
          'No backend dependency was introduced and the counter remained clickable.',
    ),
    _ExecutionResultItem(
      title: 'Maintenance Launcher Surface',
      relatedPromptTitle: 'Maintenance Signal',
      filesChanged: [
        'admin_hub_page.dart',
        'admin_maintenance_system_page.dart',
      ],
      resultSummary:
          'Surfaced maintenance access and aligned launcher visibility for diagnostics follow-through.',
      riskLevel: 'Medium',
      qaStatus: 'Needs Fix',
      notes:
          'Verify route visibility and final text polish before marking the handoff complete.',
    ),
  ];

  static const List<String> _qaChecklist = [
    'App builds',
    'Route opens',
    'No crash',
    'No Firestore/rules regression',
    'UI responsive',
    'Rollback possible',
  ];

  Future<void> _openTool(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (launched || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open tool')),
    );
  }

  Future<void> _copyPrompt(BuildContext context, String prompt) async {
    await Clipboard.setData(ClipboardData(text: prompt));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prompt copied')),
    );
  }

  Future<void> _copyText(
    BuildContext context, {
    required String text,
    required String message,
  }) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String summary,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        color: _sectionBackground,
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: _primaryText,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _secondaryText,
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildAssistantCard(BuildContext context, _AiAssistantItem item) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: _secondaryCardBackground,
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: _primaryText,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.summary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _secondaryText,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            item.status,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF73C1B8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: () => _openTool(context, item.url),
            icon: const Icon(Icons.open_in_new, size: 18),
            label: const Text('Open Tool'),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, _DevToolItem item) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: _cardBackground,
      borderColor: const Color(0xFF3E9B90).withValues(alpha: 0.16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: _primaryText,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.summary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _secondaryText,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: () => _openTool(context, item.url),
            icon: const Icon(Icons.open_in_new, size: 18),
            label: const Text('Open Tool'),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptCard(BuildContext context, _PromptQueueItem item) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: _cardBackground,
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: _primaryText,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${item.targetArea} • ${item.priority} • ${item.status}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF73C1B8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.promptSummary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _secondaryText,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(AppRadii.md),
              border: Border.all(
                color: const Color(0xFFD8B26A).withValues(alpha: 0.16),
              ),
            ),
            child: Text(
              item.fullPrompt,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _secondaryText,
                    height: 1.4,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Expected return: ${item.expectedReturn}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _goldText,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilledButton.icon(
                onPressed: () => _copyPrompt(context, item.fullPrompt),
                icon: const Icon(Icons.copy_all_outlined, size: 18),
                label: const Text('Copy Prompt'),
              ),
              OutlinedButton.icon(
                onPressed: () =>
                    _openTool(context, 'https://chatgpt.com/codex'),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('Open Codex'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marked as used (UI only)')),
                  );
                },
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('Mark as Used'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromptIntakeCard(BuildContext context, _PromptIntakeItem item) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: _cardBackground,
      borderColor: const Color(0xFF3E9B90).withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.promptTitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: _primaryText,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${item.sourceChat} • ${item.targetSystem} • ${item.readinessStatus}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF73C1B8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Purpose: ${item.purpose}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _secondaryText,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(AppRadii.md),
              border: Border.all(
                color: const Color(0xFFD8B26A).withValues(alpha: 0.16),
              ),
            ),
            child: Text(
              item.fullPrompt,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _secondaryText,
                    height: 1.4,
                  ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Notes: ${item.notes}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _goldText,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              FilledButton.icon(
                onPressed: () => _copyText(
                  context,
                  text: item.fullPrompt,
                  message: 'Prompt copied',
                ),
                icon: const Icon(Icons.copy_all_outlined, size: 18),
                label: const Text('Copy Prompt'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marked for Prompt Queue')),
                  );
                },
                icon: const Icon(Icons.move_down_outlined, size: 18),
                label: const Text('Move to Prompt Queue'),
              ),
              OutlinedButton.icon(
                onPressed: () =>
                    _openTool(context, 'https://chatgpt.com/codex'),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('Open Codex'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, _ExecutionResultItem item) {
    final riskColor = switch (item.riskLevel) {
      'Low' => const Color(0xFF34D399),
      'Medium' => const Color(0xFFF59E0B),
      'High' => const Color(0xFFEF4444),
      _ => _secondaryText,
    };
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      color: _cardBackground,
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: _primaryText,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Related prompt: ${item.relatedPromptTitle}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF73C1B8),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Files changed: ${item.filesChanged.join(', ')}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _secondaryText,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            item.resultSummary,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _secondaryText,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: riskColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(
                    color: riskColor.withValues(alpha: 0.28),
                  ),
                ),
                child: Text(
                  'Risk: ${item.riskLevel}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: riskColor,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD8B26A).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(
                    color: const Color(0xFFD8B26A).withValues(alpha: 0.22),
                  ),
                ),
                child: Text(
                  'QA: ${item.qaStatus}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _goldText,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Notes: ${item.notes}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _secondaryText,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marked QA passed (UI only)')),
                  );
                },
                icon: const Icon(Icons.verified_outlined, size: 18),
                label: const Text('Mark QA Passed'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Marked needs fix (UI only)')),
                  );
                },
                icon: const Icon(Icons.build_circle_outlined, size: 18),
                label: const Text('Needs Fix'),
              ),
              FilledButton.icon(
                onPressed: () => _copyText(
                  context,
                  text:
                      '${item.title}\nRelated prompt: ${item.relatedPromptTitle}\nFiles changed: ${item.filesChanged.join(', ')}\nSummary: ${item.resultSummary}\nRisk: ${item.riskLevel}\nQA: ${item.qaStatus}\nNotes: ${item.notes}',
                  message: 'Summary copied',
                ),
                icon: const Icon(Icons.copy_all_outlined, size: 18),
                label: const Text('Copy Summary'),
              ),
            ],
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
        title: 'AI & DevOps Interaction Center',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            AppSectionPanel(
              padding: const EdgeInsets.all(AppSpacing.lg),
              color: _sectionBackground,
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI & DevOps Interaction Center',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: _primaryText,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'This surface coordinates AI-assisted planning, code execution handoff, local validation, and QA review manually without automation or direct tool integration.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _secondaryText,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildSection(
              context,
              title: 'AI Assistants',
              summary:
                  'Manual assistant roles for planning, execution, and review coordination only.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: _assistants
                      .map(
                        (item) => SizedBox(
                          width: 320,
                          child: _buildAssistantCard(context, item),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'Development Tools',
              summary:
                  'Manual reference tools for implementation, validation, repository review, and diagnostics.',
              children: [
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: _devTools
                      .map(
                        (item) => SizedBox(
                          width: 320,
                          child: _buildToolCard(context, item),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            _buildSection(
              context,
              title: 'ChatGPT Prompt Intake',
              summary:
                  'Prompt Intake is manual. It does not send prompts automatically.',
              children: _promptIntake
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _buildPromptIntakeCard(context, item),
                    ),
                  )
                  .toList(),
            ),
            _buildSection(
              context,
              title: 'Prompt Queue',
              summary:
                  'Static placeholder queue for prompts prepared for Codex execution.',
              children: _promptQueue
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _buildPromptCard(context, item),
                    ),
                  )
                  .toList(),
            ),
            _buildSection(
              context,
              title: 'Execution Results',
              summary:
                  'Execution Results are manual entries based on Codex outputs.',
              children: _executionResults
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _buildResultCard(context, item),
                    ),
                  )
                  .toList(),
            ),
            _buildSection(
              context,
              title: 'QA / Validation Checklist',
              summary:
                  'Manual checklist for validating changes after AI-assisted execution.',
              children: _qaChecklist
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.check_circle_outline,
                              size: 18,
                              color: _goldText,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              item,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: _secondaryText,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            _buildSection(
              context,
              title: 'Boundaries',
              summary:
                  'Architectural guidance for how admin, AI assistants, local tools, and QA should interact.',
              children: [
                Text(
                  'Admin creates and approves prompts. ChatGPT supports planning and review. Codex executes code tasks externally. Android Studio and Flutter validate locally. No direct autonomous code modification is initiated from this app.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _secondaryText,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AiAssistantItem {
  final String title;
  final String summary;
  final String status;
  final String url;

  const _AiAssistantItem({
    required this.title,
    required this.summary,
    required this.status,
    required this.url,
  });
}

class _DevToolItem {
  final String title;
  final String summary;
  final String url;

  const _DevToolItem({
    required this.title,
    required this.summary,
    required this.url,
  });
}

class _PromptQueueItem {
  final String title;
  final String targetArea;
  final String priority;
  final String status;
  final String promptSummary;
  final String expectedReturn;
  final String fullPrompt;

  const _PromptQueueItem({
    required this.title,
    required this.targetArea,
    required this.priority,
    required this.status,
    required this.promptSummary,
    required this.expectedReturn,
    required this.fullPrompt,
  });
}

class _PromptIntakeItem {
  final String sourceChat;
  final String promptTitle;
  final String purpose;
  final String targetSystem;
  final String readinessStatus;
  final String fullPrompt;
  final String notes;

  const _PromptIntakeItem({
    required this.sourceChat,
    required this.promptTitle,
    required this.purpose,
    required this.targetSystem,
    required this.readinessStatus,
    required this.fullPrompt,
    required this.notes,
  });
}

class _ExecutionResultItem {
  final String title;
  final String relatedPromptTitle;
  final List<String> filesChanged;
  final String resultSummary;
  final String riskLevel;
  final String qaStatus;
  final String notes;

  const _ExecutionResultItem({
    required this.title,
    required this.relatedPromptTitle,
    required this.filesChanged,
    required this.resultSummary,
    required this.riskLevel,
    required this.qaStatus,
    required this.notes,
  });
}
