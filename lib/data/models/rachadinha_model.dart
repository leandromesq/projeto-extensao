import 'dart:convert';

class RachadinhaModel {
  String id;
  String name;
  String itemId;
  double price;
  bool active;
  String appid;
  RachadinhaModel({
    this.id = '',
    this.name = '',
    this.itemId = '',
    this.price = 0.0,
    this.active = false,
    this.appid = '',
  });

  RachadinhaModel copyWith({
    String? id,
    String? name,
    String? itemId,
    double? price,
    bool? active,
    String? appid,
  }) {
    return RachadinhaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      itemId: itemId ?? this.itemId,
      price: price ?? this.price,
      active: active ?? this.active,
      appid: appid ?? this.appid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'itemId': itemId,
      'price': price,
      'active': active,
      'appid': appid,
    };
  }

  factory RachadinhaModel.fromMap(Map<String, dynamic> map) {
    return RachadinhaModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      itemId: map['itemId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      active: map['active'] ?? false,
      appid: map['appid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RachadinhaModel.fromJson(String source) =>
      RachadinhaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RachadinhaModel(id: $id, name: $name, itemId: $itemId, price: $price, active: $active, appid: $appid)';
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
        other.appid == appid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        itemId.hashCode ^
        price.hashCode ^
        active.hashCode ^
        appid.hashCode;
  }
}
