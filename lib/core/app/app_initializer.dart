import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/design/system/app_system_ui.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_client.dart';
import 'package:amna_food_industries_mobile_app/core/services/connectivity_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/location_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/storage_service.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> setup() async {
    await AppSystemUi.apply();
    await _loadEnv();

    final storage = StorageService();
    Get.put(storage, permanent: true);

    final sessionService = SessionService(storage);
    try {
      await sessionService.init();
    } catch (error, stackTrace) {
      debugPrint('Session restore failed: $error\n$stackTrace');
    }
    Get.put(sessionService, permanent: true);

    Get.put(ApiClient(storage, sessionService), permanent: true);

    final connectivity = ConnectivityService();
    Get.put(connectivity, permanent: true);
    await connectivity.init();

    final location = LocationService();
    Get.put(location, permanent: true);
    await location.init();
  }

  static Future<void> _loadEnv() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (error, stackTrace) {
      debugPrint('Env load skipped: $error\n$stackTrace');
    }
  }
}
