import 'dart:async';

import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/repositories/auth/auth_repository.dart';
import 'package:rachadinha/data/services/auth/auth_firestore.dart';
import 'package:rachadinha/data/services/auth/auth_local_storage.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:rachadinha/domain/validators/credentials_validator.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authLocalStorage, this._store);

  final AuthLocalStorage _authLocalStorage;
  final AuthFirestore _store;

  final _streamController = StreamController<UserModel>.broadcast();

  @override
  AsyncResult<UserModel> getUser() {
    return _authLocalStorage.getUser();
  }

  @override
  AsyncResult<UserModel> login(Credentials credentials) async {
    final validator = LoginCredentialsValidator();

    if (!validator.validate(credentials).isValid) {
      return Failure(Exception('Invalid credentials'));
    }
    return _store //
        .loginUser(email: credentials.email, password: credentials.password)
        .flatMap(_store.getUserById)
        .flatMap(_authLocalStorage.saveUser)
        .onSuccess(_streamController.add);
  }

  @override
  AsyncResult<UserModel> register(Credentials credentials) async {
    final validator = RegisterCredentialsValidator();

    if (!validator.validate(credentials).isValid) {
      return Failure(Exception('Invalid credentials'));
    }

    return _store //
        .addUser(
            name: credentials.name ?? '',
            email: credentials.email,
            password: credentials.password,
            birthDate: credentials.birthDate!)
        .flatMap(_authLocalStorage.saveUser)
        .onSuccess(_streamController.add);
  }

  @override
  AsyncResult<void> logout() async {
    return _store //
        .logoutUser()
        .flatMap((_) => _authLocalStorage.removeUser())
        .onSuccess((_) => _streamController.add(UserModel.empty));
  }

  @override
  Stream<UserModel> userObserver() {
    return _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
