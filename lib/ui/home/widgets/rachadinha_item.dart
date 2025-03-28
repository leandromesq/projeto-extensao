import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/data/models/rachadinha_model.dart';
import 'package:rachadinha/ui/home/viewmodels/home_viewmodel.dart';

class RachadinhaItem extends StatefulWidget {
  final RachadinhaModel rachadinhaModel;
  const RachadinhaItem({super.key, required this.rachadinhaModel});

  @override
  State<RachadinhaItem> createState() => _RachadinhaItemState();
}

class _RachadinhaItemState extends State<RachadinhaItem> {
  var ctrl = injector.get<HomeViewmodel>();
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
              const SizedBox(width: 8),
              Transform.flip(
                flipX: true,
                child: IconButton(
                  icon: Icon(
                    Icons.receipt_long_rounded,
                    color: context.colors.primarygreen,
                    size: 34,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    iconSize: 40,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    ctrl.removeRachadinha(rachadinha);
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => const ReceiptDialog());
                  },
                ),
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
