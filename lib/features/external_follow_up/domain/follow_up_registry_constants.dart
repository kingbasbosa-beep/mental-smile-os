class FollowUpRegistryStatus {
  static const String active = 'active';
  static const String paused = 'paused';
  static const String archived = 'archived';

  static const List<String> values = <String>[
    active,
    paused,
    archived,
  ];
}

class FollowUpRegistryType {
  static const String birthday = 'birthday';
  static const String recoverySupport = 'recovery_support';
  static const String generalSupport = 'general_support';
  static const String educationalAwareness = 'educational_awareness';

  static const List<String> values = <String>[
    birthday,
    recoverySupport,
    generalSupport,
    educationalAwareness,
  ];
}

class FollowUpRegistrySupportFrequency {
  static const String every3Days = 'every_3_days';
  static const String every7Days = 'every_7_days';

  static const List<String> values = <String>[
    every3Days,
    every7Days,
  ];
}

class FollowUpRegistryRecoveryFrequency {
  static const String monthly = 'monthly';
  static const String quarterly = 'quarterly';

  static const List<String> values = <String>[
    monthly,
    quarterly,
  ];
}

class FollowUpRegistryContactChannel {
  static const String whatsapp = 'whatsapp';
  static const String email = 'email';
  static const String both = 'both';

  static const List<String> values = <String>[
    whatsapp,
    email,
    both,
  ];
}

class FollowUpRegistryGender {
  static const String male = 'male';
  static const String female = 'female';

  static const List<String> values = <String>[
    male,
    female,
  ];
}

class FollowUpMessageTemplateVariant {
  static const String neutral = 'neutral';
  static const String male = 'male';
  static const String female = 'female';

  static const List<String> values = <String>[
    neutral,
    male,
    female,
  ];
}

class FollowUpRegistryBirthdayTopic {
  static const String warm = 'warm';
  static const String short = 'short';
  static const String motivational = 'motivational';
  static const String family = 'family';

  static const List<String> values = <String>[
    warm,
    short,
    motivational,
    family,
  ];
}

class FollowUpRegistryRecoveryTopic {
  static const String encouragement = 'encouragement';
  static const String relapsePrevention = 'relapse_prevention';
  static const String celebration = 'celebration';
  static const String safetyReminder = 'safety_reminder';

  static const List<String> values = <String>[
    encouragement,
    relapsePrevention,
    celebration,
    safetyReminder,
  ];
}

class FollowUpRegistrySupportTopic {
  static const String reassurance = 'reassurance';
  static const String motivation = 'motivation';
  static const String notAlone = 'not_alone';
  static const String stressSupport = 'stress_support';

  static const List<String> values = <String>[
    reassurance,
    motivation,
    notAlone,
    stressSupport,
  ];
}

class FollowUpRegistryEducationalTopic {
  static const String relapsePrevention = 'relapse_prevention';
  static const String lifeSkills = 'life_skills';
  static const String relaxation = 'relaxation';
  static const String familyAwareness = 'family_awareness';
  static const String addictionUnderstanding = 'addiction_understanding';
  static const String emotionalRegulation = 'emotional_regulation';
  static const String habitBuilding = 'habit_building';
  static const String recoverySupport = 'recovery_support';

  static const List<String> values = <String>[
    relapsePrevention,
    lifeSkills,
    relaxation,
    familyAwareness,
    addictionUnderstanding,
    emotionalRegulation,
    habitBuilding,
    recoverySupport,
  ];
}

class FollowUpRegistryEducationalTemplateTopic {
  static const String contentShare = 'content_share';
  static const String libraryArticle = 'library_article';
  static const String externalLink = 'external_link';

  static const List<String> values = <String>[
    contentShare,
    libraryArticle,
    externalLink,
  ];
}

class FollowUpRegistrySource {
  static const String manualAdminEntry = 'manual_admin_entry';
  static const String clientRequest = 'client_request';
  static const String imported = 'imported';

  static const List<String> values = <String>[
    manualAdminEntry,
    clientRequest,
    imported,
  ];
}
