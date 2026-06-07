class ContactDoctrineProfile {
  const ContactDoctrineProfile({
    required this.officialNameEn,
    required this.officialNameAr,
    required this.allowedAction,
    required this.forbiddenActionLanguage,
  });

  final String officialNameEn;
  final String officialNameAr;
  final String allowedAction;
  final Set<String> forbiddenActionLanguage;
}

class ContactVisibilityAlignment {
  const ContactVisibilityAlignment({
    required this.targetType,
    required this.contactVisible,
    required this.visibilityNotes,
  });

  final String targetType;
  final bool contactVisible;
  final String visibilityNotes;
}
