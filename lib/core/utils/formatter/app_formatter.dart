import 'package:intl/intl.dart';

import 'package:amna_food_industries_mobile_app/core/network/api_map.dart';

class AppFormatter {
  AppFormatter._();

  static String currencyWhole(num amount, {String symbol = 'Rs. '}) {
    final formatter = NumberFormat('#,##0');
    return '$symbol${formatter.format(amount)}';
  }

  static String currency(double amount, {String symbol = 'Rs. '}) {
    final formatter = NumberFormat('#,##0.00');
    return '$symbol${formatter.format(amount)}';
  }

  static DateTime? parseApiDateTime(dynamic raw) {
    if (raw is DateTime) return raw.toLocal();
    return ApiMap.asDateTime(raw);
  }
}
