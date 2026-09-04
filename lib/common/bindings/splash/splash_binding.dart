import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/controllers/splash/splash_controller.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/storage_service.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Must Get.put (not lazyPut): SplashScreen never reads `controller`, so a
    // lazy instance would never be created and bootstrap would never run.
    Get.put(
      SplashController(Get.find<SessionService>(), Get.find<StorageService>()),
    );
  }
}
