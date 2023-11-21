import 'package:palomas_test/domain/model/order.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/repository/order_repo.dart';

class OrdersSQLRepo extends OrderRepo {
  static final OrdersSQLRepo instance = OrdersSQLRepo._init();
  static const String tableOrders = 'OrderTable';
  final filePath = "basket.db";

  static Database? _database;

  OrdersSQLRepo._init();

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const integerType = 'INTEGER';

    await db.execute('''
CREATE TABLE $tableOrders (
  ${DBOrdersFields.id} $idType,
  ${DBOrdersFields.uuid} $integerType,
  ${DBOrdersFields.name} $textType,
  ${DBOrdersFields.quantity} $integerType,
  ${DBOrdersFields.ordersType} $textType
  )
''');
  }

  @override
  Future<int> update(Order order) {
    return _database!.update(
      tableOrders,
      order.toJson(),
      where: '${DBOrdersFields.id} = ?',
      whereArgs: [DBOrdersFields.id],
    );
  }

  @override
  Future<void> add(Order order) async {
    final id = await _database!.insert(tableOrders, order.toJson());
    order.copy(id: id);
  }

  @override
  Future<List<Order>> getOrders() async {
    final result = await _database!.query(tableOrders);
    return result.map((json) => Order.fromJson(json)).toList();
  }

  @override
  Future<void> init() async {
    if (_database == null) {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      _database = await openDatabase(path, version: 1, onCreate: _createDB);
    }
  }

  @override
  Future<void> remove(Order order) async {
    await _database!.delete(
      tableOrders,
      where: '${DBOrdersFields.uuid} = ?',
      whereArgs: [order.uuid],
    );
  }

  @override
  Future<Order?> getOrder(int uuid) async {
    return await _database!.query(
      tableOrders,
      columns: DBOrdersFields.values,
      where: '${DBOrdersFields.uuid} = ?',
      whereArgs: [uuid],
    ).then((maps) => maps.isEmpty ? null : Order.fromJson(maps.first));
  }

  @override
  Future<void> removeAllDB(Order order) async {
    await _database!.rawDelete("DELETE FROM $tableOrders");
  }

  @override
  Future<void> closeDB() async {
    return _database!.close();
  }
}
