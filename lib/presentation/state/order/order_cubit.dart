import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/order.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  List<Order> _ordersList;

  List<Order> get ordersList => _ordersList;

  OrderCubit(this._ordersList) : super(OrderState(ordersList: _ordersList)) {
    emit(OrderState(ordersList: _ordersList));
  }

  Future<void> setProject(List<Order> value) async {
    _ordersList = value;
    emit(OrderState(ordersList: _ordersList));
  }

  Future<void> incOrder(Order orderOld) async {
    bool isContains = false;
    for (var order in _ordersList) {
      if (order.uuid == orderOld.uuid) {
        final newOrder = Order(id: order.id, uuid: order.uuid, quantity: order.quantity +1 , name: order.name, ordersType: order.ordersType);
        var index = _ordersList.indexOf(order);
        _ordersList.remove(order);
        _ordersList.insert(index, newOrder);
        isContains = true;
      }
    }
    if(!isContains){
      final newOrder = Order(
        id: orderOld.id,
        uuid: orderOld.uuid,
        quantity: orderOld.quantity + 1,
        name: orderOld.name,
        ordersType: orderOld.ordersType
      );
      _ordersList.add(newOrder);
    }

    emit(OrderState(ordersList: _ordersList));
  }


  Future<void> decOrder(Order orderOld) async {
    for (var order in _ordersList) {
      if (order.uuid == orderOld.uuid && order.quantity>0) {
        final newOrder = Order(id: order.id, uuid: order.uuid, quantity: order.quantity - 1 , name: order.name, ordersType: order.ordersType);
        if(newOrder.quantity > 0) {
          var index = _ordersList.indexOf(order);
          _ordersList.remove(order);
          _ordersList.insert(index, newOrder);
          _ordersList.remove(order);
        }else{
          _ordersList.remove(order);
        }
        break;
      }
    }

    emit(OrderState(ordersList: _ordersList));
  }

}