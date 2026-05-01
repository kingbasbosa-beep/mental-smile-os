import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/gateways/role_access_gateway.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';
import 'package:flutterprojects/features/chat/controller/chat_controller.dart';
import 'package:flutterprojects/features/chat/data/models/chat_message_model.dart';
import 'package:flutterprojects/features/chat/data/models/chat_thread_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.initialThreadId,
    this.adminSupportMode = false,
    this.entryContext,
  });

  final String? initialThreadId;
  final bool adminSupportMode;
  final String? entryContext;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController _controller = ChatController();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  ChatThreadModel? _thread;
  ({
    String english,
    String arabic,
    String ownerEnglish,
    String ownerArabic,
  })? _selectedStructuredRequest;
  bool _loading = true;
  bool _sending = false;
  bool? _viewerIsAdmin;
  String? _error;

  bool _isArabic() =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String get _avatarAsset {
    final value = widget.adminSupportMode
        ? 'assets/c5/avatars/avatar_admin_support.png'
        : 'assets/c5/avatars/avatar_client.png';
    if (value.startsWith('assets/assets/')) {
      return value.replaceFirst('assets/assets/', 'assets/');
    }
    return value;
  }

  String _pageSubtitle(bool isArabic) {
    if (widget.adminSupportMode) {
      return isArabic
          ? 'محادثة داخلية مع الإدارة للمتابعة والرد'
          : 'Internal admin support conversation';
    }
    return isArabic
        ? 'دعم أولي آمن مع تصعيد بشري عند ارتفاع مستوى الخطر'
        : 'Safe first-line support with human escalation when risk rises';
  }

  String? _entryContextHelper(bool isArabic) {
    if (widget.adminSupportMode || widget.initialThreadId != null) return null;

    switch (widget.entryContext) {
      case 'family_support':
        return isArabic
            ? 'يمكنك التحدث هنا للحصول على دعم عام وإرشاد مناسب لاحتياجات الأسرة.'
            : 'You can talk here for general support and guidance for family needs.';
      case 'recovery_support':
        return isArabic
            ? 'يمكنك التحدث هنا للحصول على دعم عام وإرشاد مرتبط بالتعافي.'
            : 'You can talk here for general support and guidance related to recovery.';
      default:
        return null;
    }
  }

  bool get _isRequestLinkedThread {
    final thread = _thread;
    if (thread == null) return false;
    return thread.threadType == 'booking_followup' || thread.bookingLinked;
  }

  List<({String english, String arabic})> get _structuredRequestOptions => [
        (
          english: 'Booking / Session Issue',
          arabic: 'مشكلة حجز أو جلسة',
        ),
        (
          english: 'Clinician Issue',
          arabic: 'مشكلة مع الأخصائي',
        ),
        (
          english: 'Center Issue',
          arabic: 'مشكلة مع المركز',
        ),
        (
          english: 'Follow-up Request',
          arabic: 'طلب متابعة',
        ),
        (
          english: 'Account / Payment Question',
          arabic: 'سؤال حساب أو دفع',
        ),
        (
          english: 'Other Admin Support',
          arabic: 'دعم إداري آخر',
        ),
      ];

  String _structuredRequestTemplate(
    bool isArabic,
    String englishType,
    String arabicType,
  ) {
    if (isArabic) {
      return '[طلب إداري منظم]\n'
          'النوع: $arabicType\n'
          'المصدر: شات الإدارة\n'
          'التفاصيل: ';
    }

    return '[Structured Admin Request]\n'
        'Type: $englishType\n'
        'Source: Admin Support Chat\n'
        'Details: ';
  }

  (String ownerEnglish, String ownerArabic) _structuredRequestOwner(
    String englishType,
  ) {
    switch (englishType) {
      case 'Booking / Session Issue':
        return ('Customer Follow-up', 'المتابعة وخدمة العملاء');
      case 'Clinician Issue':
        return (
          'Customer Follow-up / Admin Review',
          'المتابعة وخدمة العملاء / مراجعة الإدارة',
        );
      case 'Center Issue':
        return (
          'Customer Follow-up / Admin Review',
          'المتابعة وخدمة العملاء / مراجعة الإدارة',
        );
      case 'Follow-up Request':
        return ('Customer Follow-up', 'المتابعة وخدمة العملاء');
      case 'Account / Payment Question':
        return (
          'Customer Follow-up / Finance Review',
          'المتابعة وخدمة العملاء / مراجعة مالية',
        );
      case 'Other Admin Support':
      default:
        return ('Customer Follow-up', 'المتابعة وخدمة العملاء');
    }
  }

  void _insertStructuredRequestTemplate(
    bool isArabic, {
    required String englishType,
    required String arabicType,
  }) {
    final template =
        _structuredRequestTemplate(isArabic, englishType, arabicType);

    _textController
      ..text = template
      ..selection = TextSelection.collapsed(offset: template.length);

    if (widget.adminSupportMode && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم تجهيز الطلب المنظم.'
                : 'Structured request prepared.',
          ),
        ),
      );
    }
  }

  Widget _buildStructuredRequestMenu(bool isArabic, TextDirection textDirection) {
    if (!widget.adminSupportMode ||
        _viewerIsAdmin == true ||
        _viewerIsAdmin == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: AppColors.mutedGold.withValues(alpha: 0.22),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.xs,
              ),
              child: Column(
                crossAxisAlignment:
                    isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'طلب منظم' : 'Structured Request',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.obsidian,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    isArabic
                        ? 'استخدم الطلبات المنظمة لمشاكل الحجز أو الأخصائي أو المركز أو المتابعة أو الحساب. حالات الخطر يتم التعامل معها عبر الشات العام.'
                        : 'Use structured requests for booking, clinician, center, follow-up, or account issues. Safety concerns should use the general support chat.',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.obsidian.withValues(alpha: 0.76),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: SizedBox(
                height: 44,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    textDirection: textDirection,
                    children: [
                      for (final option in _structuredRequestOptions) ...[
                        ActionChip(
                          avatar: const Icon(
                            Icons.add_comment_outlined,
                            size: 16,
                            color: AppColors.deepTeal,
                          ),
                          label: Text(
                            isArabic ? option.arabic : option.english,
                            textAlign:
                                isArabic ? TextAlign.right : TextAlign.left,
                          ),
                          onPressed: () {
                            final owner =
                                _structuredRequestOwner(option.english);
                            setState(() {
                              _selectedStructuredRequest = (
                                english: option.english,
                                arabic: option.arabic,
                                ownerEnglish: owner.$1,
                                ownerArabic: owner.$2,
                              );
                            });
                            _insertStructuredRequestTemplate(
                              isArabic,
                              englishType: option.english,
                              arabicType: option.arabic,
                            );
                          },
                        ),
                        const SizedBox(width: AppSpacing.xs),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (_selectedStructuredRequest != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7E8),
                    borderRadius: BorderRadius.circular(AppRadii.md),
                    border: Border.all(
                      color: const Color(0xFFD8B26A).withValues(alpha: 0.28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: isArabic
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic ? 'معاينة الطلب' : 'Request Preview',
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.obsidian,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _structuredRequestTemplate(
                          isArabic,
                          _selectedStructuredRequest!.english,
                          _selectedStructuredRequest!.arabic,
                        ),
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.obsidian,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      AppStatusBadge(
                        label: isArabic
                            ? 'الجهة المسؤولة: ${_selectedStructuredRequest!.ownerArabic}'
                            : 'Ownership: ${_selectedStructuredRequest!.ownerEnglish}',
                        color: AppColors.deepTeal,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Align(
                        alignment: isArabic
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: FilledButton.icon(
                          onPressed: _sending
                              ? null
                              : () async {
                                  await _send();
                                  if (!mounted) return;
                                  setState(() {
                                    _selectedStructuredRequest = null;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isArabic
                                            ? 'تم تسجيل طلبك وهو تحت المراجعة.'
                                            : 'Your request has been submitted and is under review.',
                                      ),
                                    ),
                                  );
                                },
                          icon: const Icon(Icons.send_rounded),
                          label: Text(
                            isArabic ? 'إرسال الطلب' : 'Submit Request',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoundaryBanner(bool isArabic, TextDirection textDirection) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: AppSurfaceCard(
        color: const Color(0xFFFFF7E8),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              textDirection: textDirection,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFF8A5A1F),
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    isArabic
                        ? 'هذه المحادثة مخصصة للدعم والإرشاد فقط، ولا يتم من خلالها تعديل الطلبات أو الأسعار أو العقود أو الدفع.'
                        : 'This chat is for support and guidance only. Requests, pricing, contracts, and payments cannot be changed through chat.',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.obsidian,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
            if (_isRequestLinkedThread) ...[
              const SizedBox(height: AppSpacing.xs),
              AppStatusBadge(
                label: isArabic
                    ? 'محادثة مرتبطة بالطلب (للعرض فقط)'
                    : 'Request-linked thread (informational only)',
                color: const Color(0xFF8A5A1F),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRedirectHint(bool isArabic) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        isArabic
            ? 'لتعديل الطلب أو البيانات، يرجى استخدام الخطوات المتاحة داخل النظام.'
            : 'To modify your request or details, please use the available actions in the system.',
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.obsidian.withValues(alpha: 0.72),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Future<bool> _isAdminUser() async {
    return RoleAccessGateway().isAdmin();
  }

  @override
  void initState() {
    super.initState();
    _resolveViewerRole();
    _initThread();
  }

  Future<void> _resolveViewerRole() async {
    final isAdmin = await _isAdminUser();
    if (!mounted) return;
    setState(() {
      _viewerIsAdmin = isAdmin;
    });
  }

  Future<void> _initThread() async {
    if (mounted) {
      setState(() {
        _loading = true;
        _error = null;
      });
    }

    try {
      ChatThreadModel thread;
      if (widget.initialThreadId != null &&
          widget.initialThreadId!.isNotEmpty) {
        final loaded = await _controller.getThreadById(widget.initialThreadId!);
        if (loaded == null) {
          throw Exception('لم يتم العثور على المحادثة المطلوبة');
        }
        thread = loaded;
      } else if (widget.adminSupportMode) {
        thread = await _controller.getOrCreateAdminSupportThread();
      } else {
        thread = await _controller.getOrCreateThread();
      }

      if (!mounted) return;
      setState(() {
        _thread = thread;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'تعذر فتح الشات: $e';
        _loading = false;
      });
    }
  }

  Future<void> _send() async {
    if (_thread == null) return;
    final text = _textController.text.trim();
    if (text.isEmpty || _sending) return;

    final isArabic = _isArabic();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _textController.clear();
    setState(() => _sending = true);

    try {
      final isAdmin = await _isAdminUser();

      if (isAdmin) {
        final threadRef = FirebaseFirestore.instance
            .collection('chat_threads')
            .doc(_thread!.id);

        final latest = await threadRef
            .collection('messages')
            .orderBy('sequenceNumber', descending: true)
            .limit(1)
            .get();

        int nextSeq = 1;
        if (latest.docs.isNotEmpty) {
          final current = latest.docs.first.data()['sequenceNumber'];
          if (current is int) {
            nextSeq = current + 1;
          }
        }

        await threadRef.collection('messages').add({
          'threadId': _thread!.id,
          'senderType': 'admin',
          'senderUid': user.uid,
          'text': text,
          'createdAt': FieldValue.serverTimestamp(),
          'sequenceNumber': nextSeq,
          'visibleToUser': true,
          'messageKind': 'admin_reply',
          'roleDetected': null,
          'statesDetected': const [],
          'riskScore': 0,
          'riskLevel': 'low',
          'strategyMode': 'containment',
          'safetyTriggered': false,
          'containsEscalationSignal': false,
          'aiModelVersion': null,
          'systemVersion': 'admin_chat_v1',
          'metadata': const {},
        });

        await threadRef.update({
          'updatedAt': FieldValue.serverTimestamp(),
          'lastMessageAt': FieldValue.serverTimestamp(),
          'lastMessagePreview':
              text.length > 120 ? text.substring(0, 120) : text,
          'messageCount': FieldValue.increment(1),
          'handoffState': 'admin_replying',
          'lifecycleState': 'assigned_admin',
        });
      } else {
        if (widget.adminSupportMode) {
          await _controller.sendSupportMessage(
            threadId: _thread!.id,
            text: text,
          );
        } else {
          await _controller.sendUserMessage(
            threadId: _thread!.id,
            text: text,
          );
        }
      }

      await Future<void>.delayed(const Duration(milliseconds: 150));
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic ? 'فشل إرسال الرسالة: $e' : 'Failed to send message: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _sending = false);
      }
    }
  }

  Future<void> _startFreshConversation() async {
    if (widget.adminSupportMode || _thread == null || _sending) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final fresh = await _controller.startFreshAiThread(
        archiveThreadId: _thread!.id,
      );

      if (!mounted) return;
      setState(() {
        _thread = fresh;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'تعذر بدء محادثة جديدة: $e';
        _loading = false;
      });
    }
  }

  Widget _bubble(ChatMessageModel msg, bool isArabic) {
    final sender = msg.senderType;
    final isUser = sender == 'user';
    final isAdmin = sender == 'admin';
    final isAi = sender == 'ai';

    final bubbleColor = isUser
        ? AppColors.deepTeal.withValues(alpha: 0.12)
        : (isAdmin
            ? const Color(0xFFEAF4FF)
            : Colors.white.withValues(alpha: 0.92));

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        constraints: const BoxConstraints(maxWidth: 520),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: isUser
                ? AppColors.deepTeal.withValues(alpha: 0.16)
                : AppColors.mutedGold.withValues(alpha: 0.10),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isUser
                  ? (isArabic ? 'أنت' : 'You')
                  : (isAdmin
                      ? (isArabic ? 'الإدارة' : 'Admin')
                      : (isAi
                          ? (isArabic
                              ? 'مساعد Mental Smile'
                              : 'Mental Smile Assistant')
                          : (isArabic ? 'الدعم' : 'Support'))),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.mist,
                  ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              msg.text,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.obsidian,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(bool isArabic) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: AppSurfaceCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 34,
                color: AppColors.softTerracotta,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _error ?? (isArabic ? 'تعذر فتح الشات' : 'Unable to open chat'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.obsidian,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton.icon(
                onPressed: _initThread,
                icon: const Icon(Icons.refresh),
                label: Text(isArabic ? 'إعادة المحاولة' : 'Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isArabic) {
    return Center(
      child: Text(
        isArabic ? 'ابدأ أول رسالة الآن' : 'Start your first message now',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.obsidian,
            ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic();
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final entryContextHelper = _entryContextHelper(isArabic);
    final isViewerAdmin = _viewerIsAdmin == true;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isArabic ? 'شات Mental Smile' : 'Mental Smile Chat'),
          actions: [
            if (!widget.adminSupportMode)
              IconButton(
                tooltip: isArabic ? 'محادثة جديدة' : 'New conversation',
                onPressed:
                    _loading || _sending ? null : _startFreshConversation,
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: AppColors.deepTeal,
                ),
              ),
          ],
        ),
        body: AppPageBackground(
          child: SafeArea(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? _buildErrorState(isArabic)
                    : _thread == null
                        ? Center(
                            child: Text(
                              isArabic
                                  ? 'تعذر تحميل المحادثة'
                                  : 'Unable to load conversation',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: AppColors.obsidian),
                            ),
                          )
                        : Column(
                            children: [
                              const SizedBox(height: AppSpacing.sm),
                              const AppLogoWordmark(width: 220),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  AppSpacing.md,
                                  AppSpacing.md,
                                  AppSpacing.md,
                                  AppSpacing.sm,
                                ),
                                child: AppSurfaceCard(
                                  color: Colors.white.withValues(alpha: 0.82),
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  child: Row(
                                    textDirection: textDirection,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: isArabic
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.adminSupportMode
                                                  ? (isArabic
                                                      ? 'دعم الإدارة'
                                                      : 'Admin Support')
                                                  : (isArabic
                                                      ? 'مساعد Mental Smile'
                                                      : 'Mental Smile Assistant'),
                                              textAlign: isArabic
                                                  ? TextAlign.right
                                                  : TextAlign.left,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const SizedBox(
                                                height: AppSpacing.xxs),
                                            Text(
                                              _pageSubtitle(isArabic),
                                              textAlign: isArabic
                                                  ? TextAlign.right
                                                  : TextAlign.left,
                                            ),
                                            if (entryContextHelper != null) ...[
                                              const SizedBox(
                                                  height: AppSpacing.xxs),
                                              Text(
                                                entryContextHelper,
                                                textAlign: isArabic
                                                    ? TextAlign.right
                                                    : TextAlign.left,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: AppColors.obsidian
                                                          .withValues(
                                                        alpha: 0.72,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      CircleAvatar(
                                        radius: 26,
                                        backgroundColor: AppColors.deepTeal
                                            .withValues(alpha: 0.10),
                                        child: ClipOval(
                                          child: Image.asset(
                                            normalizeAssetPath(_avatarAsset),
                                            width: 52,
                                            height: 52,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                width: 52,
                                                height: 52,
                                                color: AppColors.deepTeal
                                                    .withValues(alpha: 0.10),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  widget.adminSupportMode
                                                      ? Icons
                                                          .support_agent_rounded
                                                      : Icons
                                                          .person_outline_rounded,
                                                  color: AppColors.deepTeal,
                                                  size: 22,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              _buildBoundaryBanner(isArabic, textDirection),
                              Expanded(
                                child: StreamBuilder<List<ChatMessageModel>>(
                                  stream:
                                      _controller.streamMessages(_thread!.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          isArabic
                                              ? 'حدث خطأ أثناء تحميل الرسائل'
                                              : 'Failed to load messages',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: AppColors.obsidian,
                                              ),
                                        ),
                                      );
                                    }

                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    final messages = snapshot.data ?? [];
                                    if (messages.isEmpty) {
                                      return ListView(
                                        controller: _scrollController,
                                        padding:
                                            const EdgeInsets.all(AppSpacing.md),
                                        children: [
                                          _buildStructuredRequestMenu(
                                            isArabic,
                                            textDirection,
                                          ),
                                          _buildEmptyState(isArabic),
                                        ],
                                      );
                                    }

                                    return ListView.builder(
                                      controller: _scrollController,
                                      padding:
                                          const EdgeInsets.all(AppSpacing.md),
                                      itemCount: messages.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return _buildStructuredRequestMenu(
                                            isArabic,
                                            textDirection,
                                          );
                                        }
                                        final msg = messages[index - 1];
                                        if (!msg.visibleToUser) {
                                          return const SizedBox.shrink();
                                        }
                                        return _bubble(msg, isArabic);
                                      },
                                    );
                                  },
                                ),
                              ),
                              if (!widget.adminSupportMode || isViewerAdmin)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    AppSpacing.sm,
                                    0,
                                    AppSpacing.sm,
                                    AppSpacing.sm,
                                  ),
                                  child: AppSectionPanel(
                                    padding: const EdgeInsets.fromLTRB(
                                      AppSpacing.sm,
                                      AppSpacing.sm,
                                      AppSpacing.sm,
                                      AppSpacing.sm,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: isArabic
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        _buildRedirectHint(isArabic),
                                        Row(
                                          textDirection: textDirection,
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller: _textController,
                                                minLines: 1,
                                                maxLines: 4,
                                                textDirection: textDirection,
                                                decoration: InputDecoration(
                                                  hintText: isArabic
                                                      ? 'اكتب رسالتك هنا...'
                                                      : 'Type your message here...',
                                                ),
                                                onSubmitted: (_) => _send(),
                                              ),
                                            ),
                                            const SizedBox(width: AppSpacing.sm),
                                            SizedBox(
                                              height: 50,
                                              child: FilledButton(
                                                onPressed:
                                                    _sending ? null : _send,
                                                child: _sending
                                                    ? const SizedBox(
                                                        width: 18,
                                                        height: 18,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : Text(
                                                        isArabic
                                                            ? 'إرسال'
                                                            : 'Send',
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
          ),
        ),
      ),
    );
  }
}
