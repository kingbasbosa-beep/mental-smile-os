import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/features/accessibility/domain/factories/accessibility_signal_factory.dart';
import 'package:mental_smile_os/features/accessibility/domain/models/accessibility_signal_type.dart';
import 'package:mental_smile_os/features/accessibility/domain/registries/accessibility_category_registry.dart';
import 'package:mental_smile_os/features/signals/signals.dart';
import 'package:url_launcher/url_launcher.dart';

class AccessibilityHubPage extends StatefulWidget {
  const AccessibilityHubPage({super.key});

  @override
  State<AccessibilityHubPage> createState() => _AccessibilityHubPageState();
}

class _AccessibilityHubPageState extends State<AccessibilityHubPage> {
  static final Uri _accessibilityTvUri = Uri.https(
    'www.youtube.com',
    '/results',
    {'search_query': 'Mental Smile Accessibility Channel'},
  );

  @override
  void initState() {
    super.initState();
    _emitHubOpened();
  }

  void _emitHubOpened() {
    unawaited(
      CleanSignalRuntime.firestore().emit(
        AccessibilitySignalFactory.package(
          signalType: AccessibilitySignalType.hubOpened,
          userId: FirebaseAuth.instance.currentUser?.uid,
        ),
      ),
    );
  }

  Future<void> _openAccessibilityTv() async {
    await launchUrl(_accessibilityTvUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F4EF),
        appBar: AppBar(
          title: Text(isArabic ? 'مسارات الوصول' : 'Accessibility'),
          backgroundColor: const Color(0xFFF7F4EF),
          foregroundColor: const Color(0xFF17201B),
          elevation: 0,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount = width < 680
                  ? 1
                  : width < 1040
                      ? 2
                      : 4;

              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    sliver: SliverToBoxAdapter(
                      child: _AccessibilityHeader(isArabic: isArabic),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _AccessibilityTvGatewayCard(
                            isArabic: isArabic,
                            onOpen: _openAccessibilityTv,
                          ),
                          const SizedBox(height: 14),
                          _OrganizationsGatewayCard(isArabic: isArabic),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                    sliver: SliverGrid.builder(
                      itemCount: AccessibilityCategoryRegistry.entries.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        mainAxisExtent: 236,
                      ),
                      itemBuilder: (context, index) {
                        return _AccessibilityCategoryCard(
                          entry: AccessibilityCategoryRegistry.entries[index],
                          isArabic: isArabic,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OrganizationsGatewayCard extends StatelessWidget {
  const _OrganizationsGatewayCard({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 920),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF116A5B).withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.groups_2_outlined,
              color: Color(0xFF116A5B),
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Organizations & Partnerships',
                  style: TextStyle(
                    color: Color(0xFF17201B),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Directory fields and partnership requests for governed accessibility organizations.',
                  style: TextStyle(
                    color: const Color(0xFF17201B).withValues(alpha: 0.70),
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(Routes.accessibilityOrganizations);
                  },
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: const Text('Open Directory'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF116A5B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessibilityTvGatewayCard extends StatelessWidget {
  const _AccessibilityTvGatewayCard({
    required this.isArabic,
    required this.onOpen,
  });

  final bool isArabic;
  final VoidCallback onOpen;

  static const List<String> _topics = <String>[
    'Sign Language',
    'Rights',
    'Complaints',
    'Platform Usage',
    'Family Support',
    'Autism',
    'Learning Difficulties',
    'Literacy Support',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 920),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF116A5B).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.ondemand_video_outlined,
                  color: Color(0xFF116A5B),
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic ? 'Accessibility TV' : 'Accessibility TV',
                      style: const TextStyle(
                        color: Color(0xFF17201B),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isArabic
                          ? 'YouTube gateway for Mental Smile accessibility videos.'
                          : 'YouTube gateway for Mental Smile accessibility videos.',
                      style: TextStyle(
                        color: const Color(0xFF17201B).withValues(alpha: 0.70),
                        fontSize: 14,
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final topic in _topics) _TvTopicChip(label: topic),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onOpen,
              icon: const Icon(Icons.open_in_new_rounded, size: 18),
              label: Text(
                isArabic
                    ? 'Open Mental Smile Accessibility Channel'
                    : 'Open Mental Smile Accessibility Channel',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF116A5B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TvTopicChip extends StatelessWidget {
  const _TvTopicChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF17201B).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF17201B),
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _AccessibilityHeader extends StatelessWidget {
  const _AccessibilityHeader({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 920),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic
                ? 'طرق مختلفة إلى نفس المدينة'
                : 'Different access paths into the same city',
            style: const TextStyle(
              color: Color(0xFF17201B),
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isArabic
                ? 'روابط ومصادر مصنفة فقط. لا تشخيص، لا وعود علاجية، ولا فصل للمستخدمين.'
                : 'Categorized links and resources only. No diagnosis, treatment promises, or separated user portal.',
            style: TextStyle(
              color: const Color(0xFF17201B).withValues(alpha: 0.72),
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessibilityCategoryCard extends StatelessWidget {
  const _AccessibilityCategoryCard({
    required this.entry,
    required this.isArabic,
  });

  final AccessibilityCategoryEntry entry;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(entry.icon, color: const Color(0xFF116A5B), size: 30),
                const Spacer(),
                _ResourceCount(value: entry.resourceCountPlaceholder),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              entry.titleAr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF17201B),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              entry.titleEn,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF17201B).withValues(alpha: 0.76),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                isArabic ? entry.descriptionAr : entry.descriptionEn,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF17201B).withValues(alpha: 0.68),
                  fontSize: 13,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  unawaited(
                    CleanSignalRuntime.firestore().emit(
                      AccessibilitySignalFactory.package(
                        signalType: AccessibilitySignalType.categoryOpened,
                        category: entry.category,
                        disabilityType: entry.disabilityType,
                        userId: FirebaseAuth.instance.currentUser?.uid,
                      ),
                    ),
                  );
                  Navigator.of(context).pushNamed(
                    Routes.accessibility,
                    arguments: {'category': entry.category.value},
                  );
                },
                icon: const Icon(Icons.open_in_new_rounded, size: 18),
                label: Text(isArabic ? 'فتح' : 'Open'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF116A5B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceCount extends StatelessWidget {
  const _ResourceCount({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF116A5B).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Color(0xFF116A5B),
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}
