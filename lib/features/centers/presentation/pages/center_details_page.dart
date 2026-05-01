import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_booking_request_page.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:flutterprojects/features/centers/data/services/centers_firestore_service.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:url_launcher/url_launcher.dart';

class CenterDetailsPage extends StatelessWidget {
  final CenterModel? center;
  final String? centerId;

  const CenterDetailsPage({
    super.key,
    this.center,
    this.centerId,
  });

  String _categoryLabelAr(CenterModel c) {
    final label = c.categoryLabelAr.trim();
    if (label.isNotEmpty) return label;

    switch (c.category.trim()) {
      case 'recovery':
        return 'مراكز التعافي';
      case 'detox':
        return 'مراكز سحب السموم';
      case 'hospital':
      case 'hospitals':
        return 'المستشفيات';
      case 'special_needs':
        return 'مراكز رعاية ذوي الاحتياجات الخاصة';
      default:
        return 'مركز';
    }
  }

  String _centerTypeLabelAr(CenterModel c) {
    switch (c.centerType.trim()) {
      case 'detox':
        return 'ديتوكس / أعراض انسحاب';
      case 'hospital':
        return 'مستشفى';
      case 'special_needs_care':
        return 'رعاية ذوي الاحتياجات الخاصة';
      case 'halfway_house':
      default:
        return 'هاف واي';
    }
  }

  String _locationLine(CenterModel c) {
    final parts = <String>[];
    final city = c.city.trim();
    final area = c.area.trim();
    if (city.isNotEmpty) parts.add(city);
    if (area.isNotEmpty) parts.add(area);
    return parts.join(' / ');
  }

  String _digitsOnly(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  Future<void> _tryLaunch(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر فتح الرابط')),
      );
    }
  }

  Widget _sectionCard({
    required BuildContext context,
    required Widget child,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.12)),
      ),
      child: child,
    );
  }

  Widget _assetOrNetworkImage({
    required String value,
    double? height,
    double? width,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
  }) {
    final v = value.trim().replaceFirst('assets/assets/', 'assets/');
    if (v.isEmpty) return const SizedBox.shrink();

    final bool isAsset = v.startsWith('assets/');
    final Widget img = isAsset
        ? Image.asset(
            v,
            height: height,
            width: width,
            fit: fit,
            errorBuilder: (context, error, stack) {
              return Container(
                height: height,
                width: width,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined),
              );
            },
          )
        : Image.network(
            v,
            height: height,
            width: width,
            fit: fit,
            errorBuilder: (context, error, stack) {
              return Container(
                height: height,
                width: width,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image_outlined),
              );
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                height: height,
                width: width,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
          );

    if (borderRadius == null) return img;
    return ClipRRect(borderRadius: borderRadius, child: img);
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      textAlign: TextAlign.right,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w800),
    );
  }

  Widget _coverSection(BuildContext context, String coverValue) {
    final v = coverValue.trim();
    if (v.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        _sectionCard(
          context: context,
          child: _assetOrNetworkImage(
            value: v,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _gallerySection(BuildContext context, List<String> values) {
    const frameLabels = [
      'الواجهة',
      'الاستقبال',
      'داخلي 1',
      'داخلي 2',
    ];
    final padded = List<String>.from(
      values.map((e) => e.trim()).where((e) => e.isNotEmpty).take(4),
    );
    while (padded.length < 4) {
      padded.add('');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _sectionTitle(context, 'صور المركز'),
              const SizedBox(height: 12),
              GridView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.35,
                ),
                itemBuilder: (context, index) {
                  final value = padded[index];
                  final scheme = Theme.of(context).colorScheme;

                  return Container(
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest.withValues(
                        alpha: 0.50,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: scheme.outline.withValues(alpha: 0.10),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: value.isEmpty
                              ? Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 34,
                                    color: scheme.onSurface.withValues(
                                      alpha: 0.35,
                                    ),
                                  ),
                                )
                              : _assetOrNetworkImage(
                                  value: value,
                                  fit: BoxFit.cover,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              frameLabels[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _pricingSection(BuildContext context, CenterModel c) {
    final isAutism = usesAutismCarePricing(c.category);
    final accommodationItems = c.accommodationCosts
        .where((item) => item.enabled && item.price > 0)
        .toList();
    final autismItems = c.autismCareCosts
        .where((item) => item.enabled && item.price > 0)
        .toList();
    String unitLabel(String unit) {
      switch (unit) {
        case 'day':
          return 'يومي';
        case 'month':
          return 'شهري';
        default:
          return '';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _sectionTitle(context, 'تكلفة الإقامة'),
              const SizedBox(height: 10),
              if (isAutism)
                for (final item in autismItems) ...[
                  Text(
                    item.labelAr,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    [
                      'السعر: ${item.price}',
                      if (item.pricingUnit.isNotEmpty)
                        'الوحدة: ${unitLabel(item.pricingUnit)}',
                      item.taxIncluded ? 'الضريبة شاملة' : 'الضريبة غير شاملة',
                    ].join(' • '),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 10),
                ]
              else
                for (final item in accommodationItems) ...[
                  Text(
                    item.labelAr,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    [
                      'السعر: ${item.price}',
                      if (item.pricingUnit.isNotEmpty)
                        'الوحدة: ${unitLabel(item.pricingUnit)}',
                      if (item.acMode == 'ac') 'مكيف',
                      if (item.acMode == 'non_ac') 'غير مكيف',
                      if (item.includesMedication) 'يشمل الدواء',
                      if (item.includesMeals) 'يشمل الوجبات',
                      if (item.includesOutdoorActivities) 'أنشطة خارجية',
                      if (item.includesRequiredTests) 'يشمل الفحوصات',
                      if (item.includesAirportPickup) 'استقبال مطار',
                      if (item.includesTourismOrExternalOutings) 'جولات خارجية',
                      item.taxIncluded ? 'الضريبة شاملة' : 'الضريبة غير شاملة',
                    ].join(' • '),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 10),
                ],
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _serviceTypeSection(BuildContext context, CenterModel c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _sectionTitle(context, 'نوع المركز وخدمته'),
              const SizedBox(height: 10),
              Text(
                'النوع التشغيلي: ${_centerTypeLabelAr(c)}',
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 6),
              Text(
                c.hasDetoxUnit
                    ? 'يوجد قسم داخلي لأعراض الانسحاب.'
                    : 'لا يوجد قسم داخلي مستقل لأعراض الانسحاب.',
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _capabilitiesSection(BuildContext context, CenterModel c) {
    final items = <String>[];
    if (c.capabilities.supportsAddictionCasesWithHiv) {
      items.add('يدعم حالات الإدمان المصاحبة لفيروس HIV');
    }
    if (c.capabilities.acceptsAddictionCases) {
      items.add('يستقبل حالات الإدمان');
    }
    if (c.capabilities.acceptsPsychiatricCasesWithoutAddiction) {
      items.add('يستقبل الحالات النفسية بدون إدمان');
    }
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _sectionTitle(context, 'قدرات المركز'),
              const SizedBox(height: 10),
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(item, textAlign: TextAlign.right),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _infoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final v = value.trim();
    if (v.isEmpty) return const SizedBox.shrink();

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            v,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: onTap == null ? FontWeight.w600 : FontWeight.w800,
                  color: onTap == null ? null : scheme.primary,
                ),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );

    if (onTap == null) return row;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: row,
      ),
    );
  }

  Widget _buildContent(BuildContext context, CenterModel c) {
    final scheme = Theme.of(context).colorScheme;
    final name = c.name.trim().isEmpty ? 'مركز' : c.name.trim();
    final categoryLabel = _categoryLabelAr(c);
    final loc = _locationLine(c);
    final desc = c.description.trim();
    final address = c.address.trim();
    final phone = c.phone.trim();
    final whatsapp = c.whatsapp.trim();
    final services = c.services.where((e) => e.trim().isNotEmpty).toList();

    final coverValue = c.coverImageUrl.trim().isNotEmpty
        ? c.coverImageUrl.trim()
        : (c.coverImageAsset.trim().isNotEmpty
            ? c.coverImageAsset.trim()
            : c.imageUrl.trim());

    final galleryValues = <String>[
      ...c.galleryImageUrls.where((value) => value.trim().isNotEmpty),
      ...c.galleryImageAssets.where((value) => value.trim().isNotEmpty),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _coverSection(context, coverValue),
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                name,
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.end,
                children: [
                  Chip(
                    label: Text(
                      categoryLabel,
                      textAlign: TextAlign.right,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                  if (loc.isNotEmpty)
                    Chip(
                      label: Text(
                        loc,
                        textAlign: TextAlign.right,
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor:
                          scheme.surfaceContainerHighest.withValues(alpha: 0.6),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    AppAnalytics.logPathSelected(
                      'centers',
                      'start_booking',
                    );
                    Navigator.of(context).pushNamed(
                      Routes.centerBookingRequest,
                      arguments: CenterBookingRequestArgs(
                        centerId: c.id,
                        centerName: name,
                        centerType: c.centerType,
                        hasDetoxUnit: c.hasDetoxUnit,
                      ),
                    );
                  },
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('اطلب المركز عبر الإدارة'),
                ),
              ),
            ],
          ),
        ),
        if (desc.isNotEmpty) ...[
          const SizedBox(height: 12),
          _sectionCard(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'نبذة',
                  textAlign: TextAlign.right,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Text(
                  desc,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 12),
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'التواصل والموقع',
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              _infoRow(
                context: context,
                icon: Icons.location_on_outlined,
                label: 'العنوان',
                value: address,
              ),
              _infoRow(
                context: context,
                icon: Icons.phone_outlined,
                label: 'هاتف',
                value: phone,
                onTap: phone.isEmpty
                    ? null
                    : () =>
                        _tryLaunch(context, Uri(scheme: 'tel', path: phone)),
              ),
              _infoRow(
                context: context,
                icon: Icons.chat_outlined,
                label: 'واتساب',
                value: whatsapp,
                onTap: null,
              ),
            ],
          ),
        ),
        if (services.isNotEmpty) ...[
          const SizedBox(height: 12),
          _sectionCard(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'الخدمات',
                  textAlign: TextAlign.right,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.end,
                  children: [
                    for (final s in services)
                      Chip(
                        label: Text(
                          s.trim(),
                          textAlign: TextAlign.right,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
        _gallerySection(context, galleryValues),
        _serviceTypeSection(context, c),
        _pricingSection(context, c),
        _capabilitiesSection(context, c),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final initial = center;
    final id = centerId?.trim();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل المركز'),
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Builder(
          builder: (context) {
            if (initial != null) {
              return _buildContent(context, initial);
            }

            if (id == null || id.isEmpty) {
              return const Center(
                child: Text('تعذّر العثور على بيانات المركز'),
              );
            }

            final service = CentersFirestoreService();
            return StreamBuilder<CenterModel?>(
              stream: service.streamCenterById(id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('حدث خطأ أثناء تحميل بيانات المركز'),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final c = snapshot.data;
                if (c == null) {
                  return const Center(
                    child: Text('تعذّر العثور على بيانات المركز'),
                  );
                }

                return _buildContent(context, c);
              },
            );
          },
        ),
      ),
    );
  }
}
