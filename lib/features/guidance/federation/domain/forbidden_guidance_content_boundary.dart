class ForbiddenGuidanceContentBoundary {
  const ForbiddenGuidanceContentBoundary._();

  static const List<String> forbiddenTerms = <String>[
    'diagnosis',
    'treatment',
    'medication prescription',
    'treatment promise',
    'commercial pressure',
    'booking',
    'session request',
    'payment proof',
    'admin approval',
    'assignment',
    'commission',
    'تشخيص',
    'علاج',
    'وصف دواء',
    'وعود علاجية',
    'ضغط تجاري',
    'حجز',
    'طلب جلسة',
    'إثبات دفع',
    'موافقة أدمن',
    'تعيين',
    'عمولة',
  ];

  static bool acceptsContent(String value) {
    final normalized = value.trim().toLowerCase();
    return !forbiddenTerms
        .map((term) => term.toLowerCase())
        .any(normalized.contains);
  }
}
