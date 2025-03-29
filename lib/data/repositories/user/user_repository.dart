import 'package:rachadinha/data/models/user_model.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class UserRepository {
  AsyncResult<UserModel> getUser(String userId);
  Future<void> editUser(UserModel user);
}
