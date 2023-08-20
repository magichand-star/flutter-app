library chat;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:monarchium/backend/schema/serializers.dart';

part 'chat.g.dart';

abstract class Chat implements Built<Chat, ChatBuilder> {
  Chat._();

  factory Chat([updates(ChatBuilder b)]) = _$Chat;

  @BuiltValueField(wireName: 'chat_id')
  String? get chatId;

  @BuiltValueField(wireName: 'sender_id')
  String? get senderId;

  @BuiltValueField(wireName: 'receiver_id')
  String? get receiverId;

  String toJson() {
    return json.encode(serializers.serializeWith(Chat.serializer, this));
  }

  static Chat? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Chat.serializer, json.decode(jsonString));
  }

  static Serializer<Chat> get serializer => _$chatSerializer;
}
