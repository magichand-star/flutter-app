library message;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'custom_chat_media.dart'; // ensure to import your CustomChatMedia class
import 'serializers.dart';

part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder> {
  Message._();

  factory Message([updates(MessageBuilder b)]) = _$Message;

  @BuiltValueField(wireName: 'id')
  String? get id;
  @BuiltValueField(wireName: 'messageText')
  String get messageText;
  @BuiltValueField(wireName: 'senderId')
  String get senderId;
  @BuiltValueField(wireName: 'timestamp')
  Timestamp get timestamp;
  @BuiltValueField(wireName: 'isSent')
  bool get isSent;
  @BuiltValueField(wireName: 'isViewed')
  bool get isViewed;
  @BuiltValueField(wireName: 'medias')
  BuiltList<CustomChatMedia>?
      get medias; // replace ChatMedia with CustomChatMedia

  // static void _initializeBuilder(MessageBuilder builder) => builder
  //   ..messageText = ''
  //   ..senderId = ''
  //   ..timestamp = null
  //   ..isSent = false
  //   ..isViewed = false
  //   ..medias = ListBuilder<CustomChatMedia>([]);

  String toJson() {
    return json.encode(serializers.serializeWith(Message.serializer, this));
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> messageMap = serializers.serializeWith(
        Message.serializer, this) as Map<String, dynamic>;
    if (medias != null) {
      messageMap['medias'] = medias!.map((media) => media.toMap()).toList();
    }
    return messageMap;
  }

  static Message fromMap(Map<String, dynamic> map) {
    // if (map['medias'] != null) {
    //   map['medias'] = (map['medias'] as List)
    //       .map((item) =>
    //           CustomChatMedia.deserialize(item as Map<String, dynamic>))
    //       .toList();
    // }
    return serializers.deserializeWith(Message.serializer, map)!;
  }

  static Message? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Message.serializer, json.decode(jsonString));
  }

  static Serializer<Message> get serializer => _$messageSerializer;

  ChatMessage toChatMessage(ChatUser user) {
    return ChatMessage(
      user: user,
      createdAt: timestamp.toDate(),
      text: messageText,
      medias: medias?.map((media) => media.toChatMedia()).toList(),
      status: isViewed ? MessageStatus.read : MessageStatus.none,
    );
  }

  static Message fromChatMessage(ChatMessage chatMessage, String id) {
    // debugger();
    return Message(
      (b) => b
        ..id = id
        ..messageText = chatMessage.text
        ..senderId = chatMessage.user.id
        ..timestamp = Timestamp.fromDate(chatMessage.createdAt)
        ..medias = ListBuilder<CustomChatMedia>(chatMessage.medias?.map(
              (media) => CustomChatMedia.fromChatMedia(media),
            ) ??
            <CustomChatMedia>[])
        ..isSent = chatMessage.status == MessageStatus.received
        ..isViewed = false,
    );
  }
}
