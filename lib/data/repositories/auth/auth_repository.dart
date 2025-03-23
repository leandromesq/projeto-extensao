import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class AuthRepository {
  AsyncResult<UserModel> login(Credentials credentials);
  AsyncResult<void> logout();
  AsyncResult<UserModel> getUser();
  AsyncResult<UserModel> register(Credentials credentials);
  Stream<UserModel> userObserver();

  void dispose();
}
