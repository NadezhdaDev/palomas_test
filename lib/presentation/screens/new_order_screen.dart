import 'package:flutter/material.dart';

import '../attributes/enum/orders_type.dart';
import '../navigation/navigation.dart';
import '../navigation/route_path.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание заказа'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[200],
              child: const Center(child: Text("Зал № 1")),
            ),
            onTap: () {
              navigate(
                RoutePath.createOrderScreen,
                argument: OrdersType.firstRoom,
                replace: false,
              );
            },
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.blue[200],
              child: const Center(child: Text('Зал № 2')),
            ),
            onTap: () {
              navigate(
                RoutePath.createOrderScreen,
                argument: OrdersType.secondRoom,
                replace: false,
              );
            },
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.green[200],
              child: const Center(child: Text('Веранда')),
            ),
            onTap: () {
              navigate(
                RoutePath.createOrderScreen,
                argument: OrdersType.veranda,
                replace: false,
              );
            },
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red[200],
              child: const Center(child: Text('VIP')),
            ),
            onTap: () {
              navigate(
                RoutePath.createOrderScreen,
                argument: OrdersType.vip,
                replace: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
