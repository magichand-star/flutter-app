// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsersRecord> _$usersRecordSerializer = new _$UsersRecordSerializer();

class _$UsersRecordSerializer implements StructuredSerializer<UsersRecord> {
  @override
  final Iterable<Type> types = const [UsersRecord, _$UsersRecord];
  @override
  final String wireName = 'UsersRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, UsersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdTime;
    if (value != null) {
      result
        ..add('created_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.lastRatingUpdated;
    if (value != null) {
      result
        ..add('last_rating_updated')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.lastEntered;
    if (value != null) {
      result
        ..add('last_entered')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.gender;
    if (value != null) {
      result
        ..add('gender')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.birthday;
    if (value != null) {
      result
        ..add('birthday')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.firstName;
    if (value != null) {
      result
        ..add('first_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.chats;
    if (value != null) {
      result
        ..add('chats')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.association;
    if (value != null) {
      result
        ..add('association')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.associations;
    if (value != null) {
      result
        ..add('associations')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.joinedAssociation;
    if (value != null) {
      result
        ..add('joined_association')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.lastName;
    if (value != null) {
      result
        ..add('last_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.birthdayPlace;
    if (value != null) {
      result
        ..add('birthday_place')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.socialLink;
    if (value != null) {
      result
        ..add('social_link')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fatherFio;
    if (value != null) {
      result
        ..add('father_fio')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fatherNationality;
    if (value != null) {
      result
        ..add('father_nationality')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.motherFio;
    if (value != null) {
      result
        ..add('mother_fio')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.motherNationality;
    if (value != null) {
      result
        ..add('mother_nationality')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emblemType;
    if (value != null) {
      result
        ..add('emblem_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.rating;
    if (value != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.friends;
    if (value != null) {
      result
        ..add('friends')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.referrals;
    if (value != null) {
      result
        ..add('referrals')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.friendsHistory;
    if (value != null) {
      result
        ..add('friends_history')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.tags;
    if (value != null) {
      result
        ..add('tags')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.emblems;
    if (value != null) {
      result
        ..add('emblems')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.generatedEmblems;
    if (value != null) {
      result
        ..add('generated_emblems')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(GeneratedEmblems)])));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.isOnline;
    if (value != null) {
      result
        ..add('is_online')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  UsersRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'last_rating_updated':
          result.lastRatingUpdated = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'last_entered':
          result.lastEntered = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'phone_number':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'gender':
          result.gender = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'birthday':
          result.birthday = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'chats':
          result.chats.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'association':
          result.association = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'associations':
          result.associations.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'joined_association':
          result.joinedAssociation = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'birthday_place':
          result.birthdayPlace = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'social_link':
          result.socialLink = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'father_fio':
          result.fatherFio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'father_nationality':
          result.fatherNationality = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mother_fio':
          result.motherFio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mother_nationality':
          result.motherNationality = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'emblem_type':
          result.emblemType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'friends':
          result.friends.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'referrals':
          result.referrals.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'friends_history':
          result.friendsHistory.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'emblems':
          result.emblems.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'generated_emblems':
          result.generatedEmblems.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(GeneratedEmblems)]))!
              as BuiltList<Object?>);
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'is_online':
          result.isOnline = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$UsersRecord extends UsersRecord {
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  final String? uid;
  @override
  final DateTime? createdTime;
  @override
  final DateTime? lastRatingUpdated;
  @override
  final DateTime? lastEntered;
  @override
  final String? phoneNumber;
  @override
  final String? gender;
  @override
  final DateTime? birthday;
  @override
  final String? firstName;
  @override
  final String? name;
  @override
  final BuiltList<DocumentReference<Object?>>? chats;
  @override
  final DocumentReference<Object?>? association;
  @override
  final BuiltList<DocumentReference<Object?>>? associations;
  @override
  final bool? joinedAssociation;
  @override
  final String? lastName;
  @override
  final String? birthdayPlace;
  @override
  final String? socialLink;
  @override
  final String? fatherFio;
  @override
  final String? fatherNationality;
  @override
  final String? motherFio;
  @override
  final String? motherNationality;
  @override
  final String? emblemType;
  @override
  final int? rating;
  @override
  final BuiltList<DocumentReference<Object?>>? friends;
  @override
  final BuiltList<DocumentReference<Object?>>? referrals;
  @override
  final BuiltList<DocumentReference<Object?>>? friendsHistory;
  @override
  final BuiltList<String>? tags;
  @override
  final BuiltList<DocumentReference<Object?>>? emblems;
  @override
  final BuiltList<GeneratedEmblems>? generatedEmblems;
  @override
  final DocumentReference<Object?>? ffRef;
  @override
  final bool? isOnline;

  factory _$UsersRecord([void Function(UsersRecordBuilder)? updates]) =>
      (new UsersRecordBuilder()..update(updates))._build();

  _$UsersRecord._(
      {this.email,
      this.displayName,
      this.photoUrl,
      this.uid,
      this.createdTime,
      this.lastRatingUpdated,
      this.lastEntered,
      this.phoneNumber,
      this.gender,
      this.birthday,
      this.firstName,
      this.name,
      this.chats,
      this.association,
      this.associations,
      this.joinedAssociation,
      this.lastName,
      this.birthdayPlace,
      this.socialLink,
      this.fatherFio,
      this.fatherNationality,
      this.motherFio,
      this.motherNationality,
      this.emblemType,
      this.rating,
      this.friends,
      this.referrals,
      this.friendsHistory,
      this.tags,
      this.emblems,
      this.generatedEmblems,
      this.ffRef,
      this.isOnline})
      : super._();

  @override
  UsersRecord rebuild(void Function(UsersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersRecordBuilder toBuilder() => new UsersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersRecord &&
        email == other.email &&
        displayName == other.displayName &&
        photoUrl == other.photoUrl &&
        uid == other.uid &&
        createdTime == other.createdTime &&
        lastRatingUpdated == other.lastRatingUpdated &&
        lastEntered == other.lastEntered &&
        phoneNumber == other.phoneNumber &&
        gender == other.gender &&
        birthday == other.birthday &&
        firstName == other.firstName &&
        name == other.name &&
        chats == other.chats &&
        association == other.association &&
        associations == other.associations &&
        joinedAssociation == other.joinedAssociation &&
        lastName == other.lastName &&
        birthdayPlace == other.birthdayPlace &&
        socialLink == other.socialLink &&
        fatherFio == other.fatherFio &&
        fatherNationality == other.fatherNationality &&
        motherFio == other.motherFio &&
        motherNationality == other.motherNationality &&
        emblemType == other.emblemType &&
        rating == other.rating &&
        friends == other.friends &&
        referrals == other.referrals &&
        friendsHistory == other.friendsHistory &&
        tags == other.tags &&
        emblems == other.emblems &&
        generatedEmblems == other.generatedEmblems &&
        ffRef == other.ffRef &&
        isOnline == other.isOnline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, createdTime.hashCode);
    _$hash = $jc(_$hash, lastRatingUpdated.hashCode);
    _$hash = $jc(_$hash, lastEntered.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jc(_$hash, birthday.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, chats.hashCode);
    _$hash = $jc(_$hash, association.hashCode);
    _$hash = $jc(_$hash, associations.hashCode);
    _$hash = $jc(_$hash, joinedAssociation.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, birthdayPlace.hashCode);
    _$hash = $jc(_$hash, socialLink.hashCode);
    _$hash = $jc(_$hash, fatherFio.hashCode);
    _$hash = $jc(_$hash, fatherNationality.hashCode);
    _$hash = $jc(_$hash, motherFio.hashCode);
    _$hash = $jc(_$hash, motherNationality.hashCode);
    _$hash = $jc(_$hash, emblemType.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, friends.hashCode);
    _$hash = $jc(_$hash, referrals.hashCode);
    _$hash = $jc(_$hash, friendsHistory.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, emblems.hashCode);
    _$hash = $jc(_$hash, generatedEmblems.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jc(_$hash, isOnline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsersRecord')
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('photoUrl', photoUrl)
          ..add('uid', uid)
          ..add('createdTime', createdTime)
          ..add('lastRatingUpdated', lastRatingUpdated)
          ..add('lastEntered', lastEntered)
          ..add('phoneNumber', phoneNumber)
          ..add('gender', gender)
          ..add('birthday', birthday)
          ..add('firstName', firstName)
          ..add('name', name)
          ..add('chats', chats)
          ..add('association', association)
          ..add('associations', associations)
          ..add('joinedAssociation', joinedAssociation)
          ..add('lastName', lastName)
          ..add('birthdayPlace', birthdayPlace)
          ..add('socialLink', socialLink)
          ..add('fatherFio', fatherFio)
          ..add('fatherNationality', fatherNationality)
          ..add('motherFio', motherFio)
          ..add('motherNationality', motherNationality)
          ..add('emblemType', emblemType)
          ..add('rating', rating)
          ..add('friends', friends)
          ..add('referrals', referrals)
          ..add('friendsHistory', friendsHistory)
          ..add('tags', tags)
          ..add('emblems', emblems)
          ..add('generatedEmblems', generatedEmblems)
          ..add('ffRef', ffRef)
          ..add('isOnline', isOnline))
        .toString();
  }
}

class UsersRecordBuilder implements Builder<UsersRecord, UsersRecordBuilder> {
  _$UsersRecord? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  DateTime? _createdTime;
  DateTime? get createdTime => _$this._createdTime;
  set createdTime(DateTime? createdTime) => _$this._createdTime = createdTime;

  DateTime? _lastRatingUpdated;
  DateTime? get lastRatingUpdated => _$this._lastRatingUpdated;
  set lastRatingUpdated(DateTime? lastRatingUpdated) =>
      _$this._lastRatingUpdated = lastRatingUpdated;

  DateTime? _lastEntered;
  DateTime? get lastEntered => _$this._lastEntered;
  set lastEntered(DateTime? lastEntered) => _$this._lastEntered = lastEntered;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _gender;
  String? get gender => _$this._gender;
  set gender(String? gender) => _$this._gender = gender;

  DateTime? _birthday;
  DateTime? get birthday => _$this._birthday;
  set birthday(DateTime? birthday) => _$this._birthday = birthday;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ListBuilder<DocumentReference<Object?>>? _chats;
  ListBuilder<DocumentReference<Object?>> get chats =>
      _$this._chats ??= new ListBuilder<DocumentReference<Object?>>();
  set chats(ListBuilder<DocumentReference<Object?>>? chats) =>
      _$this._chats = chats;

  DocumentReference<Object?>? _association;
  DocumentReference<Object?>? get association => _$this._association;
  set association(DocumentReference<Object?>? association) =>
      _$this._association = association;

  ListBuilder<DocumentReference<Object?>>? _associations;
  ListBuilder<DocumentReference<Object?>> get associations =>
      _$this._associations ??= new ListBuilder<DocumentReference<Object?>>();
  set associations(ListBuilder<DocumentReference<Object?>>? associations) =>
      _$this._associations = associations;

  bool? _joinedAssociation;
  bool? get joinedAssociation => _$this._joinedAssociation;
  set joinedAssociation(bool? joinedAssociation) =>
      _$this._joinedAssociation = joinedAssociation;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _birthdayPlace;
  String? get birthdayPlace => _$this._birthdayPlace;
  set birthdayPlace(String? birthdayPlace) =>
      _$this._birthdayPlace = birthdayPlace;

  String? _socialLink;
  String? get socialLink => _$this._socialLink;
  set socialLink(String? socialLink) => _$this._socialLink = socialLink;

  String? _fatherFio;
  String? get fatherFio => _$this._fatherFio;
  set fatherFio(String? fatherFio) => _$this._fatherFio = fatherFio;

  String? _fatherNationality;
  String? get fatherNationality => _$this._fatherNationality;
  set fatherNationality(String? fatherNationality) =>
      _$this._fatherNationality = fatherNationality;

  String? _motherFio;
  String? get motherFio => _$this._motherFio;
  set motherFio(String? motherFio) => _$this._motherFio = motherFio;

  String? _motherNationality;
  String? get motherNationality => _$this._motherNationality;
  set motherNationality(String? motherNationality) =>
      _$this._motherNationality = motherNationality;

  String? _emblemType;
  String? get emblemType => _$this._emblemType;
  set emblemType(String? emblemType) => _$this._emblemType = emblemType;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  ListBuilder<DocumentReference<Object?>>? _friends;
  ListBuilder<DocumentReference<Object?>> get friends =>
      _$this._friends ??= new ListBuilder<DocumentReference<Object?>>();
  set friends(ListBuilder<DocumentReference<Object?>>? friends) =>
      _$this._friends = friends;

  ListBuilder<DocumentReference<Object?>>? _referrals;
  ListBuilder<DocumentReference<Object?>> get referrals =>
      _$this._referrals ??= new ListBuilder<DocumentReference<Object?>>();
  set referrals(ListBuilder<DocumentReference<Object?>>? referrals) =>
      _$this._referrals = referrals;

  ListBuilder<DocumentReference<Object?>>? _friendsHistory;
  ListBuilder<DocumentReference<Object?>> get friendsHistory =>
      _$this._friendsHistory ??= new ListBuilder<DocumentReference<Object?>>();
  set friendsHistory(ListBuilder<DocumentReference<Object?>>? friendsHistory) =>
      _$this._friendsHistory = friendsHistory;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= new ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  ListBuilder<DocumentReference<Object?>>? _emblems;
  ListBuilder<DocumentReference<Object?>> get emblems =>
      _$this._emblems ??= new ListBuilder<DocumentReference<Object?>>();
  set emblems(ListBuilder<DocumentReference<Object?>>? emblems) =>
      _$this._emblems = emblems;

  ListBuilder<GeneratedEmblems>? _generatedEmblems;
  ListBuilder<GeneratedEmblems> get generatedEmblems =>
      _$this._generatedEmblems ??= new ListBuilder<GeneratedEmblems>();
  set generatedEmblems(ListBuilder<GeneratedEmblems>? generatedEmblems) =>
      _$this._generatedEmblems = generatedEmblems;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  bool? _isOnline;
  bool? get isOnline => _$this._isOnline;
  set isOnline(bool? isOnline) => _$this._isOnline = isOnline;

  UsersRecordBuilder() {
    UsersRecord._initializeBuilder(this);
  }

  UsersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _displayName = $v.displayName;
      _photoUrl = $v.photoUrl;
      _uid = $v.uid;
      _createdTime = $v.createdTime;
      _lastRatingUpdated = $v.lastRatingUpdated;
      _lastEntered = $v.lastEntered;
      _phoneNumber = $v.phoneNumber;
      _gender = $v.gender;
      _birthday = $v.birthday;
      _firstName = $v.firstName;
      _name = $v.name;
      _chats = $v.chats?.toBuilder();
      _association = $v.association;
      _associations = $v.associations?.toBuilder();
      _joinedAssociation = $v.joinedAssociation;
      _lastName = $v.lastName;
      _birthdayPlace = $v.birthdayPlace;
      _socialLink = $v.socialLink;
      _fatherFio = $v.fatherFio;
      _fatherNationality = $v.fatherNationality;
      _motherFio = $v.motherFio;
      _motherNationality = $v.motherNationality;
      _emblemType = $v.emblemType;
      _rating = $v.rating;
      _friends = $v.friends?.toBuilder();
      _referrals = $v.referrals?.toBuilder();
      _friendsHistory = $v.friendsHistory?.toBuilder();
      _tags = $v.tags?.toBuilder();
      _emblems = $v.emblems?.toBuilder();
      _generatedEmblems = $v.generatedEmblems?.toBuilder();
      _ffRef = $v.ffRef;
      _isOnline = $v.isOnline;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsersRecord;
  }

  @override
  void update(void Function(UsersRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsersRecord build() => _build();

  _$UsersRecord _build() {
    _$UsersRecord _$result;
    try {
      _$result = _$v ??
          new _$UsersRecord._(
              email: email,
              displayName: displayName,
              photoUrl: photoUrl,
              uid: uid,
              createdTime: createdTime,
              lastRatingUpdated: lastRatingUpdated,
              lastEntered: lastEntered,
              phoneNumber: phoneNumber,
              gender: gender,
              birthday: birthday,
              firstName: firstName,
              name: name,
              chats: _chats?.build(),
              association: association,
              associations: _associations?.build(),
              joinedAssociation: joinedAssociation,
              lastName: lastName,
              birthdayPlace: birthdayPlace,
              socialLink: socialLink,
              fatherFio: fatherFio,
              fatherNationality: fatherNationality,
              motherFio: motherFio,
              motherNationality: motherNationality,
              emblemType: emblemType,
              rating: rating,
              friends: _friends?.build(),
              referrals: _referrals?.build(),
              friendsHistory: _friendsHistory?.build(),
              tags: _tags?.build(),
              emblems: _emblems?.build(),
              generatedEmblems: _generatedEmblems?.build(),
              ffRef: ffRef,
              isOnline: isOnline);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'chats';
        _chats?.build();

        _$failedField = 'associations';
        _associations?.build();

        _$failedField = 'friends';
        _friends?.build();
        _$failedField = 'referrals';
        _referrals?.build();
        _$failedField = 'friendsHistory';
        _friendsHistory?.build();
        _$failedField = 'tags';
        _tags?.build();
        _$failedField = 'emblems';
        _emblems?.build();
        _$failedField = 'generatedEmblems';
        _generatedEmblems?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UsersRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
