import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/controllers/auth/auth_controller.dart';
import 'package:amna_food_industries_mobile_app/common/services/auth/auth_service.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_client.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/storage_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthService>()) {
      Get.put(
        AuthService(
          Get.find<ApiClient>(),
          Get.find<StorageService>(),
          Get.find<SessionService>(),
        ),
        permanent: true,
      );
    }
    Get.lazyPut(
      () => AuthController(Get.find<AuthService>(), Get.find<StorageService>()),
    );
  }
}
