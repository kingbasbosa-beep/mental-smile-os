import 'package:flutterprojects/shared/contracts/state_brain/clinician_state_translation.dart';

const List<String> kSampleRawStates = [
  'assigned_clinician',
  'awaiting_payment',
  'clinician_rejected',
  'forwarded_to_clinician',
  'clinician_review',
  'resolved',
  'pending_clinician',
  'accepted',
  'approved',
  'rejected',
  'open',
  'rejected_admin',
  'unexpected_state',
];

const Set<String> kLockedInventoryStates = {
  'assigned_clinician',
  'awaiting_payment',
  'clinician_rejected',
  'forwarded_to_clinician',
  'clinician_review',
  'resolved',
  'pending_clinician',
  'accepted',
  'approved',
  'rejected',
  'open',
  'rejected_admin',
};

class ComparisonRow {
  final String rawState;
  final ClinicianStateTranslation translation;
  final String classification;
  final List<String> mismatchCategories;

  const ComparisonRow({
    required this.rawState,
    required this.translation,
    required this.classification,
    required this.mismatchCategories,
  });
}

void main() {
  final rows = kSampleRawStates.map(_compareState).toList();
  final missingInventoryStates =
      kLockedInventoryStates.difference(kSampleRawStates.toSet()).toList()
        ..sort();

  for (final row in rows) {
    print('rawState: ${row.rawState}');
    print('classification: ${row.classification}');
    print('progress: ${row.translation.progress}');
    print('ownership: ${row.translation.ownership ?? 'null'}');
    print(
      'operationalSignal: ${row.translation.operationalSignal ?? 'null'}',
    );
    print('ambiguity: ${row.translation.ambiguity ?? 'null'}');
    print(
      'mismatchCategories: '
      '${row.mismatchCategories.isEmpty ? 'none' : row.mismatchCategories.join(', ')}',
    );
    print('');
  }

  print('summary:');
  print('translated=${rows.where((row) => row.classification == 'translated').length}');
  print('ambiguous=${rows.where((row) => row.classification == 'ambiguous').length}');
  print('unknown=${rows.where((row) => row.classification == 'unknown').length}');
  print(
    'missingInventoryStates='
    '${missingInventoryStates.isEmpty ? 'none' : missingInventoryStates.join(', ')}',
  );
}

ComparisonRow _compareState(String rawState) {
  final translation = translateClinicianState(rawState);
  final mismatchCategories = <String>[];

  final classification = _classify(translation);

  if (!kLockedInventoryStates.contains(rawState)) {
    mismatchCategories.add('raw_state_outside_locked_inventory');
  }

  if (classification == 'unknown') {
    mismatchCategories.add('unknown_raw_state');
  }

  if (classification == 'ambiguous') {
    mismatchCategories.add('ambiguous_translation');
  }

  if (classification != 'unknown' &&
      (translation.ownership == null ||
          translation.operationalSignal == null)) {
    mismatchCategories.add('translator_output_missing_expected_fields');
  }

  if (_isMixedDomain(translation.ownership)) {
    mismatchCategories.add('mixed_domain_state_visible_in_clinician_flow');
  }

  if (_isLegacy(rawState)) {
    mismatchCategories.add('legacy_state_present_in_sample');
  }

  return ComparisonRow(
    rawState: rawState,
    translation: translation,
    classification: classification,
    mismatchCategories: mismatchCategories,
  );
}

String _classify(ClinicianStateTranslation translation) {
  if (translation.progress == 'unknown') {
    return 'unknown';
  }

  if (translation.ambiguity != null && translation.ambiguity!.trim().isNotEmpty) {
    return 'ambiguous';
  }

  return 'translated';
}

bool _isMixedDomain(String? ownership) {
  return ownership == 'mixed' ||
      ownership == 'non-clinician' ||
      ownership == 'non-clinician primary' ||
      ownership == 'non-clinician or mixed';
}

bool _isLegacy(String rawState) {
  return rawState == 'pending_clinician' ||
      rawState == 'accepted' ||
      rawState == 'approved' ||
      rawState == 'rejected';
}
