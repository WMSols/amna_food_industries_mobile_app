import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/icons/app_icons.dart';
import 'package:amna_food_industries_mobile_app/core/design/images/app_images.dart';
import 'package:amna_food_industries_mobile_app/core/design/responsive/app_responsive.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/text_styles/app_text_styles.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/utils/formatter/app_formatter.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/cards/app_outline_card.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/chips/app_status_chip.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_empty_state.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_network_signal_bars.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/layout/app_dashboard_greeting.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/layout/app_scaffold.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/layout/app_section_header.dart';
import 'package:amna_food_industries_mobile_app/order_booker/controllers/dashboard/ob_dashboard_controller.dart';

class ObDashboardScreen extends GetView<ObDashboardController> {
  const ObDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: AppSpacing.screenPadding(context),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppTexts.dashboard,
                    style: AppTextStyles.headline(context),
                  ),
                ),
                const AppNetworkSignalBars(),
                AppSpacing.horizontal(context, 0.02),
                IconButton(
                  onPressed: controller.logout,
                  icon: Icon(
                    AppIcons.logout,
                    color: AppColors.primary,
                    size: AppResponsive.iconSize(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView(
                padding: AppSpacing.screenPadding(context),
                children: [
                  AppDashboardGreeting(
                    greeting: controller.greeting,
                    userName: controller.userName,
                  ),
                  AppSpacing.vertical(context, 0.02),
                  _CreateOrderCard(onTap: controller.goToCreateSalesOrder),
                  AppSpacing.vertical(context, 0.02),
                  AppSectionHeader(title: AppTexts.recentOrders),
                  if (controller.recentOrders.isEmpty)
                    AppEmptyState(
                      title: AppTexts.emptyNoOrdersTitle,
                      subtitle: AppTexts.noRecentOrders,
                      image: AppImages.emptyNoOrders,
                    )
                  else
                    ...controller.recentOrders.map(
                      (order) => Padding(
                        padding: EdgeInsets.only(
                          bottom: AppSpacing.verticalValue(context, 0.012),
                        ),
                        child: AppOutlineCard(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.customerName,
                                      style: AppTextStyles.bodyText(context)
                                          .copyWith(fontWeight: FontWeight.w700),
                                    ),
                                    AppSpacing.vertical(context, 0.004),
                                    Text(
                                      AppFormatter.currencyWhole(order.total),
                                      style: AppTextStyles.caption(context),
                                    ),
                                  ],
                                ),
                              ),
                              AppStatusChip.order(order.status),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateOrderCard extends StatelessWidget {
  const _CreateOrderCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Padding(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          child: Row(
            children: [
              Icon(
                AppIcons.add,
                color: AppColors.white,
                size: AppResponsive.iconSize(context),
              ),
              AppSpacing.horizontal(context, 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.createSalesOrder,
                      style: AppTextStyles.bodyText(context).copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.003),
                    Text(
                      AppTexts.createSalesOrderSubtitle,
                      style: AppTextStyles.caption(context).copyWith(
                        color: AppColors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                AppIcons.arrowRight,
                color: AppColors.white,
                size: AppResponsive.iconSize(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
