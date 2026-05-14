import 'package:flutter/material.dart';

import 'safe_support_copy.dart';

class FailSafeSupportMessage extends StatelessWidget {
  const FailSafeSupportMessage({
    super.key,
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final lines = isArabic
        ? const [
            SafeSupportCopy.calmOpeningAr,
            SafeSupportCopy.notEverythingNowAr,
            SafeSupportCopy.trustedPersonAr,
          ]
        : const [
            SafeSupportCopy.calmOpeningEn,
            SafeSupportCopy.notEverythingNowEn,
            SafeSupportCopy.trustedPersonEn,
          ];

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        for (final line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              line,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF3D3322),
                    height: 1.45,
                  ),
            ),
          ),
      ],
    );
  }
}
