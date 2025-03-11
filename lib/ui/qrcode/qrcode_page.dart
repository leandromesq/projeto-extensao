import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        leading: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(8),
          color: context.colors.primarygreen,
          child: IconButton(
            color: context.colors.white,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 38,
            ),
            onPressed: () => Routefly.pop(context),
          ),
        ),
      ),
    );
  }
}
