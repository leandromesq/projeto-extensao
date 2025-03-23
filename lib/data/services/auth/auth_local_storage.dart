import 'dart:convert';

import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/services/local_storage.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:result_dart/result_dart.dart';

const _userKey = '_userKey';

class AuthLocalStorage {
  final LocalStorage _localStorage;
  AuthLocalStorage(this._localStorage);

  AsyncResult<UserModel> getUser() async {
    return _localStorage
        .getData(_userKey) //
        .map((json) => UserModel.fromJson(jsonDecode(json)));
  }

  AsyncResult<UserModel> saveUser(UserModel user) async {
    return _localStorage //
        .saveData(_userKey, jsonEncode(user.toJson()))
        .pure(user);
  }

  AsyncResult<Unit> removeUser() async {
    return _localStorage.removeData(_userKey);
  }

  AsyncResult<UserModel> login(Credentials credentials) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(UserModel(
      id: '1',
      name: 'leandro mesquita',
      email: 'leandro.mesquita@bridsolucoes.com.br',
      birthDate: DateTime.now(),
      profilepic: '',
      qrcode: '',
    ));
  }
}
