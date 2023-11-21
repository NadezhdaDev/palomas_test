
import '../model/order.dart';

abstract class OrderRepo {
  Future<void> init();

  Future<List<Order>> getOrders();

  Future<Order?> getOrder(int uuid);

  Future<void> add(Order order);

  Future<void> update(Order order);

  Future<void> remove(Order order);

  Future<void> removeAllDB (Order order);

  Future<void> closeDB ();
}
