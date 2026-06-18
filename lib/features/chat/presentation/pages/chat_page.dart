import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/shared/ui_kit/app_design_system.dart';
import 'package:mental_smile_os/shared/gateways/role_access_gateway.dart';
import 'package:mental_smile_os/shared/utils/asset_path_utils.dart';
import 'package:mental_smile_os/features/chat/controller/chat_controller.dart';
import 'package:mental_smile_os/features/chat/data/models/chat_message_model.dart';
import 'package:mental_smile_os/features/chat/data/models/chat_thread_model.dart';

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
    this.supportRoomMode = false,
    this.entryContext,
  });

  final String? initialThreadId;
  final bool supportRoomMode;
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
  bool? _viewerIsSupportObserver;
  String? _error;

  bool _isArabic() =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String get _avatarAsset {
    final value = widget.supportRoomMode
        ? 'assets/images/avatar_client.png'
        : 'assets/images/avatar_client.png';
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
    if (widget.supportRoomMode) {
      return isArabic
          ? 'محادثة داخلية مع الإدارة للمتابعة والرد'
          : 'Internal support room conversation';
    }
    return isArabic
        ? 'دعم أولي آمن مع تصعيد بشري عند ارتفاع مستوى الخطر'
        : 'Safe first-line support with human escalation when risk rises';
  }

  String? _entryContextHelper(bool isArabic) {
    if (widget.supportRoomMode || widget.initialThreadId != null) return null;

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

  List<({String english, String arabic})> get _structuredRequestOptions => [
        (
          english: 'Support / Contact Issue',
          arabic: 'مشكلة دعم أو تواصل',
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
          english: 'Continuity Support',
          arabic: 'دعم الاستمرارية',
        ),
        (
          english: 'Account / Service Cost Question',
          arabic: 'سؤال حساب أو تكلفة خدمة',
        ),
        (
          english: 'Other Support Room',
          arabic: 'دعم إداري آخر',
        ),
      ];

  String _structuredRequestTemplate(
    bool isArabic,
    String englishType,
    String arabicType,
  ) {
    if (isArabic) {
      return '[إشارة دعم منظمة]\n'
          'النوع: $arabicType\n'
          'المصدر: شات الدعم\n'
          'التفاصيل: ';
    }

    return '[Structured Support Request]\n'
        'Type: $englishType\n'
        'Source: Support Room Chat\n'
        'Details: ';
  }

  (String ownerEnglish, String ownerArabic) _structuredRequestOwner(
    String englishType,
  ) {
    switch (englishType) {
      case 'Clinician Issue':
        return (
          'Support / Specialist Guidance',
          'الدعم / إرشاد الأخصائيين',
        );
      case 'Center Issue':
        return (
          'Support / Center Guidance',
          'الدعم / إرشاد المراكز',
        );
      case 'Continuity Support':
        return ('Support', 'الدعم');
      case 'Account / Service Cost Question':
        return (
          'Support / Account Guidance',
          'الدعم / إرشاد الحساب',
        );
      case 'Other Support Room':
      default:
        return ('Support', 'الدعم');
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

    if (widget.supportRoomMode && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic ? 'تم تجهيز إشارة الدعم.' : 'Support signal prepared.',
          ),
        ),
      );
    }
  }

  Widget _buildStructuredRequestMenu(
      bool isArabic, TextDirection textDirection) {
    if (!widget.supportRoomMode ||
        _viewerIsSupportObserver == true ||
        _viewerIsSupportObserver == null) {
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
                    isArabic ? 'إشارة دعم منظمة' : 'Structured Support Signal',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: const Color(0xFFE7C766),
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    isArabic
                        ? 'استخدم إشارات الدعم المنظمة للتواصل أو الوصول إلى الموارد أو مساعدة الحساب. إشارات الأمان تستخدم محادثة الأمان.'
                        : 'Use structured support signals for communication, resource access, or account help. Safety signals use the safety chat.',
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
                        isArabic
                            ? 'معاينة إشارة الدعم'
                            : 'Support Signal Preview',
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
                            ? 'جهة الإرشاد: ${_selectedStructuredRequest!.ownerArabic}'
                            : 'Guidance: ${_selectedStructuredRequest!.ownerEnglish}',
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
                                            ? 'تمت مشاركة إشارة الدعم للرصد.'
                                            : 'Your support signal was shared for observation.',
                                      ),
                                    ),
                                  );
                                },
                          icon: const Icon(Icons.send_rounded),
                          label: Text(
                            isArabic
                                ? 'مشاركة إشارة الدعم'
                                : 'Share Support Signal',
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
                        ? 'هذه المحادثة مخصصة للدعم والإرشاد فقط، ولا يتم من خلالها تعديل إشارات الدعم أو معلومات التكلفة أو العقود.'
                        : 'This chat is for support and guidance only. Requests, pricing, contracts, and external arrangements cannot be changed through chat.',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFFFF4D4),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
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
            ? 'لتحديث إشارة الدعم أو البيانات، يرجى استخدام الخطوات المتاحة داخل النظام.'
            : 'To update your support signal or details, please use the available actions in the system.',
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFFFFF4D4).withValues(alpha: 0.72),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Future<bool> _isSupportObserverUser() async {
    return RoleAccessGateway().isSupportObserver();
  }

  @override
  void initState() {
    super.initState();
    _resolveViewerRole();
    _initThread();
  }

  Future<void> _resolveViewerRole() async {
    final isSupportObserver = await _isSupportObserverUser();
    if (!mounted) return;
    setState(() {
      _viewerIsSupportObserver = isSupportObserver;
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
      } else if (widget.supportRoomMode) {
        thread = await _controller.getOrCreateSupportRoomThread();
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
      final isSupportObserver = await _isSupportObserverUser();

      if (isSupportObserver) {
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
          'senderType': 'support',
          'senderUid': user.uid,
          'text': text,
          'createdAt': FieldValue.serverTimestamp(),
          'sequenceNumber': nextSeq,
          'visibleToUser': true,
          'messageKind': 'support_reply',
          'roleDetected': null,
          'statesDetected': const [],
          'riskScore': 0,
          'riskLevel': 'low',
          'strategyMode': 'containment',
          'safetyTriggered': false,
          'containsEscalationSignal': false,
          'aiModelVersion': null,
          'systemVersion': 'support_chat_v1',
          'metadata': const {},
        });

        await threadRef.update({
          'updatedAt': FieldValue.serverTimestamp(),
          'lastMessageAt': FieldValue.serverTimestamp(),
          'lastMessagePreview':
              text.length > 120 ? text.substring(0, 120) : text,
          'messageCount': FieldValue.increment(1),
        });
      } else {
        if (widget.supportRoomMode) {
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
    if (widget.supportRoomMode || _thread == null || _sending) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final fresh = await _controller.startFreshAiThread();

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
    final isSupport = sender == 'support';
    final isAi = sender == 'ai';

    final bubbleColor = isUser
        ? const Color(0xFFE7C766).withValues(alpha: 0.16)
        : (isSupport
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
                  : (isSupport
                      ? (isArabic ? 'الدعم' : 'Support')
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
    final isViewerSupportObserver = _viewerIsSupportObserver == true;

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
            if (!widget.supportRoomMode)
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
                                                    widget.supportRoomMode
                                                        ? (isArabic
                                                            ? 'دعم الإدارة'
                                                            : 'Support Room')
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
                                                        widget.supportRoomMode
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
                                    if (!widget.supportRoomMode ||
                                        isViewerSupportObserver)
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
