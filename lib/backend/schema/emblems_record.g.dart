// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emblems_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EmblemsRecord> _$emblemsRecordSerializer =
    new _$EmblemsRecordSerializer();

class _$EmblemsRecordSerializer implements StructuredSerializer<EmblemsRecord> {
  @override
  final Iterable<Type> types = const [EmblemsRecord, _$EmblemsRecord];
  @override
  final String wireName = 'EmblemsRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, EmblemsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.emblem;
    if (value != null) {
      result
        ..add('emblem')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.backgroundColor;
    if (value != null) {
      result
        ..add('background_color')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(Color)));
    }
    value = object.suggestedColors;
    if (value != null) {
      result
        ..add('suggested_colors')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Color)])));
    }
    value = object.tags;
    if (value != null) {
      result
        ..add('tags')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.positions;
    if (value != null) {
      result
        ..add('positions')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.filled;
    if (value != null) {
      result
        ..add('filled')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
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
  EmblemsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EmblemsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'emblem':
          result.emblem = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'background_color':
          result.backgroundColor = serializers.deserialize(value,
              specifiedType: const FullType(Color)) as Color?;
          break;
        case 'suggested_colors':
          result.suggestedColors.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Color)]))!
              as BuiltList<Object?>);
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'positions':
          result.positions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'filled':
          result.filled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
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

class _$EmblemsRecord extends EmblemsRecord {
  @override
  final String? emblem;
  @override
  final Color? backgroundColor;
  @override
  final BuiltList<Color>? suggestedColors;
  @override
  final BuiltList<String>? tags;
  @override
  final BuiltList<String>? positions;
  @override
  final bool? filled;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$EmblemsRecord([void Function(EmblemsRecordBuilder)? updates]) =>
      (new EmblemsRecordBuilder()..update(updates))._build();

  _$EmblemsRecord._(
      {this.emblem,
      this.backgroundColor,
      this.suggestedColors,
      this.tags,
      this.positions,
      this.filled,
      this.ffRef})
      : super._();

  @override
  EmblemsRecord rebuild(void Function(EmblemsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmblemsRecordBuilder toBuilder() => new EmblemsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmblemsRecord &&
        emblem == other.emblem &&
        backgroundColor == other.backgroundColor &&
        suggestedColors == other.suggestedColors &&
        tags == other.tags &&
        positions == other.positions &&
        filled == other.filled &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, emblem.hashCode);
    _$hash = $jc(_$hash, backgroundColor.hashCode);
    _$hash = $jc(_$hash, suggestedColors.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, positions.hashCode);
    _$hash = $jc(_$hash, filled.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EmblemsRecord')
          ..add('emblem', emblem)
          ..add('backgroundColor', backgroundColor)
          ..add('suggestedColors', suggestedColors)
          ..add('tags', tags)
          ..add('positions', positions)
          ..add('filled', filled)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class EmblemsRecordBuilder
    implements Builder<EmblemsRecord, EmblemsRecordBuilder> {
  _$EmblemsRecord? _$v;

  String? _emblem;
  String? get emblem => _$this._emblem;
  set emblem(String? emblem) => _$this._emblem = emblem;

  Color? _backgroundColor;
  Color? get backgroundColor => _$this._backgroundColor;
  set backgroundColor(Color? backgroundColor) =>
      _$this._backgroundColor = backgroundColor;

  ListBuilder<Color>? _suggestedColors;
  ListBuilder<Color> get suggestedColors =>
      _$this._suggestedColors ??= new ListBuilder<Color>();
  set suggestedColors(ListBuilder<Color>? suggestedColors) =>
      _$this._suggestedColors = suggestedColors;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  ListBuilder<String>? _positions;
  ListBuilder<String> get positions =>
      _$this._positions ??= new ListBuilder<String>();
  set positions(ListBuilder<String>? positions) =>
      _$this._positions = positions;

  bool? _filled;
  bool? get filled => _$this._filled;
  set filled(bool? filled) => _$this._filled = filled;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  EmblemsRecordBuilder() {
    EmblemsRecord._initializeBuilder(this);
  }

  EmblemsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _emblem = $v.emblem;
      _backgroundColor = $v.backgroundColor;
      _suggestedColors = $v.suggestedColors?.toBuilder();
      _tags = $v.tags?.toBuilder();
      _positions = $v.positions?.toBuilder();
      _filled = $v.filled;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmblemsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EmblemsRecord;
  }

  @override
  void update(void Function(EmblemsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmblemsRecord build() => _build();

  _$EmblemsRecord _build() {
    _$EmblemsRecord _$result;
    try {
      _$result = _$v ??
          new _$EmblemsRecord._(
              emblem: emblem,
              backgroundColor: backgroundColor,
              suggestedColors: _suggestedColors?.build(),
              tags: _tags?.build(),
              positions: _positions?.build(),
              filled: filled,
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'suggestedColors';
        _suggestedColors?.build();
        _$failedField = 'tags';
        _tags?.build();
        _$failedField = 'positions';
        _positions?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'EmblemsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
