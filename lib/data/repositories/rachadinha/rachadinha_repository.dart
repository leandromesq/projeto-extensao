import 'package:rachadinha/data/models/item_model.dart';
import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/data/models/rachadinha_model.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class RachadinhaRepository {
  AsyncResult<OrderModel> createOrder(OrderModel orderModel);
  AsyncResult<List<OrderModel>> findOrders();
  AsyncResult<OrderModel> findOrderbyId(String orderId);
  AsyncResult<OrderModel> editOrder(OrderModel orderModel);
  AsyncResult<OrderModel> deleteOrder(String orderId);
  AsyncResult<List<ItemModel>> findItems(String orderId);
  AsyncResult<ItemModel> addItem(ItemModel item);
  AsyncResult<ItemModel> editItem(ItemModel item);
  AsyncResult<ItemModel> deleteItem(ItemModel item);
  AsyncResult<List<RachadinhaModel>> findRachadinhas(
      String orderId, String itemId);
  AsyncResult<RachadinhaModel> addRachadinha(
      RachadinhaModel rachadinha, String orderId);
  AsyncResult<RachadinhaModel> editRachadinha(RachadinhaModel rachadinha);
  AsyncResult<RachadinhaModel> deleteRachadinha(RachadinhaModel rachadinha);
}
