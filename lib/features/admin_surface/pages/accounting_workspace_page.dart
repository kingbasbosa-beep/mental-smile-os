import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class AccountingWorkspacePage extends StatefulWidget {
  const AccountingWorkspacePage({super.key});

  @override
  State<AccountingWorkspacePage> createState() => _AccountingWorkspacePageState();
}

class _AccountingWorkspacePageState extends State<AccountingWorkspacePage> {
  int _selectedSectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    final sections = <_SectionData>[
      _SectionData(
        titleAr: 'الجلسات والإقامة',
        titleEn: 'Sessions & Residency',
        icon: Icons.event_available,
        subtitleAr: 'حسابات جلسات الأخصائيين وإقامات المراكز',
        subtitleEn: 'Clinician session accounting and center residency accounting',
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
        titleEn: 'Payment & Transfer Review',
        icon: Icons.payments_outlined,
        actions: const [
          _ActionData(
            labelAr: 'إثباتات السداد من العملاء',
            labelEn: 'Customer Payment Proofs',
            route: Routes.adminPayments,
          ),
          _ActionData(
            labelAr: 'اعتماد / رفض السداد',
            labelEn: 'Approve / Reject Payment',
            route: Routes.adminPayments,
          ),
          _ActionData(
            labelAr: 'تجميد المبلغ',
            labelEn: 'Freeze Amount',
            route: Routes.adminPayments,
          ),
        ],
      ),
      _SectionData(
        titleAr: 'المستحقات والإغلاق المالي',
        titleEn: 'Dues & Financial Close',
        icon: Icons.account_balance_wallet_outlined,
        actions: const [
          _ActionData(labelAr: 'مستحقات المراكز', labelEn: 'Center Dues'),
          _ActionData(
            labelAr: 'مستحقات الأخصائيين',
            labelEn: 'Clinician Dues',
            route: Routes.adminArchiveClinicians,
          ),
          _ActionData(
            labelAr: 'خصم العمولة / الضرائب',
            labelEn: 'Commission / Tax Deduction',
          ),
          _ActionData(
            labelAr: 'الإغلاق المالي',
            labelEn: 'Financial Closing',
            route: Routes.adminArchiveAccounting,
          ),
        ],
      ),
      _SectionData(
        titleAr: 'السجلات المالية',
        titleEn: 'Financial Records',
        icon: Icons.receipt_long_outlined,
        actions: const [
          _ActionData(
            labelAr: 'سجل المدفوعات',
            labelEn: 'Payments Ledger',
            route: Routes.adminArchivePayments,
          ),
          _ActionData(
            labelAr: 'السجل المحاسبي',
            labelEn: 'Accounting Ledger',
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
        actions: const [
          _ActionData(labelAr: 'Google / Meta / Ads', labelEn: 'Google / Meta / Ads'),
          _ActionData(labelAr: 'رعايات', labelEn: 'Sponsorships'),
          _ActionData(labelAr: 'اشتراكات مستقبلية', labelEn: 'Future Subscriptions'),
        ],
      ),
      _SectionData(
        titleAr: 'المصروفات والتشغيل',
        titleEn: 'Expenses & Operations',
        icon: Icons.build_outlined,
        actions: const [
          _ActionData(labelAr: 'صيانة', labelEn: 'Maintenance'),
          _ActionData(labelAr: 'أجهزة', labelEn: 'Equipment'),
          _ActionData(labelAr: 'اشتراكات أدوات', labelEn: 'Tool Subscriptions'),
          _ActionData(labelAr: 'رواتب / تشغيل', labelEn: 'Payroll / Operations'),
        ],
      ),
    ];

    final selectedSection = sections[_selectedSectionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'مساحة العمل المحاسبية' : 'Accounting Workspace'),
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
            onSelected: (index) => setState(() => _selectedSectionIndex = index),
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
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              isArabic
                  ? 'مساحة تشغيل مستقلة لمتابعة السداد، التحويلات، السجلات، المستحقات، الدخل، والمصروفات.'
                  : 'A dedicated operational space to track payments, transfers, records, dues, income, and expenses.',
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
    final accent = isSelected ? colorScheme.primary : colorScheme.outline;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 142,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent),
          color: isSelected ? colorScheme.primary.withValues(alpha: 0.08) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor:
                  isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
              child: Icon(
                section.icon,
                color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isArabic ? section.titleAr : section.titleEn,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: isSelected ? colorScheme.primary : null,
              ),
            ),
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
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (section.subtitleAr != null || section.subtitleEn != null) ...[
              const SizedBox(height: 4),
              Text(
                isArabic ? (section.subtitleAr ?? '') : (section.subtitleEn ?? ''),
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
      tileColor: isEnabled ? null : Theme.of(context).disabledColor.withValues(alpha: 0.08),
      title: Text(isArabic ? action.labelAr : action.labelEn),
      trailing: isEnabled
          ? const Icon(Icons.arrow_forward_ios, size: 16)
          : Text(
              isArabic ? 'قريبًا' : 'Soon',
              style: Theme.of(context).textTheme.bodySmall,
            ),
      onTap: isEnabled ? () => Navigator.of(context).pushNamed(action.route!) : null,
    );
  }
}

class _SectionData {
  const _SectionData({
    required this.titleAr,
    required this.titleEn,
    required this.icon,
    this.subtitleAr,
    this.subtitleEn,
    required this.actions,
  });

  final String titleAr;
  final String titleEn;
  final IconData icon;
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
