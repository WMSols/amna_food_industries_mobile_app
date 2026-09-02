import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/constants/api_endpoints.dart';
import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/core/mock/app_mock_data.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_client.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_map.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/customer_model.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/product_model.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/sales_order_draft.dart';

class SalesOrderService extends GetxService {
  SalesOrderService(this._api);

  final ApiClient _api;
  final RxList<SalesOrderSummary> recentOrders = <SalesOrderSummary>[].obs;

  Future<List<CustomerModel>> fetchCustomers() async {
    if (!_api.hasBaseUrl) {
      await Future.delayed(const Duration(milliseconds: 400));
      return AppMockData.customers;
    }

    final data = await _api.postData(ApiEndpoints.customersList);
    return ApiMap.listOf(data, 'customers')
        .map(CustomerModel.fromJson)
        .where((customer) => customer.id.isNotEmpty && customer.name.isNotEmpty)
        .toList(growable: false);
  }

  Future<List<ProductModel>> fetchProducts() async {
    if (!_api.hasBaseUrl) {
      await Future.delayed(const Duration(milliseconds: 400));
      return AppMockData.products;
    }

    final data = await _api.postData(ApiEndpoints.productsList);
    return ApiMap.listOf(data, 'products')
        .map(ProductModel.fromJson)
        .where((product) => product.id.isNotEmpty && product.name.isNotEmpty)
        .toList(growable: false);
  }

  Future<SalesOrderSummary> submitOrder(SalesOrderDraft draft) async {
    if (!_api.hasBaseUrl) {
      await Future.delayed(const Duration(milliseconds: 600));
      final summary = SalesOrderSummary(
        id: 'mock-${DateTime.now().millisecondsSinceEpoch}',
        customerName: draft.customer.name,
        total: draft.total,
        status: OrderStatus.submitted,
        createdAt: DateTime.now(),
      );
      recentOrders.insert(0, summary);
      return summary;
    }

    final data = await _api.postData(
      ApiEndpoints.salesOrdersCreate,
      data: draft.toJson(),
    );

    final summary = SalesOrderSummary(
      id: (data['id'] ?? data['order_id'])?.toString() ?? '',
      customerName: draft.customer.name,
      total: ApiMap.asDouble(data['total']) ?? draft.total,
      status: OrderStatus.submitted,
      createdAt: DateTime.now(),
    );
    recentOrders.insert(0, summary);
    return summary;
  }
}
