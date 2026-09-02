import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/order_booker/bindings/ob_bindings.dart';
import 'package:amna_food_industries_mobile_app/order_booker/views/dashboard/ob_dashboard_screen.dart';
import 'package:amna_food_industries_mobile_app/order_booker/views/sales_order/sales_order_form_screen.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';

class OrderBookerRoutes {
  OrderBookerRoutes._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const ObDashboardScreen(),
      binding: ObDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.salesOrderCreate,
      page: () => const SalesOrderFormScreen(),
      binding: SalesOrderBinding(),
    ),
  ];
}
