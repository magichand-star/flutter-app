// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_emblems.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GeneratedEmblems> _$generatedEmblemsSerializer =
    new _$GeneratedEmblemsSerializer();

class _$GeneratedEmblemsSerializer
    implements StructuredSerializer<GeneratedEmblems> {
  @override
  final Iterable<Type> types = const [GeneratedEmblems, _$GeneratedEmblems];
  @override
  final String wireName = 'GeneratedEmblems';

  @override
  Iterable<Object?> serialize(Serializers serializers, GeneratedEmblems object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.backgroundColor;
    if (value != null) {
      result
        ..add('background_color')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emblem;
    if (value != null) {
      result
        ..add('emblem')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.filled;
    if (value != null) {
      result
        ..add('filled')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GeneratedEmblems deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GeneratedEmblemsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'background_color':
          result.backgroundColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'emblem':
          result.emblem = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'filled':
          result.filled = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GeneratedEmblems extends GeneratedEmblems {
  @override
  final String? backgroundColor;
  @override
  final String? emblem;
  @override
  final bool? filled;

  factory _$GeneratedEmblems(
          [void Function(GeneratedEmblemsBuilder)? updates]) =>
      (new GeneratedEmblemsBuilder()..update(updates))._build();

  _$GeneratedEmblems._({this.backgroundColor, this.emblem, this.filled})
      : super._();

  @override
  GeneratedEmblems rebuild(void Function(GeneratedEmblemsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneratedEmblemsBuilder toBuilder() =>
      new GeneratedEmblemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneratedEmblems &&
        backgroundColor == other.backgroundColor &&
        emblem == other.emblem &&
        filled == other.filled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, backgroundColor.hashCode);
    _$hash = $jc(_$hash, emblem.hashCode);
    _$hash = $jc(_$hash, filled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GeneratedEmblems')
          ..add('backgroundColor', backgroundColor)
          ..add('emblem', emblem)
          ..add('filled', filled))
        .toString();
  }
}

class GeneratedEmblemsBuilder
    implements Builder<GeneratedEmblems, GeneratedEmblemsBuilder> {
  _$GeneratedEmblems? _$v;

  String? _backgroundColor;
  String? get backgroundColor => _$this._backgroundColor;
  set backgroundColor(String? backgroundColor) =>
      _$this._backgroundColor = backgroundColor;

  String? _emblem;
  String? get emblem => _$this._emblem;
  set emblem(String? emblem) => _$this._emblem = emblem;

  bool? _filled;
  bool? get filled => _$this._filled;
  set filled(bool? filled) => _$this._filled = filled;

  GeneratedEmblemsBuilder();

  GeneratedEmblemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _backgroundColor = $v.backgroundColor;
      _emblem = $v.emblem;
      _filled = $v.filled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeneratedEmblems other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GeneratedEmblems;
  }

  @override
  void update(void Function(GeneratedEmblemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeneratedEmblems build() => _build();

  _$GeneratedEmblems _build() {
    final _$result = _$v ??
        new _$GeneratedEmblems._(
            backgroundColor: backgroundColor, emblem: emblem, filled: filled);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
