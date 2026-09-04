import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/design/colors/app_colors.dart';
import 'package:amna_food_industries_mobile_app/core/design/icons/app_icons.dart';
import 'package:amna_food_industries_mobile_app/core/design/images/app_images.dart';
import 'package:amna_food_industries_mobile_app/core/design/spacing/app_spacing.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/buttons/app_primary_button.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/cards/app_amount_summary_bar.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_empty_state.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_shimmer_skeletons.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/form/app_dropdown_field.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/form/app_form_section_header.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/form/app_text_field.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/layout/app_sub_screen_scaffold.dart';
import 'package:amna_food_industries_mobile_app/order_booker/controllers/sales_order/sales_order_controller.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/customer_model.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/product_model.dart';

class SalesOrderFormScreen extends GetView<SalesOrderController> {
  const SalesOrderFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSubScreenScaffold(
      title: AppTexts.salesOrderFormTitle,
      body: Obx(() {
        if (controller.isLoadingCatalog.value) {
          return AppShimmerSkeletons.genericList(context, count: 6);
        }

        if (controller.loadError.value != null) {
          return AppEmptyState(
            title: AppTexts.emptyLoadFailedTitle,
            subtitle: controller.loadError.value!,
            image: AppImages.emptyError,
            onRefresh: controller.loadCatalog,
          );
        }

        return Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: AppSpacing.screenPadding(context),
                  children: [
                    AppFormSectionHeader(
                      icon: AppIcons.orders,
                      title: AppTexts.orderDetails,
                    ),
                    AppSpacing.vertical(context, 0.012),
                    Obx(
                      () => AppDropdownField<CustomerModel>(
                        label: AppTexts.customer,
                        hint: AppTexts.selectCustomer,
                        required: true,
                        prefixIcon: AppIcons.person,
                        value: controller.selectedCustomer.value,
                        items: controller.customers,
                        getLabel: (customer) => customer.name,
                        onChanged: controller.onCustomerChanged,
                        validator: controller.validateCustomer,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.016),
                    Obx(
                      () => AppDropdownField<ProductModel>(
                        label: AppTexts.product,
                        hint: AppTexts.selectProduct,
                        required: true,
                        prefixIcon: AppIcons.product,
                        value: controller.selectedProduct.value,
                        items: controller.products,
                        getLabel: (product) => product.name,
                        onChanged: controller.onProductChanged,
                        validator: controller.validateProduct,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.016),
                    AppTextField(
                      controller: controller.quantityController,
                      label: AppTexts.quantity,
                      hint: AppTexts.quantityHint,
                      required: true,
                      prefixIcon: AppIcons.quantity,
                      keyboardType: TextInputType.number,
                      validator: controller.validateQuantity,
                    ),
                    AppSpacing.vertical(context, 0.016),
                    AppTextField(
                      controller: controller.unitPriceController,
                      label: AppTexts.unitPrice,
                      hint: AppTexts.unitPriceHint,
                      required: true,
                      prefixIcon: AppIcons.money,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: controller.validateUnitPrice,
                    ),
                    AppSpacing.vertical(context, 0.016),
                    AppTextField(
                      controller: controller.notesController,
                      label: AppTexts.notes,
                      hint: AppTexts.notesHint,
                      prefixIcon: AppIcons.note,
                      maxLines: 3,
                    ),
                    if (controller.products.isEmpty) ...[
                      AppSpacing.vertical(context, 0.02),
                      AppEmptyState(
                        title: AppTexts.emptyNoProductsTitle,
                        subtitle: AppTexts.loadingProducts,
                        image: AppImages.emptyNoProducts,
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: AppSpacing.screenPadding(context),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(top: BorderSide(color: AppColors.cardBorder)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(
                      () => AppAmountSummaryBar(
                        label: AppTexts.orderTotal,
                        amount: controller.orderTotal.value,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.012),
                    Obx(
                      () => AppPrimaryButton(
                        label: AppTexts.submitOrder,
                        isLoading: controller.isSubmitting.value,
                        onPressed: controller.submitOrder,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
