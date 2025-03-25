import 'dart:convert';

import 'package:rachadinha/data/models/rachadinha_model.dart';

class ItemModel {
  String id;
  String name;
  String orderId;
  double price;
  List<RachadinhaModel> rachadinhas;
  ItemModel({
    required this.id,
    required this.name,
    required this.orderId,
    required this.price,
    this.rachadinhas = const [],
  });

  ItemModel copyWith({
    String? id,
    String? name,
    String? orderId,
    double? price,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      orderId: orderId ?? this.orderId,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'orderId': orderId,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      orderId: map['orderId'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, orderId: $orderId, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.id == id &&
        other.name == name &&
        other.orderId == orderId &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ orderId.hashCode ^ price.hashCode;
  }

  static final empty = ItemModel(
    id: '',
    name: '',
    orderId: '',
    price: 0.0,
    rachadinhas: [],
  );
}
