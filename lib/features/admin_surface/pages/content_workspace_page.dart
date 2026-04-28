import 'package:flutter/material.dart';
import 'package:flutterprojects/features/admin_surface/pages/admin_workspace_command_center_page.dart';

class ContentWorkspacePage extends StatelessWidget {
  const ContentWorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: future role guard -> content_operator / content_editor
    return const AdminWorkspaceCommandCenterPage(
      standaloneMode: true,
    );
  }
}
