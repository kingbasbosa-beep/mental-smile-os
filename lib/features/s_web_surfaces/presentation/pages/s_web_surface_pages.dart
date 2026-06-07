import 'package:flutter/material.dart';

// [S] Web Surface Asset
// Approved by Wave S-5 Classification Map.
// Navigation skeleton only; must remain free from legacy workflow coupling.
class SSurfaceIndexPage extends StatelessWidget {
  const SSurfaceIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SSurfaceShell(
      title: '[S] SURFACE INDEX',
      subtitle: 'Signal-first personal ecosystem map',
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: <Widget>[
          _SurfaceNavigationCard(
            title: '[S] City',
            subtitle: 'Discovery city center for providers, knowledge, tools, and programs',
            route: '/s/city',
          ),
          _SurfaceNavigationCard(
            title: '[S] Capital',
            subtitle: 'Monitoring, intelligence, departments, and reports',
            route: '/s/capital',
          ),
          _SurfaceNavigationCard(
            title: '[S] Owner',
            subtitle: 'Sovereign oversight, memory, strategy, and archive access',
            route: '/s/owner',
          ),
          _SurfaceNavigationCard(
            title: '[S] Personal Space',
            subtitle: 'The app is the room: signals, privacy, tools, and saved destinations',
            route: '/s/personal-space',
          ),
        ],
      ),
    );
  }
}

class SWebSurfacePage extends StatelessWidget {
  const SWebSurfacePage({
    super.key,
    required this.surfaceName,
    required this.surfaceType,
    required this.routeName,
    required this.description,
    required this.items,
  });

  final String surfaceName;
  final String surfaceType;
  final String routeName;
  final String description;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SSurfaceShell(
      title: _surfaceHeader(surfaceType),
      subtitle: 'Signal Native Surface',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SurfaceStamp(surfaceType: surfaceType, routeName: routeName),
          const SizedBox(height: 18),
          Text(
            surfaceName,
            style: theme.textTheme.displaySmall?.copyWith(
              color: const Color(0xFF172033),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF40506A),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          _SurfaceNavigation(currentRoute: routeName),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: items
                .map((item) => _SurfaceItemChip(label: item))
                .toList(growable: false),
          ),
          const SizedBox(height: 30),
          const _BoundaryNotice(),
        ],
      ),
    );
  }

  static String _surfaceHeader(String surfaceType) {
    return '[S] ${surfaceType.replaceAll('[S]', '').trim().toUpperCase()}';
  }
}

class _SSurfaceShell extends StatelessWidget {
  const _SSurfaceShell({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      appBar: AppBar(
        title: const Text('Mental Smile [S]'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFF172033),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF4A6CF7),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 30),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SurfaceNavigation extends StatelessWidget {
  const _SurfaceNavigation({required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    const entries = <_SurfaceNavigationEntry>[
      _SurfaceNavigationEntry('[S] City', '/s/city'),
      _SurfaceNavigationEntry('[S] Capital', '/s/capital'),
      _SurfaceNavigationEntry('[S] Owner', '/s/owner'),
    ];
    final visibleEntries =
        entries.where((entry) => entry.route != currentRoute).toList();

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: visibleEntries
          .map(
            (entry) => OutlinedButton(
              onPressed: () => Navigator.of(context).pushNamed(entry.route),
              child: Text(entry.label),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _SurfaceNavigationCard extends StatelessWidget {
  const _SurfaceNavigationCard({
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFE1E5EE)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => Navigator.of(context).pushNamed(route),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF40506A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SurfaceNavigationEntry {
  const _SurfaceNavigationEntry(this.label, this.route);

  final String label;
  final String route;
}

class _SurfaceStamp extends StatelessWidget {
  const _SurfaceStamp({
    required this.surfaceType,
    required this.routeName,
  });

  final String surfaceType;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF172033),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Text(
              '[S]',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
        Text(
          surfaceType,
          style: const TextStyle(
            color: Color(0xFF4A6CF7),
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          routeName,
          style: const TextStyle(color: Color(0xFF667085)),
        ),
      ],
    );
  }
}

class _SurfaceItemChip extends StatelessWidget {
  const _SurfaceItemChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE1E5EE)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF26324A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _BoundaryNotice extends StatelessWidget {
  const _BoundaryNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE8D8A8)),
      ),
      child: const Text(
        'Signal-first placeholder only. No booking foundation, legacy admin '
        'workflow, Firebase write, auth claim change, automation, or production '
        'data operation is attached to this surface.',
        style: TextStyle(
          color: Color(0xFF5E4B1B),
          fontWeight: FontWeight.w700,
          height: 1.45,
        ),
      ),
    );
  }
}
