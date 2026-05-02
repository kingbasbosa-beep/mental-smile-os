import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class AccountingWorkspacePage extends StatelessWidget {
  const AccountingWorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    final sections = <_SectionData>[
      _SectionData(
        titleAr: 'الجلسات والإقامة',
        titleEn: 'Sessions & Residency',
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
        actions: const [
          _ActionData(labelAr: 'Google / Meta / Ads', labelEn: 'Google / Meta / Ads'),
          _ActionData(labelAr: 'رعايات', labelEn: 'Sponsorships'),
          _ActionData(labelAr: 'اشتراكات مستقبلية', labelEn: 'Future Subscriptions'),
        ],
      ),
      _SectionData(
        titleAr: 'المصروفات والتشغيل',
        titleEn: 'Expenses & Operations',
        actions: const [
          _ActionData(labelAr: 'صيانة', labelEn: 'Maintenance'),
          _ActionData(labelAr: 'أجهزة', labelEn: 'Equipment'),
          _ActionData(labelAr: 'اشتراكات أدوات', labelEn: 'Tool Subscriptions'),
          _ActionData(labelAr: 'رواتب / تشغيل', labelEn: 'Payroll / Operations'),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'مساحة العمل المحاسبية' : 'Accounting Workspace'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final section = sections[index];
          return _SectionCard(isArabic: isArabic, section: section);
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.isArabic, required this.section});

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
    this.subtitleAr,
    this.subtitleEn,
    required this.actions,
  });

  final String titleAr;
  final String titleEn;
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
