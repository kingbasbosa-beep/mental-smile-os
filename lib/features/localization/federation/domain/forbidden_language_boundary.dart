class ForbiddenLanguageBoundary {
  const ForbiddenLanguageBoundary._();

  static const List<String> forbiddenTerms = <String>[
    'booking',
    'session request',
    'payment proof',
    'admin approval',
    'assignment',
    'payout',
    'commission',
    'حجز',
    'طلب جلسة',
    'إثبات دفع',
    'موافقة أدمن',
    'تعيين',
    'عمولة',
    'صرف مستحقات',
  ];

  static bool acceptsText(String value) {
    final normalized = value.trim().toLowerCase();
    return !forbiddenTerms
        .map((term) => term.toLowerCase())
        .any(normalized.contains);
  }
}
