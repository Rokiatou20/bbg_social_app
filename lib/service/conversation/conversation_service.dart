import 'package:test_drive/data/models/conversation/conversation.dart';

abstract class ConversationService {

  Future<Conversation> openConversation({
    required List<int> speakers,
    bool isGroup = false,
    String groupName = '',
    List<int>? admins
  });

  Future<List<Conversation>> loadConversationsByCustomerId(int customerId);

  //TODO Load Contacts https://api-socialapp.adjemincloud.com/api/v1/contacts/1
}