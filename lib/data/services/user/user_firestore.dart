import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';

import 'package:rachadinha/data/models/user_model.dart';

class UserFirestore {
  final FirebaseFirestore _store;
  UserFirestore({FirebaseFirestore? firestore})
      : _store = firestore ?? FirebaseFirestore.instance;
  AsyncResult<UserModel> getUserById(String userId) async {
    try {
      DocumentSnapshot doc = await _store.collection('users').doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        var user = UserModel.fromMap(userData);
        return Success(user);
      } else {
        return Failure(Exception('Usuário não encontrado'));
      }
    } catch (e) {
      log('Erro ao buscar usuário: $e');
      return Failure(Exception(e.toString()));
    }
  }

  AsyncResult<Unit> editUser(
      String userId, String? name, String? email, String? qrcode) async {
    try {
      await _store.collection('users').doc(userId).update({'qrcode': ''});
      log('Usuário atualizado com sucesso: $userId');
      return const Success(unit);
    } catch (e) {
      log('Erro ao atualizar usuário: $e');
      return Failure(Exception(e.toString()));
    }
  }
}
