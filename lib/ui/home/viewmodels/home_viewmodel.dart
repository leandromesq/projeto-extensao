import 'dart:developer';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:rachadinha/data/models/item_model.dart';
import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/data/models/rachadinha_model.dart';
import 'package:rachadinha/data/repositories/rachadinha/rachadinha_repository.dart';
import 'package:rachadinha/core/widgets/fading_error_dialog.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  final RachadinhaRepository repo;

  HomeViewModel(this.repo);

  late final finishOrderCommand = Command1(finishOrder);

  final CurrencyTextInputFormatter moneyFormatter =
      CurrencyTextInputFormatter.currency(symbol: '', locale: 'pt-BR');
  OrderModel order = OrderModel();
  ItemModel item = ItemModel()
      .copyWith(appid: DateTime.now().microsecondsSinceEpoch.toString());
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<String?> getSavedUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_uid'); // Retorna null se não houver UID salvo
  }

  updateItemName(String name) {
    item.name = name;
    notifyListeners();
  }

  updateItemPrice() {
    item.price = moneyFormatter.getUnformattedValue().toDouble();
    notifyListeners();
  }

  addItem(BuildContext context) async {
    if (item.price <= 0 || item.name.isEmpty) {
      showFadingErrorPopup(context, 'Preencha os campos corretamente');
      return;
    }

    // Filtra as pessoas selecionadas
    final selectedPeople = item.rachadinhas.where((p) => p.active).toList();
    if (selectedPeople.isEmpty) return; // ou pode exibir um alerta

    // Calcula o valor por pessoa
    final share = item.price / selectedPeople.length;

    // Atribui o valor a cada pessoa selecionada
    for (var rachadinha in selectedPeople) {
      rachadinha.price = share;
      rachadinha.itemName = item.name;
    }

    // Se houver um acumulador de total na ordem, atualiza-o
    order.total += item.price;
    order.items.add(item);
    log(item.toString());
    notifyListeners();

    // Limpa o item
    List<RachadinhaModel> cleanRachadinhas = [];
    for (var rachadinha in item.rachadinhas) {
      cleanRachadinhas.add(rachadinha.copyWith(
        appid: DateTime.now().microsecondsSinceEpoch.toString(),
        active: false,
        price: 0,
      ));
    }
    item = ItemModel().copyWith(
        appid: DateTime.now().microsecondsSinceEpoch.toString(),
        rachadinhas: cleanRachadinhas);
    nameController.clear();
    priceController.clear();
    log('Item limpo: ${item.toString()}');
    notifyListeners();
  }

  toggleRachadinha(RachadinhaModel rachadinha) async {
    int index = item.rachadinhas.indexWhere((r) => r == rachadinha);
    if (index != -1) {
      item.rachadinhas[index] =
          item.rachadinhas[index].copyWith(active: !rachadinha.active);
    }
    log(item.toString());
    notifyListeners();
  }

  addRachadinhaField() {
    item.rachadinhas.add(RachadinhaModel()
        .copyWith(appid: DateTime.now().microsecondsSinceEpoch.toString()));
    log(item.toString());
    notifyListeners();
  }

  removeRachadinha(RachadinhaModel rachadinha) {
    item.rachadinhas.remove(rachadinha);
    List<RachadinhaModel> cleanRachadinhas = [];
    for (var rachadinha in item.rachadinhas) {
      cleanRachadinhas.add(rachadinha.copyWith(
        appid: DateTime.now().microsecondsSinceEpoch.toString(),
        active: false,
        price: 0,
      ));
    }
    order = OrderModel();
    order.items.clear();
    item = ItemModel()
        .copyWith(appid: DateTime.now().microsecondsSinceEpoch.toString());
    item.rachadinhas.clear();
    item.rachadinhas = cleanRachadinhas;
    log(item.toString());
    notifyListeners();
  }

  double getPersonTotal(String name) {
    double total = 0;
    if (name.isEmpty) return total;
    for (var item in order.items) {
      var personRachadinha = item.rachadinhas.firstWhere((r) => r.name == name);
      var itemPrice = personRachadinha.price;
      total += itemPrice;
      log('personTotal rachadinha: ${personRachadinha.toString()} - $itemPrice');
    }
    log('personTotal - $name: $total');
    return total;
  }

  AsyncResult<Unit> finishOrder(BuildContext context) async {
    // Exemplo de validação: se não houver itens ou pessoas, não finaliza.
    if (order.items.isEmpty || order.items[0].rachadinhas.isEmpty) {
      // Pode disparar um alerta ou log
      return Failure(Exception('Nenhum item ou pessoa selecionada'));
    }
    await saveOrder(context);
    notifyListeners();

    order = OrderModel();
    order.items.clear();
    item = ItemModel();
    item.rachadinhas.clear();
    nameController.clear();
    priceController.clear();
    log('Pedido finalizado');
    notifyListeners();
    return const Success(unit);
  }

  List<RachadinhaModel> personRachadinhas = [];
  double personTotal = 0.0;
  loadPersonRachadinhas(String name) {
    personRachadinhas = [];
    personTotal = 0.0;
    for (var item in order.items) {
      var personRachadinha = item.rachadinhas.firstWhere((r) => r.name == name);
      if (personRachadinha.price != 0) {
        personRachadinhas.add(personRachadinha);
      }
      var itemPrice = personRachadinha.price;
      personTotal += itemPrice;
      log('personTotal rachadinha: ${personRachadinha.toString()} - $itemPrice');
    }
  }

  showFadingErrorPopup(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 30,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: FadingErrorDialog(
          message: message,
          duration: duration,
          onDismissed: () => overlayEntry.remove(),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }

  saveOrder(BuildContext context) async {
    var uid = await getSavedUID();
    var orderItems = order.items;
    order.userId = uid!;
    order = await repo.createOrder(order).fold(
        (s) => s, (error) => showFadingErrorPopup(context, error.toString()));
    for (var item in orderItems) {
      var rachadinhaItems = item.rachadinhas;
      item.orderId = order.id;
      item = await repo.addItem(item).fold(
          (s) => s, (error) => showFadingErrorPopup(context, error.toString()));
      for (var rachadinha in rachadinhaItems) {
        rachadinha.itemId = item.id;
        await repo.addRachadinha(rachadinha, order.id).fold((s) => s,
            (error) => showFadingErrorPopup(context, error.toString()));
      }
    }
    notifyListeners();
  }
}
