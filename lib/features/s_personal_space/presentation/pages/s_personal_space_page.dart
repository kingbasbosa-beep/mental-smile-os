import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// [S] Personal Space Package
// Construction Era asset. Reads only approved Client Room fields:
// clientSignals, privacyPreferences, and roomPreferences.
class SPersonalSpacePage extends StatelessWidget {
  const SPersonalSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.isAnonymous) {
      return const _SPersonalSpaceScaffold(
        child: _EmptyState(
          title: 'Sign in required',
          message: 'Personal Space opens after signing in.',
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('clients')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const _SPersonalSpaceScaffold(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data?.data() ?? const <String, dynamic>{};
        final clientSignals = _readMap(data['clientSignals']);
        final privacyPreferences = _readMap(data['privacyPreferences']);
        final roomPreferences = _readMap(data['roomPreferences']);
        final model = _PersonalSpaceModel(
          clientSignals: clientSignals,
          privacyPreferences: privacyPreferences,
          roomPreferences: roomPreferences,
        );

        return _SPersonalSpaceScaffold(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _HeroBlock(),
              const SizedBox(height: 18),
              _PersonalSpaceOverviewCard(model: model),
              const SizedBox(height: 18),
              _SignalSummaryCard(model: model),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 860;
                  final panels = <Widget>[
                    _MyGoalsSection(model: model),
                    _MyInterestsSection(model: model),
                    _AccessibilityPreferencesSection(model: model),
                    _CommunicationPreferencesSection(model: model),
                    const _SavedProvidersSection(),
                    const _SavedCentersSection(),
                    const _SavedContentSection(),
                    const _PersonalToolsSection(),
                    const _PersonalShortcutsSection(),
                    _SignalReviewPanel(model: model),
                    _PrivacyPanel(model: model),
                    _RoomPreferencesPanel(model: model),
                    _SignalHealthCard(model: model),
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
            ],
          ),
        );
      },
    );
  }

  static Map<String, dynamic> _readMap(dynamic value) {
    if (value is Map) return Map<String, dynamic>.from(value);
    return const <String, dynamic>{};
  }
}

class _SPersonalSpaceScaffold extends StatelessWidget {
  const _SPersonalSpaceScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        title: const Text('[S] Personal Space'),
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
              constraints: const BoxConstraints(maxWidth: 1040),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroBlock extends StatelessWidget {
  const _HeroBlock();

  @override
  Widget build(BuildContext context) {
    return const _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Stamp(text: '[S] Client Room'),
          SizedBox(height: 14),
          Text(
            'The App Is The Room',
            style: TextStyle(
              color: Color(0xFF172033),
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'A personal room for profile context, goals, interests, access, '
            'communication, privacy, shortcuts, tools, and saved destinations.',
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

class _PersonalSpaceOverviewCard extends StatelessWidget {
  const _PersonalSpaceOverviewCard({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            title: 'Client Room Overview',
            subtitle: 'A quiet snapshot of your personal living space.',
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _CounterPill(label: 'Signals', count: model.totalSignalsCount),
              _CounterPill(label: 'Interests', count: model.interests.length),
              _CounterPill(label: 'Goals', count: model.goals.length),
              const _CounterPill(label: 'Saved content', count: 0),
              const _CounterPill(label: 'Saved providers', count: 0),
              const _CounterPill(label: 'Tools', count: 0),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignalSummaryCard extends StatelessWidget {
  const _SignalSummaryCard({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            title: 'Signal Summary',
            subtitle: 'Read-only overview of your selected signals.',
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _CounterPill(label: 'Goals', count: model.goals.length),
              _CounterPill(label: 'Interests', count: model.interests.length),
              _CounterPill(
                label: 'Accessibility',
                count: model.accessibility.length,
              ),
              _CounterPill(
                label: 'Communication',
                count: model.communication.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyGoalsSection extends StatelessWidget {
  const _MyGoalsSection({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _PersonalDistrictCard(
      title: 'My Goals',
      subtitle: 'Goals, focus areas, and personal direction.',
      emptyMessage: 'Your goals can appear here after you configure signals.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Goals', model.goals),
        _DistrictGroup('Focus areas', model.goals),
        _DistrictGroup('Personal direction', model.goals),
      ],
    );
  }
}

class _MyInterestsSection extends StatelessWidget {
  const _MyInterestsSection({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _PersonalDistrictCard(
      title: 'My Interests',
      subtitle: 'Interests, topics, and areas of focus.',
      emptyMessage:
          'Your interests can appear here after you configure signals.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Interests', model.interests),
        _DistrictGroup('Topics', model.interests),
        _DistrictGroup('Areas of focus', model.interests),
      ],
    );
  }
}

class _AccessibilityPreferencesSection extends StatelessWidget {
  const _AccessibilityPreferencesSection({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _PersonalDistrictCard(
      title: 'Accessibility Preferences',
      subtitle: 'Hearing, speech, visual, and simplified support signals.',
      emptyMessage:
          'Accessibility preferences can appear here after you configure signals.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Accessibility', model.accessibility),
      ],
    );
  }
}

class _CommunicationPreferencesSection extends StatelessWidget {
  const _CommunicationPreferencesSection({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _PersonalDistrictCard(
      title: 'Communication Preferences',
      subtitle: 'Preferred communication formats and support modes.',
      emptyMessage:
          'Communication preferences can appear here after you configure signals.',
      groups: <_DistrictGroup>[
        _DistrictGroup('Communication', model.communication),
      ],
    );
  }
}

class _SavedProvidersSection extends StatelessWidget {
  const _SavedProvidersSection();

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderDistrictCard(
      title: 'My Providers',
      subtitle: 'Saved providers and favorite providers.',
      items: <String>[
        'Saved Providers',
        'Favorite Providers',
      ],
      message: 'Saved provider data is not connected in this package yet.',
    );
  }
}

class _SavedCentersSection extends StatelessWidget {
  const _SavedCentersSection();

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderDistrictCard(
      title: 'My Centers',
      subtitle: 'Saved centers and favorite centers.',
      items: <String>[
        'Saved Centers',
        'Favorite Centers',
      ],
      message: 'Saved center data is not connected in this package yet.',
    );
  }
}

class _SavedContentSection extends StatelessWidget {
  const _SavedContentSection();

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderDistrictCard(
      title: 'My Library',
      subtitle: 'Saved articles, guides, and awareness content.',
      items: <String>[
        'Saved Articles',
        'Saved Guides',
        'Saved Awareness Content',
      ],
      message: 'Saved library data is not connected in this package yet.',
    );
  }
}

class _PersonalToolsSection extends StatelessWidget {
  const _PersonalToolsSection();

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderDistrictCard(
      title: 'My Tools',
      subtitle: 'Reusable personal capabilities, not departments.',
      items: <String>[
        'Saved Items',
        'Provider Finder',
        'Center Finder',
        'Family Resources',
        'Recovery Resources',
        'Learning Resources',
      ],
      message: 'Personal tool runtime is not connected in this package yet.',
    );
  }
}

class _PersonalShortcutsSection extends StatelessWidget {
  const _PersonalShortcutsSection();

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderDistrictCard(
      title: 'My Shortcuts',
      subtitle: 'Personal shortcuts and saved destinations.',
      items: <String>[
        'Saved Destinations',
        'Favorite Knowledge',
        'Support Entry',
      ],
      message: 'Shortcut data is not connected in this package yet.',
    );
  }
}

class _SignalReviewPanel extends StatelessWidget {
  const _SignalReviewPanel({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            title: 'Signal Review Panel',
            subtitle: 'Goals, interests, access, and communication.',
          ),
          const SizedBox(height: 14),
          _SignalGroup(title: 'Goals', values: model.goals),
          _SignalGroup(title: 'Interests', values: model.interests),
          _SignalGroup(title: 'Accessibility', values: model.accessibility),
          _SignalGroup(title: 'Communication', values: model.communication),
        ],
      ),
    );
  }
}

class _PrivacyPanel extends StatelessWidget {
  const _PrivacyPanel({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            title: 'Privacy Panel',
            subtitle: 'Privacy, communication permissions, and visibility.',
          ),
          const SizedBox(height: 14),
          _BooleanRow(
            label: 'Keep support preferences private',
            value: model.keepSupportPreferencesPrivate,
          ),
          _BooleanRow(
            label: 'Use preferences for recommendations',
            value: model.usePreferencesForRecommendations,
          ),
          const _InfoLine(
            label: 'Visibility preferences',
            value: 'Personal preferences remain user-controlled.',
          ),
          const _InfoLine(
            label: 'Communication permissions',
            value: 'No new communication permission is created here.',
          ),
        ],
      ),
    );
  }
}

class _RoomPreferencesPanel extends StatelessWidget {
  const _RoomPreferencesPanel({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            title: 'Room Preferences Panel',
            subtitle: 'Theme, comfort, and personal room options.',
          ),
          const SizedBox(height: 14),
          _InfoLine(label: 'Theme', value: model.themeLabel),
          _InfoLine(label: 'Background', value: model.backgroundLabel),
          _BooleanRow(label: 'Calm mode', value: model.calmMode),
          const _InfoLine(
            label: 'Personal room options',
            value: 'Display-only in this package.',
          ),
        ],
      ),
    );
  }
}

class _SignalHealthCard extends StatelessWidget {
  const _SignalHealthCard({required this.model});

  final _PersonalSpaceModel model;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            title: 'Signal Health Card',
            subtitle: 'Informational completeness only. Not a score.',
          ),
          const SizedBox(height: 14),
          _CompletenessRow(
            label: 'Profile completeness',
            completed: model.profileCompleteness,
            total: 3,
          ),
          _CompletenessRow(
            label: 'Signal completeness',
            completed: model.signalCompleteness,
            total: 4,
          ),
          _CompletenessRow(
            label: 'Privacy completeness',
            completed: model.privacyCompleteness,
            total: 2,
          ),
          _CompletenessRow(
            label: 'Room completeness',
            completed: model.roomCompleteness,
            total: 3,
          ),
        ],
      ),
    );
  }
}

class _PersonalDistrictCard extends StatelessWidget {
  const _PersonalDistrictCard({
    required this.title,
    required this.subtitle,
    required this.emptyMessage,
    required this.groups,
  });

  final String title;
  final String subtitle;
  final String emptyMessage;
  final List<_DistrictGroup> groups;

  @override
  Widget build(BuildContext context) {
    final hasValues = groups.any((group) => group.values.isNotEmpty);
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(title: title, subtitle: subtitle),
          const SizedBox(height: 14),
          if (!hasValues)
            Text(
              emptyMessage,
              style: const TextStyle(
                color: Color(0xFF667085),
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            )
          else
            for (final group in groups)
              _SignalGroup(title: group.title, values: group.values),
        ],
      ),
    );
  }
}

class _PlaceholderDistrictCard extends StatelessWidget {
  const _PlaceholderDistrictCard({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.message,
  });

  final String title;
  final String subtitle;
  final List<String> items;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(title: title, subtitle: subtitle),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items
                .map((item) => _SignalPill(label: item))
                .toList(growable: false),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              color: Color(0xFF667085),
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _DistrictGroup {
  const _DistrictGroup(this.title, this.values);

  final String title;
  final List<String> values;
}

class _SignalGroup extends StatelessWidget {
  const _SignalGroup({
    required this.title,
    required this.values,
  });

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          if (values.isEmpty)
            const Text(
              'Not configured yet.',
              style: TextStyle(color: Color(0xFF667085)),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: values
                  .map(
                      (value) => _SignalPill(label: _SignalLabels.label(value)))
                  .toList(growable: false),
            ),
        ],
      ),
    );
  }
}

class _CompletenessRow extends StatelessWidget {
  const _CompletenessRow({
    required this.label,
    required this.completed,
    required this.total,
  });

  final String label;
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final ratio = total == 0 ? 0.0 : completed / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF26324A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '$completed / $total',
                style: const TextStyle(
                  color: Color(0xFF667085),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: ratio.clamp(0.0, 1.0).toDouble(),
              minHeight: 8,
              backgroundColor: const Color(0xFFE7EAF0),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF4A6CF7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child});

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
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
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

class _SignalPill extends StatelessWidget {
  const _SignalPill({required this.label});

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

class _BooleanRow extends StatelessWidget {
  const _BooleanRow({
    required this.label,
    required this.value,
  });

  final String label;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    final resolved = value == null ? 'Unknown' : (value! ? 'On' : 'Off');
    return _InfoLine(label: label, value: resolved);
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF667085),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF26324A),
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
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

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF172033),
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(
              color: Color(0xFF40506A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalSpaceModel {
  const _PersonalSpaceModel({
    required this.clientSignals,
    required this.privacyPreferences,
    required this.roomPreferences,
  });

  final Map<String, dynamic> clientSignals;
  final Map<String, dynamic> privacyPreferences;
  final Map<String, dynamic> roomPreferences;

  List<String> get goals => _readSignalList('goalSignals');
  List<String> get interests => _readSignalList('interestSignals');
  List<String> get accessibility => _readSignalList('accessibilitySignals');
  List<String> get communication => _readSignalList('communicationSignals');

  int get totalSignalsCount =>
      goals.length +
      interests.length +
      accessibility.length +
      communication.length;

  bool? get keepSupportPreferencesPrivate =>
      _readBool(privacyPreferences, 'keepSupportPreferencesPrivate');
  bool? get usePreferencesForRecommendations =>
      _readBool(privacyPreferences, 'usePreferencesForRecommendations');
  bool? get calmMode => _readBool(roomPreferences, 'calmMode');

  String get themeLabel => _SignalLabels.label(
        _readString(roomPreferences, 'themeKey', fallback: 'unknown'),
      );
  String get backgroundLabel => _SignalLabels.label(
        _readString(roomPreferences, 'backgroundKey', fallback: 'unknown'),
      );

  int get signalCompleteness => <List<String>>[
        goals,
        interests,
        accessibility,
        communication,
      ].where((values) => values.isNotEmpty).length;

  int get privacyCompleteness => <bool?>[
        keepSupportPreferencesPrivate,
        usePreferencesForRecommendations,
      ].where((value) => value != null).length;

  int get roomCompleteness {
    final keys = <String>['themeKey', 'backgroundKey', 'calmMode'];
    return keys.where((key) => roomPreferences.containsKey(key)).length;
  }

  int get profileCompleteness => <bool>[
        clientSignals.isNotEmpty,
        privacyPreferences.isNotEmpty,
        roomPreferences.isNotEmpty,
      ].where((value) => value).length;

  List<String> _readSignalList(String key) {
    final value = clientSignals[key];
    if (value is! List) return const <String>[];
    final out = value
        .map((item) => item.toString().trim())
        .where((item) => item.isNotEmpty)
        .toList();
    out.sort();
    return out;
  }

  static bool? _readBool(Map<String, dynamic> source, String key) {
    final value = source[key];
    if (value is bool) return value;
    return null;
  }

  static String _readString(
    Map<String, dynamic> source,
    String key, {
    required String fallback,
  }) {
    final value = (source[key] ?? '').toString().trim();
    return value.isEmpty ? fallback : value;
  }
}

class _SignalLabels {
  const _SignalLabels._();

  static const Map<String, String> _labels = <String, String>{
    'need_specialist': 'Find specialist',
    'need_center': 'Find center',
    'recovery_support': 'Recovery support',
    'family_guidance': 'Family guidance',
    'general_help': 'General help',
    'addiction': 'Addiction',
    'recovery': 'Recovery',
    'family_support': 'Family support',
    'learning': 'Learning',
    'career_growth': 'Career growth',
    'special_needs': 'Special needs',
    'accessibility_support': 'Accessibility support',
    'prevention_awareness': 'Prevention awareness',
    'family_awareness': 'Family awareness',
    'coaching': 'Coaching',
    'speech_support': 'Speech support',
    'children_support': 'Children support',
    'hearing_support': 'Hearing support',
    'visual_assistance': 'Visual assistance',
    'visual_support': 'Visual support',
    'simplified_content': 'Simplified content',
    'text': 'Text',
    'audio': 'Audio',
    'video': 'Video',
    'visual': 'Visual',
    'calm_gold': 'Calm gold',
    'soft_blue': 'Soft blue',
    'simple_dark': 'Simple dark',
    'default': 'Default',
    'quiet': 'Quiet',
    'plain': 'Plain',
    'unknown': 'Unknown',
  };

  static String label(String key) {
    final normalized = key.trim();
    return _labels[normalized] ??
        normalized
            .replaceAll('_', ' ')
            .split(' ')
            .where((part) => part.isNotEmpty)
            .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
            .join(' ');
  }
}
