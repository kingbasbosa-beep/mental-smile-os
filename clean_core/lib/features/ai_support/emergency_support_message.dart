import 'package:flutter/material.dart';

import 'safe_support_copy.dart';

class EmergencySupportMessage extends StatelessWidget {
  const EmergencySupportMessage({
    super.key,
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      '${SafeSupportCopy.emergency(isArabic: isArabic)}\n'
      '${isArabic ? SafeSupportCopy.noGuaranteeAr : SafeSupportCopy.noGuaranteeEn}',
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: const Color(0xFF3D3322),
        height: 1.45,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
