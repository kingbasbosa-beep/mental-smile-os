import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_smile_os/core/auth/account_access_service.dart';
import 'package:mental_smile_os/shared/contracts/role_names.dart';

class RoleAccessGateway {
  RoleAccessGateway({AccountAccessService? accessService})
      : _accessService = accessService ?? AccountAccessService();

  final AccountAccessService _accessService;

  Future<bool> isOwner() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.role == RoleNames.owner;
  }

  Future<bool> isMonitoringOperator() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.role == RoleNames.monitoringOperator;
  }

  Future<bool> isRegistrySteward() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.role == RoleNames.registrySteward;
  }

  Future<bool> isDeclarationReviewer() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.role == RoleNames.declarationReviewer;
  }

  Future<bool> isSupportObserver() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.role == RoleNames.supportObserver;
  }

  Future<bool> isClient() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.role == RoleNames.client;
  }

  Future<bool> isCenter() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.role == RoleNames.center;
  }

  Future<bool> isClinician() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.role == RoleNames.clinician;
  }
}
