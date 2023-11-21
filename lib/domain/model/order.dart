class Order {
  int? id;
  final int uuid;
  final String name;
  final int quantity;
  final String ordersType;

  Order(
      {this.id,
      required this.uuid,
      required this.quantity,
      required this.name,
      required this.ordersType});

  Order copy({
    int? id,
    int? uuid,
    int? quantity,
    String? name,
    String? ordersType,
  }) =>
      Order(
        id: id ?? this.id,
        uuid: id ?? this.uuid,
        quantity: quantity ?? this.quantity,
        name: name ?? this.name,
        ordersType: ordersType ?? this.ordersType,
      );

  static Order fromJson(Map<String, Object?> json) => Order(
      id: json[DBOrdersFields.id] as int,
      uuid: json[DBOrdersFields.uuid] as int,
      quantity: json[DBOrdersFields.quantity] as int,
      name: json[DBOrdersFields.name] as String,
      ordersType: json[DBOrdersFields.ordersType] as String);

  static Order fromJsonAssets(Map<String, Object?> json) => Order(
      id: json[DBOrdersFields.uuid] as int,
      uuid: json[DBOrdersFields.uuid] as int,
      quantity: 0,
      name: json[DBOrdersFields.name] as String,
      ordersType: json[DBOrdersFields.name] as String);

  Map<String, Object?> toJson() => {
        DBOrdersFields.id: id,
        DBOrdersFields.uuid: uuid,
        DBOrdersFields.quantity: quantity,
        DBOrdersFields.name: name,
        DBOrdersFields.ordersType: ordersType
      };
}

class DBOrdersFields {
  static final List<String> values = [
    id,
    uuid,
    name,
    quantity,
    ordersType,
  ];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String name = 'name';
  static const String quantity = 'quantity';
  static const String ordersType = 'orders_type';
}
