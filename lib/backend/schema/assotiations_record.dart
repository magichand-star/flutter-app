import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'assotiations_record.g.dart';

abstract class AssotiationsRecord
    implements Built<AssotiationsRecord, AssotiationsRecordBuilder> {
  static Serializer<AssotiationsRecord> get serializer =>
      _$assotiationsRecordSerializer;

  String? get name;

  DocumentReference? get creator;

  String? get logo;

  @BuiltValueField(wireName: 'created_date')
  DateTime? get createdDate;

  String? get place;

  String? get website;

  String? get career;

  BuiltList<DocumentReference>? get users;

  String? get type;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(AssotiationsRecordBuilder builder) => builder
    ..name = ''
    ..logo = ''
    ..place = ''
    ..website = ''
    ..career = ''
    ..users = ListBuilder()
    ..type = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('assotiations');

  static Stream<AssotiationsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<AssotiationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  AssotiationsRecord._();
  factory AssotiationsRecord(
          [void Function(AssotiationsRecordBuilder) updates]) =
      _$AssotiationsRecord;

  static AssotiationsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createAssotiationsRecordData({
  String? name,
  DocumentReference? creator,
  String? logo,
  DateTime? createdDate,
  String? place,
  String? website,
  String? career,
  String? type,
}) {
  final firestoreData = serializers.toFirestore(
    AssotiationsRecord.serializer,
    AssotiationsRecord(
      (a) => a
        ..name = name
        ..creator = creator
        ..logo = logo
        ..createdDate = createdDate
        ..place = place
        ..website = website
        ..career = career
        ..users = null
        ..type = type,
    ),
  );

  return firestoreData;
}
