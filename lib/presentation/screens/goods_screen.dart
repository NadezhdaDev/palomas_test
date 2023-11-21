import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/mapper/json_mapper.dart';
import '../../domain/model/order.dart';
import '../attributes/enum/category_goods.dart';
import '../attributes/enum/orders_type.dart';
import '../navigation/navigation.dart';
import '../navigation/route_path.dart';
import '../state/order/order_cubit.dart';
import '../state/order/order_state.dart';

class GoodsScreen extends StatelessWidget {
  final CategoryGoods categoryGoods;
  final BuildContext contextCubit;
  final OrdersType ordersType;

  const GoodsScreen({
    super.key,
    required this.categoryGoods,
    required this.contextCubit,
    required this.ordersType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Order>>(
        future: JsonMapper().getGoodsFromJson(context, categoryGoods),
        builder: (context, snapshot) {
          return BlocBuilder<OrderCubit, OrderState>(
              builder: (contextCubit, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                _listView(snapshot, contextCubit),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: ElevatedButton(onPressed: () {
                    navigate(
                      RoutePath.ordersScreen,
                      argument: [contextCubit,ordersType],
                      replace: false,
                    );
                  }, child: const Text('Оформить')),
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot, BuildContext contextCubit) {
    if (snapshot.hasData) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(snapshot.data[index].name),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          final orderCubit = contextCubit.read<OrderCubit>();
                          orderCubit.incOrder(snapshot.data[index]);
                        },
                        child: const Text('+'),
                      ),
                      Text('${_getText(snapshot.data[index], contextCubit)}'),
                      TextButton(
                        onPressed: () {
                          final orderCubit = contextCubit.read<OrderCubit>();
                          orderCubit.decOrder(snapshot.data[index]);
                        },
                        child: const Text('-'),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      );
    } else if (snapshot.hasError) {
      return const Center(
        child: Text('Error'),
      );
    } else {
      return const Center(
        child: Text('Loading data...'),
      );
    }
  }

  int _getText(Order data, BuildContext context) {
    var orderCubit = contextCubit.read<OrderCubit>();
    var ordersList = orderCubit.ordersList;
    for (var order in ordersList) {
      if (order.uuid == data.uuid) {
        return order.quantity;
      }
    }

    return 0;
  }
}
