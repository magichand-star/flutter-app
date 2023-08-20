// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TagsRecord> _$tagsRecordSerializer = new _$TagsRecordSerializer();

class _$TagsRecordSerializer implements StructuredSerializer<TagsRecord> {
  @override
  final Iterable<Type> types = const [TagsRecord, _$TagsRecord];
  @override
  final String wireName = 'TagsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, TagsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.tag;
    if (value != null) {
      result
        ..add('tag')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tags;
    if (value != null) {
      result
        ..add('tags')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  TagsRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TagsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'tag':
          result.tag = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'tags':
          result.tags = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$TagsRecord extends TagsRecord {
  @override
  final String? tag;
  @override
  final String? tags;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$TagsRecord([void Function(TagsRecordBuilder)? updates]) =>
      (new TagsRecordBuilder()..update(updates))._build();

  _$TagsRecord._({this.tag, this.tags, this.ffRef}) : super._();

  @override
  TagsRecord rebuild(void Function(TagsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TagsRecordBuilder toBuilder() => new TagsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TagsRecord &&
        tag == other.tag &&
        tags == other.tags &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tag.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TagsRecord')
          ..add('tag', tag)
          ..add('tags', tags)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class TagsRecordBuilder implements Builder<TagsRecord, TagsRecordBuilder> {
  _$TagsRecord? _$v;

  String? _tag;
  String? get tag => _$this._tag;
  set tag(String? tag) => _$this._tag = tag;

  String? _tags;
  String? get tags => _$this._tags;
  set tags(String? tags) => _$this._tags = tags;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  TagsRecordBuilder() {
    TagsRecord._initializeBuilder(this);
  }

  TagsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tag = $v.tag;
      _tags = $v.tags;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TagsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TagsRecord;
  }

  @override
  void update(void Function(TagsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TagsRecord build() => _build();

  _$TagsRecord _build() {
    final _$result =
        _$v ?? new _$TagsRecord._(tag: tag, tags: tags, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
