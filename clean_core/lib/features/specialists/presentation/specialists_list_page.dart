import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/specialists/data/clinician_specialty_catalog.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/ui_kit/asset_fallback_widgets.dart';

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

  String _returnRoute() {
    final route = (args['returnRoute'] ?? '').toString().trim();
    return route.isEmpty ? Routes.specialists : route;
  }

  Map<String, dynamic>? _returnArguments() {
    final parentReturnRoute = (args['parentReturnRoute'] ?? '').toString().trim();
    if (parentReturnRoute.isEmpty) return null;
    return {'returnRoute': parentReturnRoute};
  }

  String _title(BuildContext context) {
    final isArabic = _isArabic(context);
    final fromArgs = (args['title'] ?? '').toString().trim();
    if (fromArgs.isNotEmpty) return fromArgs;
    return isArabic ? 'الأخصائيون' : 'Specialists';
  }

  bool _matchesCategory(Map<String, dynamic> data) {
    final specialtyKey = (data['specialtyKey'] ?? '').toString().trim();
    return ClinicianSpecialtyCatalog.specialtyMatchesCategory(
      specialtyKey: specialtyKey,
      categoryKey: _categoryKey(),
    );
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
    final specialtyLabel = ClinicianSpecialtyCatalog.specialtyLabel(
      specialtyKey: (data['specialtyKey'] ?? '').toString(),
      isArabic: isArabic,
    );
    if (specialtyLabel.isNotEmpty) return specialtyLabel;
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

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, pageConstraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  _backgroundAsset(pageConstraints.maxWidth),
                  fit: BoxFit.cover,
                  alignment: pageConstraints.maxWidth < 700
                      ? Alignment.topCenter
                      : Alignment.center,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.50),
                        Colors.black.withValues(alpha: 0.30),
                        Colors.black.withValues(alpha: 0.66),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('clinicians')
                      .where('isActive', isEqualTo: true)
                      .where('approvalStatus', isEqualTo: 'approved')
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
                        const crossAxisCount = 1;
                        final childAspectRatio =
                            constraints.maxWidth < 760 ? 1.02 : 2.35;

                        return GridView.builder(
                          padding: EdgeInsets.fromLTRB(
                            16,
                            pageConstraints.maxWidth < 700 ? 76 : 92,
                            16,
                            16,
                          ),
                          itemCount: docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                  color: Colors.black.withValues(alpha: 0.34),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: const Color(0xFFE7C766)
                                        .withValues(alpha: 0.34),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 26,
                                      offset: const Offset(0, 12),
                                      color: const Color(0xFFE7C766)
                                          .withValues(alpha: 0.10),
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
                                              const Color(0xFFE7C766)
                                                  .withValues(alpha: 0.18),
                                          backgroundImage: imageProvider,
                                          child: imageProvider == null
                                              ? Text(
                                                  _initials(name),
                                                  style: const TextStyle(
                                                    color: Color(0xFFFFE7B2),
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
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: const Color(
                                                          0xFFFFE7B2),
                                                    ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                specialty,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: const Color(
                                                              0xFFFFF4D4)
                                                          .withValues(
                                                              alpha: 0.78),
                                                    ),
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
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            height: 1.4,
                                            color: const Color(0xFFFFF4D4)
                                                .withValues(alpha: 0.84),
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
                                            title:
                                                isArabic ? 'المدة' : 'Duration',
                                            value: duration,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (offersGroups) ...[
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 7,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE7C766)
                                                .withValues(alpha: 0.16),
                                            borderRadius:
                                                BorderRadius.circular(999),
                                            border: Border.all(
                                              color: const Color(0xFFE7C766)
                                                  .withValues(alpha: 0.30),
                                            ),
                                          ),
                                          child: Text(
                                            isArabic
                                                ? 'يقدم جروبات جماعية'
                                                : 'Offers group sessions',
                                            style: const TextStyle(
                                              color: Color(0xFFFFE7B2),
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
                                        style: FilledButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFFE7C766)
                                                  .withValues(alpha: 0.16),
                                          foregroundColor:
                                              const Color(0xFFFFE7B2),
                                          side: BorderSide(
                                            color: const Color(0xFFE7C766)
                                                .withValues(alpha: 0.38),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                        ),
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
                                        icon: const Icon(
                                            Icons.visibility_outlined),
                                        label: Text(
                                          isArabic
                                              ? 'عرض المزيد'
                                              : 'View details',
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
                SafeArea(
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: pageConstraints.maxWidth < 700 ? 14 : 22,
                        top: pageConstraints.maxWidth < 700 ? 12 : 18,
                      ),
                      child: _BackToMenuButton(
                        compact: pageConstraints.maxWidth < 700,
                        returnRoute: _returnRoute(),
                        returnArguments: _returnArguments(),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: pageConstraints.maxWidth < 700 ? 16 : 28,
                        top: pageConstraints.maxWidth < 700 ? 18 : 24,
                      ),
                      child: Text(
                        _title(context),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: const Color(0xFFFFE7B2),
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BackToMenuButton extends StatelessWidget {
  const _BackToMenuButton({
    required this.compact,
    required this.returnRoute,
    required this.returnArguments,
  });

  final bool compact;
  final String returnRoute;
  final Map<String, dynamic>? returnArguments;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 44.0 : 52.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.of(context).pushNamed(
          returnRoute,
          arguments: returnArguments,
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1B1007).withValues(alpha: 0.50),
            border: Border.all(
              color: const Color(0xFFFFD98A).withValues(alpha: 0.56),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE7A94C).withValues(alpha: 0.18),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Image.asset(
            Directionality.of(context) == TextDirection.rtl
                ? 'assets/branding/navigation/back/back_right_gold.png'
                : 'assets/branding/navigation/back/back_left_gold.png',
            width: compact ? 22 : 26,
            height: compact ? 22 : 26,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.arrow_back_rounded,
                color: const Color(0xFFFFE7B2),
                size: compact ? 22 : 26,
              );
            },
          ),
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
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.22),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFF4D4).withValues(alpha: 0.72),
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFFFE7B2),
                ),
          ),
        ],
      ),
    );
  }
}
