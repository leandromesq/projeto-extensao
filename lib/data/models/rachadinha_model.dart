import 'dart:convert';

class RachadinhaModel {
  final String id;
  final String name;
  final String itemId;
  final double price;
  RachadinhaModel({
    required this.id,
    required this.name,
    required this.itemId,
    required this.price,
  });

  RachadinhaModel copyWith({
    String? id,
    String? name,
    String? itemId,
    double? price,
  }) {
    return RachadinhaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      itemId: itemId ?? this.itemId,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'itemId': itemId,
      'price': price,
    };
  }

  factory RachadinhaModel.fromMap(Map<String, dynamic> map) {
    return RachadinhaModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      itemId: map['itemId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RachadinhaModel.fromJson(String source) =>
      RachadinhaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RachadinhaModel(id: $id, name: $name, itemId: $itemId, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RachadinhaModel &&
        other.id == id &&
        other.name == name &&
        other.itemId == itemId &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ itemId.hashCode ^ price.hashCode;
  }
}
