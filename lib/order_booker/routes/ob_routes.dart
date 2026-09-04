import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';
import 'package:amna_food_industries_mobile_app/order_booker/bindings/ob_bindings.dart';
import 'package:amna_food_industries_mobile_app/order_booker/shell/ob_home_shell.dart';
import 'package:amna_food_industries_mobile_app/order_booker/views/sales_order/sales_order_form_screen.dart';

class OrderBookerRoutes {
  OrderBookerRoutes._();

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const ObHomeShell(),
      binding: ObDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.salesOrderCreate,
      page: () => const SalesOrderFormScreen(),
      binding: SalesOrderBinding(),
    ),
  ];
}
