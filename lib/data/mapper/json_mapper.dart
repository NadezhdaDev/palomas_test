import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:palomas_test/domain/model/order.dart';

import '../../presentation/attributes/enum/category_goods.dart';

class JsonMapper {
  Future<List<Order>> getGoodsFromJson(
      BuildContext context, CategoryGoods category) async {
    String data = await DefaultAssetBundle.of(context).loadString(
        "assets/goods/${category.name}.json");
    final decoded = jsonDecode(data);
    List<Order> listArticles = [];
    for (final item in decoded) {
      final Order person = Order.fromJsonAssets(item);
      listArticles.add(person);
    }

    return listArticles;
  }
}
