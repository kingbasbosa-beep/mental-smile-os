import 'package:flutter/material.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class DomainAdvisoryBanner extends StatelessWidget {
  const DomainAdvisoryBanner({
    super.key,
    required this.status,
    required this.domainDisplayName,
    required this.title,
    required this.body,
    required this.nonBlockingMessage,
    required this.isArabic,
    this.margin = EdgeInsets.zero,
  });

  final DomainStatus status;
  final String domainDisplayName;
  final String title;
  final String body;
  final String nonBlockingMessage;
  final bool isArabic;
  final EdgeInsetsGeometry margin;

  static String statusSourceLabel(String value) {
    switch (value) {
      case 'admin_set':
        return 'Admin Set';
      case 'mixed':
        return 'Mixed';
      default:
        return 'Observed';
    }
  }

  static Color advisoryColor(String status) {
    switch (status) {
      case 'disabled':
        return const Color(0xFFC97C7C);
      case 'maintenance':
        return const Color(0xFF6A8FBE);
      case 'degraded':
        return const Color(0xFFD9A441);
      default:
        return AppColors.mist;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = advisoryColor(status.status);

    return Padding(
      padding: margin,
      child: Semantics(
        container: true,
        label: '$domainDisplayName advisory',
        child: AppSurfaceCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      body,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      nonBlockingMessage,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.obsidian.withValues(alpha: 0.72),
                            fontWeight: FontWeight.w600,
                          ),
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
}
