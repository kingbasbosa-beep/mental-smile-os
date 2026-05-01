import 'package:flutter/material.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_message_template.dart';
import 'package:flutterprojects/features/external_follow_up/data/services/follow_up_message_template_service.dart';
import 'package:flutterprojects/features/external_follow_up/domain/follow_up_registry_constants.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class FollowUpTemplatesPage extends StatefulWidget {
  const FollowUpTemplatesPage({super.key});

  @override
  State<FollowUpTemplatesPage> createState() => _FollowUpTemplatesPageState();
}

class _FollowUpTemplatesPageState extends State<FollowUpTemplatesPage> {
  final _service = FollowUpMessageTemplateService();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('قوالب الرسائل'),
        ),
        body: AppPageBackground(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: _openCreateTemplateDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('إضافة قالب'),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: StreamBuilder<List<FollowUpMessageTemplate>>(
                    stream: _service.streamActiveTemplates(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'تعذر تحميل القوالب',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      }

                      final templates =
                          snapshot.data ?? const <FollowUpMessageTemplate>[];

                      if (templates.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد قوالب مسجلة حتى الآن',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: templates.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final template = templates[index];
                          final neutralPreview =
                              (template.variants[FollowUpMessageTemplateVariant.neutral] ??
                                      '')
                                  .trim();

                          return AppSurfaceCard(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  template.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Wrap(
                                  spacing: AppSpacing.xs,
                                  runSpacing: AppSpacing.xs,
                                  children: [
                                    _TemplateMetaTag(
                                      label: _categoryLabel(template.category),
                                    ),
                                    _TemplateMetaTag(
                                      label: _topicLabel(
                                        template.category,
                                        template.topic,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  _previewText(neutralPreview),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openCreateTemplateDialog() async {
    final messenger = ScaffoldMessenger.of(context);
    final formKey = GlobalKey<FormState>();
    String? selectedCategory;
    String? selectedTopic;
    String? selectedMessage;
    bool submitting = false;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final topicOptions = _topicsForCategory(selectedCategory);
            final messageOptions = _messageOptionsFor(
              selectedCategory,
              selectedTopic,
            );

            if (selectedTopic != null && !topicOptions.contains(selectedTopic)) {
              selectedTopic = null;
            }
            if (selectedMessage != null &&
                !messageOptions.contains(selectedMessage)) {
              selectedMessage = null;
            }

            Future<void> submit() async {
              if (submitting) return;
              if (formKey.currentState?.validate() != true) return;
              if (selectedCategory == null ||
                  selectedTopic == null ||
                  selectedMessage == null) {
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('الرجاء اختيار التصنيف والموضوع والرسالة'),
                  ),
                );
                return;
              }

              setDialogState(() => submitting = true);

              try {
                final template = FollowUpMessageTemplate(
                  id: '',
                  category: selectedCategory!,
                  topic: selectedTopic!,
                  title: _templateTitle(selectedCategory!, selectedTopic!),
                  variants: <String, String>{
                    FollowUpMessageTemplateVariant.neutral: selectedMessage!,
                  },
                  isActive: true,
                  createdAt: null,
                  updatedAt: null,
                );

                await _service.createTemplate(template);

                if (!mounted) return;
                Navigator.of(dialogContext).pop();
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('تم إنشاء القالب بنجاح'),
                  ),
                );
              } catch (error) {
                if (!mounted) return;
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('تعذر إنشاء القالب: $error'),
                  ),
                );
              } finally {
                if (dialogContext.mounted) {
                  setDialogState(() => submitting = false);
                }
              }
            }

            return AlertDialog(
              title: const Text('إضافة قالب'),
              content: SizedBox(
                width: 520,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: appInputDecoration(
                            context: context,
                            label: 'Category',
                            icon: Icons.category_outlined,
                          ),
                          items: FollowUpRegistryType.values
                              .map(
                                (category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(_categoryLabel(category)),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedCategory = value;
                              selectedTopic = null;
                              selectedMessage = null;
                            });
                          },
                          validator: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'التصنيف مطلوب';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DropdownButtonFormField<String>(
                          value: selectedTopic,
                          decoration: appInputDecoration(
                            context: context,
                            label: 'Topic',
                            icon: Icons.label_outline,
                          ),
                          items: topicOptions
                              .map(
                                (topic) => DropdownMenuItem<String>(
                                  value: topic,
                                  child: Text(
                                    _topicLabel(selectedCategory, topic),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: topicOptions.isEmpty
                              ? null
                              : (value) {
                                  setDialogState(() {
                                    selectedTopic = value;
                                    selectedMessage = null;
                                  });
                                },
                          validator: (value) {
                            if ((value ?? '').trim().isEmpty) {
                              return 'الموضوع مطلوب';
                            }
                            return null;
                          },
                        ),
                        if (messageOptions.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'اختيار الرسالة',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ...messageOptions.map(
                            (message) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: RadioListTile<String>(
                                value: message,
                                groupValue: selectedMessage,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.md,
                                  ),
                                  side: BorderSide(
                                    color: selectedMessage == message
                                        ? AppColors.deepTeal
                                        : AppColors.deepTeal.withValues(
                                            alpha: 0.14,
                                          ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setDialogState(() {
                                    selectedMessage = value;
                                  });
                                },
                                title: Text(
                                  message,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed:
                      submitting ? null : () => Navigator.of(dialogContext).pop(),
                  child: const Text('إلغاء'),
                ),
                FilledButton(
                  onPressed: submitting ? null : submit,
                  child: Text(submitting ? 'جارٍ الحفظ...' : 'حفظ'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<String> _topicsForCategory(String? category) {
    switch (category) {
      case FollowUpRegistryType.birthday:
        return FollowUpRegistryBirthdayTopic.values;
      case FollowUpRegistryType.recoverySupport:
        return FollowUpRegistryRecoveryTopic.values;
      case FollowUpRegistryType.generalSupport:
        return FollowUpRegistrySupportTopic.values;
      case FollowUpRegistryType.educationalAwareness:
        return FollowUpRegistryEducationalTemplateTopic.values;
      default:
        return const <String>[];
    }
  }

  String _categoryLabel(String category) {
    switch (category) {
      case FollowUpRegistryType.birthday:
        return 'birthday';
      case FollowUpRegistryType.recoverySupport:
        return 'recovery_support';
      case FollowUpRegistryType.generalSupport:
        return 'general_support';
      case FollowUpRegistryType.educationalAwareness:
        return 'educational_awareness';
      default:
        return category;
    }
  }

  String _topicLabel(String? category, String topic) {
    switch (category) {
      case FollowUpRegistryType.birthday:
        return topic;
      case FollowUpRegistryType.recoverySupport:
        return topic;
      case FollowUpRegistryType.generalSupport:
        return topic;
      case FollowUpRegistryType.educationalAwareness:
        return topic;
      default:
        return topic;
    }
  }

  String _templateTitle(String category, String topic) {
    return '${_categoryLabel(category)} - ${_topicLabel(category, topic)}';
  }

  List<String> _messageOptionsFor(String? category, String? topic) {
    if (category == null || topic == null) return const <String>[];

    switch (category) {
      case FollowUpRegistryType.birthday:
        switch (topic) {
          case FollowUpRegistryBirthdayTopic.warm:
            return const <String>[
              'كل سنة وانت طيب ❤️ نتمنى لك يوم سعيد مليان راحة وفرح.',
              'يومك جميل زيك ❤️ كل سنة وانت طيب وعقبال سنين هادية وسعيدة.',
              'نتمنى لك يوم مليان راحة وسعادة ❤️ وكل سنة وانت بخير.',
            ];
          case FollowUpRegistryBirthdayTopic.short:
            return const <String>[
              'كل سنة وانت طيب ❤️',
              'عيد ميلاد سعيد ❤️',
              'نتمنى لك يوم جميل وكل سنة وانت بخير ❤️',
            ];
          case FollowUpRegistryBirthdayTopic.motivational:
            return const <String>[
              'كل سنة وانت طيب ❤️ سنة جديدة نتمناها لك أهدى وأقوى وأجمل.',
              'عيد ميلاد سعيد ❤️ نتمنى لك بداية جديدة فيها راحة وثبات وأمل.',
              'كل سنة وانت بخير ❤️ القادم ممكن يكون ألطف وأقرب لراحة بالك.',
            ];
          case FollowUpRegistryBirthdayTopic.family:
            return const <String>[
              'كل سنة وانت طيب ❤️ نتمنى لك يوم دافئ بين الناس اللي بتحبك.',
              'عيد ميلاد سعيد ❤️ نتمنى لك وقت جميل ولمّة مريحة ومبهجة.',
              'كل سنة وانت بخير ❤️ عسى أيامك تكون مليانة طمأنينة ومحبة.',
            ];
        }
      case FollowUpRegistryType.recoverySupport:
        switch (topic) {
          case FollowUpRegistryRecoveryTopic.encouragement:
            return const <String>[
              'خطواتك مهمة حتى لو كانت هادئة. إحنا مقدّرين مجهودك ❤️',
              'الاستمرار الصغير له قيمة كبيرة. كمل يومك بهدوء وثبات ❤️',
              'رحلة التعافي يوم بيوم، وكل يوم ثابت هو إنجاز حقيقي ❤️',
            ];
          case FollowUpRegistryRecoveryTopic.relapsePrevention:
            return const <String>[
              'لو اليوم صعب، خليك قريب من روتينك الداعم وخطواتك الآمنة ❤️',
              'التذكير البسيط مهم: ابعد عن المحفزات وارجع للأشياء اللي بتثبتك ❤️',
              'الحماية تبدأ من التفاصيل الصغيرة: راحة، تواصل، وقرار هادئ ❤️',
            ];
          case FollowUpRegistryRecoveryTopic.celebration:
            return const <String>[
              'نفتخر بخطواتك ❤️ كل مرحلة بتعدّيها تستحق التقدير.',
              'هذا التقدم يستحق الاحتفال ❤️ استمر بالهدوء اللي أوصلك لهنا.',
              'إنجازك مهم ❤️ واللي وصلت له دليل على قوتك وصبرك.',
            ];
          case FollowUpRegistryRecoveryTopic.safetyReminder:
            return const <String>[
              'لو حسيت بضغط، ارجع فورًا لخطتك الآمنة والأشخاص الداعمين ❤️',
              'تذكير لطيف: الأمان أولًا، وخطوة التوقف أحيانًا أفضل قرار ❤️',
              'خلي اليوم بسيط وآمن، وركز على الأشياء اللي بتحافظ على اتزانك ❤️',
            ];
        }
      case FollowUpRegistryType.generalSupport:
        switch (topic) {
          case FollowUpRegistrySupportTopic.reassurance:
            return const <String>[
              'نحب نذكرك إن مش لازم تحمل كل شيء وحدك ❤️ خذ الأمور بهدوء.',
              'حتى الأيام الثقيلة تعدّي ❤️ خفف عن نفسك وخذ مساحة راحة.',
              'كل شيء ليس مطلوبًا الآن ❤️ خطوة واحدة كفاية لليوم.',
            ];
          case FollowUpRegistrySupportTopic.motivation:
            return const <String>[
              'عندك قدرة تكمل، حتى لو بشكل بسيط جدًا اليوم ❤️',
              'التقدم الهادئ ما زال تقدمًا ❤️ استمر بخطوات صغيرة وواضحة.',
              'خذ اليوم كما هو، وكمّل بما تقدر عليه فقط ❤️',
            ];
          case FollowUpRegistrySupportTopic.notAlone:
            return const <String>[
              'أنت لست وحدك ❤️ وفيه دائمًا مساحة للدعم والاحتواء.',
              'حتى لو اليوم ثقيل، تذكّر أن وجودك مهم وأنك لست بمفردك ❤️',
              'في لحظات كثيرة يكفي أن نتذكّر أننا لسنا وحدنا ❤️',
            ];
          case FollowUpRegistrySupportTopic.stressSupport:
            return const <String>[
              'خفف الإيقاع قليلًا اليوم ❤️ نفس هادئ وخطوة واحدة تكفي.',
              'لو التوتر عالي، ارجع لشيء بسيط ومريح تعرفه ❤️',
              'أعط نفسك دقائق هدوء ❤️ أحيانًا الراحة القصيرة تغيّر اليوم كله.',
            ];
        }
      case FollowUpRegistryType.educationalAwareness:
        switch (topic) {
          case FollowUpRegistryEducationalTemplateTopic.contentShare:
            return const <String>[
              'شاركنا لك اليوم محتوى توعوي خفيف ومفيد ❤️',
              'هذا محتوى مختصر قد يفيدك اليوم ❤️',
              'أرسلنا لك مادة توعوية بسيطة لدعم يومك ❤️',
            ];
          case FollowUpRegistryEducationalTemplateTopic.libraryArticle:
            return const <String>[
              'اخترنا لك مقالًا من المكتبة قد يكون مناسبًا لك اليوم ❤️',
              'هذا مقال توعوي من المكتبة ربما يفيدك ❤️',
              'نشارك معك مادة مقروءة من المكتبة بأسلوب بسيط ومختصر ❤️',
            ];
          case FollowUpRegistryEducationalTemplateTopic.externalLink:
            return const <String>[
              'هذا رابط خارجي لمحتوى توعوي موثوق قد يفيدك ❤️',
              'شاركنا لك رابطًا مختارًا بعناية لمادة توعوية مفيدة ❤️',
              'هذا مصدر خارجي بسيط ومباشر للاطلاع والتوعية ❤️',
            ];
        }
      default:
        return const <String>[];
    }
    return const <String>[];
  }

  String _previewText(String value) {
    if (value.isEmpty) return '';
    if (value.length <= 60) return value;
    return '${value.substring(0, 60)}...';
  }
}

class _TemplateMetaTag extends StatelessWidget {
  const _TemplateMetaTag({
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
