import 'dart:convert';
import 'dart:developer';

import 'package:db_miner/modal/quotes_modal.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class JsonHelper {
  JsonHelper._();
  static final JsonHelper jesonhelper = JsonHelper._();
  Logger logger = Logger();
  late Database database;

  String tableName = 'Quotestable';
  String colId = "Id";
  String colQuotes = "quote";
  String colAuther = 'author';
  String colCategory = 'category';
  String query = '';

  Future<List> getData() async {
    String data = await rootBundle.loadString('assets/JSON/quotes.json');
    List jsonData = jsonDecode(data);
    // log('DATA : ${jsonData.runtimeType}');
    // print(jsonData[0]);
    return jsonData;
  }

  init() async {
    String dbPath = await getDatabasesPath();

    String path = join(dbPath, 'quotes_database.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, ver) {
        query =
            "CREATE TABLE $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colQuotes TEXT NOT NULL,$colAuther TEXT,$colCategory TEXT)";

        db
            .execute(query)
            .then(
              (value) => logger.i("TABLE CREATED.."),
            )
            .onError((error, stackTrace) => logger.e("ERROR : $error"));
      },
      onUpgrade: (db, oldversion, newversion) {
        query =
            "CREATE TABLE $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colQuotes TEXT NOT NULL,$colAuther TEXT,$colCategory TEXT)";

        db
            .execute(query)
            .then(
              (value) => logger.i("TABLE CREATED.."),
            )
            .onError((error, stackTrace) => logger.e("ERROR : $error"));
      },
    );
  }

  Future<int> insertFavQuotes({required Quotes quotes}) async {
    return await database.insert(tableName, quotes.toMap);
  }

  Future<List<Quotes>> getAllFavQuotes() async {
    query = "SELECT * FROM $tableName";
    List<Map> allMapQuotes = await database.rawQuery(query);

    print("allFavouriteQuotes : $allMapQuotes");
    List<Quotes> allFavQuotes =
        allMapQuotes.map((e) => Quotes.fromSqlTable(data: e)).toList();
    return allFavQuotes;
  }

  Future<int> deleteFavQuotes({required int id}) async {
    query = "DELETE FROM $tableName WHERE $colId=$id";
    return await database.rawDelete(query);
  }
}
