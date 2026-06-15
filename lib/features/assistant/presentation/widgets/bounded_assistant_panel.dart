import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mental_smile_os/shared/ui_kit/app_design_system.dart';

class BoundedAssistantCommand {
  const BoundedAssistantCommand({
    required this.id,
    required this.labelAr,
    required this.labelEn,
    this.icon,
    this.selected = false,
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final IconData? icon;
  final bool selected;
}

class BoundedAssistantPanel extends StatefulWidget {
  const BoundedAssistantPanel({
    super.key,
    required this.items,
    required this.commands,
    required this.onCommand,
    this.outputText = '',
    this.titleAr = 'المساعد الذكي للأرشيف',
    this.titleEn = 'Archive Assistant',
    this.descriptionAr =
        'مساعد محدود النطاق يعمل فقط على النتائج الحالية داخل هذه الصفحة.',
    this.descriptionEn =
        'Bounded assistant scoped only to the current results on this page.',
    this.inputLabelAr = 'أمر سريع للمساعد',
    this.inputLabelEn = 'Quick assistant command',
    this.inputHintAr = 'اكتب أمرًا محددًا',
    this.inputHintEn = 'Enter a bounded command',
    this.copyLabelAr = 'نسخ المخرج',
    this.copyLabelEn = 'Copy output',
    this.copiedMessageAr = 'تم نسخ المخرج الحالي',
    this.copiedMessageEn = 'Current output copied',
    this.emptyOutputAr = 'لا يوجد مخرج بعد.',
    this.emptyOutputEn = 'No output yet.',
  });

  final List<Map<String, dynamic>> items;
  final List<BoundedAssistantCommand> commands;
  final ValueChanged<String> onCommand;
  final String outputText;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final String inputLabelAr;
  final String inputLabelEn;
  final String inputHintAr;
  final String inputHintEn;
  final String copyLabelAr;
  final String copyLabelEn;
  final String copiedMessageAr;
  final String copiedMessageEn;
  final String emptyOutputAr;
  final String emptyOutputEn;

  @override
  State<BoundedAssistantPanel> createState() => _BoundedAssistantPanelState();
}

class _BoundedAssistantPanelState extends State<BoundedAssistantPanel> {
  final TextEditingController _controller = TextEditingController();

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitText() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onCommand(text);
  }

  Future<void> _copyOutput(BuildContext context) async {
    if (widget.outputText.trim().isEmpty) return;
    final isArabic = _isArabic(context);
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: widget.outputText));
    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          isArabic ? widget.copiedMessageAr : widget.copiedMessageEn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final theme = Theme.of(context);
    final titleStyle =
        theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800);

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFE7F0FF),
                child: Icon(
                  Icons.smart_toy_outlined,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic ? widget.titleAr : widget.titleEn,
                      style: titleStyle,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isArabic ? widget.descriptionAr : widget.descriptionEn,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: widget.commands
                .map(
                  (command) => ChoiceChip(
                    selected: command.selected,
                    avatar: command.icon == null ? null : Icon(command.icon),
                    label: Text(isArabic ? command.labelAr : command.labelEn),
                    onSelected: (_) => widget.onCommand(command.id),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Text(
            isArabic ? widget.inputLabelAr : widget.inputLabelEn,
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            onSubmitted: (_) => _submitText(),
            textInputAction: TextInputAction.send,
            decoration: appInputDecoration(
              context: context,
              label: isArabic ? widget.inputHintAr : widget.inputHintEn,
              icon: Icons.auto_awesome_outlined,
            ).copyWith(
              suffixIcon: IconButton(
                onPressed: _submitText,
                icon: const Icon(Icons.send_outlined),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FA),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.10),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Align(
                  alignment:
                      isArabic ? Alignment.centerRight : Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: widget.outputText.trim().isEmpty
                        ? null
                        : () => _copyOutput(context),
                    icon: const Icon(Icons.copy_all_outlined),
                    label: Text(
                      isArabic ? widget.copyLabelAr : widget.copyLabelEn,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SelectableText(
                  widget.outputText.trim().isEmpty
                      ? (isArabic ? widget.emptyOutputAr : widget.emptyOutputEn)
                      : widget.outputText,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
