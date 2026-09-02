import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/services/auth/auth_service.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_client.dart';
import 'package:amna_food_industries_mobile_app/core/services/connectivity_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/location_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<StorageService>()) {
      Get.put(StorageService(), permanent: true);
    }
    if (!Get.isRegistered<SessionService>()) {
      Get.put(SessionService(Get.find<StorageService>()), permanent: true);
    }
    if (!Get.isRegistered<ConnectivityService>()) {
      final connectivity = ConnectivityService();
      Get.put<ConnectivityService>(connectivity, permanent: true);
      connectivity.init();
    }
    if (!Get.isRegistered<LocationService>()) {
      final location = LocationService();
      Get.put<LocationService>(location, permanent: true);
      location.init();
    }
    if (!Get.isRegistered<ApiClient>()) {
      Get.put<ApiClient>(
        ApiClient(Get.find<StorageService>(), Get.find<SessionService>()),
        permanent: true,
      );
    }
    if (!Get.isRegistered<AuthService>()) {
      Get.put<AuthService>(
        AuthService(
          Get.find<ApiClient>(),
          Get.find<StorageService>(),
          Get.find<SessionService>(),
        ),
        permanent: true,
      );
    }
  }
}
