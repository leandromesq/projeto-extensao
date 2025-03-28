import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/ui/home/viewmodels/home_viewmodel.dart';

class ReceiptDialog extends StatelessWidget {
  const ReceiptDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrl = injector.get<HomeViewModel>();
    final money = NumberFormat("##,##0.00", "pt_BR");
    var rachadinhas = ctrl.personRachadinhas;
    return Dialog(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: SizedBox(
                width: 300,
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rachadinhas.first.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      const SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: ListView.separated(
                          itemCount: rachadinhas.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            var rachadinha = rachadinhas[index];
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('- ${rachadinha.itemName}:',
                                      style: const TextStyle(fontSize: 20)),
                                  Text('R\$ ${money.format(rachadinha.price)}',
                                      style: const TextStyle(fontSize: 20)),
                                ]);
                          },
                        ),
                      ),
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
                    Text('R\$ ${money.format(ctrl.personTotal)}',
                        style: const TextStyle(
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
