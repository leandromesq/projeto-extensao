import 'dart:async';

import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/repositories/auth/auth_repository.dart';
import 'package:rachadinha/data/services/auth/auth_local_storage.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:rachadinha/domain/validators/credentials_validator.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authLocalStorage);

  final AuthLocalStorage _authLocalStorage;

  final _streamController = StreamController<User>.broadcast();

  @override
  AsyncResult<LoggedUser> getUser() {
    return _authLocalStorage.getUser();
  }

  @override
  AsyncResult<LoggedUser> login(Credentials credentials) async {
    final validator = CredentialsValidator();

    if (!validator.validate(credentials).isValid) {
      return Failure(Exception('Invalid credentials'));
    }
    return _authLocalStorage //
        .login(credentials)
        .flatMap(_authLocalStorage.saveUser)
        .onSuccess(_streamController.add);
  }

  @override
  AsyncResult<Unit> logout() {
    return _authLocalStorage //
        .removeUser()
        .onSuccess(
          (_) => _streamController.add(const NotLoggedUser()),
        );
  }

  @override
  Stream<User> userObserver() {
    return _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
