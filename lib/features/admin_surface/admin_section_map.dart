import 'package:flutterprojects/app/router/routes.dart';

enum AdminTopLevelSection {
  operations,
  communications,
  controlRoom,
  directoryApprovals,
  governance,
  gatewayLayer,
  archive,
}

class AdminSectionEntry {
  const AdminSectionEntry({
    required this.route,
    required this.title,
    required this.section,
    required this.purpose,
  });

  final String route;
  final String title;
  final AdminTopLevelSection section;
  final String purpose;
}

const List<AdminSectionEntry> adminSectionEntries = [
  AdminSectionEntry(
    route: Routes.adminHub,
    title: 'Admin Home',
    section: AdminTopLevelSection.controlRoom,
    purpose: 'Executive launchpad with advisory, health, and section entry.',
  ),
  AdminSectionEntry(
    route: '/admin/booking-queue',
    title: 'Booking Monitoring & Exception Board',
    section: AdminTopLevelSection.operations,
    purpose:
        'Monitoring and exception review for booking flow signals. Normal workflow progression should remain with the core owners.',
  ),
  AdminSectionEntry(
    route: Routes.adminPayments,
    title: 'Payment Monitoring & Financial Gate',
    section: AdminTopLevelSection.operations,
    purpose:
        'Monitoring, financial gate review, and exception-only payout confirmation. Normal flow ownership should remain outside Control Room.',
  ),
  AdminSectionEntry(
    route: Routes.adminSessions,
    title: 'Sessions Monitoring & Exception Control',
    section: AdminTopLevelSection.operations,
    purpose:
        'Session readiness monitoring, link visibility, and exception-only state correction. Normal workflow progression should remain with the core owners.',
  ),
  AdminSectionEntry(
    route: Routes.adminSessionReport,
    title: 'Session Report',
    section: AdminTopLevelSection.operations,
    purpose: 'Secondary reporting utility for session-related review.',
  ),
  AdminSectionEntry(
    route: Routes.adminSupportChats,
    title: 'Legacy Support Threads',
    section: AdminTopLevelSection.communications,
    purpose:
        'Historical chat threads only. New support requests are handled via structured support requests.',
  ),
  AdminSectionEntry(
    route: Routes.chatEscalations,
    title: 'Escalated Cases (Historical)',
    section: AdminTopLevelSection.communications,
    purpose:
        'Historical escalated cases only. New support requests are handled via structured support requests.',
  ),
  AdminSectionEntry(
    route: Routes.adminClinicianRequests,
    title: 'Clinician Registrations',
    section: AdminTopLevelSection.directoryApprovals,
    purpose: 'Clinician account approvals and related admin actions.',
  ),
  AdminSectionEntry(
    route: Routes.adminClinicianProfileRequests,
    title: 'Profile/Data Requests',
    section: AdminTopLevelSection.directoryApprovals,
    purpose: 'Clinician and center profile/data change request review.',
  ),
  AdminSectionEntry(
    route: Routes.adminCenters,
    title: 'Centers Management',
    section: AdminTopLevelSection.directoryApprovals,
    purpose: 'Center approvals, activation, and management.',
  ),
  AdminSectionEntry(
    route: Routes.adminClients,
    title: 'Clients Management',
    section: AdminTopLevelSection.directoryApprovals,
    purpose: 'Client directory search, blocking, and account review.',
  ),
  AdminSectionEntry(
    route: Routes.adminAiPolicies,
    title: 'AI Policies',
    section: AdminTopLevelSection.governance,
    purpose: 'Policy inspection, draft/publish workflow, and policy review.',
  ),
  AdminSectionEntry(
    route: Routes.adminDomainStatus,
    title: 'System Domains',
    section: AdminTopLevelSection.governance,
    purpose: 'Domain health, governance visibility, and status metadata.',
  ),
  AdminSectionEntry(
    route: '/admin/alerts-review',
    title: 'Alerts Review',
    section: AdminTopLevelSection.controlRoom,
    purpose:
        'Detailed review of generated operational alerts for monitoring and exception handling.',
  ),
  AdminSectionEntry(
    route: Routes.adminArchive,
    title: 'Archive Home',
    section: AdminTopLevelSection.archive,
    purpose: 'Archive landing for historical lookup and reporting.',
  ),
  AdminSectionEntry(
    route: Routes.adminArchiveSessions,
    title: 'Sessions Archive',
    section: AdminTopLevelSection.archive,
    purpose: 'Archived session records and historical session flows.',
  ),
  AdminSectionEntry(
    route: Routes.adminArchivePayments,
    title: 'Payments Archive',
    section: AdminTopLevelSection.archive,
    purpose: 'Archived payment and transfer records.',
  ),
  AdminSectionEntry(
    route: Routes.adminArchiveReports,
    title: 'Reports Archive',
    section: AdminTopLevelSection.archive,
    purpose: 'Archived reports, summaries, and archive-scoped analysis.',
  ),
  AdminSectionEntry(
    route: Routes.adminArchiveClinicians,
    title: 'Clinicians Archive',
    section: AdminTopLevelSection.archive,
    purpose: 'Archived clinician-related records and history.',
  ),
  AdminSectionEntry(
    route: Routes.adminArchiveCenters,
    title: 'Centers Archive',
    section: AdminTopLevelSection.archive,
    purpose: 'Archived center-related records and history.',
  ),
  AdminSectionEntry(
    route: Routes.adminArchiveSupport,
    title: 'Support Archive',
    section: AdminTopLevelSection.archive,
    purpose: 'Archived support threads, messages, and escalations.',
  ),
  AdminSectionEntry(
    route: Routes.adminArchiveAccounting,
    title: 'Accounting Archive',
    section: AdminTopLevelSection.archive,
    purpose: 'Archived accounting and finance-oriented records.',
  ),
];
