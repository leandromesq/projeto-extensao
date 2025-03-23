import 'package:flutter/foundation.dart';
import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/repositories/auth/auth_repository.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:result_dart/result_dart.dart';
import 'package:result_command/result_command.dart';

class AuthViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewmodel(this._authRepository);

  late final loginCommand = Command1(_login);
  late final registerCommand = Command1(register);

  AsyncResult<UserModel> _login(Credentials credentials) async {
    return await _authRepository.login(credentials);
  }

  AsyncResult<UserModel> register(Credentials credentials) async {
    return await _authRepository.register(credentials);
  }

  Future<void> logout() async => await _authRepository.logout();
}
