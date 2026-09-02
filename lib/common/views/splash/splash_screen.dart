import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/controllers/splash/splash_controller.dart';
import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/images/app_images.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logoWidth = AppResponsive.screenWidth(context) * 0.55;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          AppImages.appLogo,
          width: logoWidth,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
