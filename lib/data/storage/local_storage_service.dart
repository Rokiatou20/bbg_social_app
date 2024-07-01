import 'package:test_drive/data/models/session/session.dart';

abstract class LocalStorageService {

  Future<void> storeConnectedUser(Session session);
  Session? getConnectedUser();
  Future<void> clear();
}