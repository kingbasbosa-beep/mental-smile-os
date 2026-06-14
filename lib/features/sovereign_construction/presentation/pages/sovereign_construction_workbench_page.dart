import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterprojects/features/sovereign_construction/domain/construction_tool_registry.dart';
import 'package:url_launcher/url_launcher.dart';

class SovereignConstructionWorkbenchPage extends StatelessWidget {
  const SovereignConstructionWorkbenchPage({super.key});

  static const _bg = Color(0xFFF7F8FB);
  static const _ink = Color(0xFF172033);
  static const _muted = Color(0xFF667085);
  static const _line = Color(0xFFE1E5EE);

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final direction = isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: direction,
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          title: Text(
            isArabic
                ? 'منضدة البناء السيادي'
                : 'Sovereign Construction Workbench',
          ),
          backgroundColor: Colors.white,
          foregroundColor: _ink,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _Header(isArabic: isArabic),
                    const SizedBox(height: 14),
                    _SafetyBanner(isArabic: isArabic),
                    const SizedBox(height: 18),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final columns = width >= 960 ? 2 : 1;
                        final gap = columns == 2 ? 14.0 : 0.0;
                        final cardWidth =
                            columns == 2 ? (width - gap) / 2 : width;
                        return Wrap(
                          spacing: gap,
                          runSpacing: 14,
                          children: ConstructionToolRegistry.entries
                              .map(
                                (tool) => SizedBox(
                                  width: cardWidth,
                                  child: _ToolCard(
                                    tool: tool,
                                    isArabic: isArabic,
                                  ),
                                ),
                              )
                              .toList(growable: false),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Stamp(text: isArabic ? 'Mental Smile OS' : 'Mental Smile OS'),
          const SizedBox(height: 14),
          Text(
            isArabic
                ? 'مساحة عمل المالك للبناء من داخل النظام'
                : 'Owner workspace for building from inside the OS',
            style: const TextStyle(
              color: SovereignConstructionWorkbenchPage._ink,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'اختصارات وأدوات سيادية للحزم المعتمدة فقط. لا أسرار، لا مفاتيح، لا نشر، ولا تنفيذ غير معتمد.'
                : 'Sovereign shortcuts for approved packages only. No secrets, keys, deployment, or unapproved execution.',
            style: const TextStyle(
              color: SovereignConstructionWorkbenchPage._muted,
              fontSize: 15,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SafetyBanner extends StatelessWidget {
  const _SafetyBanner({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.verified_user_outlined, color: Color(0xFF2E6B57)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isArabic
                  ? 'سطح مؤقت محمي بمسار المالك الحالي. TODO: Replace with Owner claim after authority implementation. لا يتم تخزين أي بيانات اعتماد هنا.'
                  : 'Temporary protected owner surface. TODO: Replace with Owner claim after authority implementation. No credentials are stored here.',
              style: const TextStyle(
                color: Color(0xFF2E6B57),
                fontWeight: FontWeight.w800,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({
    required this.tool,
    required this.isArabic,
  });

  final ConstructionToolEntry tool;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? tool.nameAr : tool.nameEn;
    final subtitle = isArabic ? tool.descriptionAr : tool.descriptionEn;
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(_iconFor(tool.type), color: const Color(0xFF5630A6)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: SovereignConstructionWorkbenchPage._ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tool.nameEn,
                      style: const TextStyle(
                        color: SovereignConstructionWorkbenchPage._muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusChip(label: tool.status),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              color: SovereignConstructionWorkbenchPage._muted,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _MiniLine(label: 'Tool ID', value: tool.id),
          _MiniLine(label: 'Allowed', value: tool.allowedUse),
          _MiniLine(label: 'Forbidden', value: tool.forbiddenUse),
          _MiniLine(label: 'Reference', value: tool.launchValue),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilledButton.icon(
                onPressed: () => _primaryAction(context),
                icon: Icon(_actionIcon()),
                label: Text(_actionLabel()),
              ),
              OutlinedButton.icon(
                onPressed: () => _copy(context, tool.launchValue),
                icon: const Icon(Icons.copy_outlined),
                label: Text(isArabic ? 'نسخ المرجع' : 'Copy reference'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _actionIcon() {
    switch (tool.launchType) {
      case ConstructionLaunchType.externalUrl:
        return Icons.open_in_new_outlined;
      case ConstructionLaunchType.localPath:
      case ConstructionLaunchType.reference:
        return Icons.copy_all_outlined;
    }
  }

  String _actionLabel() {
    switch (tool.launchType) {
      case ConstructionLaunchType.externalUrl:
        return isArabic ? 'فتح' : 'Open';
      case ConstructionLaunchType.localPath:
        return isArabic ? 'نسخ المسار' : 'Copy path';
      case ConstructionLaunchType.reference:
        return isArabic ? 'نسخ التعليمات' : 'Copy instruction';
    }
  }

  Future<void> _primaryAction(BuildContext context) async {
    if (tool.launchType == ConstructionLaunchType.externalUrl &&
        tool.url != null) {
      final uri = Uri.tryParse(tool.url!);
      if (uri != null) {
        final opened = await launchUrl(uri, mode: LaunchMode.platformDefault);
        if (opened) return;
      }
    }

    if (!context.mounted) return;
    await _copy(context, tool.launchValue);
  }

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isArabic ? 'تم النسخ' : 'Copied'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  IconData _iconFor(ConstructionToolType type) {
    switch (type) {
      case ConstructionToolType.strategicWorkspace:
        return Icons.psychology_alt_outlined;
      case ConstructionToolType.constructionWorkspace:
        return Icons.terminal_outlined;
      case ConstructionToolType.verificationWorkspace:
        return Icons.android_outlined;
      case ConstructionToolType.sourceControl:
        return Icons.account_tree_outlined;
      case ConstructionToolType.console:
        return Icons.cloud_outlined;
      case ConstructionToolType.publishing:
        return Icons.rocket_launch_outlined;
      case ConstructionToolType.localWorkspace:
        return Icons.folder_open_outlined;
      case ConstructionToolType.sourceRepository:
        return Icons.source_outlined;
      case ConstructionToolType.packageReference:
        return Icons.inventory_2_outlined;
      case ConstructionToolType.memoryReference:
        return Icons.history_edu_outlined;
    }
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SovereignConstructionWorkbenchPage._line),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    );
  }
}

class _Stamp extends StatelessWidget {
  const _Stamp({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: SovereignConstructionWorkbenchPage._ink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE1D7FF)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5630A6),
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _MiniLine extends StatelessWidget {
  const _MiniLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Color(0xFF40506A),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
      ),
    );
  }
}
