import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/icons/app_icons.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/buttons/app_edge_icon_button.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_loader.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/layout/app_profile_avatar.dart';
import 'package:amna_food_industries_mobile_app/order_booker/controllers/dashboard/ob_dashboard_controller.dart';
import 'package:amna_food_industries_mobile_app/order_booker/views/dashboard/ob_dashboard_screen.dart';

/// Home chrome for order booker — owns the AppBar like Shahtaj [AppShell].
/// Tab content lives in [ObDashboardScreen] via [AppScaffold] (body only).
class ObHomeShell extends GetView<ObDashboardController> {
  const ObHomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: AppResponsive.scaleSize(context, 64),
        actionsPadding: EdgeInsets.zero,
        leading: Obx(
          () => Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.horizontalValue(context, 0.03),
            ),
            child: Center(
              child: AppProfileAvatar(
                name: controller.userName,
                size: 40,
                onPrimary: true,
                showPresenceDot: true,
                presenceStatus: controller.presenceStatus,
              ),
            ),
          ),
        ),
        title: Text(
          AppTexts.dashboard,
          style: AppTextStyles.heading(
            context,
          ).copyWith(color: AppColors.white),
        ),
        actions: [
          Obx(
            () => AppEdgeIconButton(
              icon: AppIcons.logout,
              onTap: controller.isLoggingOut.value ? null : controller.logout,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoggingOut.value) {
          return const ColoredBox(
            color: AppColors.scaffoldBackground,
            child: AppLoader(),
          );
        }
        return const ObDashboardScreen();
      }),
    );
  }
}
