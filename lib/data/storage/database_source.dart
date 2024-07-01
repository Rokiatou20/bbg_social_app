import 'dart:convert';

import 'package:test_drive/data/database/database_helper.dart';
import 'package:test_drive/data/models/session/session.dart';
import 'package:test_drive/data/storage/local_storage_service.dart';

class DatabaseSource extends LocalStorageService {

  static List<Map<String, dynamic>>? _list = [];
  static DatabaseSource? _instance;

  DatabaseSource._();

  static Future<DatabaseSource> getInstance() async {
    _list =  await  DatabaseHelper.selectAllSessions();

    if (_instance == null) {
      _instance = DatabaseSource._();
    }

    return _instance!;
  }

  @override
  Future<void> clear() async {
    await DatabaseHelper.deleteAllSessions();
  }

  @override
  Session? getConnectedUser() {

    if (_list == null){
      return null;
    }
    if (_list!.isEmpty) {
      return null;
    }
    Map<String, dynamic> row = _list!.first;
    String data = row["data"];
    Map<String, dynamic> json = jsonDecode(data);

    return Session.fromJson(json);
  }

  @override
  Future<void> storeConnectedUser(Session session) async {
    await DatabaseHelper.deleteAllSessions();
    await DatabaseHelper.insertSession(session.toJson());
    await refreshList();
  }

  static refreshList() async {
    _list =  await  DatabaseHelper.selectAllSessions();
  }

}