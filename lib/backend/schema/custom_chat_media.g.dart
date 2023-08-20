// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_chat_media.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MediaType _$image = const MediaType._('image');
const MediaType _$video = const MediaType._('video');
const MediaType _$file = const MediaType._('file');

MediaType _$valueOf(String name) {
  switch (name) {
    case 'image':
      return _$image;
    case 'video':
      return _$video;
    case 'file':
      return _$file;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MediaType> _$values = new BuiltSet<MediaType>(const <MediaType>[
  _$image,
  _$video,
  _$file,
]);

Serializer<CustomChatMedia> _$customChatMediaSerializer =
    new _$CustomChatMediaSerializer();
Serializer<MediaType> _$mediaTypeSerializer = new _$MediaTypeSerializer();

class _$CustomChatMediaSerializer
    implements StructuredSerializer<CustomChatMedia> {
  @override
  final Iterable<Type> types = const [CustomChatMedia, _$CustomChatMedia];
  @override
  final String wireName = 'CustomChatMedia';

  @override
  Iterable<Object?> serialize(Serializers serializers, CustomChatMedia object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'fileName',
      serializers.serialize(object.fileName,
          specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(MediaType)),
      'isUploading',
      serializers.serialize(object.isUploading,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.uploadedDate;
    if (value != null) {
      result
        ..add('uploadedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.customProperties;
    if (value != null) {
      result
        ..add('customProperties')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    return result;
  }

  @override
  CustomChatMedia deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CustomChatMediaBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'fileName':
          result.fileName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(MediaType))! as MediaType;
          break;
        case 'isUploading':
          result.isUploading = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'uploadedDate':
          result.uploadedDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'customProperties':
          result.customProperties = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
      }
    }

    return result.build();
  }
}

class _$MediaTypeSerializer implements PrimitiveSerializer<MediaType> {
  @override
  final Iterable<Type> types = const <Type>[MediaType];
  @override
  final String wireName = 'MediaType';

  @override
  Object serialize(Serializers serializers, MediaType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  MediaType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MediaType.valueOf(serialized as String);
}

class _$CustomChatMedia extends CustomChatMedia {
  @override
  final String url;
  @override
  final String fileName;
  @override
  final MediaType type;
  @override
  final bool isUploading;
  @override
  final DateTime? uploadedDate;
  @override
  final Map<String, dynamic>? customProperties;

  factory _$CustomChatMedia([void Function(CustomChatMediaBuilder)? updates]) =>
      (new CustomChatMediaBuilder()..update(updates))._build();

  _$CustomChatMedia._(
      {required this.url,
      required this.fileName,
      required this.type,
      required this.isUploading,
      this.uploadedDate,
      this.customProperties})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(url, r'CustomChatMedia', 'url');
    BuiltValueNullFieldError.checkNotNull(
        fileName, r'CustomChatMedia', 'fileName');
    BuiltValueNullFieldError.checkNotNull(type, r'CustomChatMedia', 'type');
    BuiltValueNullFieldError.checkNotNull(
        isUploading, r'CustomChatMedia', 'isUploading');
  }

  @override
  CustomChatMedia rebuild(void Function(CustomChatMediaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CustomChatMediaBuilder toBuilder() =>
      new CustomChatMediaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CustomChatMedia &&
        url == other.url &&
        fileName == other.fileName &&
        type == other.type &&
        isUploading == other.isUploading &&
        uploadedDate == other.uploadedDate &&
        customProperties == other.customProperties;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, isUploading.hashCode);
    _$hash = $jc(_$hash, uploadedDate.hashCode);
    _$hash = $jc(_$hash, customProperties.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CustomChatMedia')
          ..add('url', url)
          ..add('fileName', fileName)
          ..add('type', type)
          ..add('isUploading', isUploading)
          ..add('uploadedDate', uploadedDate)
          ..add('customProperties', customProperties))
        .toString();
  }
}

class CustomChatMediaBuilder
    implements Builder<CustomChatMedia, CustomChatMediaBuilder> {
  _$CustomChatMedia? _$v;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  MediaType? _type;
  MediaType? get type => _$this._type;
  set type(MediaType? type) => _$this._type = type;

  bool? _isUploading;
  bool? get isUploading => _$this._isUploading;
  set isUploading(bool? isUploading) => _$this._isUploading = isUploading;

  DateTime? _uploadedDate;
  DateTime? get uploadedDate => _$this._uploadedDate;
  set uploadedDate(DateTime? uploadedDate) =>
      _$this._uploadedDate = uploadedDate;

  Map<String, dynamic>? _customProperties;
  Map<String, dynamic>? get customProperties => _$this._customProperties;
  set customProperties(Map<String, dynamic>? customProperties) =>
      _$this._customProperties = customProperties;

  CustomChatMediaBuilder();

  CustomChatMediaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _url = $v.url;
      _fileName = $v.fileName;
      _type = $v.type;
      _isUploading = $v.isUploading;
      _uploadedDate = $v.uploadedDate;
      _customProperties = $v.customProperties;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CustomChatMedia other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CustomChatMedia;
  }

  @override
  void update(void Function(CustomChatMediaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CustomChatMedia build() => _build();

  _$CustomChatMedia _build() {
    final _$result = _$v ??
        new _$CustomChatMedia._(
            url: BuiltValueNullFieldError.checkNotNull(
                url, r'CustomChatMedia', 'url'),
            fileName: BuiltValueNullFieldError.checkNotNull(
                fileName, r'CustomChatMedia', 'fileName'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'CustomChatMedia', 'type'),
            isUploading: BuiltValueNullFieldError.checkNotNull(
                isUploading, r'CustomChatMedia', 'isUploading'),
            uploadedDate: uploadedDate,
            customProperties: customProperties);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
