import 'dart:html' as html;

class WebRegistrationDraftStore {
  static const _centerUidKey = 'webCenterDraftUid';
  static const _clinicianUidKey = 'webClinicianDraftUid';

  static String? get centerUid => html.window.localStorage[_centerUidKey];
  static String? get clinicianUid => html.window.localStorage[_clinicianUidKey];

  static void setCenterUid(String uid) {
    html.window.localStorage[_centerUidKey] = uid;
  }

  static void setClinicianUid(String uid) {
    html.window.localStorage[_clinicianUidKey] = uid;
  }

  static void clearCenterUid() {
    html.window.localStorage.remove(_centerUidKey);
  }

  static void clearClinicianUid() {
    html.window.localStorage.remove(_clinicianUidKey);
  }
}
