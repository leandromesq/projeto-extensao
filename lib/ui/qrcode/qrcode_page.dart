import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rachadinha/core/utils/extensions/screen_extensions.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:routefly/routefly.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
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
      body: Center(
          child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        height: context.screenHeight * 0.7,
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: const Icon(
                Icons.qr_code_scanner,
                size: 264,
                color: Colors.white,
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
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
