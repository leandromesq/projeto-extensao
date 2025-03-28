import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/repositories/user/user_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrcodeViewModel extends ChangeNotifier {
  final UserRepository repo;

  QrcodeViewModel(this.repo);

  UserModel? user;
  String qrcode = '';

  Future<void> getQrcode() async {
    var uid = await getSavedUID();
    user = await repo.getUser(uid!).fold((s) => s, (error) => null);
    qrcode = user!.qrcode;
  }

  Future<void> addQrcode() async {}

  Future<void> deleteQrcode() async {}

  Future<String?> getSavedUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_uid'); // Retorna null se não houver UID salvo
  }
}
