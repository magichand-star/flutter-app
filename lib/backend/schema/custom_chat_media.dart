import 'package:built_value/built_value.dart';
import 'package:dash_chat_2/dash_chat_2.dart' as dashChat;

import 'serializers.dart';

part 'custom_chat_media.g.dart';

abstract class CustomChatMedia
    implements Built<CustomChatMedia, CustomChatMediaBuilder> {
  String get url;
  String get fileName;
  MediaType get type;
  bool get isUploading;
  DateTime? get uploadedDate;
  Map<String, dynamic>? get customProperties;

  CustomChatMedia._();
  factory CustomChatMedia([void Function(CustomChatMediaBuilder) updates]) =
      _$CustomChatMedia;

  static Serializer<CustomChatMedia> get serializer =>
      _$customChatMediaSerializer;

  static CustomChatMedia deserialize(Map<String, dynamic> map) {
    return CustomChatMedia(
      (b) => b
        ..url = map['url']
        ..fileName = map['fileName']
        ..type = MediaType.valueOf(map['type'])
        ..isUploading = map['isUploading']
        ..uploadedDate = map['uploadedDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['uploadedDate'])
            : null
        ..customProperties = map['customProperties'] != null
            ? Map<String, dynamic>.from(map['customProperties'])
            : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'fileName': fileName,
      'type': serializers.serializeWith(MediaType.serializer, type),
      'isUploading': isUploading,
      'uploadedDate': uploadedDate?.millisecondsSinceEpoch,
      'customProperties': customProperties,
    };
  }

  // Convert map to CustomChatMedia
  factory CustomChatMedia.fromMap(Map<String, dynamic> map) {
    return CustomChatMedia(
      (b) => b
        ..url = map['url']
        ..fileName = map['fileName']
        ..type = serializers.deserializeWith(MediaType.serializer, map['type'])
        ..isUploading = map['isUploading']
        ..uploadedDate = map['uploadedDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['uploadedDate'])
            : null
        ..customProperties = map['customProperties'],
    );
  }

  // Convert CustomChatMedia to ChatMedia
  dashChat.ChatMedia toChatMedia() {
    return dashChat.ChatMedia(
      url: url,
      fileName: fileName,
      type: toDashChatMediaType(), // use conversion method here
      // other fields...
    );
  }

  // Convert ChatMedia to CustomChatMedia
  factory CustomChatMedia.fromChatMedia(dashChat.ChatMedia chatMedia) {
    return CustomChatMedia(
      (b) => b
        ..url = chatMedia.url
        ..fileName = chatMedia.fileName
        ..type = fromDashChatMediaType(chatMedia.type)
        ..isUploading = chatMedia.isUploading
        ..uploadedDate = chatMedia.uploadedDate
        ..customProperties = chatMedia.customProperties != null
            ? MapBuilder<String, dynamic>(chatMedia.customProperties)
                .build()
                .asMap()
            : null,
    );
  }

  dashChat.MediaType toDashChatMediaType() {
    switch (type.toString()) {
      case 'image':
        return dashChat.MediaType.image;
      case 'video':
        return dashChat.MediaType.video;
      case 'file':
        return dashChat.MediaType.file;
      default:
        throw UnsupportedError('${type.toString()} is not a valid MediaType');
    }
  }

  static MediaType fromDashChatMediaType(dashChat.MediaType mediaType) {
    switch (mediaType.toString()) {
      case 'image':
        return MediaType.image;
      case 'video':
        return MediaType.video;
      case 'file':
        return MediaType.file;
      default:
        throw UnsupportedError(
            '${mediaType.toString()} is not a valid MediaType');
    }
  }
}

class MediaType extends EnumClass {
  static const MediaType image = _$image;
  static const MediaType video = _$video;
  static const MediaType file = _$file;

  const MediaType._(String name) : super(name);

  static BuiltSet<MediaType> get values => _$values;
  static MediaType valueOf(String name) => _$valueOf(name);
  static Serializer<MediaType> get serializer => _$mediaTypeSerializer;
}
