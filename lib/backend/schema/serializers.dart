import 'package:built_value/standard_json_plugin.dart';
import 'package:from_css_color/from_css_color.dart';

import '../backend.dart';
import 'custom_chat_media.dart';
import 'message.dart';

export 'index.dart';

part 'serializers.g.dart';

const kDocumentReferenceField = 'Document__Reference__Field';

@SerializersFor(const [
  UsersRecord,
  AssotiationsRecord,
  EmblemsRecord,
  TagsRecord,
  Message,
  // ChatMedia,
  CustomChatMedia,
  MediaType,
  // List<ChatMedia>,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DocumentReferenceSerializer())
      ..add(DateTimeSerializer())
      // ..add(LatLngSerializer())
      ..add(FirestoreUtilDataSerializer())
      ..add(TimestampSerializer())
      ..add(ColorSerializer())
      // ..add(ChatMediaSerializer())
      // ..addBuilderFactory(
      //     FullType(BuiltList, const [const FullType(ChatMedia)]),
      //     () => ListBuilder<ChatMedia>())
      // ..add(ListChatMediaSerializer())
      // ..addPlugin(StandardJsonPlugin())
      ..addPlugin(StandardJsonPlugin()))
    .build();

extension SerializerExtensions on Serializers {
  Map<String, dynamic> toFirestore<T>(Serializer<T> serializer, T object) =>
      mapToFirestore(serializeWith(serializer, object) as Map<String, dynamic>);
}

class DocumentReferenceSerializer
    implements PrimitiveSerializer<DocumentReference> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([DocumentReference]);
  @override
  final String wireName = 'DocumentReference';

  @override
  Object serialize(Serializers serializers, DocumentReference reference,
      {FullType specifiedType = FullType.unspecified}) {
    return reference;
  }

  @override
  DocumentReference deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      serialized as DocumentReference;
}

class TimestampSerializer implements PrimitiveSerializer<Timestamp> {
  @override
  Timestamp deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return Timestamp.fromMillisecondsSinceEpoch(serialized as int);
  }

  @override
  Object serialize(Serializers serializers, Timestamp object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.millisecondsSinceEpoch;
  }

  @override
  Iterable<Type> get types => [Timestamp];

  @override
  String get wireName => 'Timestamp';
}

class DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  final Iterable<Type> types = new BuiltList<Type>([DateTime]);
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType = FullType.unspecified}) {
    return dateTime;
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      serialized as DateTime;
}

// class LatLngSerializer implements PrimitiveSerializer<LatLng> {
//   final bool structured = false;
//   @override
//   final Iterable<Type> types = new BuiltList<Type>([LatLng]);
//   @override
//   final String wireName = 'LatLng';

//   @override
//   Object serialize(Serializers serializers, LatLng location,
//       {FullType specifiedType: FullType.unspecified}) {
//     return location;
//   }

//   @override
//   LatLng deserialize(Serializers serializers, Object serialized,
//           {FullType specifiedType: FullType.unspecified}) =>
//       serialized as LatLng;
// }

class FirestoreUtilData {
  const FirestoreUtilData({
    this.fieldValues = const {},
    this.clearUnsetFields = true,
    this.create = false,
    this.delete = false,
  });
  final Map<String, dynamic> fieldValues;
  final bool clearUnsetFields;
  final bool create;
  final bool delete;
  static String get name => 'firestoreUtilData';
}

class FirestoreUtilDataSerializer
    implements PrimitiveSerializer<FirestoreUtilData> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([FirestoreUtilData]);
  @override
  final String wireName = 'FirestoreUtilData';

  @override
  Object serialize(Serializers serializers, FirestoreUtilData firestoreUtilData,
      {FullType specifiedType = FullType.unspecified}) {
    return firestoreUtilData;
  }

  @override
  FirestoreUtilData deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      serialized as FirestoreUtilData;
}

class ColorSerializer implements PrimitiveSerializer<Color> {
  @override
  final Iterable<Type> types = new BuiltList<Type>([Color]);
  @override
  final String wireName = 'Color';

  @override
  Object serialize(Serializers serializers, Color color,
      {FullType specifiedType = FullType.unspecified}) {
    return color.toCssString();
  }

  @override
  Color deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      fromCssColor(serialized as String);
}

Map<String, dynamic> serializedData(DocumentSnapshot doc) => {
      ...mapFromFirestore(doc.data() as Map<String, dynamic>),
      kDocumentReferenceField: doc.reference
    };

Map<String, dynamic> mapFromFirestore(Map<String, dynamic> data) =>
    mergeNestedFields(data)
        .where((k, _) => k != FirestoreUtilData.name)
        .map((key, value) {
      // Handle Timestamp
      if (value is Timestamp) {
        value = value.toDate();
      }
      // Handle list of Timestamp
      if (value is Iterable && value.isNotEmpty && value.first is Timestamp) {
        value = value.map((v) => (v as Timestamp).toDate()).toList();
      }
      // Handle GeoPoint
      // if (value is GeoPoint) {
      //   value = value.toLatLng();
      // }
      // // Handle list of GeoPoint
      // if (value is Iterable && value.isNotEmpty && value.first is GeoPoint) {
      //   value = value.map((v) => (v as GeoPoint).toLatLng()).toList();
      // }
      // Handle nested data.
      if (value is Map) {
        value = mapFromFirestore(value as Map<String, dynamic>);
      }
      // Handle list of nested data.
      if (value is Iterable && value.isNotEmpty && value.first is Map) {
        value = value
            .map((v) => mapFromFirestore(v as Map<String, dynamic>))
            .toList();
      }
      return MapEntry(key, value);
    });

Map<String, dynamic> mapToFirestore(Map<String, dynamic> data) =>
    data.where((k, v) => k != FirestoreUtilData.name).map((key, value) {
      // Handle GeoPoint
      // if (value is LatLng) {
      //   value = value.toGeoPoint();
      // }
      // Handle list of GeoPoint
      // if (value is Iterable && value.isNotEmpty && value.first is LatLng) {
      //   value = value.map((v) => (v as LatLng).toGeoPoint()).toList();
      // }
      // Handle nested data.
      if (value is Map) {
        value = mapFromFirestore(value as Map<String, dynamic>);
      }
      // Handle list of nested data.
      if (value is Iterable && value.isNotEmpty && value.first is Map) {
        value = value
            .map((v) => mapFromFirestore(v as Map<String, dynamic>))
            .toList();
      }
      return MapEntry(key, value);
    });

// extension GeoPointExtension on LatLng {
//   GeoPoint toGeoPoint() => GeoPoint(latitude, longitude);
// }

// extension LatLngExtension on GeoPoint {
//   LatLng toLatLng() => LatLng(latitude, longitude);
// }

DocumentReference toRef(String ref) => FirebaseFirestore.instance.doc(ref);

T? safeGet<T>(T Function() func, [Function(dynamic)? reportError]) {
  try {
    return func();
  } catch (e) {
    reportError?.call(e);
  }
  return null;
}

Map<String, dynamic> mergeNestedFields(Map<String, dynamic> data) {
  final nestedData = data.where((k, _) => k.contains('.'));
  final fieldNames = nestedData.keys.map((k) => k.split('.').first).toSet();
  // Remove nested values (e.g. 'foo.bar') and merge them into a map.
  data.removeWhere((k, _) => k.contains('.'));
  fieldNames.forEach((name) {
    final mergedValues = mergeNestedFields(
      nestedData
          .where((k, _) => k.split('.').first == name)
          .map((k, v) => MapEntry(k.split('.').skip(1).join('.'), v)),
    );
    final existingValue = data[name];
    data[name] = {
      if (existingValue != null && existingValue is Map)
        ...existingValue as Map<String, dynamic>,
      ...mergedValues,
    };
  });
  // Merge any nested maps inside any of the fields as well.
  data.where((_, v) => v is Map).forEach((k, v) {
    data[k] = mergeNestedFields(v as Map<String, dynamic>);
  });

  return data;
}

extension _WhereMapExtension<K, V> on Map<K, V> {
  Map<K, V> where(bool Function(K, V) test) =>
      Map.fromEntries(entries.where((e) => test(e.key, e.value)));
}

// class ChatMediaSerializer implements StructuredSerializer<ChatMedia> {
//   @override
//   ChatMedia deserialize(Serializers serializers, Iterable serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     final Map<String, dynamic> data =
//         Map<String, dynamic>.from(serialized.first);

//     return ChatMedia(
//       url: data['url'],
//       fileName: data['fileName'],
//       type: MediaType.parse(data['type']),
//       isUploading: data['isUploading'],
//       uploadedDate: data['uploadedDate'] != null
//           ? DateTime.parse(data['uploadedDate'])
//           : null,
//       customProperties: Map<String, dynamic>.from(data['customProperties']),
//     );
//   }

//   @override
//   Iterable serialize(Serializers serializers, ChatMedia object,
//       {FullType specifiedType = FullType.unspecified}) {
//     return [
//       {
//         'url': object.url,
//         'fileName': object.fileName,
//         'type': object.type.toString(),
//         'isUploading': object.isUploading,
//         'uploadedDate': object.uploadedDate?.toUtc().toIso8601String(),
//         'customProperties': object.customProperties,
//       },
//     ];
//   }

//   @override
//   Iterable<Type> get types => [ChatMedia];

//   @override
//   String get wireName => 'ChatMedia';
// }

// class ListChatMediaSerializer implements StructuredSerializer<List<ChatMedia>> {
//   @override
//   final Iterable<Type> types = new BuiltList<Type>([BuiltList<ChatMedia>]);
//   @override
//   final String wireName = 'List<ChatMedia>';

//   @override
//   Iterable<Object?> serialize(
//       Serializers serializers, List<ChatMedia> chatMediaList,
//       {FullType specifiedType = FullType.unspecified}) {
//     return chatMediaList.map((ChatMedia chatMedia) =>
//         serializers.serializeWith(ChatMediaSerializer(), chatMedia));
//   }

//   @override
//   List<ChatMedia> deserialize(
//       Serializers serializers, Iterable<Object?> serialized,
//       {FullType specifiedType = FullType.unspecified}) {
//     return serialized
//         .map((e) => serializers.deserializeWith(ChatMediaSerializer(), e))
//         .where((element) => element != null)
//         .toList() as List<ChatMedia>;
//   }
// }
