import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/repositories/user/user_repository.dart';
import 'package:rachadinha/data/services/user/user_firestore.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._store);
  final UserFirestore _store;

  @override
  AsyncResult<void> editUser(
      String userId, String? name, String? email, String? qrcode) {
    return _store.editUser(userId, name, email, qrcode);
  }

  @override
  AsyncResult<UserModel> getUser(String userId) async {
    return _store.getUserById(userId);
  }
}
