import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/models/account/user_model.dart';
import 'package:amna_food_industries_mobile_app/core/constants/api_endpoints.dart';
import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_client.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_exception.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/storage_service.dart';

class AuthService extends GetxService {
  AuthService(this._api, this._storage, this._session);

  final ApiClient _api;
  final StorageService _storage;
  final SessionService _session;

  static const _mockTokenPrefix = 'mock-token-';

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    const role = UserRole.orderBooker;

    if (!_api.hasBaseUrl) {
      return _loginMock(username: username, role: role);
    }

    final database = _api.odooDatabase.trim();
    if (database.isEmpty) {
      throw ApiException(message: 'Missing database name (db).');
    }

    final login = username.trim();
    final data = await _api.postData(
      ApiEndpoints.authLogin,
      data: {'db': database, 'login': login, 'password': password},
    );

    final sessionId = data['session_id']?.toString() ?? '';
    if (sessionId.isEmpty) {
      throw ApiException(
        message: 'Login succeeded but no session_id was returned.',
      );
    }

    final user = UserModel(
      id: data['uid']?.toString() ?? '',
      name: data['name']?.toString().trim() ?? '',
      email: login,
      role: role,
      presenceStatus: PresenceStatus.online,
    ).withResolvedName();

    await _storage.saveToken(sessionId);
    await _storage.saveRole(role.name);
    await _session.setSession(userModel: user, userRole: role);
    return user;
  }

  Future<UserModel> _loginMock({
    required String username,
    required UserRole role,
  }) async {
    final trimmed = username.trim();
    final display = trimmed.isEmpty
        ? AppTextsFallback.defaultUserName
        : trimmed;

    final user = UserModel(
      id: 'mock-${role.name}',
      name: display,
      email: '$trimmed@amna.local',
      role: role,
      presenceStatus: PresenceStatus.online,
    ).withResolvedName();

    await _storage.saveToken('$_mockTokenPrefix${role.name}');
    await _storage.saveRole(role.name);
    await _session.setSession(userModel: user, userRole: role);
    return user;
  }

  Future<void> logout() async {
    await _session.clearSession();
  }
}

/// Avoids importing [AppTexts] in the service layer for mock fallback name.
class AppTextsFallback {
  AppTextsFallback._();
  static const defaultUserName = 'Order Booker';
}
