import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/order.dart';
import '../../domain/repository/order_repo.dart';
import '../attributes/enum/orders_type.dart';

class HistoryOrdersScreen extends StatelessWidget {
  const HistoryOrdersScreen({super.key});

  String _getText(String ordersType) {
    if (ordersType == OrdersType.firstRoom.name) {
      return 'Зал № 1';
    } else if (ordersType == OrdersType.secondRoom.name) {
      return 'Зал № 2';
    } else if (ordersType == OrdersType.veranda.name) {
      return 'Веранда';
    } else {
      return 'VIP';
    }
  }

  Color? _getColor(String ordersType) {
    if (ordersType == OrdersType.firstRoom.name) {
      return Colors.teal[200];
    } else if (ordersType == OrdersType.secondRoom.name) {
      return Colors.blue[200];
    } else if (ordersType == OrdersType.veranda.name) {
      return Colors.green[200];
    } else {
      return Colors.red[200];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Order>>(
        future: context.read<OrderRepo>().getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: _getColor(snapshot.data![index].ordersType),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(snapshot.data![index].name),
                          ),
                          Text('${snapshot.data![index].quantity}  шт.'),
                          Text(_getText(snapshot.data![index].ordersType)),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const Center(
              child: Text('Loading data...'),
            );
          }
        },
      ),
    );
  }
}
