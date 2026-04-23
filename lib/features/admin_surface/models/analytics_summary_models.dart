import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyticsSummaryBase {
  const AnalyticsSummaryBase({
    required this.summaryName,
    required this.period,
    required this.generatedAt,
    required this.windowStart,
    required this.windowEnd,
    required this.version,
  });

  final String summaryName;
  final String period;
  final DateTime? generatedAt;
  final DateTime? windowStart;
  final DateTime? windowEnd;
  final int version;

  bool get hasWindow => windowStart != null || windowEnd != null;

  static DateTime? parseDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static int parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse((value ?? '').toString()) ?? 0;
  }

  static String parseString(dynamic value) {
    return (value ?? '').toString().trim();
  }
}

class TopEntryModuleItem {
  const TopEntryModuleItem({
    required this.key,
    required this.count,
  });

  final String key;
  final int count;

  factory TopEntryModuleItem.fromMap(Map<String, dynamic> map) {
    return TopEntryModuleItem(
      key: AnalyticsSummaryBase.parseString(map['key']),
      count: AnalyticsSummaryBase.parseInt(map['count']),
    );
  }

  bool get isValid => key.isNotEmpty;
}

class TopEntryModulesSummary extends AnalyticsSummaryBase {
  const TopEntryModulesSummary({
    required super.summaryName,
    required super.period,
    required super.generatedAt,
    required super.windowStart,
    required super.windowEnd,
    required super.version,
    required this.items,
  });

  final List<TopEntryModuleItem> items;

  bool get hasData => items.isNotEmpty;

  factory TopEntryModulesSummary.fromMap(Map<String, dynamic> map) {
    final rawItems = map['items'];
    final items = rawItems is List
        ? rawItems
            .whereType<Map>()
            .map((item) => TopEntryModuleItem.fromMap(
                  Map<String, dynamic>.from(item),
                ))
            .where((item) => item.isValid)
            .toList()
        : <TopEntryModuleItem>[];

    return TopEntryModulesSummary(
      summaryName: AnalyticsSummaryBase.parseString(map['summaryName']),
      period: AnalyticsSummaryBase.parseString(map['period']),
      generatedAt: AnalyticsSummaryBase.parseDate(map['generatedAt']),
      windowStart: AnalyticsSummaryBase.parseDate(map['windowStart']),
      windowEnd: AnalyticsSummaryBase.parseDate(map['windowEnd']),
      version: AnalyticsSummaryBase.parseInt(map['version']),
      items: items,
    );
  }
}

class TopSelectedPathItem {
  const TopSelectedPathItem({
    required this.key,
    required this.module,
    required this.path,
    required this.count,
  });

  final String key;
  final String module;
  final String path;
  final int count;

  factory TopSelectedPathItem.fromMap(Map<String, dynamic> map) {
    return TopSelectedPathItem(
      key: AnalyticsSummaryBase.parseString(map['key']),
      module: AnalyticsSummaryBase.parseString(map['module']),
      path: AnalyticsSummaryBase.parseString(map['path']),
      count: AnalyticsSummaryBase.parseInt(map['count']),
    );
  }

  bool get isValid => key.isNotEmpty || (module.isNotEmpty && path.isNotEmpty);
}

class TopSelectedPathsSummary extends AnalyticsSummaryBase {
  const TopSelectedPathsSummary({
    required super.summaryName,
    required super.period,
    required super.generatedAt,
    required super.windowStart,
    required super.windowEnd,
    required super.version,
    required this.items,
  });

  final List<TopSelectedPathItem> items;

  bool get hasData => items.isNotEmpty;

  factory TopSelectedPathsSummary.fromMap(Map<String, dynamic> map) {
    final rawItems = map['items'];
    final items = rawItems is List
        ? rawItems
            .whereType<Map>()
            .map((item) => TopSelectedPathItem.fromMap(
                  Map<String, dynamic>.from(item),
                ))
            .where((item) => item.isValid)
            .toList()
        : <TopSelectedPathItem>[];

    return TopSelectedPathsSummary(
      summaryName: AnalyticsSummaryBase.parseString(map['summaryName']),
      period: AnalyticsSummaryBase.parseString(map['period']),
      generatedAt: AnalyticsSummaryBase.parseDate(map['generatedAt']),
      windowStart: AnalyticsSummaryBase.parseDate(map['windowStart']),
      windowEnd: AnalyticsSummaryBase.parseDate(map['windowEnd']),
      version: AnalyticsSummaryBase.parseInt(map['version']),
      items: items,
    );
  }
}

class ChatContextCountItem {
  const ChatContextCountItem({
    required this.context,
    required this.count,
  });

  final String context;
  final int count;

  factory ChatContextCountItem.fromMap(Map<String, dynamic> map) {
    return ChatContextCountItem(
      context: AnalyticsSummaryBase.parseString(map['context']),
      count: AnalyticsSummaryBase.parseInt(map['count']),
    );
  }

  bool get isValid => context.isNotEmpty;
}

class ChatOpensByContextSummary extends AnalyticsSummaryBase {
  const ChatOpensByContextSummary({
    required super.summaryName,
    required super.period,
    required super.generatedAt,
    required super.windowStart,
    required super.windowEnd,
    required super.version,
    required this.total,
    required this.items,
  });

  final int total;
  final List<ChatContextCountItem> items;

  bool get hasData => total > 0 || items.isNotEmpty;

  factory ChatOpensByContextSummary.fromMap(Map<String, dynamic> map) {
    final rawItems = map['items'];
    final items = rawItems is List
        ? rawItems
            .whereType<Map>()
            .map((item) => ChatContextCountItem.fromMap(
                  Map<String, dynamic>.from(item),
                ))
            .where((item) => item.isValid)
            .toList()
        : <ChatContextCountItem>[];

    return ChatOpensByContextSummary(
      summaryName: AnalyticsSummaryBase.parseString(map['summaryName']),
      period: AnalyticsSummaryBase.parseString(map['period']),
      generatedAt: AnalyticsSummaryBase.parseDate(map['generatedAt']),
      windowStart: AnalyticsSummaryBase.parseDate(map['windowStart']),
      windowEnd: AnalyticsSummaryBase.parseDate(map['windowEnd']),
      version: AnalyticsSummaryBase.parseInt(map['version']),
      total: AnalyticsSummaryBase.parseInt(map['total']),
      items: items,
    );
  }
}

class AnalyticsSummaryBundle {
  const AnalyticsSummaryBundle({
    this.topEntryModules,
    this.topSelectedPaths,
    this.chatOpensByContext,
  });

  final TopEntryModulesSummary? topEntryModules;
  final TopSelectedPathsSummary? topSelectedPaths;
  final ChatOpensByContextSummary? chatOpensByContext;

  bool get hasAnyData =>
      (topEntryModules?.hasData ?? false) ||
      (topSelectedPaths?.hasData ?? false) ||
      (chatOpensByContext?.hasData ?? false);
}
