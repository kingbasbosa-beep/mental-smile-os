enum ConstructionToolType {
  strategicWorkspace,
  constructionWorkspace,
  verificationWorkspace,
  sourceControl,
  console,
  publishing,
  localWorkspace,
  sourceRepository,
  packageReference,
  memoryReference,
}

enum ConstructionLaunchType {
  externalUrl,
  localPath,
  reference,
}

class ConstructionToolEntry {
  const ConstructionToolEntry({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.type,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.launchType,
    this.url,
    this.localPath,
    required this.allowedUse,
    required this.forbiddenUse,
    required this.status,
  });

  final String id;
  final String nameAr;
  final String nameEn;
  final ConstructionToolType type;
  final String descriptionAr;
  final String descriptionEn;
  final ConstructionLaunchType launchType;
  final String? url;
  final String? localPath;
  final String allowedUse;
  final String forbiddenUse;
  final String status;

  String get launchValue => url ?? localPath ?? 'Not configured';
}

class ConstructionToolRegistry {
  const ConstructionToolRegistry._();

  static const entries = <ConstructionToolEntry>[
    ConstructionToolEntry(
      id: 'CONSTRUCTION_TOOL_CHATGPT_V1',
      nameAr: 'مساحة ChatGPT للمعمار الاستراتيجي',
      nameEn: 'ChatGPT Strategic Architecture Workspace',
      type: ConstructionToolType.strategicWorkspace,
      descriptionAr: 'صياغة الرؤية والمعمار والبرومبتات الدستورية.',
      descriptionEn:
          'Shape constitutional architecture, prompts, and strategy.',
      launchType: ConstructionLaunchType.externalUrl,
      url: 'https://chatgpt.com/',
      allowedUse: 'Strategic architecture, doctrine drafting, Owner review.',
      forbiddenUse: 'Runtime execution, secrets, legal approval, deployment.',
      status: 'CONFIGURED',
    ),
    ConstructionToolEntry(
      id: 'CONSTRUCTION_TOOL_CODEX_V1',
      nameAr: 'مساحة Codex للبناء',
      nameEn: 'Codex Construction Workspace',
      type: ConstructionToolType.constructionWorkspace,
      descriptionAr: 'بناء الحزم المعتمدة داخل المشروع.',
      descriptionEn: 'Construct approved packages inside the project.',
      launchType: ConstructionLaunchType.reference,
      localPath: 'Open this Codex workspace for the current project.',
      allowedUse: 'Approved package construction and verification commands.',
      forbiddenUse: 'Unapproved edits, secrets, maintenance authority.',
      status: 'REFERENCE_ONLY',
    ),
    ConstructionToolEntry(
      id: 'CONSTRUCTION_TOOL_ANDROID_STUDIO_V1',
      nameAr: 'Android Studio للتحقق التشغيلي',
      nameEn: 'Android Studio Runtime Verification',
      type: ConstructionToolType.verificationWorkspace,
      descriptionAr: 'تشغيل وفحص التطبيق محليًا عند طلب التحقق.',
      descriptionEn:
          'Run and inspect the app locally when verification is required.',
      launchType: ConstructionLaunchType.localPath,
      localPath: 'Open project folder in Android Studio.',
      allowedUse: 'Local runtime verification for approved outputs.',
      forbiddenUse: 'Technical Operations, deployment, maintenance monitoring.',
      status: 'LOCAL_PLACEHOLDER',
    ),
    ConstructionToolEntry(
      id: 'CONSTRUCTION_TOOL_GITHUB_V1',
      nameAr: 'GitHub للتحكم في المصدر',
      nameEn: 'GitHub Source Control',
      type: ConstructionToolType.sourceControl,
      descriptionAr: 'الفروع والمراجعات وتاريخ المصدر.',
      descriptionEn: 'Branches, reviews, and source history.',
      launchType: ConstructionLaunchType.externalUrl,
      url: 'https://github.com/kingbasbosa-beep/mental-smile-app',
      allowedUse: 'Source control, branch, commit, pull request review.',
      forbiddenUse: 'Unapproved deployment or authority decisions.',
      status: 'CONFIGURED',
    ),
    ConstructionToolEntry(
      id: 'CONSTRUCTION_TOOL_FIREBASE_V1',
      nameAr: 'Firebase Console',
      nameEn: 'Firebase Console',
      type: ConstructionToolType.console,
      descriptionAr: 'مرجع Console فقط بدون تغيير قواعد أو أسرار.',
      descriptionEn: 'Console reference only; no rules or secrets are changed.',
      launchType: ConstructionLaunchType.externalUrl,
      url: 'https://console.firebase.google.com/',
      allowedUse: 'Inspection and approved future configuration only.',
      forbiddenUse: 'Changing Firebase from this workbench or storing keys.',
      status: 'CONFIGURED',
    ),
    ConstructionToolEntry(
      id: 'CONSTRUCTION_TOOL_GOOGLE_PLAY_CONSOLE_V1',
      nameAr: 'Google Play Console للنشر',
      nameEn: 'Google Play Console Publishing',
      type: ConstructionToolType.publishing,
      descriptionAr: 'مرجع جاهزية النشر بعد اعتماد المالك.',
      descriptionEn: 'Publishing readiness reference after Owner approval.',
      launchType: ConstructionLaunchType.externalUrl,
      url: 'https://play.google.com/console/',
      allowedUse: 'Release readiness review when authorized.',
      forbiddenUse: 'Publishing without Owner approval.',
      status: 'CONFIGURED',
    ),
    ConstructionToolEntry(
      id: 'CONSTRUCTION_TOOL_LOCAL_PROJECT_V1',
      nameAr: 'مساحة المشروع المحلية',
      nameEn: 'Local Project Workspace',
      type: ConstructionToolType.localWorkspace,
      descriptionAr: 'مسار ملفات المشروع الحالية.',
      descriptionEn: 'Current project file workspace path.',
      launchType: ConstructionLaunchType.localPath,
      localPath: r'C:\mental_smile_workspace\app\mental-smile-app-clean2',
      allowedUse: 'Local project review and approved artifact construction.',
      forbiddenUse: 'Unbounded edits or unrelated cleanup.',
      status: 'CONFIGURED',
    ),
    ConstructionToolEntry(
      id: 'CONSTRUCTION_TOOL_MENTAL_SMILE_CORE_SOURCE_V1',
      nameAr: 'مرجع Mental Smile Core كمصدر',
      nameEn: 'Mental Smile Core Source Repository',
      type: ConstructionToolType.sourceRepository,
      descriptionAr: 'مصدر للاستخراج والتنقية فقط، لا نسخ مباشر.',
      descriptionEn:
          'Source for extraction and purification only; no direct copy.',
      launchType: ConstructionLaunchType.localPath,
      localPath:
          r'C:\mental_smile_workspace\app\mental-smile-app-clean2\mental_smile_clean_core',
      allowedUse: 'Source lookup, inventory, extraction evidence.',
      forbiddenUse: 'Copying as-is or treating Core as active OS.',
      status: 'CONFIGURED',
    ),
    ConstructionToolEntry(
      id: 'CURRENT_BUILD_PACKAGE_V1',
      nameAr: 'حزمة البناء الحالية',
      nameEn: 'Current Build Package',
      type: ConstructionToolType.packageReference,
      descriptionAr: 'مرجع استراتيجية بناء Residential الحالية.',
      descriptionEn:
          'Reference to the current Residential build strategy package.',
      launchType: ConstructionLaunchType.localPath,
      localPath:
          r'docs\mental-smile-os\strategic-planning-room\RESIDENTIAL_DOMAIN_BUILD_STRATEGY_V1.md',
      allowedUse: 'Review approved planning package before construction.',
      forbiddenUse: 'Treating strategy as build approval.',
      status: 'REFERENCE_ONLY',
    ),
    ConstructionToolEntry(
      id: 'CURRENT_PROMPT_MEMORY_REGISTRY_V1',
      nameAr: 'سجل ذاكرة البرومبت الحالي',
      nameEn: 'Current Prompt Memory Registry',
      type: ConstructionToolType.memoryReference,
      descriptionAr: 'مرجع نسب البرومبتات داخل الذاكرة الدستورية.',
      descriptionEn: 'Prompt lineage reference inside Constitutional Memory.',
      launchType: ConstructionLaunchType.localPath,
      localPath:
          r'docs\mental-smile-os\constitutional-memory-domain\PROMPT_MEMORY_REGISTRY_V1.md',
      allowedUse: 'Trace prompt lineage before construction.',
      forbiddenUse: 'Editing memory records from the workbench UI.',
      status: 'REFERENCE_ONLY',
    ),
  ];
}
