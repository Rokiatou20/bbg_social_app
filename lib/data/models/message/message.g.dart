// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: (json['id'] as num?)?.toInt(),
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String?,
      conversationId: (json['conversation_id'] as num?)?.toInt(),
      senderId: (json['sender_id'] as num?)?.toInt(),
      contentType: json['content_type'] as String?,
      isRead: json['is_read'] as bool?,
      isReceived: json['is_received'] as bool?,
      isSent: json['is_sent'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'content': instance.content,
      'conversation_id': instance.conversationId,
      'sender_id': instance.senderId,
      'content_type': instance.contentType,
      'is_read': instance.isRead,
      'is_received': instance.isReceived,
      'is_sent': instance.isSent,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
