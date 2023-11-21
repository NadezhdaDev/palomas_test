import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palomas_test/presentation/state/order/order_cubit.dart';
import 'package:palomas_test/presentation/state/order/order_state.dart';

import '../attributes/enum/category_goods.dart';
import '../attributes/enum/orders_type.dart';
import 'goods_screen.dart';

class CreateOrdersScreen extends StatefulWidget {
  final OrdersType ordersType;

  const CreateOrdersScreen({required this.ordersType, super.key});

  @override
  State<CreateOrdersScreen> createState() => _CreateOrdersScreenState();
}

class _CreateOrdersScreenState extends State<CreateOrdersScreen> {
  List<Widget> _tabs(BuildContext contextCubit) => [
        GoodsScreen(
          categoryGoods: CategoryGoods.pizza,
          contextCubit: contextCubit,
          ordersType: widget.ordersType,
        ),
        GoodsScreen(
          categoryGoods: CategoryGoods.beverages,
          contextCubit: contextCubit,
          ordersType: widget.ordersType,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCubit>(
      create: (contextCubit) => OrderCubit([]),
      child:
          BlocBuilder<OrderCubit, OrderState>(builder: (contextCubit, state) {
        return DefaultTabController(
          length: _tabs(context).length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Товары'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Пицца'),
                  Tab(text: 'Напитки'),
                ],
              ),
            ),
            body: TabBarView(
              children: _tabs(contextCubit),
            ),
          ),
        );
      }),
    );
  }
}
