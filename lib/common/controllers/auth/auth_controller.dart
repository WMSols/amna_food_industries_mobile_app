import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/services/auth/auth_service.dart';
import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_exception.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';
import 'package:amna_food_industries_mobile_app/core/services/storage_service.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_toast.dart';

class AuthController extends GetxController {
  AuthController(this._authService, this._storage);

  final AuthService _authService;
  final StorageService _storage;

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool rememberMe = false.obs;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  static const _role = UserRole.orderBooker;

  @override
  void onInit() {
    super.onInit();
    _restoreRememberedCredentials();
  }

  @override
  void onClose() {
    final username = usernameController;
    final password = passwordController;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      username.dispose();
      password.dispose();
    });
    super.onClose();
  }

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void setRememberMe(bool value) => rememberMe.value = value;

  Future<void> _restoreRememberedCredentials() async {
    final enabled = await _storage.isRememberMeEnabled(_role);
    if (isClosed) return;
    rememberMe.value = enabled;
    if (!enabled) return;

    final login = await _storage.getRememberedLogin(_role);
    final password = await _storage.getRememberedPassword(_role);
    if (isClosed) return;
    if (login != null && login.isNotEmpty) {
      usernameController.text = login;
    }
    if (password != null && password.isNotEmpty) {
      passwordController.text = password;
    }
  }

  Future<void> _persistRememberMe({
    required String login,
    required String password,
  }) async {
    if (rememberMe.value) {
      await _storage.saveRememberedCredentials(
        role: _role,
        login: login,
        password: password,
      );
    } else {
      await _storage.clearRememberedCredentials(_role);
    }
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      AppToast.showError(AppTexts.loginCredentialsRequired);
      return;
    }

    isLoading.value = true;
    try {
      await _authService.login(username: username, password: password);
      await _persistRememberMe(login: username, password: password);
      if (isClosed) return;
      AppToast.showSuccess(AppTexts.loginSuccessful);
      Get.offAllNamed(AppRoutes.dashboard);
      return;
    } on ApiException catch (e) {
      if (!isClosed) AppToast.showError(e.message);
    } catch (_) {
      if (!isClosed) AppToast.showError(AppTexts.loginFailed);
    } finally {
      if (!isClosed) isLoading.value = false;
    }
  }
}
