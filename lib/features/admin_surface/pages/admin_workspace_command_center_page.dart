import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminWorkspaceCommandCenterPage extends StatefulWidget {
  const AdminWorkspaceCommandCenterPage({
    super.key,
    this.standaloneMode = false,
  });

  final bool standaloneMode;

  @override
  State<AdminWorkspaceCommandCenterPage> createState() =>
      _AdminWorkspaceCommandCenterPageState();
}

class _AdminWorkspaceCommandCenterPageState
    extends State<AdminWorkspaceCommandCenterPage> {
  static const String _canvaUrl = 'https://www.canva.com/';
  static const String _capCutUrl = 'https://www.capcut.com/';
  static const String _whatsAppBusinessUrl = 'https://business.whatsapp.com/';
  static const String _metaBusinessSuiteUrl =
      'https://business.facebook.com/latest/home';
  static const String _googleDriveUrl = 'https://drive.google.com/';
  static const String _voiceToolUrl = 'https://elevenlabs.io/';

  final List<_WorkspaceTool> _tools = const [
    _WorkspaceTool(
      title: 'Canva',
      description: 'Design posts, thumbnails, story frames, and reusable brand kits.',
      url: _canvaUrl,
    ),
    _WorkspaceTool(
      title: 'CapCut',
      description: 'Edit reels, short clips, captions, and visual timing passes.',
      url: _capCutUrl,
    ),
    _WorkspaceTool(
      title: 'WhatsApp Business',
      description: 'Manual review handoff and outbound coordination with no automation.',
      url: _whatsAppBusinessUrl,
    ),
    _WorkspaceTool(
      title: 'Meta Business Suite',
      description: 'Manual publishing destination and post-link follow-up surface.',
      url: _metaBusinessSuiteUrl,
    ),
    _WorkspaceTool(
      title: 'Google Drive / Assets',
      description: 'Open asset folders, drafts, references, and upload-ready bundles.',
      url: _googleDriveUrl,
    ),
  ];

  final List<String> _boardColumns = const [
    'Ideas',
    'Script Ready',
    'Design Needed',
    'Video Editing',
    'Ready to Publish',
    'Published',
    'Needs Review',
  ];

  ScrollController? _pageScrollController = ScrollController();

  final List<_ContentCardData> _contentItems = const [
    _ContentCardData(
      title: 'Family recovery myth-buster carousel',
      type: 'Post',
      purpose: 'Awareness',
      target: 'Families',
      platform: 'Instagram',
      status: 'Ideas',
      cta: 'Save and share',
      assets: 'Research notes, brand template, icon pack',
      owner: 'Content Lead',
      templateLink: 'https://www.canva.com/',
      workingFileLink: '',
      assetsFolderLink: 'https://drive.google.com/',
      exportLink: '',
      publishLink: '',
      caption: 'A carousel draft focused on clearing common recovery myths for families.',
      script: 'Slide 1 hook, Slide 2 myth, Slide 3 correction, Slide 4 CTA.',
    ),
    _ContentCardData(
      title: 'Support intake explainer reel',
      type: 'Reel',
      purpose: 'Education',
      target: 'New visitors',
      platform: 'Instagram Reels',
      status: 'Script Ready',
      cta: 'Message the team',
      assets: 'Script notes, intro frame, brand audio bed',
      owner: 'Growth Editor',
      templateLink: '',
      workingFileLink: 'https://www.capcut.com/',
      assetsFolderLink: 'https://drive.google.com/',
      exportLink: '',
      publishLink: '',
      caption: 'Short reel explaining how Mental Smile support intake works.',
      script: 'Hook, 3-step intake explanation, reassurance close, CTA.',
    ),
    _ContentCardData(
      title: 'Clinician partnership visual pack',
      type: 'Post',
      purpose: 'Partnership awareness',
      target: 'Clinicians',
      platform: 'LinkedIn',
      status: 'Design Needed',
      cta: 'Start a conversation',
      assets: 'Draft copy, logo files, partner testimonials',
      owner: 'Brand Designer',
      templateLink: 'https://www.canva.com/',
      workingFileLink: 'https://www.canva.com/',
      assetsFolderLink: 'https://drive.google.com/',
      exportLink: '',
      publishLink: '',
      caption: 'Partnership post highlighting supervised collaboration pathways.',
      script: 'Static visual pack only.',
    ),
    _ContentCardData(
      title: 'Before-first-session reassurance reel',
      type: 'Reel',
      purpose: 'Trust building',
      target: 'Clients',
      platform: 'TikTok',
      status: 'Video Editing',
      cta: 'Visit the support page',
      assets: 'Voice take, timeline rough cut, subtitles',
      owner: 'Video Editor',
      templateLink: '',
      workingFileLink: 'https://www.capcut.com/',
      assetsFolderLink: 'https://drive.google.com/',
      exportLink: 'https://drive.google.com/',
      publishLink: '',
      caption: 'Reassurance reel for what happens before a first session.',
      script: 'Narration-led sequence with calm motion and end CTA.',
    ),
    _ContentCardData(
      title: 'Support channel comparison card',
      type: 'Post',
      purpose: 'Operational clarity',
      target: 'Support seekers',
      platform: 'Facebook',
      status: 'Ready to Publish',
      cta: 'Choose the right entry point',
      assets: 'Approved graphic, final caption, export set',
      owner: 'Operations Marketing',
      templateLink: 'https://www.canva.com/',
      workingFileLink: 'https://www.canva.com/',
      assetsFolderLink: 'https://drive.google.com/',
      exportLink: 'https://drive.google.com/',
      publishLink: '',
      caption: 'Static post clarifying support email vs chat vs guided intake.',
      script: 'Approved caption with action summary.',
    ),
    _ContentCardData(
      title: 'Weekly hope note reel',
      type: 'Reel',
      purpose: 'Retention',
      target: 'Community',
      platform: 'Instagram Reels',
      status: 'Published',
      cta: 'Follow for updates',
      assets: 'Final MP4, subtitle file, thumbnail',
      owner: 'Growth Editor',
      templateLink: '',
      workingFileLink: 'https://www.capcut.com/',
      assetsFolderLink: 'https://drive.google.com/',
      exportLink: 'https://drive.google.com/',
      publishLink: 'https://www.instagram.com/',
      caption: 'Published reel already live and ready for metrics follow-up.',
      script: 'Published content summary.',
    ),
    _ContentCardData(
      title: 'Community FAQ answer pack',
      type: 'Post',
      purpose: 'Review',
      target: 'General audience',
      platform: 'Instagram',
      status: 'Needs Review',
      cta: 'Review factual clarity',
      assets: 'Drive folder, draft copy, source notes',
      owner: 'QA Reviewer',
      templateLink: '',
      workingFileLink: '',
      assetsFolderLink: 'https://drive.google.com/',
      exportLink: '',
      publishLink: '',
      caption: 'FAQ pack waiting on final supervision review.',
      script: 'Review notes needed before moving forward.',
    ),
  ];

  Future<void> _openExternalLink(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!mounted) return;
    if (ok) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Unable to open $url'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _copyText(String text, String message) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _showTextDialog({
    required String title,
    required String text,
    String copyLabel = 'Copy',
  }) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: SelectableText(text),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: text));
                if (!dialogContext.mounted) return;
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  const SnackBar(
                    content: Text('Copied'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Text(copyLabel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _buildManualDialogText(
    _ContentCardData item, {
    required String title,
    required String instruction,
  }) {
    return '$title\n\n'
        'Content: ${item.title}\n'
        'Type: ${item.type}\n'
        'Platform: ${item.platform}\n'
        'Status: ${item.status}\n\n'
        '$instruction\n\n'
        'Manual only. No publishing automation or backend write is active.';
  }

  List<Widget> _buildContextButtons(_ContentCardData item) {
    final buttons = <Widget>[];

    if (item.type == 'Post') {
      buttons.addAll([
        _buildContextButton(
          label: 'Open Canva',
          icon: Icons.palette_outlined,
          onPressed: () => _openExternalLink(_canvaUrl),
        ),
        _buildContextButton(
          label: 'Copy Caption',
          icon: Icons.copy_all_outlined,
          onPressed: () => _copyText(item.caption, 'Caption copied'),
        ),
        _buildContextButton(
          label: 'Open Meta',
          icon: Icons.open_in_new,
          onPressed: () => _openExternalLink(_metaBusinessSuiteUrl),
        ),
        _buildContextButton(
          label: 'Add Publish Link',
          icon: Icons.link_outlined,
          onPressed: () => _showTextDialog(
            title: 'Add Publish Link',
            text: _buildManualDialogText(
              item,
              title: 'Publish Link Placeholder',
              instruction:
                  'Paste the live publish URL here manually after posting.',
            ),
          ),
        ),
      ]);
    }

    if (item.type == 'Reel') {
      buttons.addAll([
        _buildContextButton(
          label: 'Open Script',
          icon: Icons.description_outlined,
          onPressed: () => _showTextDialog(
            title: 'Reel Script',
            text: item.script,
          ),
        ),
        _buildContextButton(
          label: 'Open CapCut',
          icon: Icons.movie_creation_outlined,
          onPressed: () => _openExternalLink(_capCutUrl),
        ),
        _buildContextButton(
          label: 'Open Voice Tool',
          icon: Icons.mic_none_outlined,
          onPressed: () => _openExternalLink(_voiceToolUrl),
        ),
        _buildContextButton(
          label: 'Open Meta',
          icon: Icons.open_in_new,
          onPressed: () => _openExternalLink(_metaBusinessSuiteUrl),
        ),
        _buildContextButton(
          label: 'Add Publish Link',
          icon: Icons.link_outlined,
          onPressed: () => _showTextDialog(
            title: 'Add Publish Link',
            text: _buildManualDialogText(
              item,
              title: 'Publish Link Placeholder',
              instruction:
                  'Paste the live publish URL here manually after posting.',
            ),
          ),
        ),
      ]);
    }

    if (item.status == 'Published') {
      buttons.addAll([
        _buildContextButton(
          label: 'Open Post Link',
          icon: Icons.public_outlined,
          onPressed: item.publishLink.trim().isEmpty
              ? null
              : () => _openExternalLink(item.publishLink),
        ),
        _buildContextButton(
          label: 'Add Metrics',
          icon: Icons.bar_chart_outlined,
          onPressed: () => _showTextDialog(
            title: 'Metrics Placeholder',
            text: _buildManualDialogText(
              item,
              title: 'Metrics Follow-up',
              instruction:
                  'Manual metrics note: reach, saves, comments, CTR, and reuse potential.',
            ),
          ),
        ),
        _buildContextButton(
          label: 'Mark as Reuse Candidate',
          icon: Icons.bookmark_add_outlined,
          onPressed: () => _copyText(
            'Reuse candidate: ${item.title}',
            'Reuse marker copied',
          ),
        ),
      ]);
    }

    if (item.status == 'Needs Review') {
      buttons.addAll([
        _buildContextButton(
          label: 'Open Assets',
          icon: Icons.folder_open_outlined,
          onPressed: () => _openExternalLink(_googleDriveUrl),
        ),
        _buildContextButton(
          label: 'Add Notes',
          icon: Icons.note_add_outlined,
          onPressed: () => _showTextDialog(
            title: 'Review Notes',
            text: _buildManualDialogText(
              item,
              title: 'Review Notes Placeholder',
              instruction:
                  'Manual notes: clarify facts, tighten copy, and confirm asset readiness.',
            ),
          ),
        ),
        _buildContextButton(
          label: 'Send to Review',
          icon: Icons.forward_to_inbox_outlined,
          onPressed: () => _showTextDialog(
            title: 'Send to Review',
            text: _buildManualDialogText(
              item,
              title: 'Review Handoff',
              instruction:
                  'Send this card to reviewer manually using your preferred channel.',
            ),
          ),
        ),
      ]);
    }

    return buttons;
  }

  Widget _buildContextButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }

  Widget _buildToolCard(_WorkspaceTool tool) {
    return SizedBox(
      width: 240,
      child: AppSectionPanel(
        color: const Color(0xFF0B1014).withValues(alpha: 0.92),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tool.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFC9A75B),
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              tool.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: () => _openExternalLink(tool.url),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('Open workspace'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandaloneLauncherCard() {
    return AppSectionPanel(
      color: const Color(0xFF0B1014).withValues(alpha: 0.92),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Open Standalone Content Workspace',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFC9A75B),
                      ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Future-ready isolated surface for content staff with no admin controls.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.contentWorkspace),
            icon: const Icon(Icons.open_in_new, size: 18),
            label: const Text('Open'),
          ),
        ],
      ),
    );
  }

  bool _isDefaultExpandedStatus(String status) {
    return status == 'Ideas' ||
        status == 'Script Ready' ||
        status == 'Design Needed';
  }

  String _sectionHelperLabel(String status) {
    switch (status) {
      case 'Ideas':
        return 'Concept backlog';
      case 'Script Ready':
        return 'Writing ready';
      case 'Design Needed':
        return 'Needs visual build';
      case 'Video Editing':
        return 'Editing lane';
      case 'Ready to Publish':
        return 'Queued manually';
      case 'Published':
        return 'Live tracking';
      case 'Needs Review':
        return 'Review queue';
      default:
        return 'Manual lane';
    }
  }

  Widget _buildBoardSection(String status) {
    final items = _contentItems.where((item) => item.status == status).toList();
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSurfaceCard(
        color: const Color(0xFF0B1014).withValues(alpha: 0.92),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            initiallyExpanded: _isDefaultExpandedStatus(status),
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            iconColor: const Color(0xFFC9A75B),
            collapsedIconColor: const Color(0xFFC9A75B),
            title: Text(
              '$status (${items.length})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFC9A75B),
                  ),
            ),
            subtitle: Text(
              _sectionHelperLabel(status),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                  ),
            ),
            children: [
              const SizedBox(height: AppSpacing.sm),
              if (items.isEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'No items in this section.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                        ),
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final cardWidth = width >= 1200
                        ? (width - AppSpacing.md * 2) / 3
                        : width >= 760
                            ? (width - AppSpacing.md) / 2
                            : width;
                    return Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      children: items
                          .map(
                            (item) => SizedBox(
                              width: cardWidth,
                              child: _buildContentCard(item),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentCard(_ContentCardData item) {
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
              item.title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFF1E5C8),
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _detailLine('Type', item.type),
            _detailLine('Purpose', item.purpose),
            _detailLine('Target', item.target),
            _detailLine('Platform', item.platform),
            _detailLine('Status', item.status),
            _detailLine('CTA', item.cta),
            _detailLine('Assets', item.assets),
            _detailLine('Owner', item.owner),
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                iconColor: const Color(0xFFC9A75B),
                collapsedIconColor: const Color(0xFFC9A75B),
                title: Text(
                  'Production Links',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFC9A75B),
                        fontWeight: FontWeight.w700,
                      ),
                ),
                subtitle: Text(
                  'Template, working file, assets, export, publish',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                      ),
                ),
                children: [
                  _buildLinkField('Template link', item.templateLink),
                  _buildLinkField('Working file link', item.workingFileLink),
                  _buildLinkField('Assets folder link', item.assetsFolderLink),
                  _buildLinkField('Export link', item.exportLink),
                  _buildLinkField('Publish link', item.publishLink),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _buildContextButtons(item),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF314A5C).withValues(alpha: 0.88),
              height: 1.35,
            ),
      ),
    );
  }

  Widget _buildLinkField(String label, String url) {
    final hasLink = url.trim().isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '$label: ${hasLink ? url : 'Not added yet'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                    height: 1.35,
                  ),
            ),
          ),
          if (hasLink) ...[
            const SizedBox(width: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => _openExternalLink(url),
              child: const Text('Open'),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollbarTheme = ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        const Color(0xFFD9DDE2).withValues(alpha: 0.92),
      ),
      trackColor: WidgetStateProperty.all(
        const Color(0xFF6B7280).withValues(alpha: 0.28),
      ),
      trackBorderColor: WidgetStateProperty.all(
        Colors.transparent,
      ),
      thickness: WidgetStateProperty.all(10),
      radius: const Radius.circular(999),
      thumbVisibility: WidgetStateProperty.all(true),
      trackVisibility: WidgetStateProperty.all(true),
    );

    return Theme(
      data: Theme.of(context).copyWith(
        scrollbarTheme: scrollbarTheme,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1316),
        appBar: AppShellActions.buildAppBar(
          context,
          title: 'Workspace Command Center',
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
          child: Scrollbar(
            controller: _pageScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: ListView(
              controller: _pageScrollController,
              primary: false,
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                const GatewayPageIntroCard(
                  title: 'Workspace Command Center',
                  summary:
                      'Operational launcher and content tracking surface for marketing and content workspaces, with no publishing automation and no external API control.',
                  boundaryNote:
                      'This page organizes manual workspace access, content board visibility, and action context only.',
                  emphasis:
                      'All actions remain manual. No Firestore migration, no publishing automation, and no external API integration are active here.',
                ),
                if (widget.standaloneMode) ...[
                  const SizedBox(height: AppSpacing.md),
                  AppSectionPanel(
                    color: const Color(0xFF0B1014).withValues(alpha: 0.92),
                    borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Content Workspace',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFFC9A75B),
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Operational content surface — no admin controls',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF314A5C)
                                        .withValues(alpha: 0.88),
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: AppSpacing.md),
                  _buildStandaloneLauncherCard(),
                ],
                const SizedBox(height: AppSpacing.md),
                GatewaySectionCard(
                  title: 'Workspace Tools',
                  description:
                      'Open the external workspaces used by the content team without adding integration or automation.',
                  children: [
                    Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      children: _tools.map(_buildToolCard).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                GatewaySectionCard(
                  title: 'Content Board',
                  description:
                      'Manual board view for ideas, production state, publishing readiness, and review flow.',
                  children: _boardColumns.map(_buildBoardSection).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkspaceTool {
  const _WorkspaceTool({
    required this.title,
    required this.description,
    required this.url,
  });

  final String title;
  final String description;
  final String url;
}

class _ContentCardData {
  const _ContentCardData({
    required this.title,
    required this.type,
    required this.purpose,
    required this.target,
    required this.platform,
    required this.status,
    required this.cta,
    required this.assets,
    required this.owner,
    required this.templateLink,
    required this.workingFileLink,
    required this.assetsFolderLink,
    required this.exportLink,
    required this.publishLink,
    required this.caption,
    required this.script,
  });

  final String title;
  final String type;
  final String purpose;
  final String target;
  final String platform;
  final String status;
  final String cta;
  final String assets;
  final String owner;
  final String templateLink;
  final String workingFileLink;
  final String assetsFolderLink;
  final String exportLink;
  final String publishLink;
  final String caption;
  final String script;
}
