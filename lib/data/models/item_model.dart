import 'dart:convert';

import 'package:rachadinha/data/models/rachadinha_model.dart';

class ItemModel {
  String id;
  String name;
  String orderId;
  double price;
  String appid;
  List<RachadinhaModel> rachadinhas;
  ItemModel({
    this.id = '',
    this.name = '',
    this.orderId = '',
    this.price = 0,
    List<RachadinhaModel>? rachadinhas,
    this.appid = '',
  }) : rachadinhas = rachadinhas ?? [];

  ItemModel copyWith({
    String? id,
    String? name,
    String? orderId,
    double? price,
    int? parts,
    List<RachadinhaModel>? rachadinhas,
    String? appid,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      orderId: orderId ?? this.orderId,
      price: price ?? this.price,
      rachadinhas: rachadinhas ?? this.rachadinhas,
      appid: appid ?? this.appid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'order_id': orderId,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      orderId: map['order_id'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, orderId: $orderId, price: $price, rachadinhas: $rachadinhas, appid: $appid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id &&
        other.name == name &&
        other.orderId == orderId &&
        other.price == price &&
        other.appid == appid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        orderId.hashCode ^
        price.hashCode ^
        appid.hashCode;
  }
}
