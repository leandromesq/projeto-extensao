import 'dart:convert';

import 'package:rachadinha/data/models/item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final double total;
  final DateTime date;
  final List<ItemModel> items;
  OrderModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.date,
    this.items = const [],
  });

  OrderModel copyWith({
    String? id,
    String? userId,
    double? total,
    DateTime? date,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      total: total ?? this.total,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'total': total,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      total: map['total']?.toDouble() ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, userId: $userId, total: $total, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.userId == userId &&
        other.total == total &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userId.hashCode ^ total.hashCode ^ date.hashCode;
  }
}
