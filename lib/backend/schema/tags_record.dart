import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'tags_record.g.dart';

abstract class TagsRecord implements Built<TagsRecord, TagsRecordBuilder> {
  static Serializer<TagsRecord> get serializer => _$tagsRecordSerializer;

  String? get tag;

  String? get tags;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(TagsRecordBuilder builder) => builder
    ..tag = ''
    ..tags = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tags');

  static Stream<TagsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<TagsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  TagsRecord._();
  factory TagsRecord([void Function(TagsRecordBuilder) updates]) = _$TagsRecord;

  static TagsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createTagsRecordData({
  String? tag,
  String? tags,
}) {
  final firestoreData = serializers.toFirestore(
    TagsRecord.serializer,
    TagsRecord(
      (t) => t
        ..tag = tag
        ..tags = tags,
    ),
  );

  return firestoreData;
}
