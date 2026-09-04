import 'package:amna_food_industries_mobile_app/core/constants/app_enums.dart';
import 'package:amna_food_industries_mobile_app/core/network/api_map.dart';
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

  /// Payload for `POST /api/orders/create`.
  Map<String, dynamic> toJson() {
    final partnerId = int.tryParse(customer.id) ?? customer.id;
    final note = notes?.trim();

    return {
      'partner_id': partnerId,
      if (note != null && note.isNotEmpty) 'note': note,
      'client_order_ref': 'MOBILE',
      'lines': lines
          .map(
            (line) => {
              'product_id': int.tryParse(line.productId) ?? line.productId,
              'qty': line.quantity,
              'unit_price': line.unitPrice,
            },
          )
          .toList(growable: false),
    };
  }
}

class SalesOrderSummary {
  const SalesOrderSummary({
    required this.id,
    required this.orderName,
    required this.customerName,
    required this.total,
    required this.status,
    required this.createdAt,
    this.note,
    this.clientOrderRef,
  });

  final String id;
  final String orderName;
  final String customerName;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final String? note;
  final String? clientOrderRef;

  factory SalesOrderSummary.fromJson(Map<String, dynamic> json) {
    return SalesOrderSummary(
      id: (json['id'] ?? json['order_id'])?.toString() ?? '',
      orderName: (json['name'] ?? json['order_name'])?.toString().trim() ?? '',
      customerName:
          (json['partner_name'] ?? json['customer_name'])?.toString().trim() ??
          '',
      total: ApiMap.asDouble(json['amount_total'] ?? json['total']) ?? 0,
      status: OrderStatusX.fromOdooState(json['state'] ?? json['status']),
      createdAt:
          ApiMap.asDateTime(json['date_order'] ?? json['created_at']) ??
          DateTime.now(),
      // Odoo may send false for empty Char fields; only keep real text.
      note: ApiMap.asString(json['note'] ?? json['notes']),
      clientOrderRef: ApiMap.asString(
        json['client_order_ref'] ??
            json['clientOrderRef'] ??
            json['po_reference'],
      ),
    );
  }
}
