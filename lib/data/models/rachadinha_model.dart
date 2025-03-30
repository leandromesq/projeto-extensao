import 'dart:convert';

class RachadinhaModel {
  String id;
  String name;
  String itemId;
  double price;
  bool active;
  String appid;
  String itemName;
  RachadinhaModel({
    this.id = '',
    this.name = '',
    this.itemId = '',
    this.price = 0.0,
    this.active = false,
    this.appid = '',
    this.itemName = '',
  });

  RachadinhaModel copyWith({
    String? id,
    String? name,
    String? itemId,
    double? price,
    bool? active,
    String? appid,
    String? itemName,
  }) {
    return RachadinhaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      itemId: itemId ?? this.itemId,
      price: price ?? this.price,
      active: active ?? this.active,
      appid: appid ?? this.appid,
      itemName: itemName ?? this.itemName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'item_id': itemId,
      'price': price,
      'active': active,
      'appid': appid,
      'item_name': itemName,
    };
  }

  factory RachadinhaModel.fromMap(Map<String, dynamic> map) {
    return RachadinhaModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      itemId: map['item_id'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      active: map['active'] ?? false,
      appid: map['appid'] ?? '',
      itemName: map['item_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RachadinhaModel.fromJson(String source) =>
      RachadinhaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RachadinhaModel(id: $id, name: $name, itemId: $itemId, itemName: $itemName, price: $price, active: $active, appid: $appid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RachadinhaModel &&
        other.id == id &&
        other.name == name &&
        other.itemId == itemId &&
        other.price == price &&
        other.active == active &&
        other.appid == appid &&
        other.itemName == itemName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        itemId.hashCode ^
        price.hashCode ^
        active.hashCode ^
        appid.hashCode ^
        itemName.hashCode;
  }
}
