import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class IModel {
  int id;

  Map<String, dynamic> toMap();
}

class DatabaseService {
  final String dbName = "cb_measurement.dbs";
  final Map<String, String> tables = {
    "history": """
            create table history
            (
              id integer primary key autoincrement,
              history text
            )
              """,
  };

  static DatabaseService dbService;
  static Database _database;

  DatabaseService._createInstance();

  factory DatabaseService() {
    if (dbService == null) {
      dbService = DatabaseService._createInstance();
    }
    return dbService;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + dbName;

    var noteDatabase =
        await openDatabase(path, version: 1, onCreate: _createTable);
    return noteDatabase;
  }

  void _createTable(Database db, int newVersion) async {
    tables.forEach((String key, String value) async {
      await db.execute(value);
    });

    ///for app version
    ///await _saveSysInfo(db);
  }

  Future<void> _saveSysInfo(Database db) async {
    await db.execute(
        'INSERT INTO SystemInfo VALUES (?)', [DateTime.now().toString()]);
  }

  Future<List<Map<String, dynamic>>> getMapListRawQuery({String query}) async {
    Database db = await this.database;
    var result = await db.rawQuery(query);
    return result;
  }

  Future<List<T>> getSingleColumnListRawQuery<T>(
      {String query, String columnName}) async {
    Database db = await this.database;
    var result = await db.rawQuery(query);

    List<T> columnList = result.map<T>((value) => value[columnName]).toList();

    return columnList;
  }

  Future<List<Map<String, dynamic>>> getMapList({String tableName}) async {
    Database db = await this.database;
    var result = await db.query(tableName);
    return result;
  }

  Future<List<Map<String, dynamic>>> getMapListWithOrder(
      {String tableName, String orderBy}) async {
    Database db = await this.database;
    var result = await db.query(tableName, orderBy: orderBy);
    return result;
  }

  Future<List<Map<String, dynamic>>> getMapListWithFilter(
      {String tableName, String where, List<dynamic> whereArgs}) async {
    Database db = await this.database;
    var result = await db.query(tableName, where: where, whereArgs: whereArgs);
    return result;
  }

  Future<int> insert({String tableName, IModel model}) async {
    Database db = await this.database;
    var result = await db.insert(tableName, model.toMap());
    return result;
  }

  Future<int> update({String tableName, IModel model}) async {
    var db = await this.database;
    var result = await db.update(tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
    return result;
  }

  Future<int> delete({String tableName, int id}) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableName WHERE id = $id');
    return result;
  }

  Future<int> deleteAll({String tableName}) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableName');
    return result;
  }
}
