import 'package:test_drive/data/models/message/message.dart';

abstract class MessageService {
  Future<Message> sendMessage({
    required String content,
    required String contentType,
    required int senderId,
    required int conversationId
  });

  Future<List<Message>> loadMessagesByConversationId({int? conversationId});
}