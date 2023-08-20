import 'dart:async';

import 'package:built_value/built_value.dart';

import 'serializers.dart';

part 'emblems_record.g.dart';

abstract class EmblemsRecord
    implements Built<EmblemsRecord, EmblemsRecordBuilder> {
  static Serializer<EmblemsRecord> get serializer => _$emblemsRecordSerializer;

  String? get emblem;
  @BuiltValueField(wireName: 'background_color')
  Color? get backgroundColor;
  @BuiltValueField(wireName: 'suggested_colors')
  BuiltList<Color>? get suggestedColors;

  BuiltList<String>? get tags;
  BuiltList<String>? get positions;

  bool? get filled;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(EmblemsRecordBuilder builder) => builder
    ..emblem = ''
    ..tags = ListBuilder()
    ..positions = ListBuilder()
    ..suggestedColors = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('emblems');

  static Stream<EmblemsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<EmblemsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  EmblemsRecord._();
  factory EmblemsRecord([void Function(EmblemsRecordBuilder) updates]) =
      _$EmblemsRecord;

  static EmblemsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createEmblemsRecordData({
  String? emblem,
  List<Color>? suggestedColors,
  Color? backgroundColor,
}) {
  final firestoreData = serializers.toFirestore(
    EmblemsRecord.serializer,
    EmblemsRecord(
      (e) => e
        ..emblem = emblem
        ..tags = null
        ..positions = null
        ..backgroundColor = backgroundColor
        ..suggestedColors = null,
    ),
  );

  return firestoreData;
}
