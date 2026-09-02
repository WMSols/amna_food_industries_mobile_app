import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/network/api_client.dart';
import 'package:amna_food_industries_mobile_app/order_booker/controllers/dashboard/ob_dashboard_controller.dart';
import 'package:amna_food_industries_mobile_app/order_booker/controllers/sales_order/sales_order_controller.dart';
import 'package:amna_food_industries_mobile_app/order_booker/services/sales_order/sales_order_service.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';

class ObServicesBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<SalesOrderService>()) {
      Get.put(SalesOrderService(Get.find<ApiClient>()), permanent: true);
    }
  }
}

class ObDashboardBinding extends Bindings {
  @override
  void dependencies() {
    ObServicesBinding().dependencies();
    Get.lazyPut(
      () => ObDashboardController(
        Get.find<SessionService>(),
        Get.find<SalesOrderService>(),
      ),
    );
  }
}

class SalesOrderBinding extends Bindings {
  @override
  void dependencies() {
    ObServicesBinding().dependencies();
    Get.lazyPut(() => SalesOrderController(Get.find<SalesOrderService>()));
  }
}
