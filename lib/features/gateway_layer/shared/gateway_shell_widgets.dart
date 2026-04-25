import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_entry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'gateway_status.dart';
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
      return 'Monitored';
    case GatewayHealthLevel.attention:
      return 'Needs attention';
    case GatewayHealthLevel.planned:
      return 'Planned';
  }
}

String gatewayHealthSummaryLabel(GatewayHealthLevel level) {
  switch (level) {
    case GatewayHealthLevel.healthy:
      return 'Monitored boundary';
    case GatewayHealthLevel.attention:
      return 'Attention boundary';
    case GatewayHealthLevel.planned:
      return 'Planned boundary';
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

class GatewayPageIntroCard extends StatelessWidget {
  const GatewayPageIntroCard({
    super.key,
    required this.title,
    required this.summary,
    required this.boundaryNote,
    this.emphasis,
  });

  final String title;
  final String summary;
  final String boundaryNote;
  final String? emphasis;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      color: const Color(0xFF0B1014).withValues(alpha: 0.96),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            summary,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            boundaryNote,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                ),
          ),
          if ((emphasis ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              emphasis!.trim(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class GatewaySectionCard extends StatelessWidget {
  const GatewaySectionCard({
    super.key,
    required this.title,
    this.description,
    required this.children,
  });

  final String title;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          if ((description ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              description!.trim(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                  ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          ...children,
        ],
      ),
    );
  }
}

class GatewaySupervisionNote extends StatelessWidget {
  const GatewaySupervisionNote({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF314A5C).withValues(alpha: 0.88),
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
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      onTap: () => Navigator.of(context).pushNamed(entry.route),
      child: AppSurfaceCard(
        color: const Color(0xFF10161A).withValues(alpha: 0.94),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        child: GatewayStatusBlock(
          title: entry.title,
          level: status.level,
          roleText: entry.description,
          summary: status.summary,
          boundaryNote: status.boundaryNote,
          monitoredNote: status.monitoredNote,
          attentionLabel: status.attentionLabel,
          trailing: Icon(
            Icons.open_in_new,
            color: gatewayHealthColor(status.level),
          ),
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
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      child: GatewayStatusBlock(
        title: entry.title,
        level: entry.status.level,
        summary: entry.status.summary,
        boundaryNote: entry.status.boundaryNote ?? entry.boundary,
        monitoredNote: entry.status.monitoredNote,
        attentionLabel: entry.status.attentionLabel,
      ),
    );
  }
}

class GatewayStatusBlock extends StatelessWidget {
  const GatewayStatusBlock({
    super.key,
    required this.title,
    required this.level,
    required this.summary,
    this.roleText,
    this.boundaryNote,
    this.monitoredNote,
    this.attentionLabel,
    this.trailing,
  });

  final String title;
  final GatewayHealthLevel level;
  final String summary;
  final String? roleText;
  final String? boundaryNote;
  final String? monitoredNote;
  final String? attentionLabel;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final color = gatewayHealthColor(level);
    final sectionLabel = gatewayHealthSummaryLabel(level);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFC9A75B),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    sectionLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GatewayHealthBadge(level: level),
                if (trailing != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  trailing!,
                ],
              ],
            ),
          ],
        ),
        if ((roleText ?? '').trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            roleText!.trim(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        Text(
          summary,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF314A5C).withValues(alpha: 0.88),
              ),
        ),
        if ((boundaryNote ?? '').trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          _GatewayMetaLine(
            label: 'Boundary',
            value: boundaryNote!,
          ),
        ],
        if ((monitoredNote ?? '').trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          _GatewayMetaLine(
            label: 'Monitoring',
            value: monitoredNote!,
          ),
        ],
        if ((attentionLabel ?? '').trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(color: color.withValues(alpha: 0.20)),
            ),
            child: Text(
              attentionLabel!,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _GatewayMetaLine extends StatelessWidget {
  const _GatewayMetaLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $value',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF314A5C).withValues(alpha: 0.88),
            height: 1.35,
          ),
    );
  }
}
