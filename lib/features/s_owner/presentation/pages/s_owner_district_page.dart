import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';

enum SOwnerDistrictFocus {
  overview,
  ownerRoom,
  strategicArchive,
  constitutionalMemory,
  sovereignVault,
  survivalCapsules,
  regenerationBoard,
  executiveIntelligence,
  recoveryConsole,
}

// [S] Owner District Package
// Construction Era placeholder. No Firebase writes.
class SOwnerDistrictPage extends StatelessWidget {
  const SOwnerDistrictPage({
    super.key,
    this.focus = SOwnerDistrictFocus.overview,
  });

  final SOwnerDistrictFocus focus;

  @override
  Widget build(BuildContext context) {
    final panels = _panelsForFocus(focus);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        title: const Text('[S] Sovereign Owner Web'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _OwnerHero(),
                  const SizedBox(height: 18),
                  const _OwnerNavigation(),
                  const SizedBox(height: 18),
                  const _OwnerOverviewCard(),
                  const SizedBox(height: 18),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 900;
                      if (!isWide) {
                        return Column(
                          children: panels
                              .map(
                                (panel) => Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: panel,
                                ),
                              )
                              .toList(growable: false),
                        );
                      }
                      return Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: panels
                            .map(
                              (panel) => SizedBox(
                                width: (constraints.maxWidth - 14) / 2,
                                child: panel,
                              ),
                            )
                            .toList(growable: false),
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  const _OwnerDoctrineFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static List<Widget> _panelsForFocus(SOwnerDistrictFocus focus) {
    switch (focus) {
      case SOwnerDistrictFocus.ownerRoom:
        return const <Widget>[_OwnerRoomPanel()];
      case SOwnerDistrictFocus.strategicArchive:
        return const <Widget>[_StrategicArchiveHall()];
      case SOwnerDistrictFocus.constitutionalMemory:
        return const <Widget>[_ConstitutionalMemoryPanel()];
      case SOwnerDistrictFocus.sovereignVault:
        return const <Widget>[_SovereignVaultPanel()];
      case SOwnerDistrictFocus.survivalCapsules:
        return const <Widget>[_SurvivalCapsuleCenter()];
      case SOwnerDistrictFocus.regenerationBoard:
        return const <Widget>[_RegenerationBoard()];
      case SOwnerDistrictFocus.executiveIntelligence:
        return const <Widget>[_ExecutiveIntelligencePanel()];
      case SOwnerDistrictFocus.recoveryConsole:
        return const <Widget>[
          _SurvivalCapsuleCenter(),
          _RegenerationBoard(),
        ];
      case SOwnerDistrictFocus.overview:
        return const <Widget>[
          _OwnerRoomPanel(),
          _StrategicArchiveHall(),
          _ConstitutionalMemoryPanel(),
          _SovereignVaultPanel(),
          _SurvivalCapsuleCenter(),
          _RegenerationBoard(),
          _ExecutiveIntelligencePanel(),
        ];
    }
  }
}

class _OwnerHero extends StatelessWidget {
  const _OwnerHero();

  @override
  Widget build(BuildContext context) {
    return const _OwnerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Stamp(text: '[S] Owner District'),
          SizedBox(height: 14),
          Text(
            'Federation Survival, Memory, And Regeneration',
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'The Owner District sees the whole map, protects sovereign memory, '
            'coordinates continuity, and prepares recovery paths. It is not '
            'governance operations and it is not a monitoring room.',
            style: TextStyle(
              color: Color(0xFF40506A),
              fontSize: 16,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _OwnerNavigation extends StatelessWidget {
  const _OwnerNavigation();

  static const _items = <_NavItem>[
    _NavItem('Overview', Routes.sOwnerHome),
    _NavItem('Owner Room', Routes.sOwnerRoom),
    _NavItem('Strategic Memory', Routes.sStrategicMemory),
    _NavItem('Constitutional Memory', Routes.sConstitutionalMemory),
    _NavItem('Sovereign Vault', Routes.sSovereignVault),
    _NavItem('Survival Capsules', Routes.sOwnerCapsules),
    _NavItem('Regeneration Board', Routes.sOwnerRegeneration),
    _NavItem('Executive Intelligence', Routes.sSovereignIntelligence),
    _NavItem('Recovery Console', Routes.sRecoveryConsole),
    _NavItem('Construction Workbench', Routes.ownerConstructionWorkbench),
  ];

  @override
  Widget build(BuildContext context) {
    return _OwnerCard(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: _items
            .map(
              (item) => OutlinedButton(
                onPressed: () => Navigator.of(context).pushNamed(item.route),
                child: Text(item.label),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _OwnerOverviewCard extends StatelessWidget {
  const _OwnerOverviewCard();

  @override
  Widget build(BuildContext context) {
    return const _OwnerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            title: '[S] Owner Overview',
            subtitle:
                'Placeholder survival visibility for the whole federation.',
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _StatusPill(label: 'City Status', value: 'Placeholder'),
              _StatusPill(label: 'Capital Status', value: 'Placeholder'),
              _StatusPill(label: 'Archive Status', value: 'Placeholder'),
              _StatusPill(label: 'Recovery Status', value: 'Placeholder'),
            ],
          ),
        ],
      ),
    );
  }
}

class _OwnerRoomPanel extends StatelessWidget {
  const _OwnerRoomPanel();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Owner Room',
      subtitle:
          'Sovereign view placeholder. It authorizes; it does not operate.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Whole Map View', <String>[
          'City overview placeholder',
          'Capital overview placeholder',
        ]),
        _DistrictGroup('Continuity Coordination', <String>[
          'Organ coordination placeholder',
          'Survival readiness placeholder',
        ]),
        _DistrictGroup('Authority Boundary', <String>[
          'Owner authorizes',
          'Departments act',
          'Monitoring observes',
          'Aggregated intelligence only',
          'No raw user activity',
          'No individual profiles by default',
        ]),
      ],
    );
  }
}

class _StrategicArchiveHall extends StatelessWidget {
  const _StrategicArchiveHall();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Strategic Archive',
      subtitle: 'Strategic memory placeholders for owner-level continuity.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Strategic Reports', <String>[
          'Report index placeholder',
          'Monthly intelligence summaries',
          'Annual ecosystem reviews',
        ]),
        _DistrictGroup('Historical Decisions', <String>[
          'Decision record placeholder',
          'Governance decisions',
        ]),
        _DistrictGroup('Federation Milestones', <String>[
          'Milestone timeline placeholder',
        ]),
        _DistrictGroup('Weekly Summaries', <String>[
          'Summary placeholder',
        ]),
      ],
    );
  }
}

class _ConstitutionalMemoryPanel extends StatelessWidget {
  const _ConstitutionalMemoryPanel();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Constitutional Memory',
      subtitle: 'Memory of governance and architecture evolution.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Constitution Versions', <String>[
          'Version list placeholder',
        ]),
        _DistrictGroup('Governance Milestones', <String>[
          'Governance milestone placeholder',
        ]),
        _DistrictGroup('Architecture Milestones', <String>[
          'Architecture milestone placeholder',
        ]),
        _DistrictGroup('Federation Evolution', <String>[
          'Evolution history placeholder',
        ]),
      ],
    );
  }
}

class _SovereignVaultPanel extends StatelessWidget {
  const _SovereignVaultPanel();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Sovereign Vault',
      subtitle:
          'Vault structure only. No secrets, credentials, keys, or passwords.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Ownership Records', <String>[
          'Ownership reference placeholder',
        ]),
        _DistrictGroup('Recovery References', <String>[
          'Recovery reference placeholder',
        ]),
        _DistrictGroup('Domain References', <String>[
          'Domain reference placeholder',
        ]),
        _DistrictGroup('Infrastructure References', <String>[
          'Infrastructure reference placeholder',
        ]),
      ],
    );
  }
}

class _SurvivalCapsuleCenter extends StatelessWidget {
  const _SurvivalCapsuleCenter();

  @override
  Widget build(BuildContext context) {
    return const _OwnerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            title: '[S] Survival Capsule Center',
            subtitle:
                'Capsules describe rebuild readiness only. No live recovery action is attached.',
          ),
          SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _CapsuleCard(title: 'Commercial Capsule'),
              _CapsuleCard(title: 'Residential Capsule'),
              _CapsuleCard(title: 'Monitoring Capsule'),
              _CapsuleCard(title: 'Archive Capsule'),
            ],
          ),
        ],
      ),
    );
  }
}

class _RegenerationBoard extends StatelessWidget {
  const _RegenerationBoard();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Federation Regeneration Board',
      subtitle: 'Rebuild map placeholders for continuity after failure.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Recoverable Organs', <String>[
          'Organ list placeholder',
        ]),
        _DistrictGroup('Recovery Paths', <String>[
          'Path placeholder',
        ]),
        _DistrictGroup('Rebuild Readiness', <String>[
          'Readiness placeholder',
        ]),
        _DistrictGroup('Federation Continuity Status', <String>[
          'Continuity placeholder',
        ]),
      ],
    );
  }
}

class _ExecutiveIntelligencePanel extends StatelessWidget {
  const _ExecutiveIntelligencePanel();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Executive Intelligence',
      subtitle:
          'Strategic summary placeholders. Intelligence informs; it does not decide.',
      groups: <_DistrictGroup>[
        _DistrictGroup('AI Strategic Summary', <String>[
          'AI summary placeholder',
          'AI does not decide',
        ]),
        _DistrictGroup('Signal-First Intelligence', <String>[
          'Aggregated signal trends',
          'Gap detection summaries',
          'Expansion opportunity notes',
        ]),
        _DistrictGroup('Human Strategic Summary', <String>[
          'Human summary placeholder',
        ]),
        _DistrictGroup('Department Summary', <String>[
          'Department summary placeholder',
        ]),
        _DistrictGroup('Federation Summary', <String>[
          'Federation summary placeholder',
        ]),
      ],
    );
  }
}

class _DistrictCard extends StatelessWidget {
  const _DistrictCard({
    required this.title,
    required this.subtitle,
    required this.groups,
  });

  final String title;
  final String subtitle;
  final List<_DistrictGroup> groups;

  @override
  Widget build(BuildContext context) {
    return _OwnerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(title: title, subtitle: subtitle),
          const SizedBox(height: 14),
          for (final group in groups)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _LabelRow(title: group.title, values: group.values),
            ),
        ],
      ),
    );
  }
}

class _LabelRow extends StatelessWidget {
  const _LabelRow({
    required this.title,
    required this.values,
  });

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: _OwnerTextStyles.groupTitle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: values
              .map((value) => _SignalBadge(label: value))
              .toList(growable: false),
        ),
      ],
    );
  }
}

class _CapsuleCard extends StatelessWidget {
  const _CapsuleCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FB),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE1E5EE)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF172033),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              const _MiniLine(label: 'Status', value: 'Placeholder'),
              const _MiniLine(label: 'Last Snapshot', value: 'Not connected'),
              const _MiniLine(
                  label: 'Recovery Readiness', value: 'Placeholder'),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniLine extends StatelessWidget {
  const _MiniLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Color(0xFF40506A),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
      ),
    );
  }
}

class _OwnerDoctrineFooter extends StatelessWidget {
  const _OwnerDoctrineFooter();

  @override
  Widget build(BuildContext context) {
    return const _OwnerCard(
      child: Text(
        'The city grows. The rooms evolve. The signals guide. The intelligence '
        'learns. Departments serve. Owner sees the whole picture. Archive '
        'remembers.',
        style: TextStyle(
          color: Color(0xFF40506A),
          fontSize: 15,
          fontWeight: FontWeight.w800,
          height: 1.4,
        ),
      ),
    );
  }
}

class _OwnerCard extends StatelessWidget {
  const _OwnerCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE1E5EE)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF172033),
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF667085),
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _SignalBadge extends StatelessWidget {
  const _SignalBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE1D7FF)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5630A6),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE1E5EE)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: Text(
          '$label: $value',
          style: const TextStyle(
            color: Color(0xFF26324A),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _Stamp extends StatelessWidget {
  const _Stamp({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF172033),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

class _DistrictGroup {
  const _DistrictGroup(this.title, this.values);

  final String title;
  final List<String> values;
}

class _NavItem {
  const _NavItem(this.label, this.route);

  final String label;
  final String route;
}

class _OwnerTextStyles {
  const _OwnerTextStyles._();

  static const TextStyle groupTitle = TextStyle(
    color: Color(0xFF172033),
    fontWeight: FontWeight.w800,
  );
}
