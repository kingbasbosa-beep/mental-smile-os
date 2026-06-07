import '../models/compact_reputation_summary.dart';
import '../models/public_comment.dart';
import '../models/public_rating.dart';
import '../models/reputation_aggregate.dart';

abstract class PublicRatingBuilder {
  PublicRating buildRating();
}

abstract class PublicCommentBuilder {
  PublicComment buildComment();
}

abstract class ReputationAggregateBuilder {
  ReputationAggregate buildAggregate();
}

abstract class CompactReputationSummaryBuilder {
  CompactReputationSummary buildSummary();
}
