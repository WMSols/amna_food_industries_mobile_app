import 'package:amna_food_industries_mobile_app/core/network/api_map.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.unitPrice,
    this.uom,
  });

  final String id;
  final String name;
  final double unitPrice;
  final String? uom;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] ?? json['product_id'])?.toString() ?? '',
      name: (json['name'] ?? json['product_name'])?.toString().trim() ?? '',
      unitPrice:
          ApiMap.asDouble(
            json['unit_price'] ?? json['list_price'] ?? json['price'],
          ) ??
          0,
      uom: ApiMap.asString(json['uom'] ?? json['uom_name'] ?? json['uom_id']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'unit_price': unitPrice,
    'uom': uom,
  };
}
