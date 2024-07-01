// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      id: (json['id'] as num?)?.toInt(),
      speakers: (json['speakers'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      speakerList: (json['speaker_list'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      isGroup: json['is_group'] as bool? ?? false,
      groupName: json['group_name'] as String?,
      admins: (json['admins'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'speakers': instance.speakers,
      'speaker_list': instance.speakerList,
      'is_group': instance.isGroup,
      'group_name': instance.groupName,
      'admins': instance.admins,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'users': instance.users,
      'messages': instance.messages,
    };
