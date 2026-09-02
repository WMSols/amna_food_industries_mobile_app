import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/customer_model.dart';
import 'package:amna_food_industries_mobile_app/order_booker/models/sales_order/product_model.dart';

class AppMockData {
  AppMockData._();

  static const customers = <CustomerModel>[
    CustomerModel(id: '1', name: 'Al Noor Traders', phone: '0300-1112233'),
    CustomerModel(id: '2', name: 'City Mart Wholesale', phone: '0321-4455667'),
    CustomerModel(id: '3', name: 'Green Valley Store', phone: '0333-7788990'),
    CustomerModel(id: '4', name: 'Metro Foods Distributor'),
    CustomerModel(id: '5', name: 'Sunrise General Store', phone: '0345-9900112'),
  ];

  static const products = <ProductModel>[
    ProductModel(id: '101', name: 'Premium Cooking Oil 1L', unitPrice: 620, uom: 'Unit'),
    ProductModel(id: '102', name: 'Premium Cooking Oil 3L', unitPrice: 1780, uom: 'Unit'),
    ProductModel(id: '103', name: 'Sunflower Oil 5L', unitPrice: 2890, uom: 'Unit'),
    ProductModel(id: '104', name: 'Canola Oil 1L', unitPrice: 590, uom: 'Unit'),
    ProductModel(id: '105', name: 'Ghee Tin 2.5kg', unitPrice: 3450, uom: 'Unit'),
    ProductModel(id: '106', name: 'Desi Ghee 1kg', unitPrice: 1650, uom: 'Unit'),
  ];
}
