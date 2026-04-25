import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/core/gateway_monitor.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminGatewayLayerPage extends StatelessWidget {
  const AdminGatewayLayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    const gatewayMonitor = GatewayMonitor();
    final statusesByKey = {
      for (final status in gatewayMonitor.familyStatuses()) status.key!: status,
    };

    return Scaffold(
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Gateway Layer',
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
              title: 'Gateway Layer',
              summary:
                  'Connect, isolate, and supervise channels, tools, devices, and storage without mixing them into business workflows.',
              boundaryNote:
                  'Each gateway family is a technical compartment that keeps future integration, supervision, and isolation safer.',
              emphasis:
                  'Business workflows remain in Operations and Communications. Gateway Layer stays focused on supervised technical boundaries.',
            ),
            const SizedBox(height: AppSpacing.md),
            ...gatewayFamilyEntries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: GatewayFamilyCard(
                  entry: entry,
                  statusOverride: statusesByKey[entry.id],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
