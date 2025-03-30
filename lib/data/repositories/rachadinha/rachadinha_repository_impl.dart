import 'package:rachadinha/data/models/item_model.dart';
import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/data/models/rachadinha_model.dart';
import 'package:rachadinha/data/repositories/rachadinha/rachadinha_repository.dart';
import 'package:rachadinha/data/services/rachadinha/rachadinha_firestore.dart';
import 'package:result_dart/result_dart.dart';

class RachadinhaRepositoryImpl implements RachadinhaRepository {
  final RachadinhaFirestore _store;
  RachadinhaRepositoryImpl(this._store);

  @override
  AsyncResult<List<OrderModel>> findOrders() {
    return _store.findOrders();
  }

  @override
  AsyncResult<ItemModel> addItem(ItemModel item) async {
    return await _store.createItem(
      name: item.name,
      price: item.price,
      orderId: item.orderId,
      appid: item.appid,
    );
  }

  @override
  AsyncResult<RachadinhaModel> addRachadinha(
      RachadinhaModel rachadinha, String orderId) async {
    return await _store.createRachadinha(
      orderId: orderId,
      itemId: rachadinha.itemId,
      name: rachadinha.name,
      price: rachadinha.price,
      itemName: rachadinha.itemName,
      appid: rachadinha.appid,
    );
  }

  @override
  AsyncResult<OrderModel> createOrder(OrderModel orderModel) async {
    return await _store.createOrder(
      userId: orderModel.userId,
      total: orderModel.total,
      date: DateTime.now(),
    );
  }

  @override
  AsyncResult<ItemModel> deleteItem(ItemModel item) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> deleteOrder(String orderId) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<RachadinhaModel> deleteRachadinha(RachadinhaModel rachadinha) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<ItemModel> editItem(ItemModel item) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> editOrder(OrderModel orderModel) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<RachadinhaModel> editRachadinha(RachadinhaModel rachadinha) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<List<ItemModel>> findItems(String orderId) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> findOrderbyId(String orderId) {
    throw UnimplementedError();
  }

  @override
  AsyncResult<List<RachadinhaModel>> findRachadinhas(String itemId) {
    throw UnimplementedError();
  }
}
