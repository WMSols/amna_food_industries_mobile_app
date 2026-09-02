import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/services/auth/auth_service.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/sales_order_draft.dart';
import 'package:amna_food_industries_mobile_app/order_booker/services/sales_order/sales_order_service.dart';

class ObDashboardController extends GetxController {
  ObDashboardController(this._session, this._salesOrderService);

  final SessionService _session;
  final SalesOrderService _salesOrderService;

  String get userName =>
      _session.user.value?.displayName(AppTexts.defaultUserName) ??
      AppTexts.defaultUserName;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppTexts.dashboardGreetingMorning;
    if (hour < 17) return AppTexts.dashboardGreetingAfternoon;
    return AppTexts.dashboardGreetingEvening;
  }

  RxList<SalesOrderSummary> get recentOrders => _salesOrderService.recentOrders;

  void goToCreateSalesOrder() {
    Get.toNamed(AppRoutes.salesOrderCreate);
  }

  Future<void> logout() async {
    if (Get.isRegistered<AuthService>()) {
      await Get.find<AuthService>().logout();
    }
    Get.offAllNamed(AppRoutes.login);
  }
}
