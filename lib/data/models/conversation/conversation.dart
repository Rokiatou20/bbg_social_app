import 'package:json_annotation/json_annotation.dart';
import 'package:test_drive/data/models/message/message.dart';

import '../user/user.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  int? id;
  List<int> speakers;
  @JsonKey(name: "speaker_list")
  List<int>? speakerList;
  @JsonKey(name: "is_group", defaultValue: false)
  bool isGroup;
  @JsonKey(name: "group_name")
  String? groupName;
  List<int>? admins;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "deleted_at")
  DateTime? deletedAt;
  List<User> users;
  List<Message> messages;

  Conversation({
    this.id,
    required this.speakers,
    this.speakerList,
    this.isGroup = false,
    this.groupName,
    this.admins,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.users,
    required this.messages
  });


  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Conversation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  bool isConnected() {
    return true;
  }

  String senderName(User me){
    if(isGroup){
      return groupName??"Inconnu";
    }

    if(users.isEmpty){
      return "Inconnu";
    }

    final List<User> list = users.where((sender)=> sender != me).toList();
    if(list.isNotEmpty){
      return '${list.first.firstName} ${list.first.lastName}';
    }

    return "Inconnu";
  }

  String messageContent(){

    if(messages.isEmpty){
      return "";
    }

    List<Message> list = messages.where((message)=> message.isRead != true).toList();
    list.sort((a,b)=>b.createdAt!.compareTo(a.createdAt!));

    if(list.isNotEmpty){
      return list.first.content??"Non disponible";
    }

    return "";
  }

  DateTime? lastMessageDate(){

    if(messages.isEmpty){
      return null;
    }

    List<Message> list = messages.where((message)=> message.isRead != true).toList();
    list.sort((a,b)=>b.createdAt!.compareTo(a.createdAt!));

    if(list.isNotEmpty){
      return list.first.createdAt;
    }

    return null;
  }

  int unReadCount(){

    if(messages.isEmpty){
      return 0;
    }

    List<Message> list = messages.where((message)=> message.isRead == false).toList();
    print("Liste des messages non lus : $list");
    print("Liste des messages non lus : ${list.length}");
    list.sort((a,b)=>b.createdAt!.compareTo(a.createdAt!));
    print("Liste des messages non lus : ${list.length}");

    if(list.isNotEmpty){
      print("Liste des messages non lus : ${list.length}");
      return list.length;
    }

    return 0;
  }
}