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
    title: 'Booking Requests',
    section: AdminTopLevelSection.operations,
    purpose: 'Primary operational intake and workflow queue.',
  ),
  AdminSectionEntry(
    route: Routes.adminPayments,
    title: 'Payments & Transfers',
    section: AdminTopLevelSection.operations,
    purpose: 'Payment review, approvals, and payout-related actions.',
  ),
  AdminSectionEntry(
    route: Routes.adminSessions,
    title: 'Sessions & Links',
    section: AdminTopLevelSection.operations,
    purpose: 'Scheduling, session links, codes, and session state actions.',
  ),
  AdminSectionEntry(
    route: Routes.adminSessionReport,
    title: 'Session Report',
    section: AdminTopLevelSection.operations,
    purpose: 'Secondary reporting utility for session-related review.',
  ),
  AdminSectionEntry(
    route: Routes.adminSupportChats,
    title: 'Messages & Support',
    section: AdminTopLevelSection.communications,
    purpose: 'Human support inbox and direct admin conversations.',
  ),
  AdminSectionEntry(
    route: Routes.chatEscalations,
    title: 'Chat Escalations',
    section: AdminTopLevelSection.communications,
    purpose: 'Escalated conversation cases and communication triage.',
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
    purpose: 'Detailed review of generated operational alerts.',
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
