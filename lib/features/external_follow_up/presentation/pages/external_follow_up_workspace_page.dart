import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_campaign.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_message_template.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_registry_entry.dart';
import 'package:flutterprojects/features/external_follow_up/data/services/follow_up_campaign_service.dart';
import 'package:flutterprojects/features/external_follow_up/data/services/follow_up_message_template_service.dart';
import 'package:flutterprojects/features/external_follow_up/data/services/follow_up_registry_service.dart';
import 'package:flutterprojects/features/external_follow_up/domain/follow_up_registry_constants.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class ExternalFollowUpWorkspacePage extends StatefulWidget {
  const ExternalFollowUpWorkspacePage({super.key});

  @override
  State<ExternalFollowUpWorkspacePage> createState() =>
      _ExternalFollowUpWorkspacePageState();
}

class _ExternalFollowUpWorkspacePageState
    extends State<ExternalFollowUpWorkspacePage> {
  final _registryService = FollowUpRegistryService();
  final _templateService = FollowUpMessageTemplateService();
  final _campaignService = FollowUpCampaignService();

  final Map<String, String?> _selectedTopics = <String, String?>{};
  final Map<String, String?> _selectedTemplateIds = <String, String?>{};
  final Set<String> _previewRequested = <String>{};
  bool _isCreatingCampaignDraft = false;

  static const List<String> _birthdayTopics = <String>[
    'warm',
    'short',
    'motivational',
    'family',
  ];

  static const List<String> _recoveryTopics = <String>[
    'encouragement',
    'relapse_prevention',
    'celebration',
    'safety_reminder',
  ];

  static const List<String> _supportTopics = <String>[
    'reassurance',
    'motivation',
    'not_alone',
    'stress_support',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('قسم المتابعة الخارجية'),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.followUpTemplates,
                    );
                  },
                  child: const Text('قوالب الرسائل'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.followUpCampaigns,
                    );
                  },
                  child: const Text('الحملات'),
                ),
              ),
            ],
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'أعياد الميلاد'),
                Tab(text: 'التعافي'),
                Tab(text: 'الدعم'),
                Tab(text: 'التوعية'),
              ],
            ),
          ),
          body: AppPageBackground(
            child: StreamBuilder<List<FollowUpRegistryEntry>>(
              stream: _registryService.streamEntries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Text(
                        'Unable to load follow-up registry.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final entries =
                    snapshot.data ?? const <FollowUpRegistryEntry>[];

                return TabBarView(
                  children: [
                    _buildPreviewTab(
                      category: FollowUpRegistryType.birthday,
                      entries: _entriesForType(
                        entries,
                        FollowUpRegistryType.birthday,
                      ),
                    ),
                    _buildPreviewTab(
                      category: FollowUpRegistryType.recoverySupport,
                      entries: _entriesForType(
                        entries,
                        FollowUpRegistryType.recoverySupport,
                      ),
                    ),
                    _buildPreviewTab(
                      category: FollowUpRegistryType.generalSupport,
                      entries: _entriesForType(
                        entries,
                        FollowUpRegistryType.generalSupport,
                      ),
                    ),
                    _buildEducationalTab(
                      entries: _entriesForType(
                        entries,
                        FollowUpRegistryType.educationalAwareness,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewTab({
    required String category,
    required List<FollowUpRegistryEntry> entries,
  }) {
    final selectedTopic = _selectedTopics[category];
    final selectedTemplateId = _selectedTemplateIds[category];
    final previewRequested = _previewRequested.contains(category);

    return StreamBuilder<List<FollowUpMessageTemplate>>(
      stream: selectedTopic == null
          ? null
          : _templateService.streamActiveTemplates(),
      builder: (context, snapshot) {
        final templates = (snapshot.data ?? const <FollowUpMessageTemplate>[])
            .where(
              (template) =>
                  template.category == category &&
                  template.topic == selectedTopic,
            )
            .toList();

        FollowUpMessageTemplate? selectedTemplate;
        for (final template in templates) {
          if (template.id == selectedTemplateId) {
            selectedTemplate = template;
            break;
          }
        }

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _PreviewComposerCard(
              category: category,
              topics: _topicsForCategory(category),
              selectedTopic: selectedTopic,
              selectedTemplateId: selectedTemplateId,
              templates: templates,
              templatesLoading: selectedTopic != null &&
                  snapshot.connectionState == ConnectionState.waiting,
              templatesError: snapshot.hasError,
              previewRequested: previewRequested,
              isCreatingCampaignDraft: _isCreatingCampaignDraft,
              onTopicChanged: (value) {
                setState(() {
                  _selectedTopics[category] = value;
                  _selectedTemplateIds[category] = null;
                  _previewRequested.remove(category);
                });
              },
              onTemplateChanged: (value) {
                setState(() {
                  _selectedTemplateIds[category] = value;
                  _previewRequested.remove(category);
                });
              },
              onPreviewPressed: () {
                setState(() {
                  _previewRequested.add(category);
                });
              },
              onPrepareCampaignPressed: (preview) async {
                if (_isCreatingCampaignDraft) return;

                final messenger = ScaffoldMessenger.of(context);
                final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
                final resolvedTemplate = templates
                    .where((template) => template.id == selectedTemplateId)
                    .cast<FollowUpMessageTemplate?>()
                    .firstWhere((template) => template != null,
                        orElse: () => null);

                if (selectedTopic == null ||
                    resolvedTemplate == null ||
                    preview == null ||
                    preview.totalCount <= 0) {
                  return;
                }

                try {
                  setState(() {
                    _isCreatingCampaignDraft = true;
                  });

                  await _campaignService.createDraftCampaign(
                    FollowUpCampaign(
                      id: '',
                      category: category,
                      topic: selectedTopic,
                      templateId: resolvedTemplate.id,
                      message: preview.templatePreview,
                      recipientCount: preview.totalCount,
                      recipientSample: preview.firstRecipients,
                      status: FollowUpCampaignService.draftStatus,
                      createdAt: null,
                      createdByUid: uid,
                    ),
                  );

                  if (!mounted) return;
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('تم تجهيز الحملة'),
                    ),
                  );
                } catch (error) {
                  if (!mounted) return;
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('تعذر تجهيز الحملة: $error'),
                    ),
                  );
                } finally {
                  if (mounted) {
                    setState(() {
                      _isCreatingCampaignDraft = false;
                    });
                  }
                }
              },
              preview: _buildPreviewData(
                entries: entries,
                selectedTopic: selectedTopic,
                selectedTemplate: selectedTemplate,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (entries.isEmpty)
              const _EmptyTabState(
                text: 'لا يوجد مستخدمون في هذه الفئة',
              )
            else
              ...entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _EntryCard(entry: entry),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildEducationalTab({
    required List<FollowUpRegistryEntry> entries,
  }) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _EducationalTabHeader(
          onAddContent: _showEducationalContentDialog,
        ),
        const SizedBox(height: AppSpacing.lg),
        if (entries.isEmpty)
          const _EmptyTabState(
            text: 'لا يوجد مستخدمون في هذه الفئة',
          )
        else
          ...entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _EntryCard(entry: entry),
            ),
          ),
      ],
    );
  }

  _PreviewData? _buildPreviewData({
    required List<FollowUpRegistryEntry> entries,
    required String? selectedTopic,
    required FollowUpMessageTemplate? selectedTemplate,
  }) {
    if (selectedTopic == null || selectedTemplate == null) {
      return null;
    }

    final activeEntries = entries
        .where((entry) => entry.status == FollowUpRegistryStatus.active)
        .toList();

    final recipients =
        activeEntries.take(5).map(_previewRecipientLabel).toList();

    return _PreviewData(
      topicLabel: _topicLabel(selectedTemplate.category, selectedTopic),
      templateTitle: selectedTemplate.title,
      totalCount: activeEntries.length,
      firstRecipients: recipients,
      remainingCount: activeEntries.length > recipients.length
          ? activeEntries.length - recipients.length
          : 0,
      templatePreview:
          selectedTemplate.variants[FollowUpMessageTemplateVariant.neutral] ??
              '',
    );
  }

  String _previewRecipientLabel(FollowUpRegistryEntry entry) {
    final displayName = entry.displayName.trim();
    if (displayName.isNotEmpty) return displayName;

    final phone = (entry.phoneNumber ?? '').trim();
    if (phone.isNotEmpty) return phone;

    final email = (entry.email ?? '').trim();
    if (email.isNotEmpty) return email;

    return 'بدون اسم';
  }

  List<FollowUpRegistryEntry> _entriesForType(
    List<FollowUpRegistryEntry> entries,
    String type,
  ) {
    return entries
        .where(
          (entry) =>
              entry.followUpTypes.contains(type) &&
              entry.status == FollowUpRegistryStatus.active,
        )
        .toList();
  }

  List<String> _topicsForCategory(String category) {
    switch (category) {
      case FollowUpRegistryType.birthday:
        return _birthdayTopics;
      case FollowUpRegistryType.recoverySupport:
        return _recoveryTopics;
      case FollowUpRegistryType.generalSupport:
        return _supportTopics;
      default:
        return const <String>[];
    }
  }

  Future<void> _showEducationalContentDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافة محتوى'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('من المكتبة (قريبًا)'),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('رابط خارجي (قريبًا)'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PreviewComposerCard extends StatelessWidget {
  const _PreviewComposerCard({
    required this.category,
    required this.topics,
    required this.selectedTopic,
    required this.selectedTemplateId,
    required this.templates,
    required this.templatesLoading,
    required this.templatesError,
    required this.previewRequested,
    required this.isCreatingCampaignDraft,
    required this.onTopicChanged,
    required this.onTemplateChanged,
    required this.onPreviewPressed,
    required this.onPrepareCampaignPressed,
    required this.preview,
  });

  final String category;
  final List<String> topics;
  final String? selectedTopic;
  final String? selectedTemplateId;
  final List<FollowUpMessageTemplate> templates;
  final bool templatesLoading;
  final bool templatesError;
  final bool previewRequested;
  final bool isCreatingCampaignDraft;
  final ValueChanged<String?> onTopicChanged;
  final ValueChanged<String?> onTemplateChanged;
  final VoidCallback onPreviewPressed;
  final ValueChanged<_PreviewData?> onPrepareCampaignPressed;
  final _PreviewData? preview;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الموضوع',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: topics.map((topic) {
              final selected = selectedTopic == topic;
              return _SelectableTopicTag(
                label: _topicLabel(category, topic),
                selected: selected,
                onTap: () => onTopicChanged(selected ? null : topic),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.md),
          if (selectedTopic == null)
            Text(
              'اختر الموضوع أولًا',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          else ...[
            if (templatesLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (templatesError)
              Text(
                'تعذر تحميل القوالب',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else if (templates.isEmpty)
              Text(
                'لا توجد قوالب لهذا الموضوع',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else
              DropdownButtonFormField<String>(
                value: templates
                        .any((template) => template.id == selectedTemplateId)
                    ? selectedTemplateId
                    : null,
                decoration: appInputDecoration(
                  context: context,
                  label: 'القالب',
                  icon: Icons.description_outlined,
                ),
                items: templates
                    .map(
                      (template) => DropdownMenuItem<String>(
                        value: template.id,
                        child: Text(template.title),
                      ),
                    )
                    .toList(),
                onChanged: onTemplateChanged,
              ),
            const SizedBox(height: AppSpacing.md),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  FilledButton(
                    onPressed:
                        templatesLoading || templatesError || templates.isEmpty
                            ? null
                            : onPreviewPressed,
                    child: const Text('معاينة الإرسال'),
                  ),
                  OutlinedButton(
                    onPressed: !isCreatingCampaignDraft &&
                            preview != null &&
                            preview!.totalCount > 0
                        ? () => onPrepareCampaignPressed(preview)
                        : null,
                    child: Text(
                      isCreatingCampaignDraft
                          ? 'جارٍ التجهيز...'
                          : 'تجهيز الحملة',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _PreviewResultPanel(
              previewRequested: previewRequested,
              hasTopic: selectedTopic != null,
              hasTemplate: selectedTemplateId != null,
              preview: preview,
            ),
          ],
        ],
      ),
    );
  }
}

class _PreviewResultPanel extends StatelessWidget {
  const _PreviewResultPanel({
    required this.previewRequested,
    required this.hasTopic,
    required this.hasTemplate,
    required this.preview,
  });

  final bool previewRequested;
  final bool hasTopic;
  final bool hasTemplate;
  final _PreviewData? preview;

  @override
  Widget build(BuildContext context) {
    if (!previewRequested) {
      return const SizedBox.shrink();
    }

    if (!hasTopic) {
      return Text(
        'اختر الموضوع أولًا',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    if (!hasTemplate) {
      return Text(
        'اختر القالب أولًا',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    if (preview == null || preview!.totalCount == 0) {
      return Text(
        'لا يوجد مستخدمون في هذه الفئة',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معاينة الإرسال',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'الموضوع: ${preview!.topicLabel}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'القالب: ${preview!.templateTitle}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'عدد المستلمين: ${preview!.totalCount}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            preview!.templatePreview,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          ...preview!.firstRecipients.map(
            (recipient) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                '- $recipient',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          if (preview!.remainingCount > 0) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              '+ ${preview!.remainingCount} آخرين',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}

class _EducationalTabHeader extends StatelessWidget {
  const _EducationalTabHeader({
    required this.onAddContent,
  });

  final VoidCallback onAddContent;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Align(
        alignment: Alignment.centerRight,
        child: FilledButton.icon(
          onPressed: onAddContent,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('إضافة محتوى توعوي'),
        ),
      ),
    );
  }
}

class _EmptyTabState extends StatelessWidget {
  const _EmptyTabState({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mark_email_read_outlined,
              size: 42,
              color: AppColors.mist.withValues(alpha: 0.75),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.entry,
  });

  final FollowUpRegistryEntry entry;

  @override
  Widget build(BuildContext context) {
    final displayName = entry.displayName.trim().isEmpty
        ? 'بدون اسم'
        : entry.displayName.trim();
    final supportFrequency = _supportFrequencyLabel(entry.supportFrequency);
    final recoveryFrequency = _recoveryFrequencyLabel(entry.recoveryFrequency);

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ContactSummary(entry: entry),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: entry.followUpTypes
                .map((type) => _TypeTag(label: _followUpTypeLabel(type)))
                .toList(),
          ),
          if (entry.educationalTopics.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: entry.educationalTopics
                  .map(
                    (topic) => _TopicTag(
                      label: _educationalTopicLabel(topic),
                    ),
                  )
                  .toList(),
            ),
          ],
          if (supportFrequency != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              supportFrequency,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mist,
                  ),
            ),
          ],
          if (recoveryFrequency != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              recoveryFrequency,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mist,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  String _followUpTypeLabel(String type) {
    switch (type) {
      case FollowUpRegistryType.birthday:
        return 'عيد ميلاد';
      case FollowUpRegistryType.recoverySupport:
        return 'تعافي';
      case FollowUpRegistryType.generalSupport:
        return 'دعم';
      case FollowUpRegistryType.educationalAwareness:
        return 'توعية';
      default:
        return type;
    }
  }

  String _educationalTopicLabel(String topic) {
    switch (topic) {
      case FollowUpRegistryEducationalTopic.relapsePrevention:
        return 'منع الانتكاس';
      case FollowUpRegistryEducationalTopic.lifeSkills:
        return 'مهارات حياة';
      case FollowUpRegistryEducationalTopic.relaxation:
        return 'تمارين استرخاء';
      case FollowUpRegistryEducationalTopic.familyAwareness:
        return 'وعي أسري';
      case FollowUpRegistryEducationalTopic.addictionUnderstanding:
        return 'فهم الإدمان';
      case FollowUpRegistryEducationalTopic.emotionalRegulation:
        return 'إدارة المشاعر';
      case FollowUpRegistryEducationalTopic.habitBuilding:
        return 'بناء العادات';
      case FollowUpRegistryEducationalTopic.recoverySupport:
        return 'دعم التعافي';
      default:
        return topic;
    }
  }

  String? _supportFrequencyLabel(String? value) {
    switch ((value ?? '').trim()) {
      case FollowUpRegistrySupportFrequency.every3Days:
        return 'كل 3 أيام';
      case FollowUpRegistrySupportFrequency.every7Days:
        return 'كل 7 أيام';
      default:
        return null;
    }
  }

  String? _recoveryFrequencyLabel(String? value) {
    switch ((value ?? '').trim()) {
      case FollowUpRegistryRecoveryFrequency.monthly:
        return 'شهريًا';
      case FollowUpRegistryRecoveryFrequency.quarterly:
        return 'كل 3 شهور';
      default:
        return null;
    }
  }
}

class _ContactSummary extends StatelessWidget {
  const _ContactSummary({
    required this.entry,
  });

  final FollowUpRegistryEntry entry;

  @override
  Widget build(BuildContext context) {
    final phone = (entry.phoneNumber ?? '').trim();
    final email = (entry.email ?? '').trim();
    final items = <Widget>[
      if (phone.isNotEmpty)
        _ContactChip(
          icon: Icons.phone_outlined,
          label: phone,
        ),
      if (email.isNotEmpty)
        _ContactChip(
          icon: Icons.email_outlined,
          label: email,
        ),
    ];

    if (items.isEmpty) {
      return Text(
        'بدون وسيلة تواصل',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: items,
    );
  }
}

class _ContactChip extends StatelessWidget {
  const _ContactChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.deepTeal,
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _TypeTag extends StatelessWidget {
  const _TypeTag({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.deepTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: AppColors.deepTeal.withValues(alpha: 0.12),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.deepTeal,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _TopicTag extends StatelessWidget {
  const _TopicTag({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.mutedGold.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: AppColors.mutedGold.withValues(alpha: 0.16),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.obsidian,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _SelectableTopicTag extends StatelessWidget {
  const _SelectableTopicTag({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.pill),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.deepTeal.withValues(alpha: 0.14)
              : AppColors.deepTeal.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(
            color: selected
                ? AppColors.deepTeal.withValues(alpha: 0.30)
                : AppColors.deepTeal.withValues(alpha: 0.12),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.deepTeal,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class _PreviewData {
  const _PreviewData({
    required this.topicLabel,
    required this.templateTitle,
    required this.totalCount,
    required this.firstRecipients,
    required this.remainingCount,
    required this.templatePreview,
  });

  final String topicLabel;
  final String templateTitle;
  final int totalCount;
  final List<String> firstRecipients;
  final int remainingCount;
  final String templatePreview;
}

String _topicLabel(String category, String topic) {
  switch (category) {
    case FollowUpRegistryType.birthday:
      switch (topic) {
        case 'warm':
          return 'warm';
        case 'short':
          return 'short';
        case 'motivational':
          return 'motivational';
        case 'family':
          return 'family';
      }
    case FollowUpRegistryType.recoverySupport:
      switch (topic) {
        case 'encouragement':
          return 'encouragement';
        case 'relapse_prevention':
          return 'relapse_prevention';
        case 'celebration':
          return 'celebration';
        case 'safety_reminder':
          return 'safety_reminder';
      }
    case FollowUpRegistryType.generalSupport:
      switch (topic) {
        case 'reassurance':
          return 'reassurance';
        case 'motivation':
          return 'motivation';
        case 'not_alone':
          return 'not_alone';
        case 'stress_support':
          return 'stress_support';
      }
    default:
      return topic;
  }
  return topic;
}
