import 'package:flutter/foundation.dart';

class AppAnalytics {
  static void logPathSelected(String area, String path) {
    if (!kDebugMode) return;
    debugPrint('ANALYTICS path_selected area=$area path=$path');
  }

  static void logChatOpened(String source) {
    if (!kDebugMode) return;
    debugPrint('ANALYTICS chat_opened source=$source');
  }

  static void logModuleEntry(String module) {
    if (!kDebugMode) return;
    debugPrint('ANALYTICS module_entry module=$module');
  }
}
