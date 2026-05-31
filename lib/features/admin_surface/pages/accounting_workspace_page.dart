import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class AccountingWorkspacePage extends StatefulWidget {
  const AccountingWorkspacePage({super.key});

  @override
  State<AccountingWorkspacePage> createState() =>
      _AccountingWorkspacePageState();
}

class _AccountingWorkspacePageState extends State<AccountingWorkspacePage> {
  int _selectedSectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    final sections = <_SectionData>[
      _SectionData(
        titleAr: 'الجلسات والإقامة',
        titleEn: 'Sessions & Residency',
        icon: Icons.event_available,
        status: _SectionStatus.partial,
        subtitleAr: 'حسابات جلسات الأخصائيين وإقامات المراكز',
        subtitleEn:
            'Clinician session accounting and center residency accounting',
        actions: const [
          _ActionData(
            labelAr: 'حسابات جلسات الأخصائيين',
            labelEn: 'Clinician Session Accounts',
            route: Routes.adminArchiveClinicians,
          ),
          _ActionData(
            labelAr: 'حسابات إقامات المراكز',
            labelEn: 'Center Residency Accounts',
          ),
          _ActionData(
            labelAr: 'سجل الجلسات والإقامات',
            labelEn: 'Sessions & Residency Archive',
            route: Routes.adminArchiveSessions,
          ),
        ],
      ),
      _SectionData(
        titleAr: 'مراجعة السداد والتحويلات',
        titleEn: 'Legacy payment visibility',
        icon: Icons.payments_outlined,
        status: _SectionStatus.active,
        actions: const [
          _ActionData(
            labelAr: 'إثباتات السداد من العملاء',
            labelEn: 'Customer Payment Proofs',
            route: Routes.adminPayments,
          ),
          _ActionData(
            labelAr: 'اعتماد / رفض السداد',
            labelEn: 'Review legacy payment signal',
            route: Routes.adminPayments,
          ),
          _ActionData(
            labelAr: 'تجميد المبلغ',
            labelEn: 'Legacy finance hold marker',
            route: Routes.adminPayments,
          ),
        ],
      ),
      _SectionData(
        titleAr: 'المستحقات والإغلاق المالي',
        titleEn: 'Optional accounting module preview',
        icon: Icons.account_balance_wallet_outlined,
        status: _SectionStatus.partial,
        actions: const [
          _ActionData(labelAr: 'مستحقات المراكز', labelEn: 'Center Dues'),
          _ActionData(
            labelAr: 'مستحقات الأخصائيين',
            labelEn: 'Clinician Dues',
            route: Routes.adminArchiveClinicians,
          ),
          _ActionData(
            labelAr: 'خصم العمولة / الضرائب',
            labelEn: 'Legacy finance placeholder - disabled',
          ),
          _ActionData(
            labelAr: 'الإغلاق المالي',
            labelEn: 'Legacy financial closing visibility',
            route: Routes.adminArchiveAccounting,
          ),
        ],
      ),
      _SectionData(
        titleAr: 'السجلات المالية',
        titleEn: 'Financial Records',
        icon: Icons.receipt_long_outlined,
        status: _SectionStatus.partial,
        actions: const [
          _ActionData(
            labelAr: 'سجل المدفوعات',
            labelEn: 'Legacy payments ledger',
            route: Routes.adminArchivePayments,
          ),
          _ActionData(
            labelAr: 'السجل المحاسبي',
            labelEn: 'Legacy accounting ledger',
            route: Routes.adminArchiveAccounting,
          ),
          _ActionData(
            labelAr: 'سجل الجلسات',
            labelEn: 'Sessions Ledger',
            route: Routes.adminArchiveSessions,
          ),
        ],
      ),
      _SectionData(
        titleAr: 'الدعاية ومصادر الدخل',
        titleEn: 'Marketing & Revenue Sources',
        icon: Icons.campaign_outlined,
        status: _SectionStatus.comingSoon,
        actions: const [
          _ActionData(
              labelAr: 'Google / Meta / Ads', labelEn: 'Google / Meta / Ads'),
          _ActionData(labelAr: 'رعايات', labelEn: 'Sponsorships'),
          _ActionData(
              labelAr: 'اشتراكات مستقبلية', labelEn: 'Future Subscriptions'),
        ],
      ),
      _SectionData(
        titleAr: 'المصروفات والتشغيل',
        titleEn: 'Expenses & Operations',
        icon: Icons.build_outlined,
        status: _SectionStatus.comingSoon,
        actions: const [
          _ActionData(labelAr: 'صيانة', labelEn: 'Maintenance'),
          _ActionData(labelAr: 'أجهزة', labelEn: 'Equipment'),
          _ActionData(labelAr: 'اشتراكات أدوات', labelEn: 'Tool Subscriptions'),
          _ActionData(
              labelAr: 'رواتب / تشغيل', labelEn: 'Payroll / Operations'),
        ],
      ),
    ];

    final selectedSection = sections[_selectedSectionIndex];

    return Scaffold(
      appBar: AppBar(
        title:
            Text(isArabic ? 'مساحة العمل المحاسبية' : 'Accounting Workspace'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _IntroCard(isArabic: isArabic),
          const SizedBox(height: 16),
          _SectionGateway(
            isArabic: isArabic,
            sections: sections,
            selectedIndex: _selectedSectionIndex,
            onSelected: (index) =>
                setState(() => _selectedSectionIndex = index),
          ),
          const SizedBox(height: 16),
          _SelectedSectionPanel(isArabic: isArabic, section: selectedSection),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isArabic ? 'قسم المحاسبة' : 'Accounting Section',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isArabic
                  ? 'مساحة تشغيل لمتابعة السداد والتحويلات والسجلات المتصلة، مع توضيح ما هو جزئي أو غير متصل بعد.'
                  : 'An operational space for connected payment, transfer, and record views, with clear labels for partial or unconnected areas.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionGateway extends StatelessWidget {
  const _SectionGateway({
    required this.isArabic,
    required this.sections,
    required this.selectedIndex,
    required this.onSelected,
  });

  final bool isArabic;
  final List<_SectionData> sections;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(sections.length, (index) {
        final section = sections[index];
        final isSelected = selectedIndex == index;
        return _SectionButton(
          isArabic: isArabic,
          section: section,
          isSelected: isSelected,
          onTap: () => onSelected(index),
        );
      }),
    );
  }
}

class _SectionButton extends StatelessWidget {
  const _SectionButton({
    required this.isArabic,
    required this.section,
    required this.isSelected,
    required this.onTap,
  });

  final bool isArabic;
  final _SectionData section;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isComingSoon = section.status == _SectionStatus.comingSoon;
    final accent = isSelected
        ? colorScheme.primary
        : isComingSoon
            ? colorScheme.outlineVariant
            : colorScheme.outline;
    final textColor = isComingSoon
        ? colorScheme.onSurfaceVariant.withValues(alpha: 0.62)
        : null;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 142,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent),
          color: isComingSoon
              ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.35)
              : isSelected
                  ? colorScheme.primary.withValues(alpha: 0.08)
                  : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: isSelected && !isComingSoon
                  ? colorScheme.primary
                  : colorScheme.surfaceContainerHighest,
              child: Icon(
                section.icon,
                color: isSelected && !isComingSoon
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isArabic ? section.titleAr : section.titleEn,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected && !isComingSoon
                    ? colorScheme.primary
                    : textColor,
              ),
            ),
            const SizedBox(height: 8),
            _StatusChip(
                isArabic: isArabic, status: section.status, compact: true),
          ],
        ),
      ),
    );
  }
}

class _SelectedSectionPanel extends StatelessWidget {
  const _SelectedSectionPanel({required this.isArabic, required this.section});

  final bool isArabic;
  final _SectionData section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isArabic ? section.titleAr : section.titleEn,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            _StatusChip(isArabic: isArabic, status: section.status),
            if (section.subtitleAr != null || section.subtitleEn != null) ...[
              const SizedBox(height: 4),
              Text(
                isArabic
                    ? (section.subtitleAr ?? '')
                    : (section.subtitleEn ?? ''),
                style: theme.textTheme.bodySmall,
              ),
            ],
            const SizedBox(height: 10),
            ...section.actions.map(
              (action) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _ActionTile(isArabic: isArabic, action: action),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.isArabic, required this.action});

  final bool isArabic;
  final _ActionData action;

  @override
  Widget build(BuildContext context) {
    final isEnabled = action.route != null;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: isEnabled
          ? null
          : Theme.of(context).disabledColor.withValues(alpha: 0.08),
      title: Text(isArabic ? action.labelAr : action.labelEn),
      trailing: isEnabled
          ? const Icon(Icons.arrow_forward_ios, size: 16)
          : Text(
              isArabic ? 'قريبًا' : 'Soon',
              style: Theme.of(context).textTheme.bodySmall,
            ),
      onTap: isEnabled
          ? () => Navigator.of(context).pushNamed(action.route!)
          : null,
    );
  }
}

class _SectionData {
  const _SectionData({
    required this.titleAr,
    required this.titleEn,
    required this.icon,
    required this.status,
    this.subtitleAr,
    this.subtitleEn,
    required this.actions,
  });

  final String titleAr;
  final String titleEn;
  final IconData icon;
  final _SectionStatus status;
  final String? subtitleAr;
  final String? subtitleEn;
  final List<_ActionData> actions;
}

class _ActionData {
  const _ActionData({required this.labelAr, required this.labelEn, this.route});

  final String labelAr;
  final String labelEn;
  final String? route;
}

enum _SectionStatus { active, partial, comingSoon }

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.isArabic,
    required this.status,
    this.compact = false,
  });

  final bool isArabic;
  final _SectionStatus status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final Color background;
    final Color foreground;
    final String statusText;
    final String dataText;

    switch (status) {
      case _SectionStatus.active:
        background = colorScheme.primaryContainer;
        foreground = colorScheme.onPrimaryContainer;
        statusText = isArabic ? 'نشط' : 'Active';
        dataText = isArabic ? 'بيانات حقيقية' : 'Real data';
        break;
      case _SectionStatus.partial:
        background = colorScheme.tertiaryContainer;
        foreground = colorScheme.onTertiaryContainer;
        statusText = isArabic ? 'عرض جزئي' : 'Partial view';
        dataText = isArabic ? 'عرض تجريبي' : 'Demo view';
        break;
      case _SectionStatus.comingSoon:
        background = colorScheme.surfaceContainerHighest;
        foreground = colorScheme.onSurfaceVariant;
        statusText = isArabic ? 'قريبًا' : 'Coming soon';
        dataText = isArabic ? 'غير متصل بعد' : 'Not connected yet';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: background,
      ),
      child: Text(
        compact ? '$statusText\n$dataText' : '$statusText · $dataText',
        textAlign: TextAlign.center,
        style: theme.textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
