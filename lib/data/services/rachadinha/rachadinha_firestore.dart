import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rachadinha/data/models/item_model.dart';
import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/data/models/rachadinha_model.dart';
import 'package:result_dart/result_dart.dart';

class RachadinhaFirestore {
  final FirebaseFirestore _store;

  RachadinhaFirestore({FirebaseFirestore? store})
      : _store = store ?? FirebaseFirestore.instance;

  AsyncResult<OrderModel> createOrder(
      {required String userId,
      required double total,
      required DateTime date}) async {
    try {
      DocumentReference docRef = await _store.collection('orders').add({
        'userId': userId,
        'total': total,
        'date': date.toString(),
      });
      var order =
          OrderModel(id: docRef.id, userId: userId, total: total, date: date);
      return Success(order);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<OrderModel> findOrderbyId(String orderId) async {
    try {
      DocumentSnapshot doc =
          await _store.collection('orders').doc(orderId).get();
      if (doc.exists) {
        var order = doc.data() as Map<String, dynamic>;
        return Success(OrderModel.fromMap(order));
      } else {
        return Failure(Exception("Pedido não encontrado"));
      }
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<List<OrderModel>> findOrders(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _store
          .collection('orders')
          .where('user_id', isEqualTo: userId)
          .get();
      var orders = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      var orderList = orders.map((order) => OrderModel.fromMap(order)).toList();
      for (var order in orderList) {
        order.id = querySnapshot.docs[orderList.indexOf(order)].id;
      }
      return Success(orderList);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> editOrder(String orderId, double total) async {
    try {
      await _store.collection('orders').doc(orderId).update({'total': total});
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> deleteOrder(String orderId) async {
    try {
      await _store.collection('orders').doc(orderId).delete();
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<ItemModel> createItem(
      {required String name,
      required double price,
      required String orderId,
      required String appid}) async {
    try {
      DocumentReference docRef = await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .add({
        'name': name,
        'price': price,
        'order_id': orderId,
        'appid': appid,
      });
      return Success(ItemModel(
          id: docRef.id,
          name: name,
          orderId: orderId,
          price: price,
          appid: appid));
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<ItemModel> findItembyId(String orderId, String itemId) async {
    try {
      DocumentSnapshot doc = await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId)
          .get();
      if (doc.exists) {
        var item = doc.data() as Map<String, dynamic>;
        return Success(ItemModel.fromMap(item));
      } else {
        return Failure(Exception("Item não encontrado"));
      }
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<List<ItemModel>> findAllItems(String orderId) async {
    try {
      QuerySnapshot querySnapshot = await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .get();
      var items = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      var itemList = items.map((item) => ItemModel.fromMap(item)).toList();
      for (var item in itemList) {
        item.id = querySnapshot.docs[itemList.indexOf(item)].id;
      }
      return Success(itemList);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> editItem(
      String orderId, String itemId, String name, double price) async {
    try {
      await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId)
          .update({
        'name': name,
        'price': price,
      });
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> deleteItem(String orderId, String itemId) async {
    try {
      await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId)
          .delete();
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<RachadinhaModel> createRachadinha(
      {required String orderId,
      required String itemId,
      required String name,
      required double price,
      required String itemName,
      required String appid}) async {
    try {
      DocumentReference docRef = await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId)
          .collection('rachadinhas')
          .add({
        'name': name,
        'order_id': orderId,
        'item_id': itemId,
        'price': price,
        'item_name': itemName,
        'appid': appid,
      });
      return Success(RachadinhaModel(
        id: docRef.id,
        name: name,
        itemId: itemId,
        price: price,
        itemName: itemName,
        appid: appid,
      ));
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<RachadinhaModel> findRachadinhabyId(
      String orderId, String itemId, String rachadinhaId) async {
    try {
      DocumentSnapshot doc = await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId)
          .collection('rachadinhas')
          .doc(rachadinhaId)
          .get();
      if (doc.exists) {
        var rachadinha = doc.data() as Map<String, dynamic>;
        return Success(RachadinhaModel.fromMap(rachadinha));
      } else {
        return Failure(Exception("Rachadinha não encontrada"));
      }
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<List<RachadinhaModel>> findAllRachadinhas(
      String orderId, String itemId) async {
    try {
      QuerySnapshot querySnapshot = await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId)
          .collection('rachadinhas')
          .get();
      var rachadinhas = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      var rachadinhasList = rachadinhas
          .map((rachadinha) => RachadinhaModel.fromMap(rachadinha))
          .toList();
      for (var rachadinha in rachadinhasList) {
        rachadinha.id =
            querySnapshot.docs[rachadinhasList.indexOf(rachadinha)].id;
      }
      return Success(rachadinhasList);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> editRachadinha(String orderId, String itemId,
      String rachadinhaId, String name, double price) async {
    try {
      await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId)
          .collection('rachadinhas')
          .doc(rachadinhaId)
          .update({
        'name': name,
        'price': price,
      });
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> deleteRachadinha(
      String orderId, String itemId, String rachadinhaId) async {
    try {
      await _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId)
          .collection('rachadinhas')
          .doc(rachadinhaId)
          .delete();
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
