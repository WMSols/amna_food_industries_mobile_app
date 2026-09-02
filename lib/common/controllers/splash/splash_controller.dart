import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/storage_service.dart';

class SplashController extends GetxController {
  SplashController(this._session, this._storage);

  final SessionService _session;
  final StorageService _storage;

  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final token = await _storage.getToken();
      if (token != null && token.isNotEmpty && _session.role.value != null) {
        Get.offAllNamed(AppRoutes.dashboard);
        return;
      }

      Get.offAllNamed(AppRoutes.login);
    } catch (error, stackTrace) {
      debugPrint('Splash bootstrap failed: $error\n$stackTrace');
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
