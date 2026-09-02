import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/bindings/auth/auth_binding.dart';
import 'package:amna_food_industries_mobile_app/common/bindings/splash/splash_binding.dart';
import 'package:amna_food_industries_mobile_app/common/views/auth/login_screen.dart';
import 'package:amna_food_industries_mobile_app/common/views/splash/splash_screen.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';

class CommonRoutes {
  CommonRoutes._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
  ];
}
