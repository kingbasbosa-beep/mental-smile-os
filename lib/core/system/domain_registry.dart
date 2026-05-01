enum DomainKey {
  chat,
  booking,
  specialistWorkspace,
  aiPolicy,
  adminControl,
  library,
  reportsInsights,
  communication,
  marketing,
  externalSessions,
}

class DomainDefinition {
  const DomainDefinition({
    required this.key,
    required this.id,
    required this.displayName,
    required this.description,
    this.ownedCollections = const <String>[],
  });

  final DomainKey key;
  final String id;
  final String displayName;
  final String description;
  final List<String> ownedCollections;
}

const List<DomainDefinition> domainRegistry = <DomainDefinition>[
  DomainDefinition(
    key: DomainKey.chat,
    id: 'chat',
    displayName: 'Chat',
    description: 'Threads, escalations, human support routing, and chat flows.',
    ownedCollections: <String>[
      'chat_threads',
      'chat_escalations',
    ],
  ),
  DomainDefinition(
    key: DomainKey.booking,
    id: 'booking',
    displayName: 'Booking',
    description: 'Booking requests, payment states, and booking workflow data.',
    ownedCollections: <String>[
      'booking_requests',
      'bookingRequests',
    ],
  ),
  DomainDefinition(
    key: DomainKey.specialistWorkspace,
    id: 'specialistWorkspace',
    displayName: 'Specialist Workspace',
    description:
        'Clinician-facing assignments, sessions, reviews, and chat-case surfaces.',
  ),
  DomainDefinition(
    key: DomainKey.aiPolicy,
    id: 'aiPolicy',
    displayName: 'AI Policy',
    description:
        'AI runtime policy definitions, drafts, publishing, and policy inspection.',
    ownedCollections: <String>[
      'ai_policies',
    ],
  ),
  DomainDefinition(
    key: DomainKey.adminControl,
    id: 'adminControl',
    displayName: 'Admin Control',
    description: 'Central governance, monitoring, and operational oversight.',
    ownedCollections: <String>[
      'admins',
      'system_domains',
    ],
  ),
  DomainDefinition(
    key: DomainKey.library,
    id: 'library',
    displayName: 'Library',
    description: 'Knowledge, content, and educational reference surfaces.',
  ),
  DomainDefinition(
    key: DomainKey.reportsInsights,
    id: 'reportsInsights',
    displayName: 'Reports & Insights',
    description: 'Reports, analytics summaries, and operational insights.',
    ownedCollections: <String>[
      'sessionRatings',
      'system_alerts',
    ],
  ),
  DomainDefinition(
    key: DomainKey.communication,
    id: 'communication',
    displayName: 'Communication',
    description:
        'External messaging gateways such as Facebook, Telegram, and web chat bridges.',
  ),
  DomainDefinition(
    key: DomainKey.marketing,
    id: 'marketing',
    displayName: 'Marketing',
    description:
        'Campaigns, lead handling, channel performance, and growth operations.',
  ),
  DomainDefinition(
    key: DomainKey.externalSessions,
    id: 'externalSessions',
    displayName: 'External Sessions',
    description:
        'Zoom and future external session providers or integration-backed meeting flows.',
  ),
];

DomainDefinition domainDefinitionFor(DomainKey key) {
  return domainRegistry.firstWhere((domain) => domain.key == key);
}

extension DomainKeyX on DomainKey {
  DomainDefinition get definition => domainDefinitionFor(this);
}
