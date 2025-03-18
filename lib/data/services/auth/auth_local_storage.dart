import 'dart:convert';

import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/services/local_storage.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:result_dart/result_dart.dart';

const _userKey = '_userKey';

class AuthLocalStorage {
  final LocalStorage _localStorage;
  AuthLocalStorage(this._localStorage);

  AsyncResult<LoggedUser> getUser() async {
    return _localStorage
        .getData(_userKey) //
        .map((json) => LoggedUser.fromJson(jsonDecode(json)));
  }

  AsyncResult<LoggedUser> saveUser(LoggedUser user) async {
    return _localStorage //
        .saveData(_userKey, jsonEncode(user.toJson()))
        .pure(user);
  }

  AsyncResult<Unit> removeUser() async {
    return _localStorage.removeData(_userKey);
  }

  AsyncResult<LoggedUser> login(Credentials credentials) async {
    // final response = await _clientHttp.post('/login', {
    //   'email': credentials.email,
    //   'password': credentials.password,
    // });

    // return response.map((response) {
    //   return LoggedUser.fromJson(response.data);
    // });

    await Future.delayed(const Duration(seconds: 2));
    return const Success(LoggedUser(
      id: 1,
      name: 'leandro mesquita',
      email: 'leandro.mesquita@bridsolucoes.com.br',
      token: 'token',
      refreshToken: 'refreshToken',
    ));
  }
}
