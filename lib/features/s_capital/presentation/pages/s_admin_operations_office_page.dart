import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

enum SCapitalOfficeFocus {
  overview,
  adminOffice,
  incidents,
  maintenance,
  broadcasts,
  emergencyBrief,
}

// [S] Admin Operations Office Package
// Construction Era placeholder. No Firebase, workflow, or legacy data coupling.
class SAdminOperationsOfficePage extends StatelessWidget {
  const SAdminOperationsOfficePage({
    super.key,
    this.focus = SCapitalOfficeFocus.overview,
  });

  final SCapitalOfficeFocus focus;

  @override
  Widget build(BuildContext context) {
    final panels = _panelsForFocus(focus);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        title: const Text('[S] Administrative Capital'),
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
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const _CapitalHero(),
                  const SizedBox(height: 18),
                  const _CapitalNavigation(),
                  const SizedBox(height: 18),
                  const _CapitalOverviewCard(),
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
                  const _CapitalDoctrineFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static List<Widget> _panelsForFocus(SCapitalOfficeFocus focus) {
    switch (focus) {
      case SCapitalOfficeFocus.adminOffice:
        return const <Widget>[_AdminOperationsOffice()];
      case SCapitalOfficeFocus.incidents:
        return const <Widget>[_IncidentCenter()];
      case SCapitalOfficeFocus.maintenance:
        return const <Widget>[_MaintenanceCenter()];
      case SCapitalOfficeFocus.broadcasts:
        return const <Widget>[_BroadcastCenter()];
      case SCapitalOfficeFocus.emergencyBrief:
        return const <Widget>[_EmergencyOwnerBrief()];
      case SCapitalOfficeFocus.overview:
        return const <Widget>[
          _AdminOperationsOffice(),
          _IncidentCenter(),
          _MaintenanceCenter(),
          _BroadcastCenter(),
          _EmergencyOwnerBrief(),
        ];
    }
  }
}

class _CapitalHero extends StatelessWidget {
  const _CapitalHero();

  @override
  Widget build(BuildContext context) {
    return const _CapitalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Stamp(text: '[S] Admin Operations Office'),
          SizedBox(height: 14),
          Text(
            'Stay Calm. Keep The City Running.',
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Operations headquarters for coordination, incident awareness, '
            'maintenance visibility, broadcasts, and emergency owner brief. '
            'It operates; it does not decide.',
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

class _CapitalNavigation extends StatelessWidget {
  const _CapitalNavigation();

  static const _items = <_NavItem>[
    _NavItem('Admin Office', Routes.sCapitalAdminOffice),
    _NavItem('Signal Control Room', Routes.sSignalControlRoom),
    _NavItem('Incidents', Routes.sCapitalIncidents),
    _NavItem('Maintenance', Routes.sCapitalMaintenance),
    _NavItem('Broadcasts', Routes.sCapitalBroadcasts),
    _NavItem('Emergency Brief', Routes.sCapitalEmergencyBrief),
  ];

  @override
  Widget build(BuildContext context) {
    return _CapitalCard(
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

class _CapitalOverviewCard extends StatelessWidget {
  const _CapitalOverviewCard();

  @override
  Widget build(BuildContext context) {
    return const _CapitalCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            title: '[S] Capital Overview',
            subtitle: 'Placeholder operational visibility for the capital.',
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _CounterPill(label: 'Incidents', count: 0),
              _CounterPill(label: 'Maintenance', count: 0),
              _CounterPill(label: 'Broadcasts', count: 0),
              _CounterPill(label: 'Active departments', count: 0),
            ],
          ),
        ],
      ),
    );
  }
}

class _AdminOperationsOffice extends StatelessWidget {
  const _AdminOperationsOffice();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Admin Operations Office',
      subtitle: 'Coordinates daily operations without sovereign authority.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Daily Operations', <String>[
          'Today summary placeholder',
          'City status placeholder',
        ]),
        _DistrictGroup('Operations Notes', <String>[
          'Notes placeholder',
          'Manual observation placeholder',
        ]),
        _DistrictGroup('Coordination Board', <String>[
          'Department coordination placeholder',
          'Handoff placeholder',
        ]),
      ],
    );
  }
}

class _IncidentCenter extends StatelessWidget {
  const _IncidentCenter();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Incident Center',
      subtitle: 'Incident visibility only. No control workflow is attached.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Open Incidents', <String>[
          'No open incident data connected',
        ]),
        _DistrictGroup('Resolved Incidents', <String>[
          'No resolved incident data connected',
        ]),
        _DistrictGroup('Incident Timeline', <String>[
          'Timeline placeholder',
        ]),
      ],
    );
  }
}

class _MaintenanceCenter extends StatelessWidget {
  const _MaintenanceCenter();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Maintenance Center',
      subtitle: 'Maintenance visibility for planned and current work.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Planned Maintenance', <String>[
          'Planned window placeholder',
        ]),
        _DistrictGroup('Current Maintenance', <String>[
          'No current maintenance connected',
        ]),
        _DistrictGroup('Maintenance History', <String>[
          'History placeholder',
        ]),
      ],
    );
  }
}

class _BroadcastCenter extends StatelessWidget {
  const _BroadcastCenter();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Broadcast Center',
      subtitle: 'Announcements and broadcasts without messaging automation.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Internal Announcements', <String>[
          'Announcement placeholder',
        ]),
        _DistrictGroup('Operations Broadcasts', <String>[
          'Operations broadcast placeholder',
        ]),
        _DistrictGroup('Emergency Broadcasts', <String>[
          'Emergency broadcast placeholder',
        ]),
      ],
    );
  }
}

class _EmergencyOwnerBrief extends StatelessWidget {
  const _EmergencyOwnerBrief();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Emergency Owner Brief',
      subtitle: 'Emergency survival cabin only. This is not the Owner Room.',
      groups: <_DistrictGroup>[
        _DistrictGroup('System Status', <String>[
          'Status placeholder',
        ]),
        _DistrictGroup('Last Strategic Snapshot', <String>[
          'Snapshot placeholder',
        ]),
        _DistrictGroup('Emergency Contacts Placeholder', <String>[
          'Contacts not connected',
        ]),
        _DistrictGroup('Recovery Instructions Placeholder', <String>[
          'Recovery instructions not connected',
        ]),
        _DistrictGroup('Last Known Constitution Version Placeholder', <String>[
          'Constitution version not connected',
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
    return _CapitalCard(
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
        Text(title, style: _CapitalTextStyles.groupTitle),
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

class _CapitalDoctrineFooter extends StatelessWidget {
  const _CapitalDoctrineFooter();

  @override
  Widget build(BuildContext context) {
    return const _CapitalCard(
      child: Text(
        'Admin Office operates. Control Room observes. Owner Room decides. '
        'Sovereign Vault remembers.',
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

class _CapitalCard extends StatelessWidget {
  const _CapitalCard({required this.child});

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
        color: const Color(0xFFF1F5FF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFD7E2FF)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF2547A0),
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _CounterPill extends StatelessWidget {
  const _CounterPill({
    required this.label,
    required this.count,
  });

  final String label;
  final int count;

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
          '$label: $count',
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

class _CapitalTextStyles {
  const _CapitalTextStyles._();

  static const TextStyle groupTitle = TextStyle(
    color: Color(0xFF172033),
    fontWeight: FontWeight.w800,
  );
}
