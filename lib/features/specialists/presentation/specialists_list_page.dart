import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class SpecialistsListPage extends StatelessWidget {
  const SpecialistsListPage({
    super.key,
    required this.args,
  });

  final Map<String, dynamic> args;

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  String _categoryKey() {
    return (args['category'] ?? '').toString().trim();
  }

  String _title(BuildContext context) {
    final isArabic = _isArabic(context);
    final fromArgs = (args['title'] ?? '').toString().trim();
    if (fromArgs.isNotEmpty) return fromArgs;
    return isArabic ? 'الأخصائيون' : 'Specialists';
  }

  bool _matchesCategory(Map<String, dynamic> data) {
    final category = _categoryKey();
    final specialtyKey = (data['specialtyKey'] ?? '').toString().trim();

    switch (category) {
      case 'psychologists':
        return specialtyKey == 'psychologist' ||
            specialtyKey == 'clinical_psychologist';
      case 'family_counseling':
        return specialtyKey == 'family_counselor';
      case 'speech_specialists':
        return specialtyKey == 'speech_specialist';
      case 'coaching':
        return specialtyKey == 'coach';
      case 'addiction':
        return specialtyKey == 'addiction_counselor';
      default:
        return true;
    }
  }

  String _displayName(Map<String, dynamic> data, bool isArabic) {
    final name = (data['displayName'] ?? '').toString().trim();
    final titleAr = (data['professionalTitleLabelAr'] ?? '').toString().trim();
    final titleEn = (data['professionalTitleLabelEn'] ?? '').toString().trim();

    if (isArabic) {
      if (titleAr.isNotEmpty && name.isNotEmpty) return '$titleAr $name';
      if (name.isNotEmpty) return name;
      return 'أخصائي';
    }

    if (titleEn.isNotEmpty && name.isNotEmpty) return '$titleEn $name';
    if (name.isNotEmpty) return name;
    return 'Specialist';
  }

  String _specialty(Map<String, dynamic> data, bool isArabic) {
    final value = (data['specialty'] ?? '').toString().trim();
    if (value.isNotEmpty) return value;
    return isArabic ? 'بدون تخصص محدد' : 'No specialty specified';
  }

  String _bio(Map<String, dynamic> data, bool isArabic) {
    final value = (data['bio'] ?? '').toString().trim();
    if (value.isNotEmpty) return value;
    return isArabic ? 'لا توجد نبذة متاحة حاليًا.' : 'No bio available yet.';
  }

  String _price(Map<String, dynamic> data, bool isArabic) {
    final value = (data['sessionPriceText'] ?? '').toString().trim();
    if (value.isNotEmpty) return value;
    return isArabic ? 'يحدد لاحقًا' : 'To be determined';
  }

  String _duration(Map<String, dynamic> data, bool isArabic) {
    final value = (data['sessionDurationText'] ?? '').toString().trim();
    if (value.isNotEmpty) return value;
    return isArabic ? 'غير محددة' : 'Not specified';
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'S';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  String _safePhotoUrl(String raw) {
    final u = raw.trim();
    if (u.isEmpty) return '';
    final uri = Uri.tryParse(u);
    if (uri == null || !uri.hasScheme) return '';
    return u;
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final scheme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: _title(context),
        ),
        body: Stack(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('clinicians')
                  .where('isActive', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      isArabic
                          ? 'تعذر تحميل الأخصائيين'
                          : 'Unable to load specialists',
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs.where((doc) {
                  final data = doc.data();
                  final role = (data['role'] ?? '').toString().trim();
                  if (role != 'clinician') return false;
                  return _matchesCategory(data);
                }).toList();

                if (docs.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        isArabic
                            ? 'لا يوجد أخصائيون ظاهرون في هذا القسم حاليًا'
                            : 'No active specialists in this category right now',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2;
                    double childAspectRatio = 1.15;

                    if (constraints.maxWidth < 760) {
                      crossAxisCount = 1;
                      childAspectRatio = 1.02;
                    } else if (constraints.maxWidth > 1450) {
                      crossAxisCount = 3;
                      childAspectRatio = 1.18;
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        final data = doc.data();

                        final name = _displayName(data, isArabic);
                        final specialty = _specialty(data, isArabic);
                        final bio = _bio(data, isArabic);
                        final price = _price(data, isArabic);
                        final duration = _duration(data, isArabic);
                        final photoAsset =
                            (data['photoAsset'] ?? '').toString().trim();
                        final photoUrl = _safePhotoUrl(
                          (data['photoUrl'] ?? '').toString(),
                        );
                        final imageProvider = photoUrl.isNotEmpty
                            ? NetworkImage(photoUrl) as ImageProvider
                            : (photoAsset.startsWith('assets/')
                                ? safeAssetImageProvider(photoAsset)
                                : null);
                        final offersGroups =
                            (data['offersGroupSessions'] ?? false) == true;

                        return InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {
                            AppAnalytics.logPathSelected(
                              'specialists',
                              'view_profile',
                            );
                            Navigator.of(context).pushNamed(
                              Routes.specialistDetails,
                              arguments: {
                                'uid': doc.id,
                                ...data,
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: scheme.outline.withValues(alpha: 0.12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 16,
                                  offset: const Offset(0, 8),
                                  color: Colors.black.withValues(alpha: 0.04),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: isArabic
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          scheme.primary.withValues(alpha: 0.10),
                                      backgroundImage: imageProvider,
                                      child: imageProvider == null
                                          ? Text(
                                              _initials(name),
                                              style: TextStyle(
                                                color: scheme.primary,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            )
                                          : null,
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
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: isArabic
                                                ? TextAlign.right
                                                : TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            specialty,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: isArabic
                                                ? TextAlign.right
                                                : TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  bio,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign:
                                      isArabic ? TextAlign.right : TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        height: 1.4,
                                      ),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _MiniInfoBox(
                                        title: isArabic ? 'السعر' : 'Price',
                                        value: price,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: _MiniInfoBox(
                                        title: isArabic ? 'المدة' : 'Duration',
                                        value: duration,
                                      ),
                                    ),
                                  ],
                                ),
                                if (offersGroups) ...[
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: isArabic
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3ECFF),
                                        borderRadius:
                                            BorderRadius.circular(999),
                                      ),
                                      child: Text(
                                        isArabic
                                            ? 'يقدم جروبات جماعية'
                                            : 'Offers group sessions',
                                        style: const TextStyle(
                                          color: Color(0xFF6C55B3),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: FilledButton.icon(
                                    onPressed: () {
                                      AppAnalytics.logPathSelected(
                                        'specialists',
                                        'view_profile',
                                      );
                                      Navigator.of(context).pushNamed(
                                        Routes.specialistDetails,
                                        arguments: {
                                          'uid': doc.id,
                                          ...data,
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.visibility_outlined),
                                    label: Text(
                                      isArabic ? 'عرض المزيد' : 'View details',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            const _PathSelectionLogger(
              module: 'specialists',
              path: 'browse',
            ),
          ],
        ),
      ),
    );
  }
}

class _PathSelectionLogger extends StatefulWidget {
  const _PathSelectionLogger({
    required this.module,
    required this.path,
  });

  final String module;
  final String path;

  @override
  State<_PathSelectionLogger> createState() => _PathSelectionLoggerState();
}

class _PathSelectionLoggerState extends State<_PathSelectionLogger> {
  @override
  void initState() {
    super.initState();
    AppAnalytics.logPathSelected(widget.module, widget.path);
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _MiniInfoBox extends StatelessWidget {
  const _MiniInfoBox({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface.withValues(alpha: 0.70),
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
