import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rachadinha/data/models/user_model.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthFirestore {
  final FirebaseFirestore _store;
  final FirebaseAuth _auth;

  AuthFirestore({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _store = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // Criar usuário com autenticação
  AsyncResult<UserModel> addUser({
    required String name,
    required String email,
    required String password,
    required DateTime birthDate,
  }) async {
    try {
      // Criar usuário no Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Salvar informações no Firestore (sem a senha!)
      await _store.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'profilepic': '',
        'qrcode': '',
        'birthDate': birthDate.toString(),
        'createdAt': DateTime.now(),
      });

      log('Usuário autenticado e salvo no Firestore!');
      return Success(UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        birthDate: birthDate,
        profilepic: '',
        qrcode: '',
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Failure(Exception('E-mail ja cadastrado.'));
      }
      log('Erro ao criar usuário: $e');
      return Failure(Exception(e.toString()));
    } catch (e) {
      log('Erro ao criar usuário: $e');
      return Failure(Exception(e.toString()));
    }
  }

  // Login de usuário
  AsyncResult<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log('Usuário logado com sucesso!');

      User? user = userCredential.user;
      if (user != null) {
        String uid = user.uid;
        log('UID: $uid');

        // Salva o UID no SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_uid', uid);

        return Success(uid);
      } else {
        return Failure(Exception("Usuário não encontrado."));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return Failure(Exception('Usuário ou senha inválidos.'));
      }
      log('Erro ao fazer login: $e');
      return Failure(Exception(e.toString()));
    }
  }

  // Logout de usuário
  AsyncResult<Unit> logoutUser() async {
    try {
      await _auth.signOut();
      log('Usuário deslogado.');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_uid');
      log('Usuário deslogado e UID removido.');
      return const Success(unit);
    } catch (e) {
      log('Erro ao deslogar usuário: $e');
      return Failure(Exception(e.toString()));
    }
  }

  // Deletar usuário
  AsyncResult<void> deleteUser() async {
    try {
      String userId = _auth.currentUser!.uid;

      // Apagar do Firestore
      await _store.collection('users').doc(userId).delete();

      // Apagar do Firebase Authentication
      await _auth.currentUser!.delete();

      log('Usuário deletado.');
      return const Success(Unit);
    } catch (e) {
      log('Erro ao deletar usuário: $e');
      return Failure(Exception(e.toString()));
    }
  }

  // Buscar usuário pelo ID
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
}
