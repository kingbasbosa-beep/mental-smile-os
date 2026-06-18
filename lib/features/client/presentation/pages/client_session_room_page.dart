import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';

class ClientSessionRoomPage extends StatelessWidget {
  const ClientSessionRoomPage({super.key});

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F4EF),
        appBar: AppBar(
          title: const Text('Client Session Room'),
          backgroundColor: const Color(0xFFF7F4EF),
          foregroundColor: const Color(0xFF17201B),
          elevation: 0,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 720;

              return ListView(
                padding: EdgeInsets.fromLTRB(
                  isCompact ? 18 : 32,
                  12,
                  isCompact ? 18 : 32,
                  32,
                ),
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 920),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start without an account',
                          style: TextStyle(
                            color: Color(0xFF17201B),
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Use a fresh session room. No profile is required, and choices here are current intent rather than stored identity.',
                          style: TextStyle(
                            color:
                                const Color(0xFF17201B).withValues(alpha: 0.72),
                            fontSize: 16,
                            height: 1.45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GridView.count(
                    crossAxisCount: isCompact ? 1 : 3,
                    childAspectRatio: isCompact ? 2.8 : 1.28,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      _SessionActionCard(
                        icon: Icons.chat_bubble_outline_rounded,
                        title: 'Talk to support',
                        body:
                            'Open a support conversation path when you need guidance.',
                        route: Routes.chat,
                      ),
                      _SessionActionCard(
                        icon: Icons.auto_stories_outlined,
                        title: 'Learning resources',
                        body:
                            'Browse simple learning material without a client profile.',
                        route: Routes.library,
                      ),
                      _SessionActionCard(
                        icon: Icons.accessibility_new_rounded,
                        title: 'Accessibility access',
                        body:
                            'Use access resources without classification or labels.',
                        route: Routes.accessibility,
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF17201B).withValues(alpha: 0.08),
                      ),
                    ),
                    child: Text(
                      'Legacy login and registration routes remain available temporarily as LEGACY_CANDIDATE surfaces while session-room access is introduced.',
                      style: TextStyle(
                        color: const Color(0xFF17201B).withValues(alpha: 0.72),
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
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

class _SessionActionCard extends StatelessWidget {
  const _SessionActionCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String body;
  final String route;

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
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.of(context).pushNamed(route),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF116A5B), size: 32),
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF17201B),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                body,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF17201B).withValues(alpha: 0.68),
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
