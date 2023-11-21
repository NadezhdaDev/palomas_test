import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palomas_test/domain/repository/order_repo.dart';

import '../../data/repository/orders_sql_repo.dart';
import '../../presentation/attributes/config/app_config.dart';
import '../../presentation/attributes/config/app_parametrs.dart';
import '../../presentation/navigation/route_path.dart';
import '../../presentation/navigation/router.dart';

class EntryPoints {
  static late AppConfig projectAppConfig;

  static Future<void> main(AppConfig appConfig) async {
    projectAppConfig = appConfig;
    WidgetsFlutterBinding.ensureInitialized();

    final repository = OrdersSQLRepo.instance;
    await repository.init();

    return runApp(RepositoryProvider<OrderRepo>.value(
      value: repository,
      child: MaterialApp(
        navigatorKey: globalKey,
        initialRoute: RoutePath.mainScreen,
        onGenerateRoute: (routeSettings) => ProjectRouter.getAppRouteFactory(
          routeSettings,
        ),
        onGenerateInitialRoutes: (initialRoute) => [
          ProjectRouter.getAppRouteFactory(
            RouteSettings(
              name: initialRoute,
            ),
          ),
        ],
      ),
    ),);

   // return runApp();
  }
}
