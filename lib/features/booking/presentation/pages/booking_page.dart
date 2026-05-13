import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/booking/presentation/pages/booking_request_page.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

const bool kDevUi = bool.fromEnvironment('MK_DEV_UI', defaultValue: false);

String _safeText(dynamic value) => (value ?? '').toString().trim();

String _pickLocalized(
  Map<String, dynamic> d,
  String lang, {
  required List<String> arKeys,
  required List<String> enKeys,
  required String fallback,
}) {
  if (lang == 'ar') {
    for (final k in arKeys) {
      final v = _safeText(d[k]);
      if (v.isNotEmpty) return v;
    }
    for (final k in enKeys) {
      final v = _safeText(d[k]);
      if (v.isNotEmpty) return v;
    }
  } else {
    for (final k in enKeys) {
      final v = _safeText(d[k]);
      if (v.isNotEmpty) return v;
    }
    for (final k in arKeys) {
      final v = _safeText(d[k]);
      if (v.isNotEmpty) return _specialtyFallbackToEnglish(v);
    }
  }
  return fallback;
}

String _clinicianName(Map<String, dynamic> d, String lang) {
  return _pickLocalized(
    d,
    lang,
    arKeys: ['name_ar', 'displayName_ar', 'displayName'],
    enKeys: ['name_en', 'displayName_en', 'displayName'],
    fallback: lang == 'ar' ? 'أخصائي' : 'Specialist',
  );
}

String _specialtyFallbackToEnglish(String raw) {
  const map = {
    'علاج نفسي إكلينيكي': 'Clinical Psychology',
    'علاج نفسي فردي': 'Individual Therapy',
    'دعم نفسي وإرشاد': 'Psychological Support & Guidance',
    'جلسات جماعية': 'Group Sessions',
    'إرشاد أسري': 'Family Counseling',
    'مشورة أسرية': 'Family Consultation',
    'تخاطب': 'Speech Therapy',
    'إرشاد سلوكيات إدمانية': 'Addiction Behavior Counseling',
    'علاج إدماني': 'Addiction Treatment',
    'كوتشينج': 'Coaching',
  };

  return map[raw.trim()] ?? raw;
}

String _clinicianSpecialty(Map<String, dynamic> d, String lang) {
  final value = _pickLocalized(
    d,
    lang,
    arKeys: ['specialty_ar', 'specialty'],
    enKeys: ['specialty_en', 'specialty'],
    fallback: '',
  );
  return lang == 'ar' ? value : _specialtyFallbackToEnglish(value);
}

String _photoUrl(Map<String, dynamic> d) {
  return _safeText(d['photoUrl']).isNotEmpty
      ? _safeText(d['photoUrl'])
      : _safeText(d['photo_url']);
}

String _photoAsset(Map<String, dynamic> d) => _safeText(d['photoAsset']);

String _safeAssetPath(String raw) {
  final v = raw.trim();
  if (v.isEmpty) return '';
  if (!v.startsWith('assets/')) return '';
  return v;
}

String _safePhotoUrl(String raw) {
  final u = raw.trim();
  if (u.isEmpty) return '';
  final uri = Uri.tryParse(u);
  if (uri == null) return '';
  if (!uri.hasScheme) return '';
  return u;
}

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  Widget _buildAvatar(
    BuildContext context, {
    required String name,
    required String photoAsset,
    required String photoUrl,
  }) {
    final asset = _safeAssetPath(photoAsset);
    final network = _safePhotoUrl(photoUrl);

    if (network.isNotEmpty) {
      return CircleAvatar(
        radius: 26,
        backgroundImage: NetworkImage(network),
      );
    }

    if (asset.isNotEmpty) {
      return CircleAvatar(
        radius: 26,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: ClipOval(
          child: Image.asset(
            normalizeAssetPath(asset),
            width: 52,
            height: 52,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text(
                  name.isEmpty ? 'S' : name.characters.first,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              );
            },
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 26,
      child: Text(
        name.isEmpty ? 'S' : name.characters.first,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode.toLowerCase();
    final isArabic = lang == 'ar';

    final q = FirebaseFirestore.instance
        .collection('clinicians')
        .where('isActive', isEqualTo: true)
        .where('role', isEqualTo: 'clinician')
        .limit(50);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.bookingBookSpecialistTitle),
          actions: [
            IconButton(
              tooltip: l10n.bookingMyRequestsTitle,
              icon: const Icon(Icons.list_alt),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.myBookings),
            ),
            if (kDevUi)
              IconButton(
                tooltip: 'DEV',
                icon: const Icon(Icons.developer_mode),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.bookingDevUiEnabled)),
                  );
                },
              ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: q.snapshots(),
          builder: (context, snap) {
            if (snap.hasError) {
              return Center(child: Text(l10n.authUnexpectedError));
            }
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs = snap.data!.docs;
            if (docs.isEmpty) {
              return Center(
                child: Text(
                  l10n.bookingNoSpecialistsYet,
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: docs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final d = docs[i].data();
                final uid = _safeText(d['uid']).isNotEmpty
                    ? _safeText(d['uid'])
                    : docs[i].id;
                final name = _clinicianName(d, lang);
                final spec = _clinicianSpecialty(d, lang);
                final avatarUrl = _photoUrl(d);
                final avatarAsset = _photoAsset(d);

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        _buildAvatar(
                          context,
                          name: name,
                          photoAsset: avatarAsset,
                          photoUrl: avatarUrl,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: isArabic
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              if (spec.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  spec,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                              const SizedBox(height: 8),
                              Text(
                                l10n.bookingTrustedSpecialistHint,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              Routes.bookingRequest,
                              arguments: BookingRequestArgs(
                                clinicianId: uid,
                                clinicianName: name,
                              ),
                            );
                          },
                          child: Text(l10n.bookingSendRequest),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
