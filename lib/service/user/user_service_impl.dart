import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_drive/service/user/user_service.dart';

import '../../data/models/session/session.dart';
import '../../data/models/user/user.dart';
import '../auth/auth_service_impl.dart';
import '../exception/auth/auth_exception.dart';

class UserServiceImpl implements UserService {

  final String apiBaseUrl = "https://api-socialapp.adjemincloud.com/api/v1";

  @override
  Future<List<User>> loadContactsByCustomerId({int? customerId}) async {
    final Uri url = Uri.parse("$apiBaseUrl/contacts/$customerId");

    // Get Access Token
    /*final Session? session = AppSetup.me;
    final User? user = session?.user;
    final String? token = session?.authorization?.token;*/

    // Get Access Token
    final Session session = await AuthServiceImpl().signIn(email: "angebagui@adjemin.com", password: "123456789");
    final String? token = session.authorization?.token;
    final User? user = session.user;

    if (user == null) {
      throw AuthException('No user found');
    }

    final Response response = await get(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic>? json = jsonDecode(response.body);

      if (json == null) {
        throw Exception('Failed to parse response body');
      }

      if (json.containsKey("success") && json['success'] == true && json['data'] != null) {
        final List<dynamic> contacts = json['data'];

        return contacts.map((user) => User.fromJson(user)).toList();
      }

      throw Exception('Unexpected response format: ${response.body}');

    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      if (response.headers['content-type']?.contains('application/json') == true) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        if (json.containsKey("message") && json['message'] != null) {
          if (json['message'].isEmpty) {
            throw ArgumentError("Bad request");
          } else {
            if (response.statusCode == 401) {
              throw AuthException(json['message']);
            } else {
              throw ArgumentError(json['message']);
            }
          }
        }
      }
      throw Exception('Client error: ${response.body}');
    } else {
      throw Exception('Server error: ${response.body}');
    }
  }
}