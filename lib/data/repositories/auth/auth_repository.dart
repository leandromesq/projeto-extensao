import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class AuthRepository {
  AsyncResult<LoggedUser> login(Credentials credentials);
  AsyncResult<Unit> logout();
  AsyncResult<LoggedUser> getUser();
  Stream<User> userObserver();

  void dispose();
}
