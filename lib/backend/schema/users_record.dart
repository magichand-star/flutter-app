import 'dart:async';

import 'package:built_value/built_value.dart';

import 'generated_emblems.dart';
import 'serializers.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  String? get email;

  @BuiltValueField(wireName: 'display_name')
  String? get displayName;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  String? get uid;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  @BuiltValueField(wireName: 'last_rating_updated')
  DateTime? get lastRatingUpdated;

  @BuiltValueField(wireName: 'last_entered')
  DateTime? get lastEntered;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;

  String? get gender;

  DateTime? get birthday;

  @BuiltValueField(wireName: 'first_name')
  String? get firstName;

  String? get name;

  BuiltList<DocumentReference>? get chats;

  DocumentReference? get association;

  BuiltList<DocumentReference>? get associations;

  @BuiltValueField(wireName: 'joined_association')
  bool? get joinedAssociation;

  @BuiltValueField(wireName: 'last_name')
  String? get lastName;

  @BuiltValueField(wireName: 'birthday_place')
  String? get birthdayPlace;

  @BuiltValueField(wireName: 'social_link')
  String? get socialLink;

  @BuiltValueField(wireName: 'father_fio')
  String? get fatherFio;

  @BuiltValueField(wireName: 'father_nationality')
  String? get fatherNationality;

  @BuiltValueField(wireName: 'mother_fio')
  String? get motherFio;

  @BuiltValueField(wireName: 'mother_nationality')
  String? get motherNationality;

  @BuiltValueField(wireName: 'emblem_type')
  String? get emblemType;

  int? get rating;

  BuiltList<DocumentReference>? get friends;

  BuiltList<DocumentReference>? get referrals;

  @BuiltValueField(wireName: 'friends_history')
  BuiltList<DocumentReference>? get friendsHistory;

  BuiltList<String>? get tags;

  BuiltList<DocumentReference>? get emblems;

  @BuiltValueField(wireName: 'generated_emblems', nestedBuilder: true)
  BuiltList<GeneratedEmblems>? get generatedEmblems;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  @BuiltValueField(wireName: 'is_online')
  bool? get isOnline;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..gender = ''
    ..firstName = ''
    ..name = ''
    ..lastName = ''
    ..birthdayPlace = ''
    ..socialLink = ''
    ..fatherFio = ''
    ..fatherNationality = ''
    ..motherFio = ''
    ..motherNationality = ''
    ..emblemType = ''
    ..rating = 0
    ..associations = ListBuilder()
    ..chats = ListBuilder()
    ..friends = ListBuilder()
    ..referrals = ListBuilder()
    ..friendsHistory = ListBuilder()
    ..tags = ListBuilder()
    ..emblems = ListBuilder()
    ..generatedEmblems = ListBuilder()
    ..isOnline = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UsersRecord._();

  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  DateTime? lastRatingUpdated,
  DateTime? lastEntered,
  String? phoneNumber,
  String? gender,
  DateTime? birthday,
  String? firstName,
  String? name,
  DocumentReference? association,
  String? lastName,
  String? birthdayPlace,
  String? socialLink,
  String? fatherFio,
  String? fatherNationality,
  String? motherFio,
  String? motherNationality,
  String? emblemType,
  int? rating,
  bool? isOnline,
}) {
  final firestoreData = serializers.toFirestore(
    UsersRecord.serializer,
    UsersRecord(
      (u) => u
        ..email = email
        ..displayName = displayName
        ..photoUrl = photoUrl
        ..uid = uid
        ..createdTime = createdTime
        ..lastRatingUpdated = lastRatingUpdated
        ..lastEntered = lastEntered
        ..phoneNumber = phoneNumber
        ..gender = gender
        ..birthday = birthday
        ..firstName = firstName
        ..name = name
        ..association = association
        ..lastName = lastName
        ..birthdayPlace = birthdayPlace
        ..socialLink = socialLink
        ..fatherFio = fatherFio
        ..fatherNationality = fatherNationality
        ..motherFio = motherFio
        ..motherNationality = motherNationality
        ..emblemType = emblemType
        ..rating = rating
        ..friends = null
        ..associations = null
        ..chats = null
        ..referrals = null
        ..friendsHistory = null
        ..tags = null
        ..emblems = null
        ..generatedEmblems = null
        ..isOnline = isOnline,
    ),
  );

  return firestoreData;
}
