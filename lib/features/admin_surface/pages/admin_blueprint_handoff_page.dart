import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminBlueprintHandoffPage extends StatelessWidget {
  const AdminBlueprintHandoffPage({super.key});

  String _buildFullContent() {
    return '''
Blueprint Handoff

Purpose
Single handoff reference explaining what is already built, what remains conceptual, what is monitored, what is frozen, and what must exist before future activation.

Built Foundations
- Admin structure
- Gateway layer
- Communication Gateway v1
- Engineering Gateway v1
- Device / Storage Gateway v1
- Growth & Awareness layer
- Exposure rules
- Compliance-to-code checkpoints

Conceptual / Not Activated
- Real channel integrations
- Real advertising / awareness placements
- Automation surfaces
- Advanced gateway telemetry

Monitoring-only / Supervisory Boundaries
- Communication boundaries
- Engineering supervision
- Device and storage supervision

Frozen / Protected Areas
- clinician-request path
- protected architecture areas
- unsafe direct integrations blocked

Future Activation Conditions
- Before real integrations
- Before exposure / advertising
- Before automation

Project Direction
- Platform-first
- Independent modules
- Shared core / contracts / auth / analytics
- AI manager per module
- Possible future split into standalone apps

Current status: Reference entry active
Manual notes: ...
''';
  }

  Future<void> _copyFullContent(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _buildFullContent()));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied')),
      );
    }
  }

  Widget _buildHandoffCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
    String statusLabel = 'Blueprint handoff item',
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSectionPanel(
        color: const Color(0xFF10161A).withValues(alpha: 0.94),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFC9A75B),
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              statusLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Boundary: $boundaryNote',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            GatewaySupervisionNote(text: supervisionNote),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'ملف تسليم المخطط العام',
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF13191D),
              Color(0xFF0F1316),
              Color(0xFF151B1F),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'ملف تسليم المخطط العام',
              summary:
                  'صفحة إشرافية واحدة تشرح ما تم بناؤه فعليًا، وما يزال مفاهيميًا، وما يُدار كواجهة إشرافية فقط، وما هو مجمّد، وما الذي يجب توفره قبل أي تفعيل مستقبلي.',
              boundaryNote:
                  'هذه الصفحة توثيقية ومعمارية فقط. لا تقوم بتفعيل أنظمة، أو تكاملات، أو تتبع، أو أي سلوك تشغيلي.',
              emphasis:
                  'تُستخدم هذه الصفحة كمرجع تسليم للحالة الحالية للمشروع من حيث المعمارية، والسلامة، وحدود البوابات، وجاهزية التفعيل المستقبلي.',
            ),
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () => _copyFullContent(context),
                icon: const Icon(Icons.copy_all_outlined, size: 18),
                label: const Text('Copy Full Content'),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الأساسات المبنية',
              description:
                  'هذه هي الأساسات الهيكلية الرئيسية الموجودة فعليًا داخل الإدارة الحالية واتجاه المنصة.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'هيكل الإدارة',
                  summary:
                      'تمت إعادة تنظيم تجربة الإدارة إلى أقسام رئيسية أوضح، مع تحويل الصفحة الرئيسية إلى منصة انطلاق بدل كونها مساحة عمل مزدحمة.',
                  boundaryNote:
                      'يحافظ على وضوح الحدود بين العمليات، والاتصالات، وغرفة التحكم، والحوكمة، وطبقة البوابات، والأرشيف.',
                  supervisionNote:
                      'تم بناؤه واعتماده كجزء من المعمارية الحالية، دون المساس بالتدفقات التشغيلية العميقة.',
                  statusLabel: 'أساس مبني',
                ),
                _buildHandoffCard(
                  context,
                  title: 'طبقة البوابات',
                  summary:
                      'طبقة البوابات موجودة الآن كقسم تقني إشرافي علوي يغطي الاتصالات، والهندسة، والأجهزة/التخزين.',
                  boundaryNote:
                      'تعزل القنوات، والأدوات، والأجهزة، والتخزين عن معالجة سير العمل التشغيلي.',
                  supervisionNote:
                      'تم بناؤها كطبقة إشرافية فقط، دون أي تكاملات خارجية حية.',
                  statusLabel: 'أساس مبني',
                ),
                _buildHandoffCard(
                  context,
                  title: 'Communication Gateway v1',
                  summary:
                      'حدود الاتصالات موجودة الآن لويب شات، وبريد الدعم، وقنوات المراسلة، وتنسيق الاجتماعات كواجهات إشرافية فقط.',
                  boundaryNote:
                      'تفصل بين حدود استقبال القنوات وبين التعامل البشري المباشر داخل قسم الاتصالات.',
                  supervisionNote:
                      'تم بناؤها كواجهة حدودية فقط، دون مزامنة صناديق بريد أو APIs خارجية أو تدفقات backend.',
                  statusLabel: 'أساس مبني',
                ),
                _buildHandoffCard(
                  context,
                  title: 'Engineering Gateway v1',
                  summary:
                      'تم تعريف حدود الهندسة والصيانة لأدوات الذكاء، ومساحات العمل، وواجهات الـ backend، والمستودعات، والتشخيصات.',
                  boundaryNote:
                      'يفصل الإشراف التقني عن العمليات التشغيلية الحية وعن واجهات التنفيذ المباشر.',
                  supervisionNote:
                      'تم بناؤه كواجهة إشرافية فقط.',
                  statusLabel: 'أساس مبني',
                ),
                _buildHandoffCard(
                  context,
                  title: 'Device / Storage Gateway v1',
                  summary:
                      'تم تعريف حدود الأجهزة، والتخزين، والنسخ الاحتياطي، والمزامنة حول لابتوب الإدارة بوصفه المركز الرئيسي للتحكم.',
                  boundaryNote:
                      'يفصل الإشراف على العتاد والتخزين عن تصفح الأرشيف وعن سير العمل التشغيلي.',
                  supervisionNote:
                      'تم بناؤه كعرض حدودي إشرافي فقط، دون probing أو منطق تحكم.',
                  statusLabel: 'أساس مبني',
                ),
                _buildHandoffCard(
                  context,
                  title: 'طبقة النمو والانتشار',
                  summary:
                      'توجد الآن طبقة مفاهيمية داخل الإدارة لتخطيط حدود النمو، والانتشار، وخطط الظهور/الاستفادة تحت إشراف واضح.',
                  boundaryNote:
                      'تمنع الخلط بين التخطيط للنمو وبين تشغيل الإعلانات الفعلية أو تنفيذ الحملات أو أنظمة الاستفادة المالية.',
                  supervisionNote:
                      'تم بناؤها كتوثيق مفاهيمي فقط.',
                  statusLabel: 'أساس مبني',
                ),
                _buildHandoffCard(
                  context,
                  title: 'قواعد الظهور والتعرّض',
                  summary:
                      'تم توثيق قيود الظهور والانتشار/الاستفادة كقواعد مخطط واضحة، خاصة في السياقات الحساسة أو المرتبطة بالأزمات.',
                  boundaryNote:
                      'يبقي السلامة والدعم متقدمين دائمًا على أي منطق ترويجي أو ربحي.',
                  supervisionNote:
                      'تم بناؤها كمخطط سياساتي فقط، دون تفعيل enforcement في وقت التشغيل.',
                  statusLabel: 'أساس مبني',
                ),
                _buildHandoffCard(
                  context,
                  title: 'نقاط الامتثال المرتبطة بالكود',
                  summary:
                      'تم ربط المعمارية، والسلامة، والبوابات، والنمو، والتموضع غير الطبي عبر نقاط امتثال واضحة مرتبطة بالكود.',
                  boundaryNote:
                      'يساعد ذلك على إبقاء أي تفعيل مستقبلي منسجمًا مع السلامة وتموضع المنتج.',
                  supervisionNote:
                      'تم بناؤها كتوثيق لنقاط تحقق فقط.',
                  statusLabel: 'أساس مبني',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'أجزاء مفاهيمية / غير مفعلة',
              description:
                  'هذه العناصر غير مفعلة عمدًا حتى الآن، وما تزال ضمن حدود التخطيط فقط.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'التكاملات الحقيقية مع القنوات',
                  summary:
                      'التكاملات الحقيقية مع واتساب، ومزامنة البريد، وتليجرام، وفيسبوك/ماسنجر، وما شابهها، غير موجودة بعد.',
                  boundaryNote:
                      'تبقى Communication Gateway على مستوى الحدود الإشرافية فقط حتى يتحقق الاعتماد الصريح وشروط الجاهزية.',
                  supervisionNote:
                      'مخطط فقط. لا توجد أتمتة قنوات، أو مزامنة صناديق بريد، أو تكاملات API نشطة.',
                  statusLabel: 'مفاهيمي / غير مفعّل',
                ),
                _buildHandoffCard(
                  context,
                  title: 'أماكن الظهور الإعلاني الفعلية',
                  summary:
                      'لا توجد حاليًا أي أماكن ظهور فعلية لمحتوى توعوي أو ربحي داخل المنتج.',
                  boundaryNote:
                      'تبقى طبقة النمو والانتشار مفاهيمية ومنفصلة عن تجربة المستخدم الحية.',
                  supervisionNote:
                      'مخطط فقط. لا يوجد rendering إعلاني أو tracking أو محرك ظهور فعلي.',
                  statusLabel: 'مفاهيمي / غير مفعّل',
                ),
                _buildHandoffCard(
                  context,
                  title: 'الأتمتة',
                  summary:
                      'لا توجد أي أسطح أتمتة نشطة حاليًا للاتصالات أو البوابات أو النمو أو منطق الظهور.',
                  boundaryNote:
                      'يمنع تحوّل الطبقات المفاهيمية بصمت إلى أنظمة تنفيذية.',
                  supervisionNote:
                      'مخطط فقط. لا توجد أتمتة للقنوات أو للنمو أو أتمتة تقنية مفعلة هنا.',
                  statusLabel: 'مفاهيمي / غير مفعّل',
                ),
                _buildHandoffCard(
                  context,
                  title: 'Telemetry متقدمة للبوابات',
                  summary:
                      'Telemetry المتقدمة للبوابات غير مطبقة بعد خارج حدود المؤشرات الإشرافية الحالية البسيطة.',
                  boundaryNote:
                      'تمنع الخلط بين العرض الإشرافي الحالي وبين observability تشغيلية عميقة.',
                  supervisionNote:
                      'مخطط فقط. لا يوجد probing للأجهزة أو telemetry backend أو health checks خارجية.',
                  statusLabel: 'مفاهيمي / غير مفعّل',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'حدود مراقبة فقط / واجهات إشرافية',
              description:
                  'هذه هي الحدود التقنية الحالية الموجودة بغرض الإشراف والتنظيم، وليس بغرض التنفيذ الحي العميق.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'حدود الاتصالات',
                  summary:
                      'تشرف Communication Gateway حاليًا على حدود القنوات ومفاهيم الاستقبال وبعض الأفعال الحدودية المحدودة مثل mailto لبريد الدعم.',
                  boundaryNote:
                      'منفصلة عن مساحة الاتصالات التشغيلية، وعن التصعيدات، وعن التعامل البشري المباشر مع الحالات.',
                  supervisionNote:
                      'واجهة إشرافية فقط.',
                  statusLabel: 'مراقبة / إشرافية فقط',
                ),
                _buildHandoffCard(
                  context,
                  title: 'الإشراف الهندسي',
                  summary:
                      'تشرف Engineering Gateway حاليًا على حدود الأدوات الخاصة بالذكاء، والمستودعات، والتشخيصات، ومساحات الصيانة المعتمدة على المتصفح.',
                  boundaryNote:
                      'منفصلة عن التدفقات التشغيلية المباشرة وعن واجهات التنفيذ الحي.',
                  supervisionNote:
                      'واجهة إشرافية فقط.',
                  statusLabel: 'مراقبة / إشرافية فقط',
                ),
                _buildHandoffCard(
                  context,
                  title: 'الإشراف على الأجهزة والتخزين',
                  summary:
                      'تشرف Device / Storage Gateway حاليًا على حدود العتاد والتخزين المفاهيمية ضمن بيئة لابتوب الإدارة.',
                  boundaryNote:
                      'منفصلة عن تصفح الأرشيف، والعمليات، والتحكم المباشر في الأجهزة.',
                  supervisionNote:
                      'واجهة إشرافية فقط.',
                  statusLabel: 'مراقبة / إشرافية فقط',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'مناطق مجمّدة / محمية',
              description:
                  'هذه المناطق محمية من إعادة الهيكلة الواسعة أو من أي تفعيل مباشر غير آمن.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'مسار clinician-request',
                  summary:
                      'مسار clinician-request مجمّد حاليًا، ولا يجب تحميله أي إعادة هيكلة جديدة أو تطوير انتهازي جانبي.',
                  boundaryNote:
                      'يمنع المناطق غير المستقرة من تعطيل تقدم الإدارة أو اتجاه المنصة الأوسع.',
                  supervisionNote:
                      'منطقة مجمّدة. تُترك كما هي حتى يبدأ مسار rebuild مخصص لها لاحقًا.',
                  statusLabel: 'مجمّد / محمي',
                ),
                _buildHandoffCard(
                  context,
                  title: 'مناطق معمارية محمية',
                  summary:
                      'أي rewrites كبيرة وغير آمنة عبر أقسام الإدارة المستقرة أو أسطح البوابات أو حدود السلامة تبقى مقيدة عمدًا.',
                  boundaryNote:
                      'يحافظ على الاستقرار الحالي وعلى سهولة التراجع عند الحاجة.',
                  supervisionNote:
                      'منطقة محمية. يُفضّل فيها الإضافات الصغيرة والربط البنيوي المحدود فقط.',
                  statusLabel: 'مجمّد / محمي',
                ),
                _buildHandoffCard(
                  context,
                  title: 'منع التكاملات المباشرة غير الآمنة',
                  summary:
                      'لا يجب تفعيل أي تكامل خارجي مباشر بدون جاهزية صريحة، وضمانات حماية، وملكية إشرافية واضحة.',
                  boundaryNote:
                      'يمنع الصفحات الإشرافية والطبقات المفاهيمية من التحول مبكرًا إلى أنظمة تشغيلية محفوفة بالمخاطر.',
                  supervisionNote:
                      'قاعدة محمية. يبقى التكامل محجوبًا حتى تتحقق شروط التفعيل.',
                  statusLabel: 'مجمّد / محمي',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'شروط التفعيل المستقبلي',
              description:
                  'هذه هي الشروط الدنيا التي يجب أن تتوفر قبل انتقال أي نظام مستقبلي من المخطط إلى التفعيل الحي.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'قبل تشغيل integrations حقيقية',
                  summary:
                      'التكاملات الحقيقية تتطلب قواعد صريحة، وملكية واضحة، وmonitoring حقيقية، وsafeguards، وفصلًا واضحًا عن التدفقات البشرية.',
                  boundaryNote:
                      'يضمن ألا تتقدم الراحة التقنية على السلامة أو على الانضباط المعماري.',
                  supervisionNote:
                      'يبقى التفعيل محجوبًا حتى تتحقق بوابات الجاهزية بشكل صريح.',
                  statusLabel: 'شرط تفعيل',
                ),
                _buildHandoffCard(
                  context,
                  title: 'قبل تفعيل الظهور / الإعلانات',
                  summary:
                      'يجب أولًا تعريف قواعد الظهور، والضوابط الأخلاقية، والحالات المحجوبة، والأسطح المسموح بها، وقيود family-safe واعتمادها.',
                  boundaryNote:
                      'يضمن ألا يتقدم الظهور الربحي أو التوعوي على الدعم أو السلامة.',
                  supervisionNote:
                      'يبقى التفعيل محجوبًا حتى توجد السياسة والضمانات فعليًا.',
                  statusLabel: 'شرط تفعيل',
                ),
                _buildHandoffCard(
                  context,
                  title: 'قبل تشغيل الأتمتة',
                  summary:
                      'الأتمتة تتطلب monitoring واضحة، ووضوحًا حوكميًا، وآليات fallback، واعتمادًا صريحًا لتأثيرها على الدعم والسلامة.',
                  boundaryNote:
                      'يمنع تمدد الأتمتة بصمت إلى سياقات المستخدم الحساسة أو إلى مسؤوليات الإدارة.',
                  supervisionNote:
                      'يبقى التفعيل محجوبًا حتى تصبح المراقبة والضمانات حقيقية لا مفاهيمية فقط.',
                  statusLabel: 'شرط تفعيل',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الاتجاه الحالي للمشروع',
              description:
                  'هذا القسم يشرح الاتجاه المعماري الفعلي للمشروع في وضعه الحالي.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'اتجاه Platform-first',
                  summary:
                      'يتم تشكيل النظام كمنصة رئيسية جامعة، وليس كتطبيق واحد مزدحم بالوظائف.',
                  boundaryNote:
                      'يدعم نموًا modular لاحقًا دون فرض فصل مبكر وغير لازم للتطبيقات.',
                  supervisionNote:
                      'اتجاه معتمد حاليًا ويظهر بوضوح في إعادة هيكلة الإدارة ومعمارية البوابات.',
                  statusLabel: 'اتجاه حالي',
                ),
                _buildHandoffCard(
                  context,
                  title: 'Modules مستقلة',
                  summary:
                      'تُعامل الأقسام الكبرى على أنها Modules مستقلة نسبيًا بحدود أوضح ومسؤوليات أكثر أمانًا في التوسع.',
                  boundaryNote:
                      'يبقي التطور المستقبلي قابلًا للإدارة ويقلل الترابط الخفي.',
                  supervisionNote:
                      'اتجاه معتمد كاستراتيجية معمارية أساسية.',
                  statusLabel: 'اتجاه حالي',
                ),
                _buildHandoffCard(
                  context,
                  title: 'Shared core / contracts / auth / analytics',
                  summary:
                      'يتجه النظام إلى مشاركة الأساسات الرئيسية عبر الـ Modules بدل التحول إلى مشاريع صغيرة منفصلة ومبعثرة.',
                  boundaryNote:
                      'يحافظ على التماسك حتى مع ازدياد استقلالية الـ Modules بمرور الوقت.',
                  supervisionNote:
                      'اتجاه معتمد، مع بقاء بعض الأساسات المشتركة ضمن المستوى المفاهيمي أو المعماري حيث لم تُنفذ بعد.',
                  statusLabel: 'اتجاه حالي',
                ),
                _buildHandoffCard(
                  context,
                  title: 'AI Manager لكل Module',
                  summary:
                      'يمكن لكل Module مستقبلية أن تمتلك AI Manager خاصة بها أو حدود مساعد ذكي تحت إشراف واضح، مع بقاء المرجعية للمنصة الرئيسية.',
                  boundaryNote:
                      'يدعم الذكاء الموزع عبر الوحدات دون فقدان الإشراف الإداري المركزي.',
                  supervisionNote:
                      'اتجاه معتمد كمبدأ معماري جاهز للمستقبل، وليس كتفعيل فوري.',
                  statusLabel: 'اتجاه حالي',
                ),
                _buildHandoffCard(
                  context,
                  title: 'إمكانية التحول إلى تطبيقات مستقلة لاحقًا',
                  summary:
                      'قد تتحول بعض الـ Modules لاحقًا إلى تطبيقات خفيفة مستقلة إذا بقيت المعمارية والعقود والإشراف منسجمة.',
                  boundaryNote:
                      'يبقي خيار الفصل المستقبلي ممكنًا دون فرض تعقيد micro-apps مبكرًا.',
                  supervisionNote:
                      'اتجاه معتمد للتطور اللاحق، وليس للتنفيذ الفوري الآن.',
                  statusLabel: 'اتجاه حالي',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
