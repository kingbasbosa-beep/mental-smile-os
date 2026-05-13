import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/gateways/role_access_gateway.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';
import 'package:flutterprojects/features/chat/controller/chat_controller.dart';
import 'package:flutterprojects/features/chat/data/models/chat_message_model.dart';
import 'package:flutterprojects/features/chat/data/models/chat_thread_model.dart';

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
          return Icon(
            Icons.arrow_back_rounded,
            color: const Color(0xFFFFE7B2),
            size: iconSize,
          );
        },
      ),
    );
  }
}

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

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  BoxDecoration _glassDecoration({
    double alpha = 0.38,
    double radius = 24,
    Color borderColor = const Color(0xFFE7C766),
  }) {
    return BoxDecoration(
      color: Colors.black.withValues(alpha: alpha),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor.withValues(alpha: 0.34)),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFE7C766).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    );
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

  String _friendlyChatError(bool isArabic) {
    return isArabic
        ? 'تعذر فتح الشات الآن. حاول إعادة المحاولة بعد لحظات.'
        : 'Unable to open chat right now. Please try again shortly.';
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

  Widget _buildStructuredRequestMenu(
      bool isArabic, TextDirection textDirection) {
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
        decoration: _glassDecoration(alpha: 0.34, radius: 20),
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
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'طلب منظم' : 'Structured Request',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: const Color(0xFFE7C766),
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
                          color:
                              const Color(0xFFFFF4D4).withValues(alpha: 0.78),
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
                            color: Color(0xFFE7C766),
                          ),
                          backgroundColor: Colors.black.withValues(alpha: 0.28),
                          side: BorderSide(
                            color:
                                const Color(0xFFE7C766).withValues(alpha: 0.30),
                          ),
                          labelStyle: const TextStyle(color: Color(0xFFFFF4D4)),
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
                    color: Colors.black.withValues(alpha: 0.32),
                    borderRadius: BorderRadius.circular(AppRadii.md),
                    border: Border.all(
                      color: const Color(0xFFE7C766).withValues(alpha: 0.28),
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
                              color: const Color(0xFFE7C766),
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
                              color: const Color(0xFFFFF4D4),
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
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: _glassDecoration(alpha: 0.30, radius: 22),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              textDirection: textDirection,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFFE7C766),
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
                          color: const Color(0xFFFFF4D4),
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
              color: const Color(0xFFFFF4D4).withValues(alpha: 0.72),
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
      if (kDebugMode) {
        debugPrint('CHAT_OPEN_FAILED $e');
      }
      if (!mounted) return;
      setState(() {
        _error = _friendlyChatError(_isArabic());
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
      if (kDebugMode) {
        debugPrint('CHAT_SEND_FAILED $e');
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تعذر إرسال الرسالة الآن. حاول مرة أخرى.'
                : 'Unable to send the message right now. Please try again.',
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
      if (kDebugMode) {
        debugPrint('CHAT_START_FRESH_FAILED $e');
      }
      if (!mounted) return;
      setState(() {
        _error = _friendlyChatError(_isArabic());
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
        ? const Color(0xFFE7C766).withValues(alpha: 0.16)
        : (isAdmin
            ? const Color(0xFF1C4E54).withValues(alpha: 0.28)
            : Colors.black.withValues(alpha: 0.42));

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
                ? const Color(0xFFE7C766).withValues(alpha: 0.38)
                : AppColors.mutedGold.withValues(alpha: 0.26),
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
                    color: const Color(0xFFE7C766),
                  ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              msg.text,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFFFFF4D4),
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
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: _glassDecoration(alpha: 0.36, radius: 22),
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
                      color: const Color(0xFFFFF4D4),
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
              color: const Color(0xFFFFF4D4),
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.88),
          elevation: 0,
          foregroundColor: const Color(0xFFFFE8A6),
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).maybePop();
              } else {
                Navigator.of(context).pushNamed(Routes.menu);
              }
            },
            icon: const _GoldBackIcon(compact: true),
          ),
          title: Text(isArabic ? 'شات Mental Smile' : 'Mental Smile Chat'),
          actions: [
            if (!widget.adminSupportMode)
              IconButton(
                tooltip: isArabic ? 'محادثة جديدة' : 'New conversation',
                onPressed:
                    _loading || _sending ? null : _startFreshConversation,
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Color(0xFFE7C766),
                ),
              ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  _backgroundAsset(constraints.maxWidth),
                  fit: BoxFit.cover,
                  alignment: constraints.maxWidth < 700
                      ? Alignment.topCenter
                      : Alignment.center,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.62),
                        Colors.black.withValues(alpha: 0.38),
                        Colors.black.withValues(alpha: 0.74),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: _loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFE7C766),
                          ),
                        )
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
                                        ?.copyWith(
                                          color: const Color(0xFFFFF4D4),
                                        ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        AppSpacing.md,
                                        AppSpacing.md,
                                        AppSpacing.md,
                                        AppSpacing.sm,
                                      ),
                                      child: Container(
                                        padding:
                                            const EdgeInsets.all(AppSpacing.md),
                                        decoration: _glassDecoration(
                                          alpha: 0.34,
                                          radius: 24,
                                        ),
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
                                                        .titleMedium
                                                        ?.copyWith(
                                                          color: const Color(
                                                              0xFFE7C766),
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                      height: AppSpacing.xxs),
                                                  Text(
                                                    _pageSubtitle(isArabic),
                                                    textAlign: isArabic
                                                        ? TextAlign.right
                                                        : TextAlign.left,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: const Color(
                                                            0xFFFFF4D4,
                                                          ).withValues(
                                                              alpha: 0.78),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                  if (entryContextHelper !=
                                                      null) ...[
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
                                                            color: const Color(
                                                              0xFFFFF4D4,
                                                            ).withValues(
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
                                            const SizedBox(
                                                width: AppSpacing.md),
                                            CircleAvatar(
                                              radius: 26,
                                              backgroundColor:
                                                  const Color(0xFFE7C766)
                                                      .withValues(alpha: 0.20),
                                              child: ClipOval(
                                                child: Image.asset(
                                                  normalizeAssetPath(
                                                      _avatarAsset),
                                                  width: 52,
                                                  height: 52,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      width: 52,
                                                      height: 52,
                                                      color: Colors.black
                                                          .withValues(
                                                              alpha: 0.24),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        widget.adminSupportMode
                                                            ? Icons
                                                                .support_agent_rounded
                                                            : Icons
                                                                .person_outline_rounded,
                                                        color: const Color(
                                                            0xFFE7C766),
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
                                    _buildBoundaryBanner(
                                        isArabic, textDirection),
                                    Expanded(
                                      child:
                                          StreamBuilder<List<ChatMessageModel>>(
                                        stream: _controller
                                            .streamMessages(_thread!.id),
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
                                                      color: const Color(
                                                          0xFFFFF4D4),
                                                    ),
                                              ),
                                            );
                                          }

                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xFFE7C766),
                                              ),
                                            );
                                          }

                                          final messages = snapshot.data ?? [];
                                          if (messages.isEmpty) {
                                            return ListView(
                                              controller: _scrollController,
                                              padding: const EdgeInsets.all(
                                                  AppSpacing.md),
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
                                            padding: const EdgeInsets.all(
                                                AppSpacing.md),
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
                                    if (!widget.adminSupportMode ||
                                        isViewerAdmin)
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          AppSpacing.sm,
                                          0,
                                          AppSpacing.sm,
                                          AppSpacing.sm,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                              AppSpacing.sm),
                                          decoration: _glassDecoration(
                                            alpha: 0.42,
                                            radius: 22,
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
                                                      controller:
                                                          _textController,
                                                      minLines: 1,
                                                      maxLines: 4,
                                                      textDirection:
                                                          textDirection,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFFFF4D4),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      cursorColor: const Color(
                                                          0xFFE7C766),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: isArabic
                                                            ? 'اكتب رسالتك هنا...'
                                                            : 'Type your message here...',
                                                        hintStyle: TextStyle(
                                                          color: const Color(
                                                            0xFFFFF4D4,
                                                          ).withValues(
                                                              alpha: 0.56),
                                                        ),
                                                        filled: true,
                                                        fillColor: Colors.black
                                                            .withValues(
                                                                alpha: 0.34),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: const Color(
                                                              0xFFE7C766,
                                                            ).withValues(
                                                                alpha: 0.28),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Color(
                                                                0xFFE7C766),
                                                          ),
                                                        ),
                                                      ),
                                                      onSubmitted: (_) =>
                                                          _send(),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width: AppSpacing.sm),
                                                  SizedBox(
                                                    height: 50,
                                                    child: FilledButton(
                                                      style: FilledButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF1C4E54),
                                                        foregroundColor:
                                                            const Color(
                                                                0xFFFFF4D4),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            18,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: _sending
                                                          ? null
                                                          : _send,
                                                      child: _sending
                                                          ? const SizedBox(
                                                              width: 18,
                                                              height: 18,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                color: Color(
                                                                    0xFFFFF4D4),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
