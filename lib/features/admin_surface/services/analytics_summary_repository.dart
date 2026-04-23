import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/features/admin_surface/models/analytics_summary_models.dart';

class AnalyticsSummaryRepository {
  const AnalyticsSummaryRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  FirebaseFirestore get _db => _firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('analytics_summaries');

  Future<TopEntryModulesSummary?> fetchTopEntryModulesSummary() async {
    return _fetchSummary(
      'top_entry_modules',
      TopEntryModulesSummary.fromMap,
    );
  }

  Future<TopSelectedPathsSummary?> fetchTopSelectedPathsSummary() async {
    return _fetchSummary(
      'top_selected_paths',
      TopSelectedPathsSummary.fromMap,
    );
  }

  Future<ChatOpensByContextSummary?> fetchChatOpensByContextSummary() async {
    return _fetchSummary(
      'chat_opens_by_context',
      ChatOpensByContextSummary.fromMap,
    );
  }

  Future<AnalyticsSummaryBundle> fetchBundle() async {
    try {
      final results = await Future.wait([
        fetchTopEntryModulesSummary(),
        fetchTopSelectedPathsSummary(),
        fetchChatOpensByContextSummary(),
      ]);

      return AnalyticsSummaryBundle(
        topEntryModules: results[0] as TopEntryModulesSummary?,
        topSelectedPaths: results[1] as TopSelectedPathsSummary?,
        chatOpensByContext: results[2] as ChatOpensByContextSummary?,
      );
    } catch (_) {
      return const AnalyticsSummaryBundle();
    }
  }

  Future<T?> _fetchSummary<T>(
    String docId,
    T Function(Map<String, dynamic> map) fromMap,
  ) async {
    try {
      final snapshot = await _collection.doc(docId).get();
      if (!snapshot.exists) return null;
      final data = snapshot.data();
      if (data == null) return null;
      return fromMap(data);
    } catch (_) {
      return null;
    }
  }
}
