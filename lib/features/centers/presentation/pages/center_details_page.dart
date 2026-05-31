import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/booking/presentation/pages/center_booking_request_page.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';
import 'package:flutterprojects/features/centers/data/services/centers_firestore_service.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';
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

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  Future<void> _tryLaunch(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!ok && context.mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authTryAgain)),
      );
    }
  }

  Uri? _whatsappUri(String value) {
    final raw = value.trim();
    if (raw.isEmpty) return null;

    final parsed = Uri.tryParse(raw);
    if (parsed != null &&
        (parsed.scheme == 'http' || parsed.scheme == 'https')) {
      return parsed;
    }

    var normalized = raw
        .replaceAll(' ', '')
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '');
    if (normalized.startsWith('+')) {
      normalized = normalized.substring(1);
    }
    if (normalized.startsWith('00')) {
      normalized = normalized.substring(2);
    }

    final digits = _digitsOnly(normalized);
    if (digits.isEmpty) return null;
    return Uri.https('wa.me', '/$digits');
  }

  Uri? _mapsSearchUri({
    required String address,
    required String area,
    required String city,
  }) {
    final query = [
      address.trim(),
      area.trim(),
      city.trim(),
    ].where((part) => part.isNotEmpty).join(', ');

    if (query.isEmpty) return null;
    return Uri.https(
      'www.google.com',
      '/maps/search/',
      {
        'api': '1',
        'query': query,
      },
    );
  }

  Widget _sectionCard({
    required BuildContext context,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.32),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7C766).withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4), height: 1.35),
        child: IconTheme(
          data: const IconThemeData(color: Color(0xFFE7C766)),
          child: child,
        ),
      ),
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
                color: Colors.black.withValues(alpha: 0.26),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image_outlined,
                  color: Color(0xFFE7C766),
                ),
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
                color: Colors.black.withValues(alpha: 0.26),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image_outlined,
                  color: Color(0xFFE7C766),
                ),
              );
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                height: height,
                width: width,
                color: Colors.black.withValues(alpha: 0.26),
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
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFFFFE7B2),
            fontWeight: FontWeight.w800,
          ),
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
    final l10n = AppLocalizations.of(context)!;
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
              _sectionTitle(context, l10n.centerGallery),
              const SizedBox(height: 12),
              _CenterGalleryCarousel(
                values: padded,
                labels: frameLabels,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _pricingSection(BuildContext context, CenterModel c) {
    final l10n = AppLocalizations.of(context)!;
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
              _sectionTitle(context, l10n.centerPricing),
              const SizedBox(height: 10),
              if (isAutism)
                for (final item in autismItems) ...[
                  Text(
                    item.labelAr,
                    textAlign: TextAlign.start,
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
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                ]
              else
                for (final item in accommodationItems) ...[
                  Text(
                    item.labelAr,
                    textAlign: TextAlign.start,
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
                    textAlign: TextAlign.start,
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _sectionTitle(context, l10n.centerTypeAndService),
              const SizedBox(height: 10),
              Text(
                'النوع التشغيلي: ${_centerTypeLabelAr(c)}',
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 6),
              Text(
                c.hasDetoxUnit
                    ? 'يوجد قسم داخلي لأعراض الانسحاب.'
                    : 'لا يوجد قسم داخلي مستقل لأعراض الانسحاب.',
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _capabilitiesSection(BuildContext context, CenterModel c) {
    final l10n = AppLocalizations.of(context)!;
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
              _sectionTitle(context, l10n.centerCapabilities),
              const SizedBox(height: 10),
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(item, textAlign: TextAlign.start),
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
    final v = value.trim();
    if (v.isEmpty) return const SizedBox.shrink();

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            v,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: onTap == null ? FontWeight.w600 : FontWeight.w800,
                  color: onTap == null
                      ? const Color(0xFFFFF4D4)
                      : const Color(0xFFE7C766),
                ),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 18, color: const Color(0xFFE7C766)),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFFFE7B2),
                fontWeight: FontWeight.w700,
              ),
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

  Widget _descriptionSection(BuildContext context, String desc) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 12),
        _sectionCard(
          context: context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    l10n.centerAbout,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFFFE7B2),
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.article_outlined,
                    size: 20,
                    color: Color(0xFFE7C766),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (false)
                Text(
                  'نبذة',
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              const SizedBox(height: 10),
              Text(
                desc,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _coverValue(CenterModel c) {
    final values = [
      c.coverImageUrl,
      c.coverImageAsset,
      c.imageUrl,
      ...c.galleryImageUrls,
      ...c.galleryImageAssets,
    ];
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) return trimmed;
    }
    return '';
  }

  String _logoValue(CenterModel c) {
    final values = [c.imageUrl, c.coverImageUrl, c.coverImageAsset];
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isNotEmpty) return trimmed;
    }
    return '';
  }

  Widget _heroMedia(BuildContext context, CenterModel c) {
    final l10n = AppLocalizations.of(context)!;
    final cover = _coverValue(c);
    final logo = _logoValue(c);

    return Container(
      height: 260,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.28),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          cover.isEmpty
              ? const _GalleryFallback()
              : _GalleryImage(value: cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.10),
                  Colors.black.withValues(alpha: 0.62),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            end: 18,
            bottom: 18,
            child: Container(
              width: 78,
              height: 78,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.42),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFE7C766).withValues(alpha: 0.50),
                ),
              ),
              child: logo.isEmpty
                  ? const Icon(
                      Icons.apartment_rounded,
                      color: Color(0xFFE7C766),
                      size: 34,
                    )
                  : _GalleryImage(value: logo),
            ),
          ),
          PositionedDirectional(
            start: 18,
            top: 18,
            child: _GoldChip(
              icon: c.isActive
                  ? Icons.verified_outlined
                  : Icons.hourglass_empty_rounded,
              label: c.isActive ? l10n.centerAvailable : l10n.centerUnavailable,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactChipsSection(
    BuildContext context,
    String address,
    String area,
    String city,
    String phone,
    String whatsapp,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final mapsUri = _mapsSearchUri(address: address, area: area, city: city);
    final whatsappUri = _whatsappUri(whatsapp);
    final locationValue = [
      address.trim(),
      area.trim(),
      city.trim(),
    ].where((part) => part.isNotEmpty).join(' / ');
    final items = [
      _ContactItem(
        Icons.location_on_outlined,
        l10n.centerAddress,
        locationValue,
        mapsUri == null ? null : () => _tryLaunch(context, mapsUri),
      ),
      _ContactItem(
        Icons.phone_outlined,
        l10n.centerPhone,
        phone,
        phone.trim().isEmpty
            ? null
            : () => _tryLaunch(context, Uri(scheme: 'tel', path: phone)),
      ),
      _ContactItem(
        Icons.chat_outlined,
        l10n.centerWhatsapp,
        whatsapp,
        whatsappUri == null ? null : () => _tryLaunch(context, whatsappUri),
      ),
    ].where((item) => item.value.trim().isNotEmpty).toList();

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _sectionTitle(context, l10n.centerContactLocation),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth >= 900
                      ? (constraints.maxWidth - 16) / 3
                      : constraints.maxWidth >= 560
                          ? (constraints.maxWidth - 8) / 2
                          : constraints.maxWidth;
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.end,
                    children: [
                      for (final item in items)
                        SizedBox(
                          width: itemWidth,
                          child: _MiniContactCard(item: item),
                        ),
                    ],
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

  List<String> _pricingLines(CenterModel c) {
    final isAutism = usesAutismCarePricing(c.category);
    final lines = <String>[];
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

    if (isAutism) {
      for (final item
          in c.autismCareCosts.where((e) => e.enabled && e.price > 0)) {
        lines.add([
          item.labelAr,
          'السعر: ${item.price}',
          if (item.pricingUnit.isNotEmpty)
            'الوحدة: ${unitLabel(item.pricingUnit)}',
          item.taxIncluded ? 'الضريبة شاملة' : 'الضريبة غير شاملة',
        ].join(' • '));
      }
    } else {
      for (final item
          in c.accommodationCosts.where((e) => e.enabled && e.price > 0)) {
        lines.add([
          item.labelAr,
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
        ].join(' • '));
      }
    }
    return lines;
  }

  List<String> _capabilityLines(CenterModel c) {
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
    return items;
  }

  Widget _detailsGrid(
    BuildContext context,
    CenterModel c,
    List<String> services,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final cards = <Widget>[
      _GridInfoCard(
        icon: Icons.account_tree_outlined,
        title: l10n.centerTypeAndService,
        lines: [
          _centerTypeLabelAr(c),
          c.hasDetoxUnit
              ? 'يوجد قسم أعراض انسحاب'
              : 'بدون قسم أعراض انسحاب مستقل',
        ],
      ),
      _GridInfoCard(
        icon: Icons.payments_outlined,
        title: l10n.centerPricing,
        lines:
            _pricingLines(c).isEmpty ? const ['غير محددة'] : _pricingLines(c),
      ),
      _GridInfoCard(
        icon: Icons.verified_user_outlined,
        title: l10n.centerCapabilities,
        lines: _capabilityLines(c).isEmpty
            ? const ['غير محددة']
            : _capabilityLines(c),
      ),
      if (services.isNotEmpty)
        _GridInfoCard(
          icon: Icons.medical_services_outlined,
          title: l10n.centerServices,
          lines: services,
        ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 980
            ? 3
            : constraints.maxWidth >= 620
                ? 2
                : 1;
        final cardWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - (columns - 1) * 10) / columns;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.end,
          children: [
            for (final card in cards)
              SizedBox(
                width: cardWidth,
                child: card,
              ),
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, CenterModel c) {
    final l10n = AppLocalizations.of(context)!;
    final name = c.name.trim().isEmpty ? l10n.centerDefaultName : c.name.trim();
    final categoryLabel = _categoryLabelAr(c);
    final loc = _locationLine(c);
    final desc = c.description.trim();
    final address = c.address.trim();
    final area = c.area.trim();
    final city = c.city.trim();
    final phone = c.phone.trim();
    final whatsapp = c.whatsapp.trim();
    final services = c.services.where((e) => e.trim().isNotEmpty).toList();

    final galleryValues = <String>[
      ...c.galleryImageUrls.where((value) => value.trim().isNotEmpty),
      ...c.galleryImageAssets.where((value) => value.trim().isNotEmpty),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionCard(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _heroMedia(context, c),
              const SizedBox(height: 12),
              Text(
                name,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w900,
                    ),
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
                      textAlign: TextAlign.start,
                    ),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.black.withValues(alpha: 0.24),
                    side: BorderSide(
                      color: const Color(0xFFE7C766).withValues(alpha: 0.30),
                    ),
                    labelStyle: const TextStyle(
                      color: Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (loc.isNotEmpty)
                    Chip(
                      label: Text(
                        loc,
                        textAlign: TextAlign.start,
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: Colors.black.withValues(alpha: 0.24),
                      side: BorderSide(
                        color: const Color(0xFF8EDBFF).withValues(alpha: 0.24),
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xFFFFF4D4),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              if (false)
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
                    label: Text(
                      Localizations.localeOf(context).languageCode
                                  .toLowerCase() ==
                              'ar'
                          ? 'طلب تواصل مع المركز'
                          : 'Request center contact',
                    ),
                  ),
                ),
            ],
          ),
        ),
        _gallerySection(context, galleryValues),
        _contactChipsSection(context, address, area, city, phone, whatsapp),
        if (false)
          _sectionCard(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  l10n.centerContactLocation,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                _infoRow(
                  context: context,
                  icon: Icons.location_on_outlined,
                  label: l10n.centerAddress,
                  value: address,
                ),
                _infoRow(
                  context: context,
                  icon: Icons.phone_outlined,
                  label: l10n.centerPhone,
                  value: phone,
                  onTap: phone.isEmpty
                      ? null
                      : () =>
                          _tryLaunch(context, Uri(scheme: 'tel', path: phone)),
                ),
                _infoRow(
                  context: context,
                  icon: Icons.chat_outlined,
                  label: l10n.centerWhatsapp,
                  value: whatsapp,
                  onTap: null,
                ),
              ],
            ),
          ),
        if (desc.isNotEmpty) _descriptionSection(context, desc),
        if (false && services.isNotEmpty) ...[
          const SizedBox(height: 12),
          _sectionCard(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  l10n.centerServices,
                  textAlign: TextAlign.start,
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
                          textAlign: TextAlign.start,
                        ),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: Colors.black.withValues(alpha: 0.24),
                        side: BorderSide(
                          color:
                              const Color(0xFFE7C766).withValues(alpha: 0.24),
                        ),
                        labelStyle: const TextStyle(
                          color: Color(0xFFFFE7B2),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
        _detailsGrid(context, c, services),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black.withValues(alpha: 0.34),
              foregroundColor: const Color(0xFFFFE7B2),
              side: BorderSide(
                color: const Color(0xFFE7C766).withValues(alpha: 0.44),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
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
            label: Text(
              Localizations.localeOf(context).languageCode.toLowerCase() ==
                      'ar'
                  ? 'طلب تواصل مع المركز'
                  : 'Request center contact',
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final initial = center;
    final id = centerId?.trim();
    final l10n = AppLocalizations.of(context)!;
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.30),
          foregroundColor: const Color(0xFFFFE7B2),
          elevation: 0,
          title: Text(l10n.centerDetailsTitle),
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: _GoldBackIcon(compact: true),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                _backgroundAsset(MediaQuery.of(context).size.width),
              ),
              fit: BoxFit.cover,
              alignment: MediaQuery.of(context).size.width < 700
                  ? Alignment.topCenter
                  : Alignment.center,
            ),
          ),
          child: DecoratedBox(
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
            child: Builder(
              builder: (context) {
                if (initial != null) {
                  return _buildContent(context, initial);
                }

                if (id == null || id.isEmpty) {
                  return Center(
                    child: Text(l10n.centerDataNotFound),
                  );
                }

                final service = CentersFirestoreService();
                return StreamBuilder<CenterModel?>(
                  stream: service.streamCenterById(id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(l10n.centerDataLoadError),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final c = snapshot.data;
                    if (c == null) {
                      return Center(
                        child: Text(l10n.centerDataNotFound),
                      );
                    }

                    return _buildContent(context, c);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _GoldBackIcon extends StatelessWidget {
  const _GoldBackIcon({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 44.0 : 52.0;
    final iconSize = compact ? 22.0 : 26.0;

    return Container(
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
            color: const Color(0xFFE7A94C).withValues(alpha: 0.16),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Image.asset(
        Directionality.of(context) == TextDirection.rtl
            ? 'assets/branding/navigation/back/back_right_gold.png'
            : 'assets/branding/navigation/back/back_left_gold.png',
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return IconTheme(
            data: IconThemeData(
              color: const Color(0xFFFFE7B2),
              size: iconSize,
            ),
            child: const BackButtonIcon(),
          );
        },
      ),
    );
  }
}

class _GoldChip extends StatelessWidget {
  const _GoldChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.46),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.42),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFFE7C766)),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFFFE7B2),
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem {
  const _ContactItem(this.icon, this.label, this.value, this.onTap);

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
}

class _MiniContactCard extends StatelessWidget {
  const _MiniContactCard({required this.item});

  final _ContactItem item;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.24),
        ),
      ),
      child: Row(
        children: [
          Icon(item.icon, size: 18, color: const Color(0xFFE7C766)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.label,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFFFE7B2),
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.value,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFFFFF4D4),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (item.onTap == null) return child;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: item.onTap,
      child: child,
    );
  }
}

class _GridInfoCard extends StatelessWidget {
  const _GridInfoCard({
    required this.icon,
    required this.title,
    required this.lines,
  });

  final IconData icon;
  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    final visibleLines = lines.where((line) => line.trim().isNotEmpty).toList();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color(0xFFFFE7B2),
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, size: 19, color: const Color(0xFFE7C766)),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final line in visibleLines)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    line,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFFFF4D4),
                          height: 1.25,
                        ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CenterGalleryCarousel extends StatefulWidget {
  const _CenterGalleryCarousel({
    required this.values,
    required this.labels,
  });

  final List<String> values;
  final List<String> labels;

  @override
  State<_CenterGalleryCarousel> createState() => _CenterGalleryCarouselState();
}

class _CenterGalleryCarouselState extends State<_CenterGalleryCarousel> {
  late PageController _controller;
  double _viewportFraction = 0.86;
  int _index = 0;

  List<String> get _slides {
    final hasImages = widget.values.any((value) => value.trim().isNotEmpty);
    return hasImages ? widget.values : const [''];
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: _viewportFraction);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nextFraction = MediaQuery.sizeOf(context).width >= 760 ? 0.48 : 0.86;
    if (nextFraction == _viewportFraction) return;
    _viewportFraction = nextFraction;
    _controller.dispose();
    _controller = PageController(
      initialPage: _index,
      viewportFraction: _viewportFraction,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final count = _slides.length;
    if (count <= 1) return;
    final next = (_index + delta).clamp(0, count - 1).toInt();
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  void _showPreview(BuildContext context, String value) {
    if (value.trim().isEmpty) return;
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(18),
          child: Stack(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 680),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.84),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFFE7C766).withValues(alpha: 0.42),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(21),
                  child: InteractiveViewer(
                    child: _GalleryImage(
                      value: value,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton.filledTonal(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 760;
        final height = desktop ? 230.0 : 190.0;
        final slides = _slides;
        final count = slides.length;

        return Column(
          children: [
            SizedBox(
              height: height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _controller,
                    padEnds: false,
                    itemCount: count,
                    onPageChanged: (value) => setState(() => _index = value),
                    itemBuilder: (context, index) {
                      final value = slides[index];
                      final label = index < widget.labels.length
                          ? widget.labels[index]
                          : 'صورة المركز';

                      return Padding(
                        padding: const EdgeInsetsDirectional.only(end: 12),
                        child: _GallerySlide(
                          value: value,
                          label: label,
                          onTap: () => _showPreview(context, value),
                        ),
                      );
                    },
                  ),
                  PositionedDirectional(
                    start: 6,
                    child: _CarouselArrow(
                      icon: Icons.chevron_left_rounded,
                      onPressed: _index == 0 ? null : () => _go(-1),
                    ),
                  ),
                  PositionedDirectional(
                    end: 6,
                    child: _CarouselArrow(
                      icon: Icons.chevron_right_rounded,
                      onPressed: _index >= count - 1 ? null : () => _go(1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < count; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: i == _index ? 18 : 7,
                    height: 7,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: i == _index
                          ? const Color(0xFFE7C766)
                          : const Color(0xFFE7C766).withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _GallerySlide extends StatelessWidget {
  const _GallerySlide({
    required this.value,
    required this.label,
    required this.onTap,
  });

  final String value;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: value.trim().isEmpty ? null : onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.24),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE7C766).withValues(alpha: 0.28),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE7C766).withValues(alpha: 0.10),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            value.trim().isEmpty
                ? const _GalleryFallback()
                : _GalleryImage(value: value),
            PositionedDirectional(
              top: 10,
              end: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.52),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: const Color(0xFFE7C766).withValues(alpha: 0.26),
                  ),
                ),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFFFE7B2),
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  const _GalleryImage({
    required this.value,
    this.fit = BoxFit.cover,
  });

  final String value;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final v = value.trim().replaceFirst('assets/assets/', 'assets/');
    if (v.isEmpty) return const _GalleryFallback();
    if (v.startsWith('assets/')) {
      return Image.asset(
        v,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const _GalleryFallback(),
      );
    }
    return Image.network(
      v,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => const _GalleryFallback(),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const _GalleryFallback(showLoader: true);
      },
    );
  }
}

class _GalleryFallback extends StatelessWidget {
  const _GalleryFallback({this.showLoader = false});

  final bool showLoader;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black.withValues(alpha: 0.72),
            const Color(0xFF141006).withValues(alpha: 0.86),
          ],
        ),
      ),
      child: Center(
        child: showLoader
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(
                Icons.image_outlined,
                size: 38,
                color: const Color(0xFFE7C766).withValues(alpha: 0.56),
              ),
      ),
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  const _CarouselArrow({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: Colors.black.withValues(alpha: 0.42),
        disabledBackgroundColor: Colors.black.withValues(alpha: 0.16),
        foregroundColor: const Color(0xFFFFE7B2),
        disabledForegroundColor:
            const Color(0xFFFFE7B2).withValues(alpha: 0.25),
        side: BorderSide(
          color: const Color(0xFFE7C766).withValues(alpha: 0.32),
        ),
      ),
      icon: Icon(icon),
    );
  }
}
