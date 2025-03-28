import 'package:flutter/foundation.dart';
import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/repositories/auth/auth_repository.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:result_dart/result_dart.dart';
import 'package:result_command/result_command.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  late final loginCommand = Command1(_login);
  late final registerCommand = Command1(register);

  Future<String?> getSavedUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_uid'); // Retorna null se não houver UID salvo
  }

  AsyncResult<UserModel> _login(Credentials credentials) async {
    return await _authRepository.login(credentials);
  }

  AsyncResult<UserModel> register(Credentials credentials) async {
    return await _authRepository.register(credentials);
  }

  Future<void> logout() async => await _authRepository.logout();
}
