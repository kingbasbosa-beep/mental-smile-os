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
              Text(
                boundaryType,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Current status: Planned / supervised / not integrated yet.',
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                separationNote,
              ),
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

  Future<void> _showWhatsAppBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'WhatsApp Boundary',
      boundaryType:
          'This boundary is reserved for messaging-channel intake and routing awareness.',
      separationNote:
          'It remains separate from direct human support handling and does not replace the Communications workspace or escalations.',
    );
  }

  Future<void> _showTelegramBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Telegram Boundary',
      boundaryType:
          'This boundary is reserved for Telegram messaging-channel intake and routing awareness.',
      separationNote:
          'It remains separate from direct human support handling and does not replace the Communications workspace or escalations.',
    );
  }

  Future<void> _showFacebookMessengerBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Facebook / Messenger Boundary',
      boundaryType:
          'This boundary is reserved for Facebook or Messenger intake and routing awareness.',
      separationNote:
          'It remains separate from direct human support handling and does not replace the Communications workspace or escalations.',
    );
  }

  Future<void> _showZoomMeetBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Zoom / Google Meet Coordination Boundary',
      boundaryType:
          'This boundary is reserved for meeting-link coordination and external channel routing awareness.',
      separationNote:
          'It remains separate from direct human support handling, Communications workspace case handling, and Operations-owned session scheduling.',
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
        onTap: () => CommunicationGatewayActions.openSupportEmail(
          context,
          intent: _selectedIntent,
        ),
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

    if (entry.id == 'whatsapp') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showWhatsAppBoundary(context),
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
        .where((entry) => entry.id == 'website_chat' || entry.id == 'support_email')
        .toList();
    final messagingEntries = communicationGatewayEntries
        .where((entry) =>
            entry.id == 'whatsapp' ||
            entry.id == 'telegram' ||
            entry.id == 'facebook_messenger')
        .toList();
    final coordinationEntries = communicationGatewayEntries
        .where((entry) =>
            entry.id == 'zoom_meet' || entry.id == 'external_intake')
        .toList();

    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Communication Gateway',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Communication Gateway',
              summary:
                  'Supervise channel intake boundaries and routing readiness without turning this page into a live communications workspace.',
              boundaryNote:
                  'Human case handling remains in Communications. This page stays focused on supervised connector boundaries only.',
              emphasis:
                  'No external channel integrations are active yet. This gateway remains a monitored shell.',
            ),
            const SizedBox(height: AppSpacing.md),
            AppSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Support Email intent',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: SupportEmailIntent.values.map((intent) {
                      return ChoiceChip(
                        label: Text(_intentLabel(intent)),
                        showCheckmark: true,
                        selected: _selectedIntent == intent,
                        onSelected: (_) {
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
                          color: const Color(0xFF2E5AAC),
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
                  'Messaging-boundary placeholders that remain supervised and separate from direct support handling.',
              entries: messagingEntries,
            ),
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
