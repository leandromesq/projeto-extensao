import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/screen_extensions.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/data/models/item_model.dart';
import 'package:rachadinha/data/models/order_model.dart';
import 'package:rachadinha/ui/history/viewmodels/history_viewmodel.dart';
import 'package:rachadinha/ui/history/widgets/order_summary_dialog.dart';
import 'package:result_command/result_command.dart';
import 'package:routefly/routefly.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var ctrl = injector.get<HistoryViewModel>();

  @override
  void initState() {
    super.initState();
    ctrl.findOrdersCommand.addListener(_listenable);
    ctrl.findOrdersCommand.execute();
  }

  void _listenable() {
    if (ctrl.findOrdersCommand.isFailure) {
      final error = ctrl.findOrdersCommand.value as FailureCommand;
      final snackBar = SnackBar(content: Text(error.error.toString()));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.light,
      appBar: AppBar(
        title: Text(
          'HISTÓRICO',
          style: TextStyle(
              color: context.colors.primarygreen,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.colors.primarygreen,
            size: 32,
          ),
          onPressed: () => Routefly.pop(context),
        ),
        backgroundColor: context.colors.light,
      ),
      body: SizedBox(
        height: context.screenHeight,
        child: Column(
          children: [
            Divider(color: context.colors.primarygreen),
            Expanded(
              child: ListenableBuilder(
                  listenable: ctrl.findOrdersCommand,
                  builder: (context, _) {
                    if (ctrl.findOrdersCommand.isRunning) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: context.colors.primarygreen,
                      ));
                    }
                    var orders = ctrl.orders;
                    // Agrupar pedidos por data
                    Map<String, List<OrderModel>> groupedOrders = {};
                    for (var order in orders) {
                      String dateKey =
                          DateFormat('MMM dd, yyyy').format(order.date!);
                      groupedOrders.putIfAbsent(dateKey, () => []).add(order);
                      groupedOrders[dateKey]!
                          .sort((a, b) => b.date!.compareTo(a.date!));
                    }
                    return ListView(
                      children: groupedOrders.entries.map((entry) {
                        return ExpansionTile(
                          shape: const ContinuousRectangleBorder(),
                          collapsedIconColor: context.colors.darkgreen,
                          iconColor: context.colors.darkgreen,
                          title: Text(entry.key,
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: context.colors.darkgreen)),
                          children: entry.value
                              .map((order) => _buildOrderCard(order))
                              .toList(),
                        );
                      }).toList(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    return Card(
      color: context.colors.tertiarygreen,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          ctrl.selectOrder(order);
          ctrl.listPeople(order);
          showDialog(
            context: context,
            builder: (context) => const OrderSummaryDialog(),
          );
        },
        splashColor: context.colors.darkgreen.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: context.screenWidth,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat('dd/MM/yyyy - HH:mm').format(order.date!),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 8),
              Column(
                children: order.items
                    .map((items) => _buildInstallmentTile(items))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstallmentTile(ItemModel item) {
    final money = NumberFormat("##,##0.00", "pt_BR");
    return ListTile(
      title: Text(item.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      subtitle: Text('Valor: R\$ ${money.format(item.price)}',
          style: const TextStyle(fontSize: 16)),
      leading: const Icon(
        FontAwesomeIcons.solidCircle,
        size: 8,
      ),
    );
  }
}
