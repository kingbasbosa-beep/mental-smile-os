import 'package:flutter/material.dart';

import 'legal_disclaimer_text.dart';

class AiSafetyDisclaimerCard extends StatelessWidget {
  const AiSafetyDisclaimerCard({
    super.key,
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3E8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE1D2B6)),
      ),
      child: Text(
        LegalDisclaimerText.aiNotice(isArabic: isArabic),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFF3D3322),
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
