import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_drive/data/models/user/user.dart';
import 'package:test_drive/service/exception/auth/auth_exception.dart';

import 'package:test_drive/data/models/session/session.dart';
import '../../app_setup.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {

  final String apiBaseUrl = "https://api-socialapp.adjemincloud.com/api/v1";

  @override
  Future<Session> signIn({required String email, required String password}) async {
    final Uri url = Uri.parse("${apiBaseUrl}/user_auth");

    var response = await post(url, body: <String, String>{
      "email": email,
      "password": password
    });

    if (response.statusCode == 200) {
      final Map json = jsonDecode(response.body);
      if (json.containsKey('success') && json['success'] == true
          && json.containsKey('data') && json['data'] != null
      ) {
        final Map<String, dynamic> data = json['data'];
        return Session.fromJson(data);
      }
      throw Exception(response.body);
    }
    else if (response.statusCode == 401) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final String message = json['message'];

      throw AuthException(json['message']);
    }
    else {
      throw Exception(response.body);
    }
  }

  @override
  Future<Session> signUp ({required String firstName, required String lastName, required String email, required String password}) async {
    final Uri url = Uri.parse("${apiBaseUrl}/user_register");

    var response = await post(url, body: <String, String>{
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password
    });

    if (response.statusCode == 200) {
      final Map json = jsonDecode(response.body);
      if (json.containsKey('success') && json['success'] == true
          && json.containsKey('data') && json['data'] != null
      ) {
        final Map<String, dynamic> data = json['data'];
        return Session.fromJson(data);
      }
      throw Exception(response.body);
    }
    else if (response.statusCode == 401) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final String message = json['message'];

      throw AuthException(json['message']);
    }
    else {
      throw Exception(response.body);
    }
  }

  @override
  Future<Session> refreshToken({Session? session}) async {
    final Uri url = Uri.parse("$apiBaseUrl/refresh_token");

    // Get Access Token
    final Session? _session = session ?? AppSetup.me;
    final String? token = _session?.authorization?.token;

    final Response response = await post(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic>? json = jsonDecode(response.body);

      if (json == null) {
        throw Exception('Failed to parse response body');
      }

      if (json.containsKey("data") && json['data'] != null) {
        final Map<String, dynamic> data = json['data'];
        return Session.fromJson(data);
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

  @override
  Future<bool> signOut({Session? session}) async {
    final Uri url = Uri.parse("$apiBaseUrl/user_logout");

    // Get Access Token
    final Session? _session = session ?? AppSetup.me;
    final String? token = _session?.authorization?.token;

    final Response response = await post(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic>? json = jsonDecode(response.body);

      if (json == null) {
        throw Exception('Failed to parse response body');
      }

      if (json.containsKey("success") && json['success'] == true) {

        return true;
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