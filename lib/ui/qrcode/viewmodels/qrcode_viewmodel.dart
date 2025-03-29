import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/repositories/user/user_repository.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrcodeViewModel extends ChangeNotifier {
  final UserRepository repo;

  QrcodeViewModel(this.repo);

  late final getQrcodeCommand = Command0(_getQrcode);

  UserModel? user;
  String? qrcode;

  AsyncResult<Unit> _getQrcode() async {
    var uid = await getSavedUID();
    user = await repo.getUser(uid!).fold((s) => s, (error) => null);
    qrcode = user!.qrcode;
    log('qrcode: $qrcode');
    notifyListeners();
    return const Success(unit);
  }

  Future<void> addQrcode({required String newqrcode}) async {
    var uid = await getSavedUID();
    user = await repo.getUser(uid!).fold((s) => s, (error) => null);
    user!.qrcode = newqrcode;
    await repo.editUser(user!);
    getQrcodeCommand.execute();
  }

  Future<void> deleteQrcode() async {}

  Future<String?> getSavedUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_uid'); // Retorna null se não houver UID salvo
  }

  Future<String?> uploadQRCodeToImgBB(File image) async {
    const String apiKey =
        "916493f7d4eca78e6a13b3329e81ccc1"; // Substitua pela sua API Key

    try {
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      var response = await http.post(
        Uri.parse("https://api.imgbb.com/1/upload?key=$apiKey"),
        body: {"image": base64Image},
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return jsonData["data"]["url"]; // Retorna a URL da imagem
      } else {
        log("Erro ao enviar imagem: ${response.body}");
        return null;
      }
    } catch (e) {
      log("Erro ao fazer upload no imgBB: $e");
      return null;
    }
  }
}
