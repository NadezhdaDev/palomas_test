import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palomas_test/domain/repository/order_repo.dart';

import '../../domain/model/order.dart';
import '../attributes/enum/orders_type.dart';
import '../navigation/navigation.dart';
import '../navigation/route_path.dart';
import '../state/order/order_cubit.dart';
import '../state/order/order_state.dart';

class OrdersScreen extends StatelessWidget {
  final BuildContext contextCubit;
  final OrdersType ordersType;

  const OrdersScreen(
      {super.key, required this.contextCubit, required this.ordersType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<OrderCubit>.value(
        value: contextCubit.read<OrderCubit>(),
        child: BlocBuilder<OrderCubit, OrderState>(
            bloc: contextCubit.read<OrderCubit>(),
            builder: (contextCubit, state) {
              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount:
                          contextCubit.read<OrderCubit>().ordersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          key: ValueKey(
                              contextCubit.read<OrderCubit>().ordersList[index].name),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  contextCubit.read<OrderCubit>().ordersList[index].name),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      final orderCubit =
                                          contextCubit.read<OrderCubit>();

                                      orderCubit.incOrder(contextCubit
                                          .read<OrderCubit>()
                                          .ordersList[index]);
                                    },
                                    child: const Text('+'),
                                  ),
                                  Text(
                                      '${contextCubit.read<OrderCubit>().ordersList[index].quantity}'),
                                  TextButton(
                                    onPressed: () {
                                      final orderCubit =
                                          contextCubit.read<OrderCubit>();
                                      orderCubit.decOrder(contextCubit
                                          .read<OrderCubit>()
                                          .ordersList[index]);
                                    },
                                    child: const Text('-'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final ordersList =
                            contextCubit.read<OrderCubit>().ordersList;
                        final ordersRepo = context.read<OrderRepo>();
                        for (var order in ordersList) {
                          ordersRepo.add(Order(
                            uuid: order.uuid,
                            quantity: order.quantity,
                            name: order.name,
                            ordersType: ordersType.name,
                          ));
                        }
                        navigate(
                          RoutePath.mainScreen,
                          argument: contextCubit,
                          replace: true,
                        );
                      },
                      child: const Text('Оформить'),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
