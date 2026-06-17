enum DomainKey {
  chat,
  specialistWorkspace,
  aiPolicy,
  governance,
  library,
  reportsInsights,
  communication,
  marketing,
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
    key: DomainKey.specialistWorkspace,
    id: 'specialistWorkspace',
    displayName: 'Clinician Room',
    description: 'Clinician-facing visibility and support context surfaces.',
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
    key: DomainKey.governance,
    id: 'governance',
    displayName: 'Federation Governance',
    description:
        'Owner, monitoring, registry, review, support, and domain stewardship.',
    ownedCollections: <String>[
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
];

DomainDefinition domainDefinitionFor(DomainKey key) {
  return domainRegistry.firstWhere((domain) => domain.key == key);
}

extension DomainKeyX on DomainKey {
  DomainDefinition get definition => domainDefinitionFor(this);
}
