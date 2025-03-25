import 'package:flutter/material.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/screen_extensions.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/ui/home/viewmodels/home_viewmodel.dart';
import 'package:rachadinha/ui/home/widgets/home_app_bar.dart';
import 'package:rachadinha/ui/home/widgets/home_drawer.dart';
import 'package:rachadinha/ui/home/widgets/receipt_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var ctrl = injector.get<HomeViewmodel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var order = ctrl.order;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.light,
        appBar: const HomeAppBar(),
        drawer: const HomeDrawer(),
        body: SingleChildScrollView(
          child: ListenableBuilder(
              listenable: ctrl,
              builder: (context, _) {
                return SizedBox(
                  child: Column(
                    children: [
                      Divider(color: context.colors.primarygreen),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: SizedBox(
                          height: .8 * context.screenHeight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              SizedBox(
                                width: 250,
                                height: 80,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w500),
                                  cursorHeight: 50,
                                  showCursor: false,
                                  decoration: const InputDecoration(
                                    hintText: 'ITEM',
                                    hintStyle: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    ctrl.item.name = value;
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
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    context.colors.primarygreen,
                                                width: 2.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    context.colors.primarygreen,
                                                width: 2.0,
                                              ),
                                            )),
                                        onChanged: (value) {
                                          ctrl.item.price = double.parse(value);
                                        },
                                      )),
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
                                      order.items.add(ctrl.item);
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      value: ctrl.rachadinha.active,
                                      onChanged: (value) {
                                        ctrl.rachadinha.active =
                                            !ctrl.rachadinha.active;
                                      }),
                                  SizedBox(
                                      height: 40,
                                      width: 200,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    context.colors.primarygreen,
                                                width: 2.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    context.colors.primarygreen,
                                                width: 2.0,
                                              ),
                                            )),
                                        onChanged: (value) {
                                          ctrl.rachadinha.name = value;
                                        },
                                      )),
                                  const SizedBox(width: 10),
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
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ReceiptDialog());
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Text('Total: R\$ 0,00',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: context.colors.black)),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.maxFinite,
                                height: 60,
                                child: ElevatedButton.icon(
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                              Text('Total: R\$ 0,00',
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
