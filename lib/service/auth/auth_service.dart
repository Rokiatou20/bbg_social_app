import 'package:test_drive/data/models/session/session.dart';

abstract class AuthService {
  Future<Session> signIn({required String email, required String password});
  Future<bool> signOut({Session? session});
  Future<Session> refreshToken({Session? session});
  Future<Session> signUp({required String firstName, required String lastName ,required String email, required String password});
}