import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/ui/history/viewmodels/history_viewmodel.dart';

class OrderSummaryDialog extends StatelessWidget {
  const OrderSummaryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrl = injector.get<HistoryViewModel>();
    final money = NumberFormat("##,##0.00", "pt_BR");
    var people = ctrl.peopleList;
    return Dialog(
      child: ListenableBuilder(
        listenable: ctrl,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: 640,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      DateFormat('dd/MM/yyyy - HH:mm')
                          .format(ctrl.selectedOrder!.date!),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.separated(
                        itemCount: people.length,
                        separatorBuilder: (context, index) => DottedDashedLine(
                          height: 0,
                          width: 300,
                          axis: Axis.horizontal,
                          dashColor: context.colors.primarygreen,
                        ),
                        itemBuilder: (context, index) {
                          var person = people[index];
                          var rachadinhas = person.rachadinhas;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: SizedBox(
                                  width: 300,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            person.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 28),
                                          ),
                                          Text(
                                            'R\$ ${money.format(person.total)}',
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: rachadinhas.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 8),
                                        itemBuilder: (context, index) {
                                          var rachadinha = rachadinhas[index];
                                          return SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '- ${rachadinha.itemName}:',
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  'R\$ ${money.format(rachadinha.price)}',
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: context.colors.darkgreen,
                          ),
                        ),
                        Text(
                          'R\$ ${money.format(ctrl.selectedOrder!.total)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
