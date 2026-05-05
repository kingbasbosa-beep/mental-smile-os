import 'dart:html' as html;

class WebRegistrationDraftStore {
  static const _centerUidKey = 'webCenterDraftUid';

  static String? get centerUid => html.window.localStorage[_centerUidKey];

  static void setCenterUid(String uid) {
    html.window.localStorage[_centerUidKey] = uid;
  }

  static void clearCenterUid() {
    html.window.localStorage.remove(_centerUidKey);
  }
}
