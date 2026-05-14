const List<Map<String, String>> kRequiredCenterDocumentTypes = [
  {
    'key': 'identity_proof',
    'labelAr': 'إثبات هوية المسؤول',
    'labelEn': 'Manager identity proof',
  },
  {
    'key': 'center_license',
    'labelAr': 'ترخيص المركز',
    'labelEn': 'Center license',
  },
  {
    'key': 'location_proof',
    'labelAr': 'إثبات العنوان أو الموقع',
    'labelEn': 'Location/address proof',
  },
];

String centerDocumentLabel(String key, bool isArabic) {
  final match = kRequiredCenterDocumentTypes.where((e) => e['key'] == key);
  if (match.isEmpty) return key;
  return isArabic
      ? (match.first['labelAr'] ?? key)
      : (match.first['labelEn'] ?? key);
}

bool isRequiredCenterDocumentType(String key) {
  return kRequiredCenterDocumentTypes.any((e) => e['key'] == key);
}
