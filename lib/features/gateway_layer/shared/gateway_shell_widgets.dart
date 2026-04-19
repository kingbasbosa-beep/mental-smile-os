import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_entry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

Color gatewayHealthColor(GatewayHealthLevel level) {
  switch (level) {
    case GatewayHealthLevel.healthy:
      return const Color(0xFF1F9D63);
    case GatewayHealthLevel.attention:
      return const Color(0xFFE39B2E);
    case GatewayHealthLevel.planned:
      return const Color(0xFF2E5AAC);
  }
}

String gatewayHealthLabel(GatewayHealthLevel level) {
  switch (level) {
    case GatewayHealthLevel.healthy:
      return 'Healthy';
    case GatewayHealthLevel.attention:
      return 'Attention';
    case GatewayHealthLevel.planned:
      return 'Planned';
  }
}

class GatewayHealthBadge extends StatelessWidget {
  const GatewayHealthBadge({
    super.key,
    required this.level,
  });

  final GatewayHealthLevel level;

  @override
  Widget build(BuildContext context) {
    final color = gatewayHealthColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Text(
        gatewayHealthLabel(level),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class GatewayFamilyCard extends StatelessWidget {
  const GatewayFamilyCard({
    super.key,
    required this.entry,
    this.statusOverride,
  });

  final GatewayFamilyEntry entry;
  final GatewayStatus? statusOverride;

  @override
  Widget build(BuildContext context) {
    final status = statusOverride ?? entry.status;
    final color = gatewayHealthColor(status.level);
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () => Navigator.of(context).pushNamed(entry.route),
      child: AppSurfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GatewayHealthBadge(level: status.level),
                const Spacer(),
                Icon(Icons.open_in_new, color: color),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              entry.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(entry.description),
            const SizedBox(height: AppSpacing.md),
            Text(
              status.summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.78),
                  ),
            ),
            if ((status.note ?? '').trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                status.note!.trim(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.obsidian.withValues(alpha: 0.70),
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class GatewayEntryCard extends StatelessWidget {
  const GatewayEntryCard({
    super.key,
    required this.entry,
  });

  final GatewayEntry entry;

  @override
  Widget build(BuildContext context) {
    return AppSectionPanel(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  entry.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              GatewayHealthBadge(level: entry.status.level),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(entry.boundary),
          const SizedBox(height: AppSpacing.sm),
          Text(
            entry.status.summary,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.82),
                ),
          ),
          if ((entry.status.note ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              entry.status.note!.trim(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.70),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
