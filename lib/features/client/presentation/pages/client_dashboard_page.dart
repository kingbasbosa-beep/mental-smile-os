import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojects/app/locale_provider.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/storage/locale_storage.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class ClientDashboardPage extends StatelessWidget {
  const ClientDashboardPage({super.key});

  Stream<Map<String, dynamic>?> _clientStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value(null);
    }

    final uid = user.uid;
    final email = (user.email ?? '').trim();

    return FirebaseFirestore.instance
        .collection('clients')
        .doc(uid)
        .snapshots()
        .asyncMap((doc) async {
      if (doc.exists && doc.data() != null) {
        return {
          'source': 'doc',
          ...doc.data()!,
        };
      }

      if (email.isNotEmpty) {
        final emailSnapshot = await FirebaseFirestore.instance
            .collection('clients')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (emailSnapshot.docs.isNotEmpty) {
          return {
            'source': 'email',
            ...emailSnapshot.docs.first.data(),
          };
        }
      }

      return null;
    });
  }

  String _fallbackDisplayName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 'Client';

    final displayName = (user.displayName ?? '').trim();
    if (displayName.isNotEmpty) return displayName;

    final email = (user.email ?? '').trim();
    if (email.isNotEmpty) return email.split('@').first;

    return 'Client';
  }

  String _readName(Map<String, dynamic>? data) {
    if (data == null) return _fallbackDisplayName();

    final candidates = [
      (data['displayName'] ?? '').toString().trim(),
      (data['name'] ?? '').toString().trim(),
      (data['fullName'] ?? '').toString().trim(),
    ];

    for (final value in candidates) {
      if (value.isNotEmpty) return value;
    }

    return _fallbackDisplayName();
  }

  String _readAvatarAsset(Map<String, dynamic>? data) {
    if (data == null) return '';
    final value = (data['avatarAsset'] ?? '').toString().trim();
    if (value.startsWith('assets/assets/')) {
      return value.replaceFirst('assets/assets/', 'assets/');
    }
    return value;
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'SC';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  _ClientSignalSnapshot _signalsFrom(Map<String, dynamic>? data) {
    final signals = data?['clientSignals'];
    final enabledTools = data?['enabledToolKeys'];

    return _ClientSignalSnapshot(
      goalSignals: _readStringList(signals, 'goalSignals'),
      interestSignals: _readStringList(signals, 'interestSignals'),
      accessibilitySignals: _readStringList(signals, 'accessibilitySignals'),
      communicationSignals: _readStringList(signals, 'communicationSignals'),
      enabledTools: enabledTools is List
          ? enabledTools
              .map((item) => item.toString().trim())
              .where((item) => item.isNotEmpty)
              .toList()
          : const [],
    );
  }

  List<String> _readStringList(dynamic source, String key) {
    if (source is! Map) return const [];
    final value = source[key];
    if (value is! List) return const [];
    return value
        .map((item) => item.toString().trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1012),
        body: StreamBuilder<Map<String, dynamic>?>(
          stream: _clientStream(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            final name = _readName(data);
            final signals = _signalsFrom(data);

            return Stack(
              fit: StackFit.expand,
              children: [
                const _SignalBackground(),
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final compact = constraints.maxWidth < 920;
                      final content = _ClientFederationContent(
                        isArabic: isArabic,
                        compact: compact,
                        name: name,
                        initials: _initials(name),
                        avatarAsset: _readAvatarAsset(data),
                        signals: signals,
                      );

                      if (compact) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _DashboardTopBar(
                                isArabic: isArabic,
                                initials: _initials(name),
                                compact: true,
                              ),
                              const SizedBox(height: 14),
                              content,
                            ],
                          ),
                        );
                      }

                      return Row(
                        children: [
                          _FederationSidebar(
                            isArabic: isArabic,
                            activeIndex: 0,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    20,
                                    14,
                                    20,
                                    0,
                                  ),
                                  child: _DashboardTopBar(
                                    isArabic: isArabic,
                                    initials: _initials(name),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.fromLTRB(
                                      20,
                                      16,
                                      20,
                                      22,
                                    ),
                                    child: content,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ClientSignalSnapshot {
  const _ClientSignalSnapshot({
    required this.goalSignals,
    required this.interestSignals,
    required this.accessibilitySignals,
    required this.communicationSignals,
    required this.enabledTools,
  });

  final List<String> goalSignals;
  final List<String> interestSignals;
  final List<String> accessibilitySignals;
  final List<String> communicationSignals;
  final List<String> enabledTools;

  bool get hasAny =>
      goalSignals.isNotEmpty ||
      interestSignals.isNotEmpty ||
      accessibilitySignals.isNotEmpty ||
      communicationSignals.isNotEmpty;

  List<String> previewOf(List<String> values, List<String> fallback) =>
      values.isEmpty ? fallback : values.take(4).toList();
}

class _SavedDestinationSummary {
  const _SavedDestinationSummary({
    required this.providers,
    required this.centers,
    required this.libraryItems,
  });

  final List<_SavedDestinationPreview> providers;
  final List<_SavedDestinationPreview> centers;
  final List<_SavedDestinationPreview> libraryItems;

  int get total => providers.length + centers.length + libraryItems.length;
}

class _SavedDestinationPreview {
  const _SavedDestinationPreview({
    required this.title,
    required this.route,
    required this.destinationId,
    required this.destinationType,
  });

  final String title;
  final String route;
  final String destinationId;
  final String destinationType;
}

Stream<_SavedDestinationSummary> _savedDestinationsStream() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream.value(
      const _SavedDestinationSummary(
        providers: [],
        centers: [],
        libraryItems: [],
      ),
    );
  }

  return FirebaseFirestore.instance
      .collection('saved_destinations')
      .where('clientId', isEqualTo: user.uid)
      .snapshots()
      .map((snapshot) {
    final providers = <_SavedDestinationPreview>[];
    final centers = <_SavedDestinationPreview>[];
    final libraryItems = <_SavedDestinationPreview>[];

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final title = (data['title'] ?? '').toString().trim();
      final route = (data['route'] ?? '').toString().trim();
      final destinationId = (data['destinationId'] ?? '').toString().trim();
      final type = (data['destinationType'] ?? '').toString().trim();
      if (title.isEmpty) continue;

      final preview = _SavedDestinationPreview(
        title: title,
        route: route,
        destinationId: destinationId,
        destinationType: type,
      );
      if (type == 'provider') {
        providers.add(preview);
      } else if (type == 'center') {
        centers.add(preview);
      } else if (type == 'libraryItem') {
        libraryItems.add(preview);
      }
    }

    return _SavedDestinationSummary(
      providers: providers,
      centers: centers,
      libraryItems: libraryItems,
    );
  }).handleError((_) {});
}

class _SignalBackground extends StatelessWidget {
  const _SignalBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF11191B),
            const Color(0xFF090D0F),
            const Color(0xFF14120D),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mutedGold.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardTopBar extends ConsumerStatefulWidget {
  const _DashboardTopBar({
    required this.isArabic,
    required this.initials,
    this.compact = false,
  });

  final bool isArabic;
  final String initials;
  final bool compact;

  @override
  ConsumerState<_DashboardTopBar> createState() => _DashboardTopBarState();
}

class _DashboardTopBarState extends ConsumerState<_DashboardTopBar> {
  Future<void> _toggleLocale(Locale locale) async {
    final nextCode = locale.languageCode.toLowerCase() == 'ar' ? 'en' : 'ar';
    await LocaleStorage().write(nextCode);
    ref.read(localeProvider.notifier).state = Locale(nextCode);
  }

  @override
  Widget build(BuildContext context) {
    final providerLocale = ref.watch(localeProvider);
    final locale = providerLocale ?? Localizations.localeOf(context);

    return Row(
      textDirection: TextDirection.ltr,
      children: [
        const Spacer(),
        _CircleAction(
          tooltip: widget.isArabic ? 'تغيير اللغة' : 'Change language',
          label: widget.isArabic ? 'EN' : 'AR',
          onTap: () => _toggleLocale(locale),
        ),
        const SizedBox(width: 10),
        _CircleAction(
          tooltip: widget.isArabic ? 'الإشعارات' : 'Notifications',
          icon: Icons.notifications_none_rounded,
          onTap: () => _showSoon(context, widget.isArabic),
        ),
        const SizedBox(width: 10),
        _AvatarMini(initials: widget.initials),
      ],
    );
  }
}

class _FederationSidebar extends StatelessWidget {
  const _FederationSidebar({
    required this.isArabic,
    required this.activeIndex,
  });

  final bool isArabic;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(Icons.home_rounded, 'الرئيسية', 'Home', Routes.clientDashboard),
      _NavItem(Icons.add_circle_outline_rounded, 'إشاراتي', 'My Signals', null),
      _NavItem(Icons.grid_view_rounded, 'أدواتي', 'My Tools', null),
      _NavItem(Icons.favorite_border_rounded, 'المفضلة', 'Saved', null),
      _NavItem(
        Icons.support_agent_rounded,
        'الدعم',
        'Support',
        Routes.supportIssueSelector,
      ),
      _NavItem(Icons.article_outlined, 'المحتوى', 'Content', Routes.library),
      _NavItem(Icons.settings_outlined, 'إعداداتي', 'Settings', null),
    ];

    return Container(
      width: 192,
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.26),
        border: Border.all(color: AppColors.mutedGold.withValues(alpha: 0.30)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          const _BrandMark(),
          const SizedBox(height: 18),
          for (var index = 0; index < items.length; index++) ...[
            _SidebarButton(
              item: items[index],
              isArabic: isArabic,
              active: index == activeIndex,
            ),
            const SizedBox(height: 7),
          ],
          const Spacer(),
          _PersonalSpaceBadge(isArabic: isArabic),
        ],
      ),
    );
  }
}

class _ClientFederationContent extends StatelessWidget {
  const _ClientFederationContent({
    required this.isArabic,
    required this.compact,
    required this.name,
    required this.initials,
    required this.avatarAsset,
    required this.signals,
  });

  final bool isArabic;
  final bool compact;
  final String name;
  final String initials;
  final String avatarAsset;
  final _ClientSignalSnapshot signals;

  @override
  Widget build(BuildContext context) {
    final header = _HeaderBand(
      isArabic: isArabic,
      name: name,
      initials: initials,
      avatarAsset: avatarAsset,
      compact: compact,
    );

    final tabs = _FederationTabs(isArabic: isArabic);
    final tools = _ActiveToolsFrame(isArabic: isArabic, signals: signals);
    final lower = _SignalDashboardGrid(
      isArabic: isArabic,
      signals: signals,
      compact: compact,
    );
    final guidance = _GuidanceGrid(isArabic: isArabic, compact: compact);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1180),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          header,
          const SizedBox(height: 16),
          tabs,
          const SizedBox(height: 12),
          _ThemeCatalogCard(isArabic: isArabic),
          const SizedBox(height: 12),
          tools,
          const SizedBox(height: 14),
          lower,
          const SizedBox(height: 24),
          guidance,
        ],
      ),
    );
  }
}

class _HeaderBand extends StatelessWidget {
  const _HeaderBand({
    required this.isArabic,
    required this.name,
    required this.initials,
    required this.avatarAsset,
    required this.compact,
  });

  final bool isArabic;
  final String name;
  final String initials;
  final String avatarAsset;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final profile = Row(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      children: [
        _ClientAvatarBadge(
          avatarAsset: avatarAsset,
          initials: initials,
          size: compact ? 78 : 90,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFFFFE7B2),
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              isArabic ? 'رحلتك تبدأ من هنا.' : 'Your journey starts here.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.74),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(
                Routes.sPersonalSpace,
              ),
              icon: const Icon(Icons.edit_outlined, size: 16),
              label: Text(isArabic ? 'تعديل الملف الشخصي' : 'Edit profile'),
            ),
          ],
        ),
      ],
    );

    final welcome = Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'مرحباً بك في مساحتك' : 'Welcome to your space',
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFFE7C766),
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          isArabic
              ? 'رحلتك، إشاراتك، أدواتك، دعمك.'
              : 'Your journey, signals, tools, and support.',
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.78),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );

    if (compact) {
      return Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          profile,
          const SizedBox(height: 18),
          welcome,
        ],
      );
    }

    return Row(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Expanded(child: profile),
        Expanded(child: welcome),
      ],
    );
  }
}

class _FederationTabs extends StatelessWidget {
  const _FederationTabs({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _NavItem(Icons.home_rounded, 'الرئيسية', 'Home', Routes.clientDashboard),
      _NavItem(Icons.auto_awesome_rounded, 'إشاراتي', 'Signals', null),
      _NavItem(Icons.dashboard_customize_outlined, 'أدواتي', 'Tools', null),
      _NavItem(Icons.bookmark_border_rounded, 'المفضلة', 'Saved', null),
      _NavItem(
        Icons.support_agent_rounded,
        'الدعم',
        'Support',
        Routes.supportIssueSelector,
      ),
      _NavItem(Icons.menu_book_outlined, 'المحتوى', 'Content', Routes.library),
      _NavItem(Icons.settings_outlined, 'إعداداتي', 'Settings', null),
    ];

    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.24),
        border: Border.all(color: AppColors.mutedGold.withValues(alpha: 0.26)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: isArabic,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => VerticalDivider(
          width: 1,
          color: AppColors.mutedGold.withValues(alpha: 0.18),
        ),
        itemBuilder: (context, index) {
          return _TopTab(
            item: tabs[index],
            isArabic: isArabic,
            active: index == 0,
          );
        },
      ),
    );
  }
}

class _ActiveToolsFrame extends StatelessWidget {
  const _ActiveToolsFrame({
    required this.isArabic,
    required this.signals,
  });

  final bool isArabic;
  final _ClientSignalSnapshot signals;

  @override
  Widget build(BuildContext context) {
    final assignedTools =
        signals.enabledTools.map(_ToolSpec.fromKey).whereType<_ToolSpec>();
    final toolSlots = [
      ...assignedTools.take(6),
      for (var i = assignedTools.length; i < 6; i++) _ToolSpec.empty(),
    ].take(6).toList();

    return _Panel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.eco_outlined,
            title: isArabic ? 'أدواتك النشطة' : 'Your Active Tools',
            subtitle: isArabic
                ? 'اختر وفعل الأدوات التي تدعم رحلتك.'
                : 'Choose and activate tools that support your journey.',
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth >= 980
                  ? (constraints.maxWidth - 50) / 6
                  : constraints.maxWidth >= 680
                      ? (constraints.maxWidth - 30) / 3
                      : (constraints.maxWidth - 12) / 2;

              return Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment:
                    isArabic ? WrapAlignment.end : WrapAlignment.start,
                children: [
                  for (var index = 0; index < toolSlots.length; index++)
                    SizedBox(
                      width: cardWidth.clamp(136.0, 190.0).toDouble(),
                      child: _ToolCard(
                        slotNumber: index + 1,
                        spec: toolSlots[index],
                        isArabic: isArabic,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ThemeCatalogCard extends StatefulWidget {
  const _ThemeCatalogCard({required this.isArabic});

  final bool isArabic;

  @override
  State<_ThemeCatalogCard> createState() => _ThemeCatalogCardState();
}

class _ThemeCatalogCardState extends State<_ThemeCatalogCard> {
  String _selected = 'calm_gold';

  static const _themes = [
    _ThemeOption('default', 'Default', 'افتراضي', Color(0xFF263238)),
    _ThemeOption('calm_gold', 'Calm Gold', 'ذهبي هادئ', Color(0xFFE7C766)),
    _ThemeOption('hope', 'Hope', 'أمل', Color(0xFF68B984)),
    _ThemeOption('focus', 'Focus', 'تركيز', Color(0xFF5B8DEF)),
    _ThemeOption('recovery', 'Recovery', 'تعافٍ', Color(0xFF9D7BEA)),
  ];

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: widget.isArabic
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.palette_outlined,
            title: widget.isArabic ? 'ثيم مساحتك' : 'Your Space Theme',
            subtitle: widget.isArabic
                ? 'اختيارات محددة فقط، بدون رفع صور مخصصة.'
                : 'Curated choices only, with no custom image uploads.',
          ),
          const SizedBox(height: 14),
          Wrap(
            alignment:
                widget.isArabic ? WrapAlignment.end : WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final theme in _themes)
                _ThemePill(
                  option: theme,
                  isArabic: widget.isArabic,
                  selected: _selected == theme.key,
                  onTap: () => setState(() => _selected = theme.key),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeOption {
  const _ThemeOption(this.key, this.labelEn, this.labelAr, this.color);

  final String key;
  final String labelEn;
  final String labelAr;
  final Color color;
}

class _ThemePill extends StatelessWidget {
  const _ThemePill({
    required this.option,
    required this.isArabic,
    required this.selected,
    required this.onTap,
  });

  final _ThemeOption option;
  final bool isArabic;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.mutedGold.withValues(alpha: 0.16)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? AppColors.mutedGold.withValues(alpha: 0.72)
                : Colors.white.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: option.color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isArabic ? option.labelAr : option.labelEn,
              style: TextStyle(
                color: selected
                    ? const Color(0xFFE7C766)
                    : Colors.white.withValues(alpha: 0.84),
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignalDashboardGrid extends StatelessWidget {
  const _SignalDashboardGrid({
    required this.isArabic,
    required this.signals,
    required this.compact,
  });

  final bool isArabic;
  final _ClientSignalSnapshot signals;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _SignalSummaryCard(isArabic: isArabic, signals: signals),
      _SavedSummaryCard(isArabic: isArabic),
      _NextStepsCard(isArabic: isArabic, signals: signals),
    ];

    if (compact) {
      return Column(
        children: [
          for (final card in cards) ...[
            card,
            const SizedBox(height: 12),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < cards.length; index++) ...[
          Expanded(child: cards[index]),
          if (index != cards.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _SignalSummaryCard extends StatelessWidget {
  const _SignalSummaryCard({
    required this.isArabic,
    required this.signals,
  });

  final bool isArabic;
  final _ClientSignalSnapshot signals;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.eco_outlined,
            title: isArabic ? 'إشاراتك' : 'Your Signals',
            subtitle: isArabic
                ? 'إشاراتك تساعدنا في تخصيص تجربتك بشكل أفضل.'
                : 'Signals help personalize your experience.',
          ),
          const SizedBox(height: 14),
          _SignalGroupSummary(
            title: isArabic ? 'إشارات الهدف' : 'Goal Signals',
            values: signals.previewOf(
              signals.goalSignals,
              const ['goals'],
            ),
            isArabic: isArabic,
          ),
          _SignalGroupSummary(
            title: isArabic ? 'إشارات الاهتمام' : 'Interest Signals',
            values: signals.previewOf(
              signals.interestSignals,
              const ['preferences'],
            ),
            isArabic: isArabic,
          ),
          _SignalGroupSummary(
            title: isArabic ? 'إشارات الوصول' : 'Accessibility Signals',
            values: signals.previewOf(
              signals.accessibilitySignals,
              const ['needs'],
            ),
            isArabic: isArabic,
          ),
          _SignalGroupSummary(
            title: isArabic ? 'إشارات التواصل' : 'Communication Signals',
            values: signals.previewOf(
              signals.communicationSignals,
              const ['communication'],
            ),
            isArabic: isArabic,
          ),
          const SizedBox(height: 18),
          _GoldOutlineButton(
            label: isArabic ? 'عرض جميع الإشارات' : 'View all signals',
            onTap: () => Navigator.of(context).pushNamed(
              Routes.sPersonalSpace,
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedSummaryCard extends StatelessWidget {
  const _SavedSummaryCard({
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.bookmark_border_rounded,
            title: isArabic ? 'مفضلاتك' : 'Your Saved',
            subtitle: isArabic
                ? 'مقدمو خدمة ومراكز وموارد محفوظة.'
                : 'Saved providers, centers, and resources.',
          ),
          const SizedBox(height: 18),
          StreamBuilder<_SavedDestinationSummary>(
            stream: _savedDestinationsStream(),
            builder: (context, snapshot) {
              final summary = snapshot.data ??
                  const _SavedDestinationSummary(
                    providers: [],
                    centers: [],
                    libraryItems: [],
                  );

              if (summary.total == 0) {
                return SizedBox(
                  height: 156,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.bookmark_border_rounded,
                          color: Colors.white.withValues(alpha: 0.42),
                          size: 46,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isArabic
                              ? 'لا توجد عناصر محفوظة بعد.'
                              : 'No saved items yet.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.76),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  _SavedDestinationGroup(
                    isArabic: isArabic,
                    icon: Icons.eco_outlined,
                    title: isArabic ? 'مقدمو الخدمة' : 'Saved Providers',
                    items: summary.providers,
                  ),
                  _SavedDestinationGroup(
                    isArabic: isArabic,
                    icon: Icons.location_city_outlined,
                    title: isArabic ? 'المراكز' : 'Saved Centers',
                    items: summary.centers,
                  ),
                  _SavedDestinationGroup(
                    isArabic: isArabic,
                    icon: Icons.menu_book_outlined,
                    title:
                        isArabic ? 'موارد المحتوى' : 'Saved Library Items',
                    items: summary.libraryItems,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 14),
          _GoldOutlineButton(
            label: isArabic
                ? 'استكشف واحفظ ما يناسبك'
                : 'Explore and save what fits',
            onTap: () => Navigator.of(context).pushNamed(Routes.specialistsList),
          ),
        ],
      ),
    );
  }
}

class _SavedDestinationGroup extends StatelessWidget {
  const _SavedDestinationGroup({
    required this.isArabic,
    required this.icon,
    required this.title,
    required this.items,
  });

  final bool isArabic;
  final IconData icon;
  final String title;
  final List<_SavedDestinationPreview> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Icon(icon, color: AppColors.mutedGold, size: 17),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    '$title (${items.length})',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (items.isNotEmpty) ...[
              const SizedBox(height: 8),
              for (final item in items.take(2))
                _SavedDestinationRow(
                  isArabic: isArabic,
                  item: item,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SavedDestinationRow extends StatelessWidget {
  const _SavedDestinationRow({
    required this.isArabic,
    required this.item,
  });

  final bool isArabic;
  final _SavedDestinationPreview item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.route.isEmpty
          ? null
          : () => _openSavedDestination(context, item),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withValues(alpha: 0.46),
              size: 12,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _openSavedDestination(
  BuildContext context,
  _SavedDestinationPreview item,
) {
  if (item.route == Routes.specialistDetails) {
    Navigator.of(context).pushNamed(
      item.route,
      arguments: {'uid': item.destinationId},
    );
    return;
  }

  if (item.route == Routes.centerDetails) {
    Navigator.of(context).pushNamed(
      item.route,
      arguments: {'centerId': item.destinationId},
    );
    return;
  }

  Navigator.of(context).pushNamed(item.route);
}

class _NextStepsCard extends StatelessWidget {
  const _NextStepsCard({
    required this.isArabic,
    required this.signals,
  });

  final bool isArabic;
  final _ClientSignalSnapshot signals;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _PanelTitle(
            icon: Icons.eco_outlined,
            title: isArabic ? 'الخطوات القادمة' : 'Next Steps',
            subtitle: isArabic
                ? 'خطوات بسيطة تساعدك على الاستمرار.'
                : 'Simple steps to keep your space useful.',
          ),
          const SizedBox(height: 14),
          _StepTile(
            isArabic: isArabic,
            icon: Icons.eco_outlined,
            title: isArabic ? 'أكمل إشاراتك الشخصية' : 'Complete your signals',
            subtitle: isArabic
                ? 'ساعدنا في فهم ما تحتاجه.'
                : 'Help us understand what you need.',
            done: signals.hasAny,
          ),
          const SizedBox(height: 8),
          _StepTile(
            isArabic: isArabic,
            icon: Icons.extension_outlined,
            title: isArabic ? 'استكشف الأدوات' : 'Explore tools',
            subtitle: isArabic
                ? 'فعل الأدوات التي تناسبك.'
                : 'Activate the tools that fit you.',
            done: signals.enabledTools.isNotEmpty,
          ),
          const SizedBox(height: 8),
          _StepTile(
            isArabic: isArabic,
            icon: Icons.eco_outlined,
            title: isArabic ? 'استكشف مقدمي الخدمة' : 'Discover providers',
            subtitle: isArabic
                ? 'اختر بناءً على إشاراتك واحتياجاتك.'
                : 'Choose through your signals and preferences.',
            done: false,
          ),
          const SizedBox(height: 8),
          _StepTile(
            isArabic: isArabic,
            icon: Icons.bookmark_border_rounded,
            title: isArabic ? 'احفظ موارد مفيدة' : 'Save helpful resources',
            subtitle: isArabic
                ? 'احتفظ بما يناسبك داخل المفضلة.'
                : 'Keep what fits inside your saved space.',
            done: false,
          ),
          const SizedBox(height: 8),
          _StepTile(
            isArabic: isArabic,
            icon: Icons.chat_bubble_outline_rounded,
            title: isArabic ? 'تواصل أو شارك إشارة دعم' : 'Contact or share support',
            subtitle: isArabic
                ? 'نحن هنا لمساعدتك.'
                : 'Support is here when you need it.',
            done: false,
          ),
        ],
      ),
    );
  }
}

class _GuidanceGrid extends StatelessWidget {
  const _GuidanceGrid({
    required this.isArabic,
    required this.compact,
  });

  final bool isArabic;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _GuidanceCard(
        icon: Icons.edit_note_rounded,
        title: isArabic ? 'نصوص وإرشادات مهمة' : 'Helpful Guidance',
        lines: isArabic
            ? const [
                'استخدم لغة إيجابية وآمنة.',
                'لا تستخدم مصطلحات علاجية أو تشغيلية.',
                'اجعل التجربة هادئة ومختصرة.',
              ]
            : const [
                'Use safe and positive language.',
                'Avoid lifecycle or operational terms.',
                'Keep the experience calm and concise.',
              ],
      ),
      _GuidanceCard(
        icon: Icons.check_box_rounded,
        title: isArabic ? 'النتيجة المطلوبة' : 'Target Result',
        lines: isArabic
            ? const [
                'صفحة نظيفة متوافقة مع الدستور الجديد.',
                'لا تعرض مفاهيم غير دستورية.',
                'تركز على الإشارات والأدوات والدعم.',
              ]
            : const [
                'A clean page aligned with the new constitution.',
                'No unconstitutional concepts are displayed.',
                'Focus on signals, tools, and support.',
              ],
      ),
      _GuidanceCard(
        icon: Icons.code_rounded,
        title: isArabic ? 'تقنياً' : 'Technical',
        lines: isArabic
            ? const [
                'لا حذف للروتات القديمة.',
                'تم تغيير واجهة العميل فقط.',
                'منطق الأعمال القديم لم يتم تعديله.',
              ]
            : const [
                'Legacy routes were not deleted.',
                'Only the client dashboard surface changed.',
                'Legacy business logic was not modified.',
              ],
      ),
    ];

    if (compact) {
      return Column(
        children: [
          for (final card in cards) ...[
            card,
            const SizedBox(height: 12),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < cards.length; index++) ...[
          Expanded(child: cards[index]),
          if (index != cards.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 204),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.24),
        border: Border.all(color: AppColors.mutedGold.withValues(alpha: 0.28)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}

class _PanelTitle extends StatelessWidget {
  const _PanelTitle({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Row(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Icon(icon, color: AppColors.mutedGold, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFE7C766),
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToolSpec {
  const _ToolSpec({
    required this.icon,
    required this.titleAr,
    required this.titleEn,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.buttonAr,
    required this.buttonEn,
    required this.color,
    this.empty = false,
  });

  factory _ToolSpec.empty() {
    return const _ToolSpec(
      icon: Icons.add_rounded,
      titleAr: 'إضافة أداة',
      titleEn: 'Add Tool',
      subtitleAr: 'اختر أداة جديدة تدعم رحلتك.',
      subtitleEn: 'Choose a new tool for your space.',
      buttonAr: '',
      buttonEn: '',
      color: Color(0xFFE7C766),
      empty: true,
    );
  }

  static _ToolSpec? fromKey(String key) {
    final normalized = key.trim().toLowerCase();
    switch (normalized) {
      case 'library':
        return const _ToolSpec(
          icon: Icons.menu_book_outlined,
          titleAr: 'موارد المحتوى',
          titleEn: 'Content Resources',
          subtitleAr: 'مواد هادئة تدعم فهمك وقراراتك.',
          subtitleEn: 'Quiet resources for understanding and choice.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: Color(0xFF2F74B9),
        );
      case 'saved_items':
        return const _ToolSpec(
          icon: Icons.bookmark_border_rounded,
          titleAr: 'حفظ الموارد',
          titleEn: 'Save Resources',
          subtitleAr: 'احتفظ بالأماكن والموارد المهمة.',
          subtitleEn: 'Keep useful places and resources close.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: Color(0xFF6A8F3B),
        );
      case 'provider_finder':
        return const _ToolSpec(
          icon: Icons.eco_outlined,
          titleAr: 'استكشاف مقدمي الخدمة',
          titleEn: 'Provider Discovery',
          subtitleAr: 'استخدم إشاراتك لاكتشاف اختيارات مناسبة.',
          subtitleEn: 'Use your signals to discover fitting options.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: Color(0xFF7E4CC2),
        );
      case 'center_finder':
        return const _ToolSpec(
          icon: Icons.location_city_outlined,
          titleAr: 'استكشاف المراكز',
          titleEn: 'Center Discovery',
          subtitleAr: 'اعثر على مساحات وخدمات مناسبة.',
          subtitleEn: 'Find spaces and services that fit.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: Color(0xFF2B8C92),
        );
      case 'family_resources':
        return const _ToolSpec(
          icon: Icons.groups_2_outlined,
          titleAr: 'موارد الأسرة',
          titleEn: 'Family Resources',
          subtitleAr: 'محتوى يساعد الأسرة على الفهم والدعم.',
          subtitleEn: 'Resources that help families support better.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: Color(0xFFD0791E),
        );
      case 'recovery_resources':
        return const _ToolSpec(
          icon: Icons.self_improvement_outlined,
          titleAr: 'موارد التعافي',
          titleEn: 'Recovery Resources',
          subtitleAr: 'مواد داعمة بدون إدارة مسار علاجي.',
          subtitleEn: 'Supportive resources without lifecycle control.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: Color(0xFF68B984),
        );
      case 'learning':
        return const _ToolSpec(
          icon: Icons.school_outlined,
          titleAr: 'التعلم',
          titleEn: 'Learning',
          subtitleAr: 'تعلم بسيط حسب اهتماماتك.',
          subtitleEn: 'Simple learning shaped by your interests.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: Color(0xFF5B8DEF),
        );
      case 'support':
        return const _ToolSpec(
          icon: Icons.support_agent_rounded,
          titleAr: 'أداة الدعم',
          titleEn: 'Support Tool',
          subtitleAr: 'تذكير بأن الدعم متاح عند الحاجة.',
          subtitleEn: 'A reminder that support is available.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: Color(0xFF9D7BEA),
        );
      default:
        if (normalized.isEmpty) return null;
        return _ToolSpec(
          icon: Icons.extension_outlined,
          titleAr: key.replaceAll('_', ' '),
          titleEn: key.replaceAll('_', ' '),
          subtitleAr: 'أداة مضافة إلى مساحتك.',
          subtitleEn: 'A tool added to your space.',
          buttonAr: 'الأداة مفعلة',
          buttonEn: 'Tool active',
          color: const Color(0xFF607D8B),
        );
    }
  }

  final IconData icon;
  final String titleAr;
  final String titleEn;
  final String subtitleAr;
  final String subtitleEn;
  final String buttonAr;
  final String buttonEn;
  final Color color;
  final bool empty;
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({
    required this.slotNumber,
    required this.spec,
    required this.isArabic,
  });

  final int slotNumber;
  final _ToolSpec spec;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () => _showSoon(context, isArabic),
        child: Container(
          height: 168,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.055),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Align(
                alignment:
                    isArabic ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: spec.empty
                        ? Colors.transparent
                        : spec.color.withValues(alpha: 0.75),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: spec.empty
                          ? AppColors.mutedGold.withValues(alpha: 0.72)
                          : Colors.white.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Icon(
                    spec.icon,
                    color: spec.empty
                        ? AppColors.mutedGold
                        : Colors.white.withValues(alpha: 0.92),
                    size: spec.empty ? 31 : 26,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isArabic ? 'خانة $slotNumber' : 'Slot $slotNumber',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.48),
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isArabic ? spec.titleAr : spec.titleEn,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Text(
                  isArabic ? spec.subtitleAr : spec.subtitleEn,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                    fontSize: 11,
                  ),
                ),
              ),
              if (!spec.empty)
                Align(
                  alignment:
                      isArabic ? Alignment.centerRight : Alignment.centerLeft,
                  child: _SmallToolButton(
                    label: isArabic ? spec.buttonAr : spec.buttonEn,
                    color: spec.color,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallToolButton extends StatelessWidget {
  const _SmallToolButton({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.8)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.computeLuminance() > 0.45 ? color : Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _GuidanceCard extends StatelessWidget {
  const _GuidanceCard({
    required this.icon,
    required this.title,
    required this.lines,
  });

  final IconData icon;
  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return _Panel(
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(icon, color: AppColors.mutedGold, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                    color: Color(0xFFE7C766),
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final line in lines) ...[
            Text(
              '• $line',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.76),
                fontWeight: FontWeight.w700,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}

class _SidebarButton extends StatelessWidget {
  const _SidebarButton({
    required this.item,
    required this.isArabic,
    required this.active,
  });

  final _NavItem item;
  final bool isArabic;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () => _navigateOrSoon(context, item.route, isArabic),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: active
                ? AppColors.mutedGold.withValues(alpha: 0.16)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: active
                ? Border.all(color: AppColors.mutedGold.withValues(alpha: 0.26))
                : null,
          ),
          child: Row(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(
                item.icon,
                color: active
                    ? AppColors.mutedGold
                    : Colors.white.withValues(alpha: 0.88),
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isArabic ? item.labelAr : item.labelEn,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: active
                        ? AppColors.mutedGold
                        : Colors.white.withValues(alpha: 0.88),
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopTab extends StatelessWidget {
  const _TopTab({
    required this.item,
    required this.isArabic,
    required this.active,
  });

  final _NavItem item;
  final bool isArabic;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateOrSoon(context, item.route, isArabic),
      child: Container(
        width: 128,
        alignment: Alignment.center,
        color: active ? AppColors.mutedGold.withValues(alpha: 0.14) : null,
        child: Text(
          isArabic ? item.labelAr : item.labelEn,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: active
                ? const Color(0xFFE7C766)
                : Colors.white.withValues(alpha: 0.84),
            fontWeight: FontWeight.w900,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.labelAr, this.labelEn, this.route);

  final IconData icon;
  final String labelAr;
  final String labelEn;
  final String? route;
}

class _PersonalSpaceBadge extends StatelessWidget {
  const _PersonalSpaceBadge({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => Navigator.of(context).pushNamed(Routes.sPersonalSpace),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.mutedGold.withValues(alpha: 0.22)),
        ),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Icon(
                  Icons.shield_outlined,
                  color: AppColors.mutedGold,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isArabic ? 'مساحتي الشخصية' : 'My Personal Space',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isArabic
                  ? 'بيئة آمنة وسرية لك وإعداداتك الشخصية'
                  : 'A private space for your settings and preferences',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 86,
          height: 86,
          child: Image.asset(
            'assets/branding/logo_primary_dark.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const AppMissingAssetPlaceholder(width: 86, height: 86),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'MENTAL SMILE',
          style: TextStyle(
            color: AppColors.mutedGold,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _ClientAvatarBadge extends StatelessWidget {
  const _ClientAvatarBadge({
    required this.avatarAsset,
    required this.initials,
    required this.size,
  });

  final String avatarAsset;
  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.mutedGold, width: 1.6),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: 0.92),
            child: avatarAsset.isNotEmpty
                ? ClipOval(
                    child: Image.asset(
                      normalizeAssetPath(avatarAsset),
                      width: size - 8,
                      height: size - 8,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          AppMissingAssetPlaceholder(
                        width: size - 8,
                        height: size - 8,
                      ),
                    ),
                  )
                : Text(
                    initials,
                    style: TextStyle(
                      color: AppColors.deepTeal,
                      fontSize: size >= 84 ? 27 : 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _AvatarMini extends StatelessWidget {
  const _AvatarMini({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.90),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.mutedGold),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.deepTeal,
          fontWeight: FontWeight.w900,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.tooltip,
    required this.onTap,
    this.icon,
    this.label,
  });

  final String tooltip;
  final VoidCallback onTap;
  final IconData? icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.20),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.mutedGold.withValues(alpha: 0.36)),
          ),
          child: icon != null
              ? Icon(icon, color: Colors.white.withValues(alpha: 0.90), size: 20)
              : Text(
                  label ?? '',
                  style: const TextStyle(
                    color: Color(0xFFFFE7B2),
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
        ),
      ),
    );
  }
}

class _SignalChip extends StatelessWidget {
  const _SignalChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.mutedGold.withValues(alpha: 0.10),
        border: Border.all(color: AppColors.mutedGold.withValues(alpha: 0.28)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFE7C766),
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _SignalGroupSummary extends StatelessWidget {
  const _SignalGroupSummary({
    required this.title,
    required this.values,
    required this.isArabic,
  });

  final String title;
  final List<String> values;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontWeight: FontWeight.w900,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            alignment: isArabic ? WrapAlignment.end : WrapAlignment.start,
            children: [
              for (final signal in values)
                _SignalChip(label: _signalLabel(signal, isArabic)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.isArabic,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.done,
  });

  final bool isArabic;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Icon(icon, color: AppColors.mutedGold.withValues(alpha: 0.76)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.70),
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            done ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            color: done
                ? const Color(0xFF77B43F)
                : Colors.white.withValues(alpha: 0.46),
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _GoldOutlineButton extends StatelessWidget {
  const _GoldOutlineButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.mutedGold,
          side: BorderSide(color: AppColors.mutedGold.withValues(alpha: 0.62)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(vertical: 13),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

String _signalLabel(String key, bool isArabic) {
  const labels = {
    'preferences': ('التفضيلات', 'Preferences'),
    'needs': ('الاحتياجات', 'Needs'),
    'goals': ('الهدف العام', 'General Goal'),
    'communication': ('التواصل', 'Communication'),
    'need_specialist': ('احتياج مقدم خدمة', 'Provider Need'),
    'need_center': ('احتياج مركز', 'Center Need'),
    'recovery_support': ('دعم التعافي', 'Recovery Support'),
    'family_guidance': ('إرشاد أسري', 'Family Guidance'),
    'general_help': ('مساعدة عامة', 'General Help'),
    'text': ('نص', 'Text'),
    'audio': ('صوت', 'Audio'),
    'video': ('فيديو', 'Video'),
    'visual': ('مرئي', 'Visual'),
  };

  final label = labels[key];
  if (label == null) return key.replaceAll('_', ' ');
  return isArabic ? label.$1 : label.$2;
}

void _navigateOrSoon(BuildContext context, String? route, bool isArabic) {
  if (route == null) {
    _showSoon(context, isArabic);
    return;
  }

  if (route == Routes.supportIssueSelector) {
    Navigator.of(context).pushNamed(
      route,
      arguments: const {'supportType': 'client_support'},
    );
    return;
  }

  Navigator.of(context).pushNamed(route);
}

void _showSoon(BuildContext context, bool isArabic) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isArabic
            ? 'هذه الأداة ستكون متاحة داخل مساحة العميل.'
            : 'This tool will be available inside the client space.',
      ),
    ),
  );
}
