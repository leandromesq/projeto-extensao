import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class RachadinhaFirestore {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final String collectionPath = "orders";

  // Criar um novo pedido com itens
  Future<void> createOrder(
      String userID, double total, List<Map<String, dynamic>> items) async {
    DocumentReference orderRef = await _store.collection(collectionPath).add({
      'date': DateTime.now().toIso8601String(),
      'total': total,
      'userID': userID,
    });

    for (var item in items) {
      await orderRef.collection("items").add(item);
    }
  }

  // Excluir um pedido e seus itens
  Future<void> deletOrder(String orderID) async {
    CollectionReference itemsRef =
        _store.collection(collectionPath).doc(orderID).collection("items");
    QuerySnapshot itemsSnapshot = await itemsRef.get();

    for (var doc in itemsSnapshot.docs) {
      await doc.reference.delete();
    }

    await _store.collection(collectionPath).doc(orderID).delete();
  }

  // Editar um pedido (apenas o total, sem alterar os itens)
  Future<void> editOrder(String orderID, double novoTotal) async {
    await _store.collection(collectionPath).doc(orderID).update({
      'total': novoTotal,
    });
  }

  // Buscar um pedido pelo ID (incluindo itens)
  Future<Map<String, dynamic>?> findOrder(String orderID) async {
    DocumentSnapshot doc =
        await _store.collection(collectionPath).doc(orderID).get();

    if (doc.exists) {
      Map<String, dynamic> pedidoData = doc.data() as Map<String, dynamic>;

      // Buscar itens dentro do pedido
      QuerySnapshot itemsSnapshot = await _store
          .collection(collectionPath)
          .doc(orderID)
          .collection("items")
          .get();
      List<Map<String, dynamic>> items = itemsSnapshot.docs
          .map((item) => item.data() as Map<String, dynamic>)
          .toList();

      pedidoData['items'] = items;
      return pedidoData;
    }
    return null;
  }

  // Criar um novo item em uma ordem
  Future<String> createItem(String orderId, String name, double value) async {
    try {
      DocumentReference itemRef = await _store
          .collection(collectionPath)
          .doc(orderId)
          .collection("items")
          .add({
        'name': name,
        'value': value,
      });
      log('Item adicionado com ID: ${itemRef.id}');
      return itemRef.id;
    } catch (e) {
      log('Erro ao adicionar item: $e');
      return '';
    }
  }

// Excluir um item de uma ordem
  Future<void> deleteItem(String orderId, String itemId) async {
    try {
      await _store
          .collection(collectionPath)
          .doc(orderId)
          .collection("items")
          .doc(itemId)
          .delete();
    } catch (e) {
      log('Erro ao excluir item: $e');
    }
  }

// Criar uma nova rachadinha em um item
  Future<void> createRachadinha(
      String orderId, String itemId, String name, double value) async {
    try {
      await _store
          .collection(collectionPath)
          .doc(orderId)
          .collection("items")
          .doc(itemId)
          .collection("rachadinhas")
          .add({
        'name': name,
        'value': value,
      });
    } catch (e) {
      log('Erro ao adicionar rachadinha: $e');
    }
  }

// Excluir uma rachadinha de um item
  Future<void> deleteRachadinha(
      String orderId, String itemId, String rachadinhaId) async {
    try {
      await _store
          .collection(collectionPath)
          .doc(orderId)
          .collection("items")
          .doc(itemId)
          .collection("rachadinhas")
          .doc(rachadinhaId)
          .delete();
    } catch (e) {
      log('Erro ao excluir rachadinha: $e');
    }
  }
}
