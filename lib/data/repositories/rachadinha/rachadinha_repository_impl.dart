import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/data/repositories/rachadinha/rachadinha_repository.dart';
import 'package:rachadinha/data/services/rachadinha/rachadinha_firestore.dart';
import 'package:result_dart/result_dart.dart';

class RachadinhaRepositoryImpl implements RachadinhaRepository {
  final RachadinhaFirestore _store;
  RachadinhaRepositoryImpl(this._store);

  @override
  AsyncResult<OrderModel> addItem(OrderModel orderModel) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> addRachadinha(OrderModel orderModel) {
    // TODO: implement addRachadinha
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> createOrder(OrderModel orderModel) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> deleteItem(OrderModel orderModel) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> deleteOrder(String orderId) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> deleteRachadinha(OrderModel orderModel) {
    // TODO: implement deleteRachadinha
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> editItem(OrderModel orderModel) {
    // TODO: implement editItem
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> editOrder(OrderModel orderModel) {
    // TODO: implement editOrder
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> editRachadinha(OrderModel orderModel) {
    // TODO: implement editRachadinha
    throw UnimplementedError();
  }

  @override
  AsyncResult<OrderModel> findOrderbyId(String orderId) {
    return _store.findOrderbyId(orderId);
  }

  @override
  AsyncResult<List<OrderModel>> findOrders() {
    return _store.findOrders();
  }
}
