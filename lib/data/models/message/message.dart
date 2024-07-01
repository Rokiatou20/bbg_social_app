import 'package:json_annotation/json_annotation.dart';
import 'package:test_drive/data/models/user/user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int? id;
  User? sender;
  String? content;
  @JsonKey(name: 'conversation_id')
  int? conversationId;
  @JsonKey(name: 'sender_id')
  int? senderId;
  @JsonKey(name: 'content_type')
  String? contentType;
  @JsonKey(name: 'is_read')
  bool? isRead;
  @JsonKey(name: 'is_received')
  bool? isReceived;
  @JsonKey(name: 'is_sent')
  bool? isSent;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  Message({
    this.id,
    this.sender,
    this.content,
    this.conversationId,
    this.senderId,
    this.contentType,
    this.isRead,
    this.isReceived,
    this.isSent,
    this.createdAt,
    this.updatedAt
    }
  );

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}