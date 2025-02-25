import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';

class ReceiptDialog extends StatelessWidget {
  const ReceiptDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: SizedBox(
                width: 300,
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nome do usuário',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('- Item 1:', style: TextStyle(fontSize: 20)),
                            Text('R\$ 10,00', style: TextStyle(fontSize: 20)),
                          ]),
                      SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('- Item 2:', style: TextStyle(fontSize: 20)),
                            Text('R\$ 20,00', style: TextStyle(fontSize: 20)),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
            DottedDashedLine(
              height: 0,
              width: 300,
              axis: Axis.horizontal,
              dashColor: context.colors.primarygreen,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: context.colors.darkgreen)),
                    const Text('R\$ 20,00',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
