# Public Reputation Foundation

## Scope

Wave M-11 adds the federation public trust and reputation foundation.

This is not session rating, booking rating, appointment review, or lifecycle
feedback. It does not create Firebase writes, Firestore collections, UI,
threaded comments, or account-bound ratings.

## Trust Layer

The federation measures public trust through compact reputation summaries.

The primary public element is the reputation summary, not the full comment
stream.

## Reputation Layer

Supported reputation targets:

- provider
- center
- tool
- library_content
- external_app
- campaign
- knowledge_resource

## Ratings

`PublicRating` contains:

- targetType
- targetId
- ratingValue
- createdAt
- classification

It contains no user account fields.

## Comments

`PublicComment` contains:

- commentId
- targetType
- targetId
- commentText
- createdAt
- classification

It contains no threading model.

## Collapsed Comments

Comments are an expandable evidence layer. They start collapsed by default.

Supported visibility modes:

- collapsed
- preview
- expanded

## Compact Summary

`CompactReputationSummary` contains:

- averageRating
- ratingCount
- commentPreview
- hiddenCommentCount

## Signals

Reputation signal names:

- rating_added
- comment_added
- comment_expanded
- reputation_viewed

## Report And Archive Alignment

The report category registry now includes:

- reputation_report

The archive export package registry now includes:

- reputation_pack

## Boundaries

Public reputation must not use sessionRatings, booking ratings, appointment
ratings, session review, booking review, appointment review, or any naming that
turns reputation into lifecycle satisfaction.

## Success Path

```text
Public Reputation
Monitoring
Reports
Archive
Meetings
```
