import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_exception.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';
import 'package:amna_food_industries_mobile_app/core/widgets/feedback/app_toast.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/customer_model.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/product_model.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/sales_order_draft.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/sales_order_line_model.dart';
import 'package:amna_food_industries_mobile_app/order_booker/services/sales_order/sales_order_service.dart';

class SalesOrderController extends GetxController {
  SalesOrderController(this._service);

  final SalesOrderService _service;
  final formKey = GlobalKey<FormState>();

  final quantityController = TextEditingController(text: '1');
  final unitPriceController = TextEditingController();
  final notesController = TextEditingController();

  final RxBool isLoadingCatalog = true.obs;
  final RxBool isSubmitting = false.obs;
  final RxnString loadError = RxnString();

  final RxList<CustomerModel> customers = <CustomerModel>[].obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final Rxn<CustomerModel> selectedCustomer = Rxn<CustomerModel>();
  final Rxn<ProductModel> selectedProduct = Rxn<ProductModel>();

  final RxDouble orderTotal = 0.0.obs;

  bool _priceManuallyEdited = false;

  @override
  void onInit() {
    super.onInit();
    unitPriceController.addListener(_onUnitPriceEdited);
    quantityController.addListener(_recalculateTotal);
    unitPriceController.addListener(_recalculateTotal);
    _recalculateTotal();
    loadCatalog();
  }

  @override
  void onClose() {
    unitPriceController.removeListener(_onUnitPriceEdited);
    quantityController.dispose();
    unitPriceController.dispose();
    notesController.dispose();
    super.onClose();
  }

  void _onUnitPriceEdited() {
    _priceManuallyEdited = true;
    _recalculateTotal();
  }

  void _recalculateTotal() {
    final qty = int.tryParse(quantityController.text.trim()) ?? 0;
    final price = double.tryParse(unitPriceController.text.trim()) ?? 0;
    orderTotal.value = qty * price;
  }

  Future<void> loadCatalog() async {
    isLoadingCatalog.value = true;
    loadError.value = null;
    try {
      final results = await Future.wait([
        _service.fetchCustomers(),
        _service.fetchProducts(),
      ]);
      customers.assignAll(results[0] as List<CustomerModel>);
      products.assignAll(results[1] as List<ProductModel>);
    } on ApiException catch (e) {
      loadError.value = e.message;
    } catch (_) {
      loadError.value = AppTexts.emptyLoadFailedTitle;
    } finally {
      isLoadingCatalog.value = false;
    }
  }

  void onCustomerChanged(CustomerModel? customer) {
    selectedCustomer.value = customer;
  }

  void onProductChanged(ProductModel? product) {
    selectedProduct.value = product;
    if (product == null) return;
    if (!_priceManuallyEdited || unitPriceController.text.trim().isEmpty) {
      unitPriceController.text = _formatPrice(product.unitPrice);
      _priceManuallyEdited = false;
    }
  }

  String? validateCustomer(CustomerModel? value) {
    if (value == null) return AppTexts.fieldRequired;
    return null;
  }

  String? validateProduct(ProductModel? value) {
    if (value == null) return AppTexts.fieldRequired;
    return null;
  }

  String? validateQuantity(String? value) {
    final qty = int.tryParse(value?.trim() ?? '');
    if (qty == null || qty <= 0) return AppTexts.invalidQuantity;
    return null;
  }

  String? validateUnitPrice(String? value) {
    final price = double.tryParse(value?.trim() ?? '');
    if (price == null || price < 0) return AppTexts.invalidUnitPrice;
    return null;
  }

  Future<void> submitOrder() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final customer = selectedCustomer.value;
    final product = selectedProduct.value;
    if (customer == null || product == null) return;

    final quantity = int.parse(quantityController.text.trim());
    final unitPrice = double.parse(unitPriceController.text.trim());

    isSubmitting.value = true;
    try {
      final draft = SalesOrderDraft(
        customer: customer,
        lines: [
          SalesOrderLineModel(
            productId: product.id,
            productName: product.name,
            quantity: quantity,
            unitPrice: unitPrice,
          ),
        ],
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
      );

      await _service.submitOrder(draft);
      AppToast.showSuccess(AppTexts.orderSubmitted);
      Get.until((route) => route.settings.name == AppRoutes.dashboard);
    } on ApiException catch (e) {
      AppToast.showError(e.message);
    } catch (_) {
      AppToast.showError(AppTexts.orderSubmitFailed);
    } finally {
      isSubmitting.value = false;
    }
  }

  String _formatPrice(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }
}
