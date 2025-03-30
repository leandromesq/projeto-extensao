import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/data/models/person_model.dart';
import 'package:rachadinha/data/repositories/rachadinha/rachadinha_repository.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class HistoryViewModel extends ChangeNotifier {
  final RachadinhaRepository repo;

  HistoryViewModel(this.repo);

  late final findOrdersCommand = Command0(findOrders);

  List<OrderModel> orders = [];
  OrderModel? selectedOrder;

  AsyncResult<Unit> findOrders() async {
    orders = await repo.findOrders().fold((s) => s, (error) => []);
    for (var order in orders) {
      order.items =
          await repo.findItems(order.id).fold((s) => s, (error) => []);
      for (var item in order.items) {
        item.orderId = order.id;
        item.rachadinhas = await repo
            .findRachadinhas(item.orderId, item.id)
            .fold((s) => s, (error) {
          log(error.toString());
          return [];
        });
      }
    }
    notifyListeners();
    return const Success(unit);
  }

  selectOrder(OrderModel order) {
    selectedOrder = order;
    notifyListeners();
  }

  List<PersonModel> peopleList = [];

  listPeople(OrderModel order) {
    peopleList = [];
    for (var item in order.items) {
      for (var rachadinha in item.rachadinhas) {
        if (rachadinha.price != 0) {
          if (peopleList.any((person) => person.name == rachadinha.name)) {
            var person =
                peopleList.firstWhere((r) => r.name == rachadinha.name);
            var rachadinhas = person.rachadinhas;
            rachadinhas.add(rachadinha);
            person.total += rachadinha.price;
            person.rachadinhas = rachadinhas;
          } else {
            peopleList.add(PersonModel(
                name: rachadinha.name,
                rachadinhas: [rachadinha],
                total: rachadinha.price));
          }
        }
      }
    }
  }
}
