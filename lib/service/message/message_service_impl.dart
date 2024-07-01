import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_drive/app_setup.dart';
import 'package:test_drive/service/auth/auth_service_impl.dart';
import 'package:test_drive/service/exception/auth/auth_exception.dart';
import 'package:test_drive/data/models/session/session.dart';

import '../../data/models/message/message.dart';
import '../../data/models/user/user.dart';
import 'message_service.dart';

class MessageServiceImpl implements MessageService {

  final String apiBaseUrl = "https://api-socialapp.adjemincloud.com/api/v1";

  @override
  Future<Message> sendMessage({
    required String content,
    required String contentType,
    required int senderId,
    required int conversationId})async {
    final Uri url = Uri.parse("$apiBaseUrl/messages");
    //TODO Load Session from cache
    //Get Access Token
    final Session session = await AuthServiceImpl().signIn(email: "angebagui@adjemin.com", password: "123456789");
    final String? token = session.authorization?.token;
    print("Authorization: Bearer $token");

    final Response response = await post(url,
        body: {
          "content": content,
          "content_type":contentType,
          "sender_id":"$senderId",
          "conversation_id":"$conversationId"
        }, headers: {
          "Accept":"application/json",
          "Authorization":"Bearer $token"
        });

    if(response.statusCode == 200){
      final Map<String, dynamic>? json = jsonDecode(response.body);

      if(json == null){
        throw Exception(response.body);
      }

      if(json.containsKey("success") && json['success'] == true && json['data'] != null){
        final Map<String, dynamic> jsonData = json['data'];
        return Message.fromJson(jsonData);
      }

      throw Exception(response.body);

    }else if(response.statusCode >=400 && response.statusCode <500){
      if(response.headers['content-type'] == "application/json"){
        final Map<String, dynamic> json = jsonDecode(response.body);

        if(json.containsKey("message") && json['message'] != null){
          if(json['message'].isEmpty){
            throw ArgumentError("Bad request");
          }else{
            if(response.statusCode == 401){
              throw AuthException(json['message']);
            }else{
              throw ArgumentError(json['message']);
            }
          }
        }
      }
      throw Exception(response.body);
    }else{
      throw Exception(response.body);
    }
  }

  @override
  Future<List<Message>> loadMessagesByConversationId(
      {int? conversationId}) async {
    final Uri url = Uri.parse("$apiBaseUrl/conversations/messages/$conversationId");

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
        final List<dynamic> conversations = json['data'];

        return conversations.map((conversation) => Message.fromJson(conversation)).toList();
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