import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/chat/data/models/chat_escalation_model.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';

/// Shows safety recommendations that include this clinician.
class ClinicianChatInboxPage extends StatefulWidget {
  const ClinicianChatInboxPage({
    super.key,
    required this.clinicianUid,
  });

  final String clinicianUid;

  @override
  State<ClinicianChatInboxPage> createState() => _ClinicianChatInboxPageState();
}

class _ClinicianChatInboxPageState extends State<ClinicianChatInboxPage> {
  final ChatFirestoreService _service = ChatFirestoreService();
  String? _resolvingId;

  Future<void> _resolve(ChatEscalationModel escalation) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid != widget.clinicianUid) return;

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

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid != widget.clinicianUid) {
      return const Scaffold(
        body: Center(child: Text('Clinician sign-in is required.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Safety Recommendations')),
      body: StreamBuilder<List<ChatEscalationModel>>(
        stream: _service.streamRecommendedEscalations(widget.clinicianUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Unable to load: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!;
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No safety recommendations are currently available.',
                  textAlign: TextAlign.center,
                ),
              ),
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
                      Text('Safety level: ${escalation.safetyEscalationLevel}'),
                      Text('Risk score: ${escalation.riskScore}'),
                      if (escalation.summaryText.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(escalation.summaryText),
                      ],
                      if (escalation.recommendedSignals.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: escalation.recommendedSignals
                              .map((signal) => Chip(label: Text(signal)))
                              .toList(),
                        ),
                      ],
                      if (escalation.status != 'resolved') ...[
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: _resolvingId == escalation.id
                              ? null
                              : () => _resolve(escalation),
                          icon: const Icon(Icons.verified_user_outlined),
                          label: const Text('Resolve safety escalation'),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
