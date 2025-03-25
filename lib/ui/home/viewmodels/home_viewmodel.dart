import 'package:flutter/material.dart';
import 'package:rachadinha/data/models/item_model.dart';
import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/data/models/rachadinha_model.dart';
import 'package:rachadinha/data/repositories/rachadinha/rachadinha_repository.dart';

class HomeViewmodel extends ChangeNotifier {
  final RachadinhaRepository _repository;
  HomeViewmodel(this._repository);
  OrderModel order = OrderModel.empty;
  ItemModel item = ItemModel.empty;
  RachadinhaModel rachadinha = RachadinhaModel.empty;
}
