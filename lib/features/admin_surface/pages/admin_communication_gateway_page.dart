import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/core/communication_gateway_actions.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_entry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminCommunicationGatewayPage extends StatefulWidget {
  const AdminCommunicationGatewayPage({super.key});

  @override
  State<AdminCommunicationGatewayPage> createState() =>
      _AdminCommunicationGatewayPageState();
}

class _AdminCommunicationGatewayPageState
    extends State<AdminCommunicationGatewayPage> {
  SupportEmailIntent _selectedIntent = SupportEmailIntent.generalSupport;

  String _intentLabel(SupportEmailIntent intent) {
    return switch (intent) {
      SupportEmailIntent.generalSupport => 'General Support',
      SupportEmailIntent.technicalIssue => 'Technical Issue',
      SupportEmailIntent.accountHelp => 'Account Help',
    };
  }

  String _intentDebugValue(SupportEmailIntent intent) {
    return switch (intent) {
      SupportEmailIntent.generalSupport => 'general_support',
      SupportEmailIntent.technicalIssue => 'technical_issue',
      SupportEmailIntent.accountHelp => 'account_help',
    };
  }

  Future<void> _showBoundaryDialog(
    BuildContext context, {
    required String title,
    required String boundaryType,
    required String separationNote,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(boundaryType),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Current status: Planned / supervised / not integrated yet.',
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(separationNote),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showWebsiteChatBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Website Chat Boundary',
      boundaryType:
          'This boundary is reserved for website-origin intake and routing awareness.',
      separationNote:
          'It is separate from direct human support handling, which remains in the Communications workspace.',
    );
  }

  Future<void> _showExternalFollowUpBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'External Follow-up Boundary',
      boundaryType:
          'External follow-up is not active here as an operational action in this phase.',
      separationNote:
          'Future outbound follow-up will live only inside the dedicated External Follow-up workspace.',
    );
  }

  Future<void> _showTelegramBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Telegram Boundary',
      boundaryType:
          'This boundary is reserved for Telegram messaging-channel awareness.',
      separationNote:
          'It remains separate from direct human support handling and does not replace the Communications workspace.',
    );
  }

  Future<void> _showFacebookMessengerBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Facebook / Messenger Boundary',
      boundaryType:
          'This boundary is reserved for Facebook or Messenger channel awareness.',
      separationNote:
          'It remains separate from direct human support handling and does not replace the Communications workspace.',
    );
  }

  Future<void> _showZoomMeetBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Zoom / Google Meet Coordination Boundary',
      boundaryType:
          'This boundary is reserved for meeting-link coordination and external channel awareness.',
      separationNote:
          'It remains separate from direct human support handling, Communications workspace case handling, and Operations-owned session scheduling.',
    );
  }

  Widget _buildExternalFollowUpNoticeCard(BuildContext context) {
    return AppSurfaceCard(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'External Follow-up Boundary',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'External follow-up is not active on this page as an operational tool. Dedicated outbound follow-up actions will be rebuilt later inside their own workspace.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEAEAEA),
                  height: 1.35,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildExternalFollowUpPausedCard(BuildContext context) {
    return AppSurfaceCard(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'External Follow-up Pending Rebuild',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Outbound follow-up actions are intentionally paused here until the dedicated External Follow-up workspace is built.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEAEAEA),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          const _GatewayStatusChip(
            label: 'Status',
            value: 'Paused on this surface',
            color: Color(0xFFC66A4A),
          ),
        ],
      ),
    );
  }

  Widget _buildGatewayGroup(
    BuildContext context, {
    required String title,
    String? description,
    required List<GatewayEntry> entries,
  }) {
    return GatewaySectionCard(
      title: title,
      description: description,
      children: entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _buildGatewayEntryCard(context, entry),
            ),
          )
          .toList(),
    );
  }

  Widget _buildGatewayEntryCard(BuildContext context, GatewayEntry entry) {
    if (entry.id == 'support_email') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () {
          if (kDebugMode) {
            debugPrint(
              'COMM_GATEWAY support_email_tap '
              'selectedIntent=${_intentDebugValue(_selectedIntent)}',
            );
          }
          CommunicationGatewayActions.openSupportEmail(
            context,
            intent: _selectedIntent,
          );
        },
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'website_chat') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showWebsiteChatBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'external_follow_up') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showExternalFollowUpBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'telegram') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showTelegramBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'facebook_messenger') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showFacebookMessengerBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'zoom_meet') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showZoomMeetBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    return GatewayEntryCard(entry: entry);
  }

  @override
  Widget build(BuildContext context) {
    final intakeEntries = communicationGatewayEntries
        .where(
          (entry) => entry.id == 'website_chat' || entry.id == 'support_email',
        )
        .toList();
    final messagingEntries = communicationGatewayEntries
        .where(
          (entry) =>
              entry.id == 'external_follow_up' ||
              entry.id == 'telegram' ||
              entry.id == 'facebook_messenger',
        )
        .toList();
    final coordinationEntries = communicationGatewayEntries
        .where(
          (entry) => entry.id == 'zoom_meet' || entry.id == 'external_intake',
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Communication Gateway',
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF13191D),
              Color(0xFF0F1316),
              Color(0xFF151B1F),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Communication Gateway',
              summary:
                  'Supervise communication boundaries without turning this page into a live support or follow-up workspace.',
              boundaryNote:
                  'Human case handling remains in Communications. External follow-up actions are paused here.',
              emphasis:
                  'No external channel integrations are active yet. This gateway remains a monitored shell.',
            ),
            const SizedBox(height: AppSpacing.md),
            _buildExternalFollowUpNoticeCard(context),
            const SizedBox(height: AppSpacing.md),
            const GatewaySectionCard(
              title: 'Gateway Boundary Definition',
              description:
                  'This compact section defines what the Communication Gateway is responsible for and where its boundaries stop.',
              children: [
                GatewaySupervisionNote(
                  text:
                      'Does: email-based communication and supervised connector visibility.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Does not do: inbound support intake, live chat handling, safety escalation routing, automation, or external follow-up execution.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Boundaries: admin-triggered only, requires an external email client, and does not store internal messages.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Supervision note: non-medical, non-diagnostic, support-first, and not a crisis-handling layer.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AppSurfaceCard(
              color: const Color(0xFF10161A).withValues(alpha: 0.94),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Support Email intent',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFC9A75B),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: SupportEmailIntent.values.map((intent) {
                      return ChoiceChip(
                        label: Text(_intentLabel(intent)),
                        labelStyle: const TextStyle(
                          color: Color(0xFFC9A75B),
                          fontWeight: FontWeight.w700,
                        ),
                        backgroundColor:
                            const Color(0xFF12181D).withValues(alpha: 0.88),
                        selectedColor:
                            const Color(0xFFD8B26A).withValues(alpha: 0.14),
                        side: BorderSide(
                          color:
                              const Color(0xFFD8B26A).withValues(alpha: 0.18),
                        ),
                        showCheckmark: true,
                        selected: _selectedIntent == intent,
                        onSelected: (_) {
                          if (kDebugMode) {
                            debugPrint(
                              'COMM_GATEWAY intent_selected='
                              '${_intentDebugValue(intent)}',
                            );
                          }
                          setState(() {
                            _selectedIntent = intent;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Selected: ${_intentLabel(_selectedIntent)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFC9A75B),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Intake Channels',
              description:
                  'Entry boundaries for web and email-origin support intake before any human handling begins.',
              entries: intakeEntries,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Messaging Channels',
              description:
                  'Messaging-boundary placeholders that remain supervised and separate from direct support intake.',
              entries: messagingEntries,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildExternalFollowUpPausedCard(context),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Meeting / Coordination',
              description:
                  'Coordination boundaries for meetings and external intake routing, kept separate from Operations scheduling.',
              entries: coordinationEntries,
            ),
          ],
        ),
      ),
    );
  }
}

class _GatewayStatusChip extends StatelessWidget {
  const _GatewayStatusChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: color.withValues(alpha: 0.24),
        ),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
