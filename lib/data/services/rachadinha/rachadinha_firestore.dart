import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rachadinha/data/models/item_model.dart';
import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/data/models/rachadinha_model.dart';
import 'package:result_dart/result_dart.dart';

class RachadinhaFirestore {
  final FirebaseFirestore _store;

  RachadinhaFirestore({FirebaseFirestore? store})
      : _store = store ?? FirebaseFirestore.instance;

  AsyncResult<String> createOrder(String userId, double total) async {
    try {
      DocumentReference docRef = await _store.collection('orders').add({
        'userId': userId,
        'total': total,
        'date': FieldValue.serverTimestamp(),
      });
      return Success(docRef.id);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<OrderModel> findOrderbyId(String pedidoId) async {
    try {
      DocumentSnapshot doc =
          await _store.collection('orders').doc(pedidoId).get();
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

  AsyncResult<List<OrderModel>> findOrders() async {
    try {
      QuerySnapshot querySnapshot = await _store.collection('orders').get();
      var orders = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return Success(orders.map((order) => OrderModel.fromMap(order)).toList());
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> editOrder(String pedidoId, double novoTotal) async {
    try {
      await _store
          .collection('orders')
          .doc(pedidoId)
          .update({'total': novoTotal});
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> deleteOrder(String pedidoId) async {
    try {
      await _store.collection('orders').doc(pedidoId).delete();
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<String> createItem(
      String pedidoId, String nome, double preco) async {
    try {
      DocumentReference docRef = await _store
          .collection('orders')
          .doc(pedidoId)
          .collection('items')
          .add({
        'nome': nome,
        'preco': preco,
      });
      return Success(docRef.id);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<ItemModel> findItembyId(String pedidoId, String itemId) async {
    try {
      DocumentSnapshot doc = await _store
          .collection('orders')
          .doc(pedidoId)
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

  AsyncResult<Unit> editItem(
      String pedidoId, String itemId, String nome, double preco) async {
    try {
      await _store
          .collection('orders')
          .doc(pedidoId)
          .collection('items')
          .doc(itemId)
          .update({
        'nome': nome,
        'preco': preco,
      });
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> deleteItem(String pedidoId, String itemId) async {
    try {
      await _store
          .collection('orders')
          .doc(pedidoId)
          .collection('items')
          .doc(itemId)
          .delete();
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<String> createRachadinha(
      String pedidoId, String itemId, String nome, double conta) async {
    try {
      DocumentReference docRef = await _store
          .collection('orders')
          .doc(pedidoId)
          .collection('items')
          .doc(itemId)
          .collection('rachadinhas')
          .add({
        'nome': nome,
        'idPedido': pedidoId,
        'idItem': itemId,
        'conta': conta,
      });
      return Success(docRef.id);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<RachadinhaModel> findRachadinhabyId(
      String pedidoId, String itemId, String rachadinhaId) async {
    try {
      DocumentSnapshot doc = await _store
          .collection('orders')
          .doc(pedidoId)
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

  AsyncResult<Unit> editRachadinha(String pedidoId, String itemId,
      String rachadinhaId, String nome, double conta) async {
    try {
      await _store
          .collection('orders')
          .doc(pedidoId)
          .collection('items')
          .doc(itemId)
          .collection('rachadinhas')
          .doc(rachadinhaId)
          .update({
        'nome': nome,
        'conta': conta,
      });
      return const Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> deleteRachadinha(
      String pedidoId, String itemId, String rachadinhaId) async {
    try {
      await _store
          .collection('orders')
          .doc(pedidoId)
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
