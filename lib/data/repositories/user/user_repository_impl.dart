import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/repositories/user/user_repository.dart';
import 'package:rachadinha/data/services/user/user_firestore.dart';
import 'package:result_dart/result_dart.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._store);
  final UserFirestore _store;

  @override
  AsyncResult<void> editUser(UserModel user) {
    return _store.editUser(user.id, user.name, user.email, user.qrcode);
  }

  @override
  AsyncResult<UserModel> getUser(String userId) async {
    return _store.getUserById(userId);
  }
}
