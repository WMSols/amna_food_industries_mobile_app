import 'package:get/get.dart';

import 'package:amna_food_industries_mobile_app/common/services/auth/auth_service.dart';
import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/core/design/texts/app_texts.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_exception.dart';
import 'package:amna_food_industries_mobile_app/core/routes/app_routes.dart';
import 'package:amna_food_industries_mobile_app/core/services/session_service.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/sales_order_draft.dart';
import 'package:amna_food_industries_mobile_app/order_booker/services/sales_order/sales_order_service.dart';

class ObDashboardController extends GetxController {
  ObDashboardController(this._session, this._salesOrderService);

  final SessionService _session;
  final SalesOrderService _salesOrderService;

  final RxBool isLoading = false.obs;
  final RxBool isLoggingOut = false.obs;
  final RxnString error = RxnString();

  String get userName =>
      _session.user.value?.displayName(AppTexts.defaultUserName) ??
      AppTexts.defaultUserName;

  PresenceStatus get presenceStatus =>
      _session.user.value?.presenceStatus ?? PresenceStatus.online;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return AppTexts.dashboardGreetingMorning;
    if (hour < 17) return AppTexts.dashboardGreetingAfternoon;
    return AppTexts.dashboardGreetingEvening;
  }

  RxList<SalesOrderSummary> get recentOrders => _salesOrderService.recentOrders;

  @override
  void onInit() {
    super.onInit();
    loadRecentOrders();
  }

  Future<void> loadRecentOrders({bool force = false}) async {
    if (isLoading.value && !force) return;
    final hadData = recentOrders.isNotEmpty;
    if (!hadData) isLoading.value = true;
    error.value = null;
    try {
      await _salesOrderService.fetchMyOrders();
    } on ApiException catch (e) {
      if (!hadData) error.value = e.message;
    } catch (_) {
      if (!hadData) error.value = AppTexts.emptyLoadFailedTitle;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> goToCreateSalesOrder() async {
    await Get.toNamed(AppRoutes.salesOrderCreate);
    await loadRecentOrders(force: true);
  }

  Future<void> logout() async {
    if (isLoggingOut.value) return;
    isLoggingOut.value = true;
    try {
      if (Get.isRegistered<AuthService>()) {
        await Get.find<AuthService>().logout();
      }
      Get.offAllNamed(AppRoutes.login);
    } finally {
      if (!isClosed) isLoggingOut.value = false;
    }
  }
}
