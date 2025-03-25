import 'dart:convert';

class RachadinhaModel {
  String id;
  String name;
  String itemId;
  double price;
  bool active;
  RachadinhaModel({
    required this.id,
    required this.name,
    required this.itemId,
    required this.price,
    required this.active,
  });

  RachadinhaModel copyWith({
    String? id,
    String? name,
    String? itemId,
    double? price,
    bool? active,
  }) {
    return RachadinhaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      itemId: itemId ?? this.itemId,
      price: price ?? this.price,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'itemId': itemId,
      'price': price,
      'active': active,
    };
  }

  factory RachadinhaModel.fromMap(Map<String, dynamic> map) {
    return RachadinhaModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      itemId: map['itemId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      active: map['active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RachadinhaModel.fromJson(String source) =>
      RachadinhaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RachadinhaModel(id: $id, name: $name, itemId: $itemId, price: $price, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RachadinhaModel &&
        other.id == id &&
        other.name == name &&
        other.itemId == itemId &&
        other.price == price &&
        other.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        itemId.hashCode ^
        price.hashCode ^
        active.hashCode;
  }

  static final empty = RachadinhaModel(
    id: '',
    name: '',
    itemId: '',
    price: 0,
    active: false,
  );
}
