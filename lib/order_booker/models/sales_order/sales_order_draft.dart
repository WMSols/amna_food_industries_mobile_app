import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/customer_model.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/sales_order_line_model.dart';

class SalesOrderDraft {
  const SalesOrderDraft({
    required this.customer,
    required this.lines,
    this.notes,
  });

  final CustomerModel customer;
  final List<SalesOrderLineModel> lines;
  final String? notes;

  double get total => lines.fold(0, (sum, line) => sum + line.subtotal);

  Map<String, dynamic> toJson() => {
        'customer_id': customer.id,
        'customer_name': customer.name,
        'notes': notes,
        'lines': lines.map((line) => line.toJson()).toList(growable: false),
        'total': total,
      };
}

class SalesOrderSummary {
  const SalesOrderSummary({
    required this.id,
    required this.customerName,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String customerName;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
}
