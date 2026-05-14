import 'package:flutter/material.dart';

import 'emergency_support_message.dart';
import 'fail_safe_support_message.dart';
import 'safe_grounding_steps.dart';

class CrisisSupportCard extends StatelessWidget {
  const CrisisSupportCard({
    super.key,
    required this.isArabic,
    this.showEmergencyMessage = true,
  });

  final bool isArabic;
  final bool showEmergencyMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE6D4A8)),
      ),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'دعم آمن' : 'Safe support',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF2F271A),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          FailSafeSupportMessage(isArabic: isArabic),
          const SizedBox(height: 8),
          SafeGroundingSteps(isArabic: isArabic),
          if (showEmergencyMessage) ...[
            const SizedBox(height: 10),
            EmergencySupportMessage(isArabic: isArabic),
          ],
        ],
      ),
    );
  }
}
