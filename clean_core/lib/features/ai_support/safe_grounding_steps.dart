import 'package:flutter/material.dart';

import 'safe_support_copy.dart';

class SafeGroundingSteps extends StatelessWidget {
  const SafeGroundingSteps({
    super.key,
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final steps = SafeSupportCopy.groundingSteps(isArabic: isArabic);
    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        for (final step in steps)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              step,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF3D3322),
                    height: 1.4,
                  ),
            ),
          ),
      ],
    );
  }
}
