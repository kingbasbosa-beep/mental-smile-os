import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

const String _canonicalBookingCollection = 'booking_requests';
const String _legacyBookingCollection = 'bookingRequests';

enum BookingOwnershipCategory {
  fullyNormalized,
  legacyOnly,
  canonicalOnly,
  unassigned,
}

class BookingOwnershipInventoryResult {
  const BookingOwnershipInventoryResult({
    required this.collectionName,
    required this.totalCount,
    required this.categoryCounts,
  });

  final String collectionName;
  final int totalCount;
  final Map<BookingOwnershipCategory, int> categoryCounts;

  int countFor(BookingOwnershipCategory category) {
    return categoryCounts[category] ?? 0;
  }

  double percentageFor(BookingOwnershipCategory category) {
    if (totalCount == 0) return 0;
    return (countFor(category) / totalCount) * 100;
  }
}

Future<BookingOwnershipInventoryResult> measureBookingOwnershipCollection({
  required String collectionName,
  FirebaseFirestore? firestore,
}) async {
  final db = firestore ?? FirebaseFirestore.instance;
  final snapshot = await db.collection(collectionName).get();

  final counts = <BookingOwnershipCategory, int>{
    BookingOwnershipCategory.fullyNormalized: 0,
    BookingOwnershipCategory.legacyOnly: 0,
    BookingOwnershipCategory.canonicalOnly: 0,
    BookingOwnershipCategory.unassigned: 0,
  };

  for (final doc in snapshot.docs) {
    final data = doc.data();
    final assignedClinicianId =
        (data['assignedClinicianId'] ?? '').toString().trim();
    final clinicianUid = (data['clinicianUid'] ?? '').toString().trim();

    final hasCanonical = assignedClinicianId.isNotEmpty;
    final hasLegacy = clinicianUid.isNotEmpty;

    final category = switch ((hasCanonical, hasLegacy)) {
      (true, true) => BookingOwnershipCategory.fullyNormalized,
      (false, true) => BookingOwnershipCategory.legacyOnly,
      (true, false) => BookingOwnershipCategory.canonicalOnly,
      (false, false) => BookingOwnershipCategory.unassigned,
    };

    counts[category] = (counts[category] ?? 0) + 1;
  }

  return BookingOwnershipInventoryResult(
    collectionName: collectionName,
    totalCount: snapshot.docs.length,
    categoryCounts: counts,
  );
}

Future<List<BookingOwnershipInventoryResult>> measureBookingOwnershipInventory({
  FirebaseFirestore? firestore,
  bool includeLegacyCollection = true,
}) async {
  final db = firestore ?? FirebaseFirestore.instance;
  final results = <BookingOwnershipInventoryResult>[
    await measureBookingOwnershipCollection(
      collectionName: _canonicalBookingCollection,
      firestore: db,
    ),
  ];

  if (includeLegacyCollection) {
    results.add(
      await measureBookingOwnershipCollection(
        collectionName: _legacyBookingCollection,
        firestore: db,
      ),
    );
  }

  return results;
}

String formatBookingOwnershipInventoryReport(
  List<BookingOwnershipInventoryResult> results,
) {
  final buffer = StringBuffer();
  buffer.writeln('BOOKING OWNERSHIP INVENTORY');
  buffer.writeln('========================================');

  for (final result in results) {
    buffer.writeln('Collection: ${result.collectionName}');
    buffer.writeln('Total: ${result.totalCount}');
    buffer.writeln(
      'A) Fully normalized: ${result.countFor(BookingOwnershipCategory.fullyNormalized)} '
      '(${result.percentageFor(BookingOwnershipCategory.fullyNormalized).toStringAsFixed(1)}%)',
    );
    buffer.writeln(
      'B) Legacy-only: ${result.countFor(BookingOwnershipCategory.legacyOnly)} '
      '(${result.percentageFor(BookingOwnershipCategory.legacyOnly).toStringAsFixed(1)}%)',
    );
    buffer.writeln(
      'C) Canonical-only: ${result.countFor(BookingOwnershipCategory.canonicalOnly)} '
      '(${result.percentageFor(BookingOwnershipCategory.canonicalOnly).toStringAsFixed(1)}%)',
    );
    buffer.writeln(
      'D) Unassigned: ${result.countFor(BookingOwnershipCategory.unassigned)} '
      '(${result.percentageFor(BookingOwnershipCategory.unassigned).toStringAsFixed(1)}%)',
    );
    buffer.writeln('----------------------------------------');
  }

  return buffer.toString().trimRight();
}

Future<void> printBookingOwnershipInventory({
  FirebaseFirestore? firestore,
  bool includeLegacyCollection = true,
}) async {
  final results = await measureBookingOwnershipInventory(
    firestore: firestore,
    includeLegacyCollection: includeLegacyCollection,
  );

  debugPrint(formatBookingOwnershipInventoryReport(results));
}

/// Temporary debug-only entry point for manual measurement.
Future<void> printBookingOwnershipInventoryDebug() async {
  await printBookingOwnershipInventory();
}
