import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/shoppinglist.dart';

class DbHelper {
  String tblShoppingList = "shoppinglist";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colMeasure = "measure";
  String colQuantity = "quantity";

  DbHelper._internal();

  static final DbHelper _dbHelper = DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "shoppinglist.db";
    var dbShoppingList = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbShoppingList;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblShoppingList($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
            "$colDescription TEXT, $colMeasure TEXT, $colQuantity INTEGER)");
  }

  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db!;
  }

  Future<int> insertList(ShoppingList list) async {
    Database db = await this.db;
    var result = await db.insert(tblShoppingList, list.toMap());
    return result;
  }

  Future<List> getLists() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblShoppingList order by $colTitle ASC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblShoppingList")
    );
    return result!;
  }

  Future<int> updateList(ShoppingList list) async {
    var db = await this.db;
    var result = await db.update(tblShoppingList,
        list.toMap(),
        where: "$colId = ?",
        whereArgs: [list.id]);
    return result;
  }

  Future<int> deleteList(String id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblShoppingList WHERE $colId = $id');
    return result;
  }

}
