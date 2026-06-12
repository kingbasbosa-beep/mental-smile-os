import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/chat/data/models/chat_escalation_model.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';

// Safety-only observatory for risk signals and resolution.
class ChatEscalationsPage extends StatefulWidget {
  const ChatEscalationsPage({super.key});

  @override
  State<ChatEscalationsPage> createState() => _ChatEscalationsPageState();
}

class _ChatEscalationsPageState extends State<ChatEscalationsPage> {
  final ChatFirestoreService _service = ChatFirestoreService();
  String _filter = 'all';
  String? _resolvingId;

  Future<void> _resolveEscalation(ChatEscalationModel escalation) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) return;

    setState(() => _resolvingId = escalation.id);
    try {
      await _service.resolveEscalation(
        escalationId: escalation.id,
        resolverUid: uid,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Safety escalation resolved')),
      );
    } finally {
      if (mounted) setState(() => _resolvingId = null);
    }
  }

  List<ChatEscalationModel> _filtered(List<ChatEscalationModel> items) {
    if (_filter == 'all') return items;
    return items.where((item) => item.status == _filter).toList();
  }

  Color _riskColor(String riskLevel) {
    switch (riskLevel) {
      case 'critical':
        return const Color(0xFFD84B4B);
      case 'high':
        return const Color(0xFFE39B2E);
      case 'medium':
        return const Color(0xFF2E5AAC);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety Escalation Observatory')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Read safety signals, recommended actions, and escalation state. '
              'This observatory does not assign people or own cases.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'all', label: Text('All')),
                ButtonSegment(value: 'open', label: Text('Open')),
                ButtonSegment(value: 'resolved', label: Text('Resolved')),
              ],
              selected: {_filter},
              onSelectionChanged: (value) {
                setState(() => _filter = value.first);
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<List<ChatEscalationModel>>(
              stream: _service.streamEscalations(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Unable to load: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = _filtered(snapshot.data!);
                if (items.isEmpty) {
                  return const Center(
                    child: Text('No safety escalations in this state.'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final escalation = items[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              escalation.participantDisplayName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Chip(
                                  avatar: Icon(
                                    Icons.health_and_safety_outlined,
                                    color: _riskColor(escalation.riskLevel),
                                  ),
                                  label: Text(
                                    'Safety: ${escalation.safetyEscalationLevel}',
                                  ),
                                ),
                                Chip(label: Text('State: ${escalation.status}')),
                                Chip(
                                  label: Text('Risk score: ${escalation.riskScore}'),
                                ),
                              ],
                            ),
                            if (escalation.summaryText.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(escalation.summaryText),
                            ],
                            if (escalation.routingSignals.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                'Routing signals',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Wrap(
                                spacing: 8,
                                children: escalation.routingSignals
                                    .map((signal) => Chip(label: Text(signal)))
                                    .toList(),
                              ),
                            ],
                            if (escalation.recommendedActions.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                'Recommended actions',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              ...escalation.recommendedActions.map(Text.new),
                            ],
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      Routes.chatEscalationReport,
                                      arguments: {'escalationId': escalation.id},
                                    );
                                  },
                                  icon: const Icon(Icons.description_outlined),
                                  label: const Text('Safety report'),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      Routes.chat,
                                      arguments: {'threadId': escalation.threadId},
                                    );
                                  },
                                  icon: const Icon(Icons.forum_outlined),
                                  label: const Text('Conversation'),
                                ),
                                if (escalation.status != 'resolved')
                                  FilledButton.icon(
                                    onPressed: _resolvingId == escalation.id
                                        ? null
                                        : () => _resolveEscalation(escalation),
                                    icon: const Icon(Icons.verified_user_outlined),
                                    label: const Text('Resolve safety escalation'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
