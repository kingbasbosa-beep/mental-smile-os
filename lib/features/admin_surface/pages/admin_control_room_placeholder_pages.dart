import 'package:flutter/material.dart';

class AdminGuidedWorkflowsPage extends StatelessWidget {
  const AdminGuidedWorkflowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AdminControlRoomPlaceholderPage(
      title: 'Guided Workflows',
    );
  }
}

class AdminReferencesPage extends StatelessWidget {
  const AdminReferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AdminControlRoomPlaceholderPage(
      title: 'References',
    );
  }
}

class AdminDetailedMonitoringPage extends StatelessWidget {
  const AdminDetailedMonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AdminControlRoomPlaceholderPage(
      title: 'Detailed Monitoring',
    );
  }
}

class AdminAnalyticsDetailsPage extends StatelessWidget {
  const AdminAnalyticsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AdminControlRoomPlaceholderPage(
      title: 'Analytics Details',
    );
  }
}

class _AdminControlRoomPlaceholderPage extends StatelessWidget {
  const _AdminControlRoomPlaceholderPage({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('Coming Soon'),
      ),
    );
  }
}
