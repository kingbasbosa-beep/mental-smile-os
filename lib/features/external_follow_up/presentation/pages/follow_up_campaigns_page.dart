import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/external_follow_up/data/models/follow_up_campaign.dart';
import 'package:flutterprojects/features/external_follow_up/data/services/follow_up_campaign_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class FollowUpCampaignsPage extends StatelessWidget {
  const FollowUpCampaignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FollowUpCampaignService();

    return DefaultTabController(
      length: 4,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('الحملات'),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'الكل'),
                Tab(text: 'مسودات'),
                Tab(text: 'جاهزة للإرسال'),
                Tab(text: 'المرسلة'),
              ],
            ),
          ),
          body: AppPageBackground(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: StreamBuilder<List<FollowUpCampaign>>(
                stream: service.streamCampaigns(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'تعذر تحميل الحملات',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }

                  final campaigns = snapshot.data ?? const <FollowUpCampaign>[];

                  return TabBarView(
                    children: [
                      _CampaignList(
                        campaigns: campaigns,
                        emptyText: 'لا توجد حملات مجهزة حتى الآن',
                      ),
                      _CampaignList(
                        campaigns: campaigns
                            .where((campaign) => campaign.status == 'draft')
                            .toList(),
                        emptyText: 'لا توجد مسودات حتى الآن',
                      ),
                      _CampaignList(
                        campaigns: campaigns
                            .where((campaign) => campaign.status == 'ready')
                            .toList(),
                        emptyText: 'لا توجد حملات جاهزة للإرسال',
                      ),
                      _CampaignList(
                        campaigns: campaigns
                            .where((campaign) => campaign.status == 'sent')
                            .toList(),
                        emptyText: 'لا توجد حملات مرسلة حتى الآن',
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CampaignList extends StatelessWidget {
  const _CampaignList({
    required this.campaigns,
    required this.emptyText,
  });

  final List<FollowUpCampaign> campaigns;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    if (campaigns.isEmpty) {
      return Center(
        child: Text(
          emptyText,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      itemCount: campaigns.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final campaign = campaigns[index];
        return InkWell(
          borderRadius: BorderRadius.circular(AppRadii.xl),
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.followUpCampaignDetails,
              arguments: campaign,
            );
          },
          child: AppSurfaceCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${campaign.category} - ${campaign.topic}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    _StatusBadge(label: campaign.status),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'القالب: ${campaign.templateId}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'عدد المستلمين: ${campaign.recipientCount}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'تاريخ التجهيز: ${_formatDate(campaign.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
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
