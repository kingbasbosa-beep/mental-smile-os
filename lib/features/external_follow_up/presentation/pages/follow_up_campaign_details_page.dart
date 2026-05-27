import 'package:flutter/material.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_campaign.dart';
import 'package:flutterprojects/features/external_follow_up/data/services/follow_up_campaign_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class FollowUpCampaignDetailsPage extends StatefulWidget {
  const FollowUpCampaignDetailsPage({
    super.key,
    required this.campaign,
  });

  final FollowUpCampaign campaign;

  @override
  State<FollowUpCampaignDetailsPage> createState() =>
      _FollowUpCampaignDetailsPageState();
}

class _FollowUpCampaignDetailsPageState
    extends State<FollowUpCampaignDetailsPage> {
  final _campaignService = FollowUpCampaignService();
  bool _updating = false;

  @override
  Widget build(BuildContext context) {
    final campaign = widget.campaign;
    final recipients = campaign.recipientSample.take(5).toList();
    final whatsappRecipients =
        recipients.where(_isLikelyWhatsAppRecipient).toList();
    final remainingCount = campaign.recipientCount > recipients.length
        ? campaign.recipientCount - recipients.length
        : 0;
    final canPrepare = campaign.status == 'draft' && !_updating;
    final canSendSimulation = campaign.status == 'ready' && !_updating;

    String buttonText;
    VoidCallback? onPressed;
    if (canPrepare) {
      buttonText = _updating ? 'جارٍ التجهيز...' : 'تأكيد الإرسال';
      onPressed = _confirmPrepare;
    } else if (canSendSimulation) {
      buttonText = _updating ? 'جارٍ التنفيذ...' : 'تنفيذ الإرسال';
      onPressed = () => _confirmSendSimulation(whatsappRecipients);
    } else if (campaign.status == 'sent') {
      buttonText = 'تم الإرسال';
      onPressed = null;
    } else {
      buttonText = 'تأكيد الإرسال';
      onPressed = null;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل الحملة'),
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.all(AppSpacing.lg),
          child: FilledButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ),
        body: AppPageBackground(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _SectionCard(
                title: 'البيانات الأساسية',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(
                      label: 'الفئة',
                      value: _categoryLabel(campaign.category),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _InfoRow(
                      label: 'الموضوع',
                      value: _topicLabel(campaign.topic),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'الحالة',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        _StatusBadge(label: campaign.status),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _SectionCard(
                title: 'نص الرسالة',
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.deepTeal.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(AppRadii.xl),
                    border: Border.all(
                      color: AppColors.deepTeal.withValues(alpha: 0.10),
                    ),
                  ),
                  child: Text(
                    campaign.message.trim().isEmpty ? '-' : campaign.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _SectionCard(
                title: 'المستلمون',
                child: recipients.isEmpty
                    ? Text(
                        'لا يوجد مستلمون',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'أول 5 مستلمين',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ...recipients.map(
                            (recipient) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.xs,
                              ),
                              child: Text(
                                '- $recipient',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          if (remainingCount > 0) ...[
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              '+ $remainingCount آخرين',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ],
                      ),
              ),
              const SizedBox(height: AppSpacing.md),
              _SectionCard(
                title: 'بيانات إضافية',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoRow(
                      label: 'عدد المستلمين',
                      value: '${campaign.recipientCount}',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _InfoRow(
                      label: 'تاريخ الإنشاء',
                      value: _formatDate(campaign.createdAt),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmSendSimulation(List<String> whatsappRecipients) async {
    final campaign = widget.campaign;

    if (whatsappRecipients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد مستلمون عبر واتساب'),
        ),
      );
      return;
    }

    final firstRecipient = whatsappRecipients.first;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تأكيد تنفيذ الإرسال'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('سيتم تعليم الحملة كمرسلة'),
              const SizedBox(height: AppSpacing.sm),
              Text('عدد المستلمين: ${campaign.recipientCount}'),
              const SizedBox(height: AppSpacing.xs),
              Text('واتساب فقط: ${whatsappRecipients.length}'),
              const SizedBox(height: AppSpacing.xs),
              Text('أول مستلم عبر واتساب: $firstRecipient'),
              const SizedBox(height: AppSpacing.xs),
              const Text('لا يتم إرسال رسائل فعلية الآن'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('تأكيد'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;

    setState(() {
      _updating = true;
    });

    try {
      await _campaignService.updateCampaignStatus(
        campaignId: campaign.id,
        status: 'sent',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تعليم الحملة كمرسلة'),
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تعذر تنفيذ الإرسال: $error'),
        ),
      );
      setState(() {
        _updating = false;
      });
    }
  }

  Future<void> _confirmPrepare() async {
    final campaign = widget.campaign;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تأكيد تجهيز الإرسال'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('سيتم تجهيز الحملة للإرسال'),
              const SizedBox(height: AppSpacing.sm),
              Text('عدد المستلمين: ${campaign.recipientCount}'),
              const SizedBox(height: AppSpacing.xs),
              Text('الفئة: ${_categoryLabel(campaign.category)}'),
              const SizedBox(height: AppSpacing.xs),
              Text('الموضوع: ${_topicLabel(campaign.topic)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('تأكيد'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;

    setState(() {
      _updating = true;
    });

    try {
      await _campaignService.updateCampaignStatus(
        campaignId: campaign.id,
        status: 'ready',
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تجهيز الحملة للإرسال'),
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تعذر تجهيز الحملة: $error'),
        ),
      );
      setState(() {
        _updating = false;
      });
    }
  }

  bool _isLikelyWhatsAppRecipient(String value) {
    final normalized = value.replaceAll(RegExp(r'[^0-9+]'), '');
    final digitsOnly = normalized.replaceAll('+', '');
    return digitsOnly.length >= 8;
  }

  String _formatDate(DateTime? value) {
    if (value == null) return '-';
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute';
  }

  String _categoryLabel(String value) {
    switch (value) {
      case 'birthday':
        return 'أعياد الميلاد';
      case 'recovery_support':
        return 'التعافي';
      case 'general_support':
        return 'الدعم';
      case 'educational_awareness':
        return 'التوعية';
      default:
        return value;
    }
  }

  String _topicLabel(String value) {
    switch (value) {
      case 'warm':
        return 'warm';
      case 'short':
        return 'short';
      case 'motivational':
        return 'motivational';
      case 'family':
        return 'family';
      case 'encouragement':
        return 'encouragement';
      case 'relapse_prevention':
        return 'relapse_prevention';
      case 'celebration':
        return 'celebration';
      case 'safety_reminder':
        return 'safety_reminder';
      case 'reassurance':
        return 'reassurance';
      case 'motivation':
        return 'motivation';
      case 'not_alone':
        return 'not_alone';
      case 'stress_support':
        return 'stress_support';
      case 'content_share':
        return 'content_share';
      case 'library_article':
        return 'library_article';
      case 'external_link':
        return 'external_link';
      default:
        return value;
    }
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
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
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.obsidian,
            ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(label);
    final text = _statusLabel(label);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Color _statusColor(String value) {
    switch (value) {
      case 'ready':
        return AppColors.mutedGold;
      case 'sent':
        return Colors.green;
      case 'draft':
      default:
        return AppColors.mist;
    }
  }

  String _statusLabel(String value) {
    switch (value) {
      case 'ready':
        return 'جاهزة للإرسال';
      case 'sent':
        return 'تم الإرسال';
      case 'draft':
      default:
        return 'مسودة';
    }
  }
}
