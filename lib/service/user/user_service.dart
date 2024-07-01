import 'package:test_drive/data/models/user/user.dart';

abstract class UserService {
  Future<List<User>> loadContactsByCustomerId({int? customerId});
}