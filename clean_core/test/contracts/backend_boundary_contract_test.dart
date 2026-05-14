import 'package:flutter_test/flutter_test.dart';
import 'package:flutterprojects/core/backend_boundaries/backend_governed_action.dart';
import 'package:flutterprojects/core/backend_boundaries/cloud_function_boundary.dart';
import 'package:flutterprojects/core/backend_boundaries/protected_governance_fields.dart';
import 'package:flutterprojects/core/backend_boundaries/trusted_operation_type.dart';

import '../emulator/protected_field_fixture.dart';

void main() {
  group('Backend boundaries', () {
    test('detect protected governance fields in client payloads', () {
      final protected = ProtectedGovernanceFields.protectedIn(
        ProtectedFieldFixture.protectedClientPayload.keys,
      );

      expect(
        protected.toSet(),
        containsAll(ProtectedFieldFixture.expectedProtectedFields),
      );
    });

    test('marks backend-governed action as unsafe for protected client writes', () {
      final contract = CloudFunctionBoundary.contractFor(
        TrustedOperationType.bookingOrchestration,
      );
      final action = BackendGovernedAction(
        contract: contract,
        payloadPreview: ProtectedFieldFixture.protectedClientPayload,
        clientWritableFields: const {'clientId', 'note'},
      );

      expect(action.containsProtectedClientWrites, isTrue);
      expect(contract.requiresAuditTrail, isTrue);
    });
  });
}
