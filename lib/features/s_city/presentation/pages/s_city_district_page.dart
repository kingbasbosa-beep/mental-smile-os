import 'package:flutter/material.dart';
import 'package:flutterprojects/features/library/data/library_signal_metadata.dart';

// [S] City Center Package
// Construction Era asset. Reuses approved Library Signal Metadata only.
// Must remain free from booking/session/payment/accounting coupling.
class SCityDistrictPage extends StatelessWidget {
  const SCityDistrictPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final knowledgeAreas = <_KnowledgeArea>[
      for (final entry in LibrarySignalCatalog.categories.entries)
        _KnowledgeArea(entry.key, entry.value),
      for (final entry in LibrarySignalCatalog.featured.entries)
        _KnowledgeArea(entry.key, entry.value),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        title: const Text('[S] City Center'),
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
                  const _CityHero(),
                  const SizedBox(height: 18),
                  _CityOverviewCard(knowledgeAreasCount: knowledgeAreas.length),
                  const SizedBox(height: 18),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 900;
                      final panels = <Widget>[
                        const _ProvidersDistrict(),
                        const _CentersDistrict(),
                        _KnowledgeDistrict(
                          areas: knowledgeAreas,
                          isArabic: isArabic,
                        ),
                        const _LearningDistrict(),
                        const _ToolsDistrict(),
                        const _CommunityDistrict(),
                        const _MarketplaceDistrict(),
                      ];
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
                  const _CitySafetyFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CityHero extends StatelessWidget {
  const _CityHero();

  @override
  Widget build(BuildContext context) {
    return const _CityCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Stamp(text: '[S] City Center'),
          SizedBox(height: 14),
          Text(
            'The Web Is The City Center',
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Explore providers, centers, knowledge, learning, tools, community, '
            'and marketplace districts. Discovery first. No queues, requests, '
            'sessions, or lifecycle ownership.',
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

class _CityOverviewCard extends StatelessWidget {
  const _CityOverviewCard({required this.knowledgeAreasCount});

  final int knowledgeAreasCount;

  @override
  Widget build(BuildContext context) {
    return _CityCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            title: '[S] City Overview',
            subtitle: 'Placeholder city counts for clean construction.',
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              const _CounterPill(label: 'Providers', count: 0),
              const _CounterPill(label: 'Centers', count: 0),
              const _CounterPill(label: 'Learning paths', count: 3),
              _CounterPill(
                  label: 'Knowledge areas', count: knowledgeAreasCount),
              const _CounterPill(label: 'Tools', count: 4),
              const _CounterPill(label: 'Marketplace', count: 0),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProvidersDistrict extends StatelessWidget {
  const _ProvidersDistrict();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Providers',
      subtitle: 'Provider discovery without requests or sessions.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Featured Providers', <String>[
          'Coming soon',
        ]),
        _DistrictGroup('Provider Categories', <String>[
          'Recovery support',
          'Family support',
          'Children support',
          'Accessibility support',
        ]),
        _DistrictGroup('Provider Discovery', <String>[
          'Explore by signals',
          'Explore by focus area',
        ]),
        _DistrictGroup('Provider Signals Preview', <String>[
          'Capability signals',
          'Accessibility signals',
          'Communication signals',
        ]),
      ],
    );
  }
}

class _CentersDistrict extends StatelessWidget {
  const _CentersDistrict();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Centers',
      subtitle: 'Center discovery without residency or lifecycle workflow.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Featured Centers', <String>[
          'Coming soon',
        ]),
        _DistrictGroup('Center Categories', <String>[
          'Recovery',
          'Family support',
          'Accessibility',
          'Education',
        ]),
        _DistrictGroup('Center Discovery', <String>[
          'Explore by programs',
          'Explore by support focus',
        ]),
      ],
    );
  }
}

class _KnowledgeDistrict extends StatelessWidget {
  const _KnowledgeDistrict({
    required this.areas,
    required this.isArabic,
  });

  final List<_KnowledgeArea> areas;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _CityCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            title: '[S] Knowledge',
            subtitle: 'Library, awareness, prevention, recovery, and access.',
          ),
          const SizedBox(height: 14),
          const _LabelRow(
            title: 'Knowledge paths',
            values: <String>[
              'Library',
              'Awareness',
              'Prevention',
              'Recovery',
              'Family Resources',
              'Accessibility Resources',
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Library Signal Metadata',
            style: _CityTextStyles.groupTitle,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: areas
                .map(
                  (area) => _SignalBadge(
                    label: _knowledgeLabel(area, isArabic: isArabic),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }

  static String _knowledgeLabel(
    _KnowledgeArea area, {
    required bool isArabic,
  }) {
    final keys = area.metadata.displaySignalKeys;
    if (keys.isEmpty) return area.key;
    final labels = keys
        .map((key) => LibrarySignalLabels.label(key, isArabic: isArabic))
        .join(' / ');
    return '${area.key}: $labels';
  }
}

class _LearningDistrict extends StatelessWidget {
  const _LearningDistrict();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Learning',
      subtitle: 'Future courses, diplomas, educational centers, and tracks.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Learning Tracks', <String>[
          'Recovery learning',
          'Family learning',
          'Accessibility learning',
        ]),
        _DistrictGroup('Future Learning Offers', <String>[
          'Courses',
          'Diplomas',
          'Educational centers',
        ]),
      ],
    );
  }
}

class _ToolsDistrict extends StatelessWidget {
  const _ToolsDistrict();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Tools',
      subtitle: 'Reusable capabilities. Tools are not departments.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Support Tools', <String>[
          'Guided support notes',
        ]),
        _DistrictGroup('Accessibility Tools', <String>[
          'Simplified reading',
          'Visual support',
        ]),
        _DistrictGroup('Recovery Tools', <String>[
          'Reflection prompts',
        ]),
        _DistrictGroup('Learning Tools', <String>[
          'Learning path notes',
        ]),
        _DistrictGroup('Future Business Tools', <String>[
          'Productivity',
          'Planning',
          'Marketing',
          'Business management',
        ]),
      ],
    );
  }
}

class _CommunityDistrict extends StatelessWidget {
  const _CommunityDistrict();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Community',
      subtitle: 'Future campaigns, events, initiatives, and volunteering.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Community Initiatives', <String>[
          'Awareness campaigns',
          'Events',
          'Volunteer opportunities',
        ]),
        _DistrictGroup('Human Belonging', <String>[
          'Family support',
          'Recovery belonging',
          'Accessibility inclusion',
        ]),
      ],
    );
  }
}

class _MarketplaceDistrict extends StatelessWidget {
  const _MarketplaceDistrict();

  @override
  Widget build(BuildContext context) {
    return const _DistrictCard(
      title: '[S] Marketplace',
      subtitle: 'Future optional tools, themes, add-ons, and service packages.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Optional Extensions', <String>[
          'Premium tools',
          'Room themes',
          'Add-ons',
        ]),
        _DistrictGroup('Service Packages', <String>[
          'Provider packages',
          'Center packages',
          'Learning packages',
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
    return _CityCard(
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
        Text(title, style: _CityTextStyles.groupTitle),
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

class _CitySafetyFooter extends StatelessWidget {
  const _CitySafetyFooter();

  @override
  Widget build(BuildContext context) {
    return const _CityCard(
      child: Text(
        'The city discovers. The rooms personalize. Signals guide. '
        'Booking stays contained as legacy operations.',
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

class _CityCard extends StatelessWidget {
  const _CityCard({required this.child});

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

class _KnowledgeArea {
  const _KnowledgeArea(this.key, this.metadata);

  final String key;
  final LibrarySignalMetadata metadata;
}

class _CityTextStyles {
  const _CityTextStyles._();

  static const TextStyle groupTitle = TextStyle(
    color: Color(0xFF172033),
    fontWeight: FontWeight.w800,
  );
}

