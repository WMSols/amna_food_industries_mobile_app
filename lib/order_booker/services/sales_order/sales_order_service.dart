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

    final data = await _api.getData(ApiEndpoints.customersList);
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

    final data = await _api.getData(ApiEndpoints.productsList);
    return ApiMap.listOf(data, 'products')
        .map(ProductModel.fromJson)
        .where((product) => product.id.isNotEmpty && product.name.isNotEmpty)
        .toList(growable: false);
  }

  Future<List<SalesOrderSummary>> fetchMyOrders() async {
    if (!_api.hasBaseUrl) {
      return List<SalesOrderSummary>.from(recentOrders);
    }

    final data = await _api.getData(ApiEndpoints.salesOrdersMyOrders);
    final orders = ApiMap.listOf(data, 'orders')
        .map(SalesOrderSummary.fromJson)
        .where((order) => order.id.isNotEmpty)
        .toList(growable: false);
    recentOrders.assignAll(orders);
    return orders;
  }

  Future<SalesOrderSummary> submitOrder(SalesOrderDraft draft) async {
    if (!_api.hasBaseUrl) {
      await Future.delayed(const Duration(milliseconds: 600));
      final summary = SalesOrderSummary(
        id: 'mock-${DateTime.now().millisecondsSinceEpoch}',
        orderName: 'SO-MOCK',
        customerName: draft.customer.name,
        total: draft.total,
        status: OrderStatus.submitted,
        createdAt: DateTime.now(),
        note: draft.notes,
        clientOrderRef: 'MOBILE',
      );
      recentOrders.insert(0, summary);
      return summary;
    }

    final data = await _api.postData(
      ApiEndpoints.salesOrdersCreate,
      data: draft.toJson(),
    );

    final summary = SalesOrderSummary(
      id: (data['order_id'] ?? data['id'])?.toString() ?? '',
      orderName: (data['order_name'] ?? data['name'])?.toString().trim() ?? '',
      customerName: (data['partner_name'] ?? draft.customer.name)
          .toString()
          .trim(),
      total:
          ApiMap.asDouble(data['amount_total'] ?? data['total']) ?? draft.total,
      status: OrderStatus.draft,
      createdAt: DateTime.now(),
      note: draft.notes,
      clientOrderRef: 'MOBILE',
    );

    await fetchMyOrders();
    return summary;
  }
}
