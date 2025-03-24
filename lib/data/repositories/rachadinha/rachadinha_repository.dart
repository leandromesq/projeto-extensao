import 'package:rachadinha/data/models/order_model.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class RachadinhaRepository {
  AsyncResult<OrderModel> createOrder(OrderModel orderModel);
  AsyncResult<List<OrderModel>> findOrders();
  AsyncResult<OrderModel> findOrderbyId(String orderId);
  AsyncResult<OrderModel> editOrder(OrderModel orderModel);
  AsyncResult<OrderModel> deleteOrder(String orderId);
  AsyncResult<OrderModel> addItem(OrderModel orderModel);
  AsyncResult<OrderModel> editItem(OrderModel orderModel);
  AsyncResult<OrderModel> deleteItem(OrderModel orderModel);
  AsyncResult<OrderModel> addRachadinha(OrderModel orderModel);
  AsyncResult<OrderModel> editRachadinha(OrderModel orderModel);
  AsyncResult<OrderModel> deleteRachadinha(OrderModel orderModel);
}
