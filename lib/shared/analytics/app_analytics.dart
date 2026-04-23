import 'dart:async';
import 'dart:collection';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AppAnalytics {
  const AppAnalytics._();

  static final Map<String, int> _moduleEntryCounts = <String, int>{};
  static final Map<String, int> _pathCounts = <String, int>{};
  static final Map<String, int> _chatContextCounts = <String, int>{};
  static final ValueNotifier<int> _revision = ValueNotifier<int>(0);

  static ValueListenable<int> get listenable => _revision;

  static void logModuleEntry(String module) {
    _increment(_moduleEntryCounts, module);
    unawaited(
      FirebaseAnalytics.instance.logEvent(
        name: 'module_entry',
        parameters: {'module': module},
      ),
    );
  }

  static void logPathSelected(String module, String path) {
    _increment(_pathCounts, '$module -> $path');
    unawaited(
      FirebaseAnalytics.instance.logEvent(
        name: 'path_selected',
        parameters: {
          'module': module,
          'path': path,
        },
      ),
    );
  }

  static void logChatOpened(String entryContext) {
    _increment(_chatContextCounts, entryContext);
    unawaited(
      FirebaseAnalytics.instance.logEvent(
        name: 'chat_opened',
        parameters: {'entry_context': entryContext},
      ),
    );
  }

  static List<MapEntry<String, int>> getTopModules() {
    return _sortedEntries(_moduleEntryCounts);
  }

  static List<MapEntry<String, int>> getTopPaths() {
    return _sortedEntries(_pathCounts);
  }

  static Map<String, int> getChatContextSplit() {
    return UnmodifiableMapView<String, int>(
      Map<String, int>.from(_chatContextCounts),
    );
  }

  static void _increment(Map<String, int> counts, String key) {
    final normalizedKey = key.trim();
    if (normalizedKey.isEmpty) return;
    counts[normalizedKey] = (counts[normalizedKey] ?? 0) + 1;
    _revision.value++;
  }

  static List<MapEntry<String, int>> _sortedEntries(Map<String, int> counts) {
    final entries = counts.entries.toList()
      ..sort((a, b) {
        final byCount = b.value.compareTo(a.value);
        if (byCount != 0) return byCount;
        return a.key.compareTo(b.key);
      });
    return List.unmodifiable(entries);
  }
}
