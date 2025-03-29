import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/screen_extensions.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/ui/qrcode/viewmodels/qrcode_viewmodel.dart';
import 'package:routefly/routefly.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  var ctrl = injector.get<QrcodeViewModel>();

  @override
  void initState() {
    super.initState();
    ctrl.getQrcodeCommand.execute();
  }

  Future<void> _pickImage() async {
    File? qrImage;

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        qrImage = File(pickedFile.path);
      });

      // Upload para imgBB
      String? downloadUrl = await ctrl.uploadQRCodeToImgBB(qrImage!);

      if (downloadUrl != null) {
        // Salvar a URL no Firestore
        ctrl.addQrcode(newqrcode: downloadUrl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primarygreen,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Icon(
                FontAwesomeIcons.moneyBillTransfer,
                color: context.colors.white,
                size: 38,
              ),
            ],
          ),
        ),
      ),
      body: ListenableBuilder(
          listenable: ctrl,
          builder: (context, _) {
            var qrcode = ctrl.qrcode;
            if (ctrl.getQrcodeCommand.isRunning) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
            return Center(
                child: Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              height: context.screenHeight * 0.7,
              child: Column(
                children: [
                  InkWell(
                    onTap: _pickImage,
                    child: qrcode == null
                        ? const Icon(
                            Icons.qr_code_scanner,
                            size: 264,
                            color: Colors.white,
                          )
                        : Image.network(
                            qrcode,
                            width: 264,
                            height: 264,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.qr_code_scanner,
                                size: 264,
                                color: Colors.white,
                              );
                            },
                          ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.maxFinite,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Routefly.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.tertiarygreen,
                      ),
                      child: const Text('Voltar',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ));
          }),
    );
  }
}
