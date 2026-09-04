import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/design/icons/app_icons.dart';
import 'package:amna_food_industries_mobile_app/core/design/images/app_images.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/buttons/app_primary_button.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_empty_state.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_line_loader.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_shimmer_skeletons.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/layout/app_dashboard_greeting.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/layout/app_scaffold.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/layout/app_section_header.dart';
import 'package:amna_food_industries_mobile_app/order_booker/controllers/dashboard/ob_dashboard_controller.dart';
import 'package:amna_food_industries_mobile_app/order_booker/widgets/dashboard/ob_recent_order_card.dart';

/// Dashboard body — lives under [ObHomeShell] AppBar.
class ObDashboardScreen extends GetView<ObDashboardController> {
  const ObDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      header: Obx(
        () => AppDashboardGreeting(
          greeting: controller.greeting,
          userName: controller.userName,
          onPrimary: true,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.recentOrders.isEmpty) {
          return AppShimmerSkeletons.dashboard(context);
        }

        if (controller.error.value != null && controller.recentOrders.isEmpty) {
          return AppEmptyState(
            title: AppTexts.emptyLoadFailedTitle,
            subtitle: controller.error.value!,
            image: AppImages.emptyError,
            onRefresh: () => controller.loadRecentOrders(force: true),
          );
        }

        final content = RefreshIndicator(
          onRefresh: () => controller.loadRecentOrders(force: true),
          child: ListView(
            padding: AppSpacing.screenPadding(context),
            children: [
              AppPrimaryButton(
                label: AppTexts.createSalesOrder,
                icon: AppIcons.add,
                onPressed: controller.goToCreateSalesOrder,
              ),
              AppSpacing.vertical(context, 0.02),
              AppSectionHeader(title: AppTexts.recentOrders),
              if (controller.recentOrders.isEmpty)
                AppEmptyState(
                  title: AppTexts.emptyNoOrdersTitle,
                  subtitle: AppTexts.noRecentOrders,
                  image: AppImages.emptyNoOrders,
                )
              else
                for (final order in controller.recentOrders) ...[
                  ObRecentOrderCard(order: order),
                  AppSpacing.vertical(context, 0.01),
                ],
            ],
          ),
        );

        return AppLineLoader.overlay(
          loading: controller.isLoading.value,
          child: content,
        );
      }),
    );
  }
}
