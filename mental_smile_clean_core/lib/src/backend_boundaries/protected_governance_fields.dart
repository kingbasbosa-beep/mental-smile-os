import 'server_owned_fields.dart';

class ProtectedGovernanceFields {
  const ProtectedGovernanceFields._();

  static const Set<String> directClientWriteDenied = ServerOwnedFields.all;

  static bool isProtected(String fieldName) {
    return directClientWriteDenied.contains(fieldName.trim());
  }

  static List<String> protectedIn(Iterable<String> fieldNames) {
    return fieldNames
        .where((fieldName) => isProtected(fieldName))
        .toList(growable: false);
  }
}
