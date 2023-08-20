// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Chat> _$chatSerializer = new _$ChatSerializer();

class _$ChatSerializer implements StructuredSerializer<Chat> {
  @override
  final Iterable<Type> types = const [Chat, _$Chat];
  @override
  final String wireName = 'Chat';

  @override
  Iterable<Object?> serialize(Serializers serializers, Chat object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.chatId;
    if (value != null) {
      result
        ..add('chat_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.senderId;
    if (value != null) {
      result
        ..add('sender_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.receiverId;
    if (value != null) {
      result
        ..add('receiver_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Chat deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'chat_id':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'sender_id':
          result.senderId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'receiver_id':
          result.receiverId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Chat extends Chat {
  @override
  final String? chatId;
  @override
  final String? senderId;
  @override
  final String? receiverId;

  factory _$Chat([void Function(ChatBuilder)? updates]) =>
      (new ChatBuilder()..update(updates))._build();

  _$Chat._({this.chatId, this.senderId, this.receiverId}) : super._();

  @override
  Chat rebuild(void Function(ChatBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatBuilder toBuilder() => new ChatBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Chat &&
        chatId == other.chatId &&
        senderId == other.senderId &&
        receiverId == other.receiverId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chatId.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Chat')
          ..add('chatId', chatId)
          ..add('senderId', senderId)
          ..add('receiverId', receiverId))
        .toString();
  }
}

class ChatBuilder implements Builder<Chat, ChatBuilder> {
  _$Chat? _$v;

  String? _chatId;
  String? get chatId => _$this._chatId;
  set chatId(String? chatId) => _$this._chatId = chatId;

  String? _senderId;
  String? get senderId => _$this._senderId;
  set senderId(String? senderId) => _$this._senderId = senderId;

  String? _receiverId;
  String? get receiverId => _$this._receiverId;
  set receiverId(String? receiverId) => _$this._receiverId = receiverId;

  ChatBuilder();

  ChatBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chatId = $v.chatId;
      _senderId = $v.senderId;
      _receiverId = $v.receiverId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Chat other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Chat;
  }

  @override
  void update(void Function(ChatBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Chat build() => _build();

  _$Chat _build() {
    final _$result = _$v ??
        new _$Chat._(
            chatId: chatId, senderId: senderId, receiverId: receiverId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
