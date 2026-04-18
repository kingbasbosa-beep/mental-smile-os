class ChatAiPolicy {
  final String policyVersion;
  final Map<String, String> responseTemplates;
  final Map<String, List<String>> rolePhrasePacks;
  final Map<String, List<String>> statePhrasePacks;
  final List<String> lossOfControlPhrases;
  final List<String> selfHarmPhrases;
  final Map<String, int> stateScores;
  final int lossOfControlScore;
  final int explicitSelfHarmScore;
  final int mediumRiskThreshold;
  final int highRiskThreshold;
  final int criticalRiskThreshold;
  final Map<String, String> strategyByRiskLevel;
  final Set<String> needsHumanSupportLevels;
  final Set<String> containsEscalationSignalLevels;
  final Set<String> safetyTriggeredLevels;

  const ChatAiPolicy({
    required this.policyVersion,
    required this.responseTemplates,
    required this.rolePhrasePacks,
    required this.statePhrasePacks,
    required this.lossOfControlPhrases,
    required this.selfHarmPhrases,
    required this.stateScores,
    required this.lossOfControlScore,
    required this.explicitSelfHarmScore,
    required this.mediumRiskThreshold,
    required this.highRiskThreshold,
    required this.criticalRiskThreshold,
    required this.strategyByRiskLevel,
    required this.needsHumanSupportLevels,
    required this.containsEscalationSignalLevels,
    required this.safetyTriggeredLevels,
  });
}

class ChatAiPolicyProvider {
  const ChatAiPolicyProvider._();

  static const ChatAiPolicy local = ChatAiPolicy(
    policyVersion: 'local_policy_v1',
    responseTemplates: {
      'critical':
          'أنا سامع إن الخطر هنا مباشر، والأولوية الآن هي الأمان فقط. ابعد حالًا عن أي شيء ممكن تستخدمه لإيذاء نفسك، وخليك في نفس المكان مع شخص موثوق أو اتصل به فورًا، واطلب دعمًا بشريًا مباشرًا الآن. لو أنت وحدك، تحرك فورًا لمكان فيه ناس قريبين منك. أنا معك الآن، ونركز فقط على النجاة من الدقائق الحالية بأمان.',
      'high':
          'واضح إن الضغط عالي جدًا عليك الآن، ومهم ما تفضلش مع ده وحدك. خلينا نهدي الإيقاع ونركز على خطوة آمنة جدًا الآن، ومعها يكون الأفضل التواصل مع شخص موثوق أو دعم بشري قريب.',
      'medium':
          'إحساسك مفهوم، ومش لازم تحل كل شيء الآن. خلينا نبطيء اللحظة ونشوف أول خطوة صغيرة تساعدك تستعيد هدوءك وسيطرتك.',
      'family_member':
          'واضح إنك شايل هم كبير، ووجودك هنا مهم. خلينا نفهم الموقف بهدوء ونركز على خطوة آمنة ومتزنة تساعدك وتساعد الطرف الآخر بدون تصعيد.',
      'default':
          'أنا معك. نقدر نمسك اللي حاصل بهدوء ونفهمه خطوة خطوة، من غير ضغط ومن غير أحكام.',
    },
    rolePhrasePacks: {
      'addicted_person': [
        'انا بتعاطى',
        'انا بتعاطي',
        'انا مدمن',
        'عايز اتعاطى',
        'عاوز اتعاطى',
        'نفسي اتعاطى',
        'مش قادر ابطل',
        'مش قادر ابطل تعاطي',
        'انتكست',
        'رجعت للتعاطي',
        'رجعت اتعاطى',
        'رجعت اتعاطي',
      ],
      'family_member': [
        'ابني',
        'بنتي',
        'اخويا',
        'اختي',
        'اختى',
        'جوزي',
        'زوجي',
        'مراتي',
        'زوجتي',
        'ابويا',
        'امي',
        'أمي',
        'أبويا',
      ],
    },
    statePhrasePacks: {
      'justification': [
        'مش مشكلة',
        'عادي ارجع',
        'عادي ارجع للتعاطي',
        'عادي ارجع اتعاطى',
        'مش غلط',
        'كل الناس بتعمل كده',
        'استاهل ارجع',
        'مفيش مانع ارجع',
      ],
      'denial': [
        'مفيش مشكلة عندي',
        'انا كويس',
        'مش محتاج مساعدة',
        'انا تمام',
        'انا مش محتاج حد',
        'مش محتاج دعم',
        'مفيش حاجة غلط',
      ],
      'craving': [
        'نفسي اتعاطى',
        'عايز اتعاطى',
        'عاوز اتعاطى',
        'مشتاق للتعاطي',
        'الرغبة شديدة',
        'رغبة قوية',
        'مش قادر امسك نفسي',
        'حاسس اني هرجع',
        'هرجع اتعاطى',
        'هرجع اتعاطي',
        'نفسي ارجع',
      ],
      'hopelessness': [
        'مفيش امل',
        'مش شايف امل',
        'خلاص ضعت',
        'انتهيت',
        'مفيش فايدة',
        'مش هتغير',
        'مش هعرف اتغير',
        'كل حاجة بايظة',
        'مافيش امل',
        'مافيش فايده',
      ],
      'fear': [
        'خايف',
        'مرعوب',
        'قلقان',
        'متوتر',
        'عندي خوف',
        'حاسس برعب',
        'مش مطمن',
      ],
      'guilt': [
        'مذنب',
        'ندمان',
        'حاسس بذنب',
        'انا السبب',
        'حاسس اني وحش',
        'انا وحش',
        'قصرت',
      ],
      'collapse': [
        'منهار',
        'مش قادر',
        'عايز اعيط',
        'وقعت',
        'تعبان جدا',
        'تعبان جدًا',
        'مكسور',
        'مش قادر اكمل',
        'حاسس اني واقع',
        'تايه جدا',
        'تايه جدًا',
      ],
      'manipulation': [
        'بتتحكموا فيا',
        'كلكم ضدي',
        'انتوا السبب',
        'هخليكم تندموا',
        'لو سبتوني هعمل حاجة',
        'لو ماعملتوش كذا هعمل كذا',
      ],
    },
    lossOfControlPhrases: [
      'مش قادر اتحكم في نفسي',
      'مش قادر اتحكم بنفسي',
      'مش قادر اسيطر على نفسي',
      'مش قادر اسيطر بنفسي',
      'مش مسيطر على نفسي',
      'خارج عن السيطرة',
      'هفقد السيطرة',
      'مش ماسك نفسي',
      'مش عارف امسك نفسي',
      'مش قادر امسك نفسي',
    ],
    selfHarmPhrases: [
      'هاذي نفسي',
      'هأذي نفسي',
      'عايز اؤذي نفسي',
      'عايز اوذي نفسي',
      'عاوز اؤذي نفسي',
      'عاوز اوذي نفسي',
      'اؤذي نفسي',
      'اوذي نفسي',
      'اذي نفسي',
      'أذي نفسي',
      'هعمل في نفسي حاجة',
      'اخلص من نفسي',
      'انهي نفسي',
      'انهي حياتي',
      'انتحار',
      'انتحر',
      'اقتل نفسي',
      'اموت نفسي',
      'هموت نفسي',
      'نفسي اموت',
      'نفسي اموت بجد',
      'نفسي اختفي',
      'مش عايز اعيش',
      'مش عاوز اعيش',
      'مش حابب اعيش',
      'ماعدتش عايز اعيش',
      'ماعدتش عاوز اعيش',
      'عايز اموت',
      'عاوز اموت',
    ],
    stateScores: {
      'justification': 2,
      'denial': 2,
      'craving': 3,
      'hopelessness': 2,
      'fear': 0,
      'guilt': 0,
      'collapse': 0,
      'manipulation': 2,
    },
    lossOfControlScore: 3,
    explicitSelfHarmScore: 5,
    mediumRiskThreshold: 3,
    highRiskThreshold: 6,
    criticalRiskThreshold: 9,
    strategyByRiskLevel: {
      'critical': 'safety_override',
      'high': 'reality_linking_boundary',
      'medium': 'awareness_disruption',
      'low': 'containment',
    },
    needsHumanSupportLevels: {
      'critical',
      'high',
    },
    containsEscalationSignalLevels: {
      'critical',
      'high',
    },
    safetyTriggeredLevels: {
      'critical',
    },
  );
}
