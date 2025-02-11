import 'dart:convert';

import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/services/local_storage.dart';
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
}
