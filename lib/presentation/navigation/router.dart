import 'package:flutter/material.dart';
import 'package:palomas_test/presentation/navigation/route_path.dart';

import '../attributes/enum/orders_type.dart';
import '../screens/create_orders_screen.dart';
import '../screens/main_screen.dart';
import '../screens/orders_screen.dart';

class ProjectRouter {
  static Route getAppRouteFactory(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.mainScreen:
        return _routeMainScreen();

      case RoutePath.createOrderScreen:
        return _routeCreateOrderScreen(routeSettings.arguments as OrdersType);

      case RoutePath.ordersScreen:
        final params = routeSettings.arguments as List;
        final contextCubit = params.first as BuildContext;
        final orderType = params.last as OrdersType;
        return _routeOrdersScreenScreen(contextCubit,orderType);

      default:
        throw Exception(
          'Unsupported navigation route: ${routeSettings.name}!',
        );
    }
  }

  static Route _routeMainScreen() => MaterialPageRoute(
    builder: (_) => const MainScreen(),
  );

  static Route _routeOrdersScreenScreen(BuildContext contextCubit,OrdersType ordersType) => MaterialPageRoute(
    builder: (_) => OrdersScreen(
      contextCubit: contextCubit, ordersType: ordersType,
    ),
  );
  static Route _routeCreateOrderScreen(OrdersType ordersType) => MaterialPageRoute(
    builder: (_) => CreateOrdersScreen(
      ordersType: ordersType,
    ),
  );
}
