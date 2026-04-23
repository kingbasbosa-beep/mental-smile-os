import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/shared/contracts/role_names.dart';

class RoleAccessGateway {
  RoleAccessGateway({AccountAccessService? accessService})
      : _accessService = accessService ?? AccountAccessService();

  final AccountAccessService _accessService;

  Future<bool> isAdmin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final access = await _accessService.resolve(user);
    return access.isAdmin;
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
