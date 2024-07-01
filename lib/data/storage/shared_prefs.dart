import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_drive/data/models/session/session.dart';

import 'local_storage_service.dart';

class SharedPrefs extends LocalStorageService {

  static const String PREF_CONNECTED_USER_KEY = "bridgebank_social_app.PREF_CONNECTED_USER_KEY";
  SharedPreferences _prefs;

  SharedPrefs(this._prefs);

  @override
  Future<void> clear () async {
    await _prefs.clear();
  }

  @override
  Session? getConnectedUser() {
    final String? jsonString = _prefs.getString(PREF_CONNECTED_USER_KEY);
    if (jsonString == null) {
      return null;
    }
    final Map<String, dynamic> jsonSession = jsonDecode(jsonString);
    return Session.fromJson(jsonSession);
  }

  @override
  Future<void> storeConnectedUser(Session session) async {
    await _prefs.setString(PREF_CONNECTED_USER_KEY, jsonEncode(session.toJson()));
  }

}