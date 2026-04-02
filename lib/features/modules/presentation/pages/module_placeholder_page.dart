import 'package:flutter/material.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

class ModulePlaceholderPage extends StatelessWidget {
  final String title;

  const ModulePlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              t.modulePlaceholderBody,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
