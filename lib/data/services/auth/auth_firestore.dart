import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthFirestore {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  // Adicionando um usuário
  Future<void> adicionarUsuario({
    required String name,
    required String email,
    required String password,
    required String profilepic,
    required String qrcode,
  }) async {
    try {
      await _store.collection('users').add({
        'name': name,
        'email': email,
        'password': password, // Em produção, criptografe a senha!
        'profilepic': profilepic,
        'qrcode': qrcode,
      });
      log('Usuário adicionado com sucesso!');
    } catch (e) {
      log('Erro ao adicionar usuário: $e');
    }
  }

  // Adicionando um pedido
  Future<String> adicionarPedido({
    required String userId,
    required double total,
    required DateTime date,
  }) async {
    try {
      DocumentReference docRef = await _store.collection('orders').add({
        'userId': userId,
        'total': total,
        'date': Timestamp.fromDate(date),
      });
      log('Pedido adicionado com ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      log('Erro ao adicionar pedido: $e');
      return '';
    }
  }

  // Adicionando um item ao pedido
  Future<String> adicionarItem({
    required String orderId,
    required String name,
    required double value,
  }) async {
    try {
      DocumentReference pedidoRef = _store.collection('orders').doc(orderId);
      DocumentReference itemRef = await pedidoRef.collection('items').add({
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

  // Adicionando uma rachadinha ao item
  Future<void> adicionarRachadinha({
    required String orderId,
    required String itemId,
    required String name,
    required double value,
  }) async {
    try {
      DocumentReference itemRef = _store
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .doc(itemId);

      await itemRef.collection('rachadinhas').add({
        'name': name,
        'value': value,
      });

      log('Rachadinha adicionada com sucesso!');
    } catch (e) {
      log('Erro ao adicionar rachadinha: $e');
    }
  }
}
