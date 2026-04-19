import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/core/communication_gateway_actions.dart';
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

  Future<void> _showWebsiteChatBoundary(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Website Chat Boundary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'This boundary is reserved for website-origin intake and routing awareness.',
              ),
              SizedBox(height: AppSpacing.sm),
              Text('Current status: Planned / supervised / not integrated yet.'),
              SizedBox(height: AppSpacing.sm),
              Text(
                'It is separate from direct human support handling, which remains in the Communications workspace.',
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

  Future<void> _showWhatsAppBoundary(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('WhatsApp Boundary'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'This boundary is reserved for messaging-channel intake and routing awareness.',
              ),
              SizedBox(height: AppSpacing.sm),
              Text('Current status: Planned / supervised / not integrated yet.'),
              SizedBox(height: AppSpacing.sm),
              Text(
                'It remains separate from direct human support handling and does not replace the Communications workspace or escalations.',
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

  @override
  Widget build(BuildContext context) {
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
            AppSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Communication Gateway',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'A gateway shell for future external communication channels and intake routing. Human case handling remains in Communications.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.72),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'This page supervises connector boundaries only. It does not replace the human communications workspace.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.70),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
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
                        selected: _selectedIntent == intent,
                        onSelected: (_) {
                          setState(() {
                            _selectedIntent = intent;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...communicationGatewayEntries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: entry.id == 'support_email'
                    ? InkWell(
                        borderRadius: BorderRadius.circular(AppRadii.xl),
                        onTap: () =>
                            CommunicationGatewayActions.openSupportEmail(
                          context,
                          intent: _selectedIntent,
                        ),
                        child: GatewayEntryCard(entry: entry),
                      )
                    : entry.id == 'website_chat'
                        ? InkWell(
                            borderRadius: BorderRadius.circular(AppRadii.xl),
                            onTap: () => _showWebsiteChatBoundary(context),
                            child: GatewayEntryCard(entry: entry),
                          )
                        : entry.id == 'whatsapp'
                            ? InkWell(
                                borderRadius: BorderRadius.circular(
                                  AppRadii.xl,
                                ),
                                onTap: () => _showWhatsAppBoundary(context),
                                child: GatewayEntryCard(entry: entry),
                              )
                    : GatewayEntryCard(entry: entry),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
