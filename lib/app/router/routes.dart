class Routes {
  static const splash = '/';
  static const language = '/language';
  static const home = '/home';
  static const login = '/login';
  static const blockedAccount = '/account-blocked';
  static const menu = '/menu';

  static const clientRegister = '/register/client';
  static const clinicianRegister = '/register/clinician';
  static const centerRegister = '/register/center';

  static const clinicianOperations = '/clinician/operations';
  static const clinicianSessions = '/clinician/sessions';
  static const clinicianInbox = '/clinician/inbox';
  static const clinicianChatInbox = '/clinician/chat-inbox';
  static const clinicianChatInboxLegacy = '/chat/clinician/inbox';

  static const clientDashboard = '/client/dashboard';
  static const clientPaymentProof = '/client/payment-proof';
  static const clientSessions = '/client/sessions';

  static const centerDashboard = '/center/dashboard';
  static const centerOperations = '/center/operations';
  static const centerInbox = '/center/inbox';
  static const centerResidencies = '/center/residencies';

  static const chat = '/chat';
  static const chatEscalations = '/chat/escalations';
  static const chatEscalationReport = '/chat/escalation/report';

  static const addiction = '/module/addiction';
  static const specialNeeds = '/module/special_needs';
  static const familyStress = '/module/family_stress';
  static const specialists = '/module/specialists';
  static const specialistsList = '/module/specialists/list';
  static const specialistDetails = '/module/specialists/details';

  static const centers = '/module/centers';
  static const centersList = '/module/centers/list';
  static const centerDetails = '/module/centers/details';
  static const centerBookingRequest = '/booking/center-request';

  static const library = '/module/library';
  static const booking = '/booking';
  static const bookingRequest = '/booking/request';
  static const myBookings = '/booking/my';

  static const adminHub = '/admin/hub';
  static const adminClients = '/admin/clients';
  static const adminClinicianRequests = '/admin/clinician-requests';
  static const adminClinicianProfileRequests =
      '/admin/clinician-profile-requests';
  static const adminSupportChats = '/admin/support-chats';
  static const adminAiPolicies = '/admin/ai-policies';
  static const adminCenters = '/admin/centers';
  static const adminArchive = '/admin/archive';
  static const adminArchiveSessions = '/admin/archive/sessions';
  static const adminArchivePayments = '/admin/archive/payments';
  static const adminArchiveReports = '/admin/archive/reports';
  static const adminArchiveClinicians = '/admin/archive/clinicians';
  static const adminArchiveCenters = '/admin/archive/centers';
  static const adminArchiveSupport = '/admin/archive/support';
  static const adminArchiveAccounting = '/admin/archive/accounting';
  static const adminPayments = '/admin/payments';
  static const adminSessions = '/admin/sessions';
  static const adminSessionReport = '/admin/session-report';

  static const sessionReview = '/session/review';
}
