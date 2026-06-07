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

  // Administrative Capital Web [S]: observability and departments only.
  static const sCapitalHome = '/s/capital';
  static const sCapitalAdminOffice = '/s/capital/admin-office';
  static const sCapitalIncidents = '/s/capital/incidents';
  static const sCapitalMaintenance = '/s/capital/maintenance';
  static const sCapitalBroadcasts = '/s/capital/broadcasts';
  static const sCapitalEmergencyBrief = '/s/capital/emergency-brief';
  static const sSignalControlRoom = '/s/capital/signal-control-room';
  static const sCapitalDepartments = '/s/capital/departments';
  static const sTrustSafety = '/s/capital/trust-safety';
  static const sFollowUpContinuity = '/s/capital/follow-up-continuity';
  static const sCapitalReports = '/s/capital/reports';
  static const sAdministrativeArchive = '/s/capital/admin-archive';

  // Sovereign Owner Web [S]: sovereign decision and memory surface only.
  static const sOwnerHome = '/s/owner';
  static const sOwnerRoom = '/s/owner/room';
  static const sSovereignIntelligence = '/s/owner/sovereign-intelligence';
  static const sStrategicArchive = '/s/owner/strategic-archive';
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
  // HomePage remains a welcome/legacy entry surface, not the primary shell.
  static const home = '/home';
  static const login = '/login';
  static const blockedAccount = '/account-blocked';
  static const menu = '/menu';

  static const clientRegister = '/register/client';
  // Alias: legacy app registration entry; same destination as webClinicianRegister.
  static const clinicianRegister = '/register/clinician';
  // Alias: legacy app registration entry; same destination as webCenterRegister.
  static const centerRegister = '/register/center';
  static const followUpRegistration = '/follow-up/register';
  static const followUpTemplates = '/workspace/external-follow-up/templates';
  static const followUpCampaigns = '/workspace/external-follow-up/campaigns';
  static const followUpCampaignDetails =
      '/workspace/external-follow-up/campaigns/details';

  static const clinicianOperations = '/clinician/operations';
  static const clinicianProfileEditRequest = '/clinician/profile-edit-request';
  static const clinicianInbox = '/clinician/inbox';
  static const clinicianChatInbox = '/clinician/chat-inbox';
  // Alias retained for old deep links into the clinician chat inbox.
  static const clinicianChatInboxLegacy = '/chat/clinician/inbox';

  static const clientDashboard = '/client/dashboard';

  static const centerDashboard = '/center/dashboard';
  static const centerOperations = '/center/operations';
  static const centerProfileEditRequest = '/center/profile-edit-request';
  static const centerInbox = '/center/inbox';

  static const chat = '/chat';
  static const chatEscalations = '/chat/escalations';
  static const chatEscalationReport = '/chat/escalation/report';

  static const addiction = '/module/addiction';
  static const specialNeeds = '/module/special_needs';
  static const supportIssueSelector = '/module/support-issue-selector';
  // Preview placeholder: route exists but is not operationally production-ready.
  static const familyStress = '/module/family_stress';
  static const specialists = '/module/specialists';
  static const specialistsList = '/module/specialists/list';
  static const specialistDetails = '/module/specialists/details';

  static const centers = '/module/centers';
  static const centersList = '/module/centers/list';
  static const centerDetails = '/module/centers/details';

  // Alias: webLibrary opens the same LibraryPage as this in-app library route.
  static const library = '/module/library';

  static const adminHub = '/admin/hub';
  static const adminOperations = '/admin/operations';
  static const adminCommunications = '/admin/communications';
  static const adminClients = '/admin/clients';
  static const adminRegistrationMaintenance = '/admin/registration-maintenance';
  static const adminClinicianRequests = '/admin/clinician-requests';
  static const adminClinicianWorkspace = '/admin/clinician-workspace';
  static const adminClinicianProfileRequests =
      '/admin/clinician-profile-requests';
  static const adminSupportChats = '/admin/support-chats';
  static const adminAlertsReview = '/admin/alerts-review';
  static const adminAiPolicies = '/admin/ai-policies';
  static const adminDomainStatus = '/admin/system-domains';
  static const adminContentCarePrograms = '/admin/content-care-programs';
  static const adminLibraryGovernance = '/admin/library-governance';
  static const adminSupportMessagingGovernance =
      '/admin/support-messaging-governance';
  static const adminFollowupCareGovernance = '/admin/followup-care-governance';
  static const adminAiFollowupBoundaries = '/admin/ai-followup-boundaries';
  // Preview/ops shell: visible for governance, not a live operational engine.
  static const adminGrowthLayer = '/admin/growth-layer';
  static const adminEmployeeSystem = '/admin/employee-system';
  static const adminMaintenanceSystem = '/admin/maintenance';
  // Preview/ops shell: UI actions remain supervised and are not automation.
  static const adminAiDevOpsCenter = '/admin/ai-devops';
  static const adminDomainAvailability = '/admin/domain-availability';
  static const adminFunctionalWorkspaces = '/admin/functional-workspaces';
  static const externalFollowUpWorkspace = '/workspace/external-follow-up';
  static const customerFollowUpWorkspace = '/workspace/customer-follow-up';
  static const technicalSupportWorkspace = '/workspace/technical-support';
  static const marketingWorkspace = '/workspace/marketing';
  // Preview/content shell: external tools are launcher-style, not integrated.
  static const adminWorkspaceCommandCenter = '/admin/workspace-command-center';
  static const contentWorkspace = '/workspace/content';
  // Preview placeholders: Control Room shells, not operational execution surfaces.
  static const adminGuidedWorkflows = '/admin/control-room/guided-workflows';
  static const adminReferences = '/admin/control-room/references';
  static const adminDetailedMonitoring =
      '/admin/control-room/detailed-monitoring';
  static const adminAnalyticsDetails = '/admin/control-room/analytics-details';
  static const adminBlueprintHandoff = '/admin/blueprint-handoff';
  static const adminComplianceCheckpoints = '/admin/compliance-checkpoints';
  static const adminExposureRules = '/admin/exposure-rules';
  static const adminActivationReadiness = '/admin/activation-readiness';
  static const adminSystemActivationPack = '/admin/system-activation-pack';
  // Preview gateway routes: governance/visibility shells, not live integrations.
  static const adminGatewayLayer = '/admin/gateways';
  static const adminCommunicationGateway = '/admin/gateways/communication';
  static const adminEngineeringGateway = '/admin/gateways/engineering';
  static const adminDeviceStorageGateway = '/admin/gateways/device-storage';
  static const adminCenters = '/admin/centers';
  static const adminCenterDetails = '/admin/centers/details';
  static const adminArchive = '/admin/archive';
  static const adminArchiveReports = '/admin/archive/reports';
  static const adminArchiveClinicians = '/admin/archive/clinicians';
  static const adminArchiveCenters = '/admin/archive/centers';
  static const adminArchiveSupport = '/admin/archive/support';
}
