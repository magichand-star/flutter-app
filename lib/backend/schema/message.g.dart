// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Message> _$messageSerializer = new _$MessageSerializer();

class _$MessageSerializer implements StructuredSerializer<Message> {
  @override
  final Iterable<Type> types = const [Message, _$Message];
  @override
  final String wireName = 'Message';

  @override
  Iterable<Object?> serialize(Serializers serializers, Message object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'messageText',
      serializers.serialize(object.messageText,
          specifiedType: const FullType(String)),
      'senderId',
      serializers.serialize(object.senderId,
          specifiedType: const FullType(String)),
      'timestamp',
      serializers.serialize(object.timestamp,
          specifiedType: const FullType(Timestamp)),
      'isSent',
      serializers.serialize(object.isSent, specifiedType: const FullType(bool)),
      'isViewed',
      serializers.serialize(object.isViewed,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.medias;
    if (value != null) {
      result
        ..add('medias')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(CustomChatMedia)])));
    }
    return result;
  }

  @override
  Message deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MessageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'messageText':
          result.messageText = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'senderId':
          result.senderId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp))! as Timestamp;
          break;
        case 'isSent':
          result.isSent = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isViewed':
          result.isViewed = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'medias':
          result.medias.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CustomChatMedia)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$Message extends Message {
  @override
  final String? id;
  @override
  final String messageText;
  @override
  final String senderId;
  @override
  final Timestamp timestamp;
  @override
  final bool isSent;
  @override
  final bool isViewed;
  @override
  final BuiltList<CustomChatMedia>? medias;

  factory _$Message([void Function(MessageBuilder)? updates]) =>
      (new MessageBuilder()..update(updates))._build();

  _$Message._(
      {this.id,
      required this.messageText,
      required this.senderId,
      required this.timestamp,
      required this.isSent,
      required this.isViewed,
      this.medias})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        messageText, r'Message', 'messageText');
    BuiltValueNullFieldError.checkNotNull(senderId, r'Message', 'senderId');
    BuiltValueNullFieldError.checkNotNull(timestamp, r'Message', 'timestamp');
    BuiltValueNullFieldError.checkNotNull(isSent, r'Message', 'isSent');
    BuiltValueNullFieldError.checkNotNull(isViewed, r'Message', 'isViewed');
  }

  @override
  Message rebuild(void Function(MessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageBuilder toBuilder() => new MessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Message &&
        id == other.id &&
        messageText == other.messageText &&
        senderId == other.senderId &&
        timestamp == other.timestamp &&
        isSent == other.isSent &&
        isViewed == other.isViewed &&
        medias == other.medias;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, messageText.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, isSent.hashCode);
    _$hash = $jc(_$hash, isViewed.hashCode);
    _$hash = $jc(_$hash, medias.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Message')
          ..add('id', id)
          ..add('messageText', messageText)
          ..add('senderId', senderId)
          ..add('timestamp', timestamp)
          ..add('isSent', isSent)
          ..add('isViewed', isViewed)
          ..add('medias', medias))
        .toString();
  }
}

class MessageBuilder implements Builder<Message, MessageBuilder> {
  _$Message? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _messageText;
  String? get messageText => _$this._messageText;
  set messageText(String? messageText) => _$this._messageText = messageText;

  String? _senderId;
  String? get senderId => _$this._senderId;
  set senderId(String? senderId) => _$this._senderId = senderId;

  Timestamp? _timestamp;
  Timestamp? get timestamp => _$this._timestamp;
  set timestamp(Timestamp? timestamp) => _$this._timestamp = timestamp;

  bool? _isSent;
  bool? get isSent => _$this._isSent;
  set isSent(bool? isSent) => _$this._isSent = isSent;

  bool? _isViewed;
  bool? get isViewed => _$this._isViewed;
  set isViewed(bool? isViewed) => _$this._isViewed = isViewed;

  ListBuilder<CustomChatMedia>? _medias;
  ListBuilder<CustomChatMedia> get medias =>
      _$this._medias ??= new ListBuilder<CustomChatMedia>();
  set medias(ListBuilder<CustomChatMedia>? medias) => _$this._medias = medias;

  MessageBuilder();

  MessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _messageText = $v.messageText;
      _senderId = $v.senderId;
      _timestamp = $v.timestamp;
      _isSent = $v.isSent;
      _isViewed = $v.isViewed;
      _medias = $v.medias?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Message other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Message;
  }

  @override
  void update(void Function(MessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Message build() => _build();

  _$Message _build() {
    _$Message _$result;
    try {
      _$result = _$v ??
          new _$Message._(
              id: id,
              messageText: BuiltValueNullFieldError.checkNotNull(
                  messageText, r'Message', 'messageText'),
              senderId: BuiltValueNullFieldError.checkNotNull(
                  senderId, r'Message', 'senderId'),
              timestamp: BuiltValueNullFieldError.checkNotNull(
                  timestamp, r'Message', 'timestamp'),
              isSent: BuiltValueNullFieldError.checkNotNull(
                  isSent, r'Message', 'isSent'),
              isViewed: BuiltValueNullFieldError.checkNotNull(
                  isViewed, r'Message', 'isViewed'),
              medias: _medias?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'medias';
        _medias?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Message', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
