import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/data/models/rachadinha_model.dart';
import 'package:rachadinha/ui/home/viewmodels/home_viewmodel.dart';
import 'package:rachadinha/ui/home/widgets/receipt_dialog.dart';

class RachadinhaItem extends StatefulWidget {
  final RachadinhaModel rachadinhaModel;
  const RachadinhaItem({super.key, required this.rachadinhaModel});

  @override
  State<RachadinhaItem> createState() => _RachadinhaItemState();
}

class _RachadinhaItemState extends State<RachadinhaItem> {
  var ctrl = injector.get<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    final money = NumberFormat("##,##0.00", "pt_BR");
    var rachadinha = widget.rachadinhaModel;
    return SizedBox(
      width: 300,
      height: 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  visualDensity: VisualDensity.comfortable,
                  side: BorderSide(
                    color: context.colors.darkgreen,
                    width: 2.0,
                  ),
                  value: rachadinha.active,
                  onChanged: (value) async {
                    ctrl.toggleRachadinha(rachadinha);
                  },
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                  height: 40,
                  width: 176,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.colors.primarygreen,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.colors.primarygreen,
                            width: 2.0,
                          ),
                        )),
                    onChanged: (value) {
                      rachadinha.name = value;
                    },
                  )),
              SpeedDial(
                icon: Icons.more_horiz,
                iconTheme: const IconThemeData(size: 36),
                buttonSize: const Size(48, 48),
                activeIcon: Icons.close,
                backgroundColor: Colors.transparent,
                foregroundColor: context.colors.primarygreen,
                elevation: 0,
                spacing: 10,
                children: [
                  SpeedDialChild(
                    child: const Icon(Icons.delete, color: Colors.white),
                    backgroundColor: Colors.red,
                    label: 'Excluir',
                    labelStyle: const TextStyle(fontSize: 16),
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Atenção'),
                              content: const Text(
                                  'Excluir uma pessoa com rachadinha em andamento removerá todos os itens, deseja continuar?'),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancelar',
                                      style: TextStyle(color: Colors.red)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    await ctrl.removeRachadinha(rachadinha);
                                    if (context.mounted &&
                                        ctrl.order.items.isNotEmpty) {
                                      ctrl.showFadingErrorPopup(context,
                                          'Todos os itens foram removidos');
                                    }
                                  },
                                  child: Text('Confirmar',
                                      style: TextStyle(
                                          color: context.colors.darkgreen)),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.receipt_long_rounded,
                        color: Colors.white),
                    backgroundColor: context.colors.primarygreen,
                    label: 'Visualizar',
                    labelStyle: const TextStyle(fontSize: 16),
                    onTap: () {
                      ctrl.loadPersonRachadinhas(rachadinha.name);
                      showDialog(
                        context: context,
                        builder: (context) => const ReceiptDialog(),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          Text(
              'Total: R\$ ${money.format(ctrl.getPersonTotal(rachadinha.name))}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: context.colors.black)),
        ],
      ),
    );
  }
}
