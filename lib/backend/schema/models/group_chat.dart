library group_chat;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:monarchium/backend/schema/serializers.dart';

part 'group_chat.g.dart';

abstract class GroupChat implements Built<GroupChat, GroupChatBuilder> {
  GroupChat._();

  factory GroupChat([updates(GroupChatBuilder b)]) = _$GroupChat;

  @BuiltValueField(wireName: 'group_chat_id')
  String? get groupChatId;

  @BuiltValueField(wireName: 'group_name')
  String? get groupName;

  @BuiltValueField(wireName: 'member_ids')
  List<String>? get memberIds;

  String toJson() {
    return json.encode(serializers.serializeWith(GroupChat.serializer, this));
  }

  static GroupChat? fromJson(String jsonString) {
    return serializers.deserializeWith(
        GroupChat.serializer, json.decode(jsonString));
  }

  static Serializer<GroupChat> get serializer => _$groupChatSerializer;
}
