import 'package:flutter/services.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';

class AppSystemUi {
  AppSystemUi._();

  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    statusBarColor: AppColors.primary,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.secondary,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: AppColors.secondary,
  );

  static Future<void> apply() async {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  }
}
