import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/controllers/auth/auth_controller.dart';
import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/images/app_images.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';

class AuthHeaderSection extends GetView<AuthController> {
  const AuthHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final logoWidth = AppResponsive.screenWidth(context) * 0.55;

    return Padding(
      padding: AppSpacing.screenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.appLogo, width: logoWidth, fit: BoxFit.contain),
          AppSpacing.vertical(context, 0.04),
          Text(
            AppTexts.signIn,
            style: AppTextStyles.heading(
              context,
            ).copyWith(color: AppColors.textPrimary),
          ),
          AppSpacing.vertical(context, 0.005),
          Text(
            AppTexts.authWelcomeSubtitle,
            style: AppTextStyles.bodyText(
              context,
            ).copyWith(color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
