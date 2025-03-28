import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/screen_extensions.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/ui/home/viewmodels/home_viewmodel.dart';
import 'package:rachadinha/ui/home/widgets/home_app_bar.dart';
import 'package:rachadinha/ui/home/widgets/home_drawer.dart';
import 'package:rachadinha/ui/home/widgets/rachadinha_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var ctrl = injector.get<HomeViewModel>();
  String? hintText = 'ITEM';

  final money = NumberFormat("##,##0.00", "pt_BR");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hintText = 'ITEM';
        });
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: context.colors.light,
        appBar: const HomeAppBar(),
        drawer: const HomeDrawer(),
        body: SingleChildScrollView(
          child: ListenableBuilder(
              listenable: ctrl,
              builder: (context, _) {
                var item = ctrl.item;
                return SizedBox(
                  child: Column(
                    children: [
                      Divider(color: context.colors.primarygreen),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: SizedBox(
                          height: .85 * context.screenHeight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              SizedBox(
                                width: 250,
                                height: 80,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w500),
                                  cursorHeight: 40,
                                  showCursor: hintText == null,
                                  cursorColor: context.colors.black,
                                  decoration: InputDecoration(
                                    hintText: hintText,
                                    hintStyle: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  controller: ctrl.nameController,
                                  onChanged: ctrl.updateItemName,
                                  onTap: () {
                                    setState(() {
                                      hintText = null;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                spacing: 10,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    r'R$',
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                      height: 60,
                                      width: 150,
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            ctrl.moneyFormatter
                                          ],
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                          style: const TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.w500),
                                          cursorHeight: 36,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: context
                                                      .colors.primarygreen,
                                                  width: 2.0,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: context
                                                      .colors.primarygreen,
                                                  width: 2.0,
                                                ),
                                              )),
                                          controller: ctrl.priceController,
                                          onChanged: (value) {
                                            ctrl.updateItemPrice();
                                          })),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    style: IconButton.styleFrom(
                                      backgroundColor: context.colors.darkgreen,
                                      iconSize: 50,
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      ctrl.addItem(context);
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 30),
                              Scrollbar(
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxHeight: 240),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: item.rachadinhas.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 8),
                                    itemBuilder: (context, index) =>
                                        RachadinhaItem(
                                            rachadinhaModel:
                                                item.rachadinhas[index]),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.maxFinite,
                                height: 60,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    await ctrl.addRachadinhaField();
                                  },
                                  label: const Text('Adicionar Pessoa',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600)),
                                  icon: Icon(
                                    Icons.add,
                                    color: context.colors.darkgreen,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        context.colors.tertiarygreen,
                                    iconSize: 34,
                                  ),
                                ),
                              ),
                              const Spacer(flex: 1),
                              SizedBox(
                                width: double.maxFinite,
                                height: 80,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ctrl.finishOrder();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: context.colors.darkgreen,
                                    iconSize: 34,
                                  ),
                                  child: const Text(
                                    'Finalizar',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                  'Total: R\$ ${money.format(ctrl.order.total)}',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: context.colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
