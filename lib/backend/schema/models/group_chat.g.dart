// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_chat.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GroupChat> _$groupChatSerializer = new _$GroupChatSerializer();

class _$GroupChatSerializer implements StructuredSerializer<GroupChat> {
  @override
  final Iterable<Type> types = const [GroupChat, _$GroupChat];
  @override
  final String wireName = 'GroupChat';

  @override
  Iterable<Object?> serialize(Serializers serializers, GroupChat object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.groupChatId;
    if (value != null) {
      result
        ..add('group_chat_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.groupName;
    if (value != null) {
      result
        ..add('group_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.memberIds;
    if (value != null) {
      result
        ..add('member_ids')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(List, const [const FullType(String)])));
    }
    return result;
  }

  @override
  GroupChat deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupChatBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'group_chat_id':
          result.groupChatId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'group_name':
          result.groupName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'member_ids':
          result.memberIds = serializers.deserialize(value,
                  specifiedType:
                      const FullType(List, const [const FullType(String)]))
              as List<String>?;
          break;
      }
    }

    return result.build();
  }
}

class _$GroupChat extends GroupChat {
  @override
  final String? groupChatId;
  @override
  final String? groupName;
  @override
  final List<String>? memberIds;

  factory _$GroupChat([void Function(GroupChatBuilder)? updates]) =>
      (new GroupChatBuilder()..update(updates))._build();

  _$GroupChat._({this.groupChatId, this.groupName, this.memberIds}) : super._();

  @override
  GroupChat rebuild(void Function(GroupChatBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupChatBuilder toBuilder() => new GroupChatBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupChat &&
        groupChatId == other.groupChatId &&
        groupName == other.groupName &&
        memberIds == other.memberIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, groupChatId.hashCode);
    _$hash = $jc(_$hash, groupName.hashCode);
    _$hash = $jc(_$hash, memberIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GroupChat')
          ..add('groupChatId', groupChatId)
          ..add('groupName', groupName)
          ..add('memberIds', memberIds))
        .toString();
  }
}

class GroupChatBuilder implements Builder<GroupChat, GroupChatBuilder> {
  _$GroupChat? _$v;

  String? _groupChatId;
  String? get groupChatId => _$this._groupChatId;
  set groupChatId(String? groupChatId) => _$this._groupChatId = groupChatId;

  String? _groupName;
  String? get groupName => _$this._groupName;
  set groupName(String? groupName) => _$this._groupName = groupName;

  List<String>? _memberIds;
  List<String>? get memberIds => _$this._memberIds;
  set memberIds(List<String>? memberIds) => _$this._memberIds = memberIds;

  GroupChatBuilder();

  GroupChatBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groupChatId = $v.groupChatId;
      _groupName = $v.groupName;
      _memberIds = $v.memberIds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupChat other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GroupChat;
  }

  @override
  void update(void Function(GroupChatBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GroupChat build() => _build();

  _$GroupChat _build() {
    final _$result = _$v ??
        new _$GroupChat._(
            groupChatId: groupChatId,
            groupName: groupName,
            memberIds: memberIds);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
