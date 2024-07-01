import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_drive/app_setup.dart';
import 'package:test_drive/service/auth/auth_service_impl.dart';
import 'package:test_drive/service/exception/auth/auth_exception.dart';
import 'package:test_drive/data/models/session/session.dart';

import '../../data/models/conversation/conversation.dart';
import '../../data/models/user/user.dart';
import 'conversation_service.dart';

class ConversationServiceImpl implements ConversationService {

  final String apiBaseUrl = "https://api-socialapp.adjemincloud.com/api/v1";

  @override
  Future<Conversation> openConversation({
    required List<int> speakers,
    bool isGroup = false,
    String groupName = "",
    List<int>? admins,
  }) async {
    final Uri url = Uri.parse("$apiBaseUrl/open_conversation");

    // Get Access Token
    final Session? session = AppSetup.me;
    final String? token = session?.authorization?.token;

    // Get Access Token
    // Future<Session> session = AuthServiceImpl().signIn(email: "rouattara150@gmail.com", password: "1234");
    //
    // final String token = (await session).authorization?.token ?? "";
    // final User? user = (await session).user;

    final Response response = await post(
      url,
      body: jsonEncode({
        "speakers": speakers,
        "is_group": isGroup,
        "group_name": groupName,
        "admins": admins ?? [],
      }),
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
        final Map<String, dynamic> jsonData = json['data'];
        return Conversation.fromJson(jsonData);
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
  Future<List<Conversation>> loadConversationsByCustomerId(int customerId) async {
    final Uri url = Uri.parse("$apiBaseUrl/conversations/customers/$customerId");

    // Get Access Token
    final Session? session = AppSetup.me;
    final User? user = session?.user;
    final String? token = session?.authorization?.token;

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
        final List<dynamic> conversations = json['data'];

        return conversations.map((conversation) => Conversation.fromJson(conversation)).toList();
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