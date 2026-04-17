import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/booking/presentation/pages/booking_request_page.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class SpecialistDetailsPage extends StatelessWidget {
  const SpecialistDetailsPage({
    super.key,
    required this.args,
  });

  final Map<String, dynamic> args;

  Map<String, dynamic> _mergedData(Map<String, dynamic>? firestoreData) {
    return {
      ...args,
      if (firestoreData != null) ...firestoreData,
    };
  }

  String _text(dynamic value, String fallback) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? fallback : text;
  }

  bool _boolValue(dynamic value) {
    return value == true;
  }

  List<String> _stringList(dynamic value) {
    if (value is List) {
      return value
          .map((e) => e.toString().trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return const [];
  }

  String _prefix(bool isArabic, String key, String ar, String en) {
    if (isArabic) {
      if (ar.trim().isNotEmpty) return ar.trim();
      switch (key) {
        case 'doctor':
          return 'د.';
        case 'specialist':
          return 'أ.';
        default:
          return '';
      }
    } else {
      if (en.trim().isNotEmpty) return en.trim();
      switch (key) {
        case 'doctor':
          return 'Dr.';
        case 'specialist':
          return 'Spec.';
        default:
          return '';
      }
    }
  }

  String _displayName(Map<String, dynamic> data, bool isArabic) {
    final name = _text(
      data['displayName'],
      isArabic ? 'أخصائي' : 'Specialist',
    );
    final prefix = _prefix(
      isArabic,
      (data['professionalTitleKey'] ?? '').toString(),
      (data['professionalTitleLabelAr'] ?? '').toString(),
      (data['professionalTitleLabelEn'] ?? '').toString(),
    );
    if (prefix.isEmpty) return name;
    return '$prefix $name';
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'S';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  String _safePhotoUrl(String raw) {
    final u = raw.trim();
    if (u.isEmpty) return '';
    final uri = Uri.tryParse(u);
    if (uri == null || !uri.hasScheme) return '';
    return u;
  }

  Widget _buildAvatar(
      BuildContext context, String name, String asset, String network) {
    final assetPath = asset.trim().startsWith('assets/') ? asset.trim() : '';
    final photoUrl = _safePhotoUrl(network);

    if (photoUrl.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          photoUrl,
          width: 132,
          height: 132,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                _initials(name),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
            );
          },
        ),
      );
    }

    if (assetPath.isNotEmpty) {
      return ClipOval(
        child: Image.asset(
          normalizeAssetPath(assetPath),
          width: 132,
          height: 132,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                _initials(name),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
            );
          },
        ),
      );
    }

    return Center(
      child: Text(
        _initials(name),
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 34,
        ),
      ),
    );
  }

  String _fallbackPrice(bool isArabic) {
    return isArabic ? 'يحدد لاحقًا' : 'To be determined';
  }

  String _fallbackDuration(bool isArabic) {
    return isArabic ? 'غير محددة' : 'Not specified';
  }

  List<String> _fallbackModes(bool isArabic) {
    return [
      isArabic ? 'حضوري' : 'In person',
      isArabic ? 'أونلاين' : 'Online',
    ];
  }

  Widget _buildRatingsSummary(
    BuildContext context, {
    required bool isArabic,
    required String clinicianId,
  }) {
    final scheme = Theme.of(context).colorScheme;

    if (clinicianId.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('sessionRatings')
          .where('clinicianId', isEqualTo: clinicianId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: Text(
              isArabic ? 'تعذر تحميل التقييمات' : 'Unable to load ratings',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          );
        }

        if (!snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final docs = snapshot.data!.docs;
        final count = docs.length;

        double totalStars = 0;
        double totalPercentage = 0;

        for (final doc in docs) {
          final data = doc.data();
          totalStars += ((data['derivedStars'] ?? 0) as num).toDouble();
          totalPercentage += ((data['percentageScore'] ?? 0) as num).toDouble();
        }

        final avgStars = count == 0 ? 0.0 : totalStars / count;
        final avgPercentage = count == 0 ? 0.0 : totalPercentage / count;

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: scheme.outline.withValues(alpha: 0.12),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'التقييمات' : 'Ratings',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _InfoMiniCard(
                      title: isArabic ? 'عدد التقييمات' : 'Ratings count',
                      value: '$count',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoMiniCard(
                      title: isArabic ? 'متوسط النجوم' : 'Average stars',
                      value: avgStars.toStringAsFixed(1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _InfoMiniCard(
                title: isArabic ? 'المتوسط العام' : 'Overall average',
                value: '${avgPercentage.toStringAsFixed(1)}%',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required bool isArabic,
    required ColorScheme scheme,
    required Map<String, dynamic> data,
    required String uid,
  }) {
    final name = _displayName(data, isArabic);
    final specialty = _text(
      data['specialty'],
      isArabic ? 'بدون تخصص محدد' : 'No specific specialty',
    );
    final bio = _text(
      data['bio'],
      isArabic ? 'لا توجد نبذة متاحة حاليًا.' : 'No bio available yet.',
    );
    final offersGroups = _boolValue(data['offersGroupSessions']);
    final asset = _text(data['photoAsset'], '');
    final network = _text(data['photoUrl'], '');
    final price = _text(data['sessionPriceText'], _fallbackPrice(isArabic));
    final duration = _text(
      data['sessionDurationText'],
      _fallbackDuration(isArabic),
    );
    final modes = _stringList(data['sessionModes']);
    final sessionModes = modes.isEmpty ? _fallbackModes(isArabic) : modes;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: scheme.outline.withValues(alpha: 0.12),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 18,
                offset: const Offset(0, 8),
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'الصورة الشخصية' : 'Profile image',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: scheme.outline.withValues(alpha: 0.10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                        color: Colors.black.withValues(alpha: 0.05),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7C6EF6),
                            Color(0xFFB9A9FF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: _buildAvatar(context, name, asset, network),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  specialty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.78),
                      ),
                ),
              ),
              if (offersGroups) ...[
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3ECFF),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      isArabic ? 'يقدم جروبات جماعية' : 'Offers group sessions',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6C55B3),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _InfoMiniCard(
                      title: isArabic ? 'السعر' : 'Price',
                      value: price,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoMiniCard(
                      title: isArabic ? 'مدة الجلسة' : 'Duration',
                      value: duration,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                isArabic ? 'وسائل الجلسة' : 'Session methods',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.end,
                children: [
                  for (final mode in sessionModes)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F2FA),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: scheme.outline.withValues(alpha: 0.10),
                        ),
                      ),
                      child: Text(
                        mode,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildRatingsSummary(
          context,
          isArabic: isArabic,
          clinicianId: uid,
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: scheme.outline.withValues(alpha: 0.12),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'نبذة' : 'About',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                bio,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        FilledButton.icon(
          onPressed: uid.isEmpty
              ? null
              : () {
                  Navigator.of(context).pushNamed(
                    Routes.bookingRequest,
                    arguments: BookingRequestArgs(
                      clinicianId: uid,
                      clinicianName: name,
                    ),
                  );
                },
          icon: const Icon(Icons.calendar_month_outlined),
          label: Text(isArabic ? 'طلب حجز' : 'Request booking'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final scheme = Theme.of(context).colorScheme;

    final uid = _text(args['uid'], '');

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isArabic ? 'تفاصيل الأخصائي' : 'Specialist details'),
        ),
        body: uid.isEmpty
            ? _buildContent(
                context,
                isArabic: isArabic,
                scheme: scheme,
                data: args,
                uid: uid,
              )
            : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('clinicians')
                    .doc(uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  final firestoreData = snapshot.data?.data();
                  final mergedData = _mergedData(firestoreData);

                  return _buildContent(
                    context,
                    isArabic: isArabic,
                    scheme: scheme,
                    data: mergedData,
                    uid: uid,
                  );
                },
              ),
      ),
    );
  }
}

class _InfoMiniCard extends StatelessWidget {
  const _InfoMiniCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.68),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
