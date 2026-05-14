import 'package:flutter/material.dart';

import 'safe_support_copy.dart';

class TrustedPersonPrompt extends StatelessWidget {
  const TrustedPersonPrompt({
    super.key,
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Text(
      SafeSupportCopy.trustedPerson(isArabic: isArabic),
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF3D3322),
            height: 1.45,
          ),
    );
  }
}
