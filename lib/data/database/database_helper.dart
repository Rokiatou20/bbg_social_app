import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_drive/configuration/constants.dart';

class DatabaseHelper {

  static String TABLE_SESSION = "sessions";
  static Database? database;

  // Open the database and store the reference.
  static connection() async {
    print("Open database");
    database = await openDatabase(
      join(await getDatabasesPath(), Constants.databaseName),
      onCreate: (db, version) async {
        print("onCreateTable Sessions");
        await db.execute(
          "CREATE TABLE $TABLE_SESSION ("
            "id INTEGER PRIMARY KEY,"
            "data TEXT"
          ")"
        );
      },
      version: Constants.databaseVersion,
    );
    return database;
  }

  static insertSession(Map<String, dynamic> session) async {

    try {
      print("InsertSession()");
      await database?.insert(TABLE_SESSION, {
        "data": jsonEncode(session)
      });
    }
    catch (error) {
      print("insertSession() error  => $error");
    }
  }

  static Future<List<Map<String, dynamic>>?> selectAllSessions() async {
    print("selectAllSessions()");
    return await database?.query(TABLE_SESSION);
  }

  static deleteAllSessions() async {
    print("deleteAllSessions()");

    await database?.rawDelete(
      "DELETE FROM $TABLE_SESSION"
    );
  }
}