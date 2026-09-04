class CustomerModel {
  const CustomerModel({required this.id, required this.name, this.phone});

  final String id;
  final String name;
  final String? phone;

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: (json['id'] ?? json['customer_id'])?.toString() ?? '',
      name:
          (json['name'] ?? json['display_name'] ?? json['customer_name'])
              ?.toString()
              .trim() ??
          '',
      phone: json['phone']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'phone': phone};
}
