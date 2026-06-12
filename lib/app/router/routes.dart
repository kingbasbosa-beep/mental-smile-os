class Routes {
  // Web Portal Phase 1 Skeleton
  static const portalHome = '/';
  static const portalAbout = '/about';
  static const portalLibrary = '/library';
  static const portalProviderRegister = '/register/provider';
  static const portalServiceRequest = '/request/service';
  static const portalPackageRequest = '/request/package';
  static const portalContact = '/contact';
  static const splash = '/splash';

  // Signal-first Web Surfaces [S]
  static const sIndex = '/s';
  static const sPersonalSpace = '/s/personal-space';
  static const sSupportRoom = '/s/support-room';
  static const sRegistryRoom = '/s/registry-room';
  static const sDeclarationReviewRoom = '/s/declaration-review-room';

  // Public City Web [S]: marketplace/discovery surface only.
  static const sCityHome = '/s/city';
  static const sCityServices = '/s/city/services';
  static const sCityTools = '/s/city/tools';
  static const sCityLibrary = '/s/city/library';
  static const sCityProviders = '/s/city/providers';
  static const sCityCenters = '/s/city/centers';
  static const sCityOrganizations = '/s/city/organizations';
  static const sCityPrograms = '/s/city/programs';
  static const sCityMarketplace = '/s/city/marketplace';

  // Federation Capital Web [S]: observability and departments only.
  static const sCapitalHome = '/s/capital';
  static const sCapitalOperationsOffice = '/s/capital/operations-office';
  static const sCapitalIncidents = '/s/capital/incidents';
  static const sCapitalMaintenance = '/s/capital/maintenance';
  static const sCapitalBroadcasts = '/s/capital/broadcasts';
  static const sCapitalEmergencyBrief = '/s/capital/emergency-brief';
  static const sSignalMonitoringRoom = '/s/capital/signal-monitoring-room';
  static const sCapitalDepartments = '/s/capital/departments';
  static const sTrustSafety = '/s/capital/trust-safety';
  static const sCapitalReports = '/s/capital/reports';

  // Sovereign Owner Web [S]: sovereign decision and memory surface only.
  static const sOwnerHome = '/s/owner';
  static const sOwnerRoom = '/s/owner/room';
  static const sSovereignIntelligence = '/s/owner/sovereign-intelligence';
  static const sStrategicMemory = '/s/owner/strategic-memory';
  static const sSovereignVault = '/s/owner/sovereign-vault';
  static const sConstitutionalMemory = '/s/owner/constitutional-memory';
  static const sRecoveryConsole = '/s/owner/recovery-console';
  static const sOwnerCapsules = '/s/owner/capsules';
  static const sOwnerRegeneration = '/s/owner/regeneration';

  // Web Registration Portal
  static const webCenterRegister = '/web/center/register';
  static const webCenterProfile = '/web/center/profile';
  static const webCenterMedia = '/web/center/media';
  static const webCenterPricing = '/web/center/pricing';
  static const webCenterDocuments = '/web/center/documents';
  static const webClinicianRegister = '/web/clinician/register';
  static const webClinicianProfile = '/web/clinician/profile';
  static const webClinicianDocuments = '/web/clinician/documents';
  static const webLibrary = '/web/library';
  static const webLibraryPolicy = '/web/library/policy';
  static const webRegistrationSuccess = '/web/register/success';
  static const language = '/language';
  // Shell alias: /home intentionally opens the operational menu hub.
  // HomePage remains a welcome entry surface, not the primary shell.
  static const home = '/home';
  static const login = '/login';
  static const blockedAccount = '/account-blocked';
  static const menu = '/menu';

  static const clientRegister = '/register/client';
  // Alias: app registration entry; same destination as webClinicianRegister.
  static const clinicianRegister = '/register/clinician';
  // Alias: app registration entry; same destination as webCenterRegister.
  static const centerRegister = '/register/center';
  static const clinicianRoom = '/clinician/room';
  static const clinicianProfileEditRequest = '/clinician/profile-edit-request';
  static const clinicianChatInbox = '/clinician/chat-inbox';

  static const clientDashboard = '/client/dashboard';

  static const centerDashboard = '/center/dashboard';
  static const centerRoom = '/center/room';
  static const centerProfileEditRequest = '/center/profile-edit-request';

  static const chat = '/chat';
  static const chatEscalations = '/chat/escalations';
  static const chatEscalationReport = '/chat/escalation/report';

  static const addiction = '/module/addiction';
  static const specialNeeds = '/module/special_needs';
  static const supportIssueSelector = '/module/support-issue-selector';
  static const specialists = '/module/specialists';
  static const specialistsList = '/module/specialists/list';
  static const specialistDetails = '/module/specialists/details';

  static const centers = '/module/centers';
  static const centersList = '/module/centers/list';
  static const centerDetails = '/module/centers/details';

  // Alias: webLibrary opens the same LibraryPage as this in-app library route.
  static const library = '/module/library';

}
