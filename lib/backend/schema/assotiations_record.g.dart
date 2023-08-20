// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assotiations_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AssotiationsRecord> _$assotiationsRecordSerializer =
    new _$AssotiationsRecordSerializer();

class _$AssotiationsRecordSerializer
    implements StructuredSerializer<AssotiationsRecord> {
  @override
  final Iterable<Type> types = const [AssotiationsRecord, _$AssotiationsRecord];
  @override
  final String wireName = 'AssotiationsRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, AssotiationsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.creator;
    if (value != null) {
      result
        ..add('creator')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    value = object.logo;
    if (value != null) {
      result
        ..add('logo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdDate;
    if (value != null) {
      result
        ..add('created_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.place;
    if (value != null) {
      result
        ..add('place')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.website;
    if (value != null) {
      result
        ..add('website')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.career;
    if (value != null) {
      result
        ..add('career')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.users;
    if (value != null) {
      result
        ..add('users')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  AssotiationsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AssotiationsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'creator':
          result.creator = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
        case 'logo':
          result.logo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_date':
          result.createdDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'place':
          result.place = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'website':
          result.website = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'career':
          result.career = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'users':
          result.users.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$AssotiationsRecord extends AssotiationsRecord {
  @override
  final String? name;
  @override
  final DocumentReference<Object?>? creator;
  @override
  final String? logo;
  @override
  final DateTime? createdDate;
  @override
  final String? place;
  @override
  final String? website;
  @override
  final String? career;
  @override
  final BuiltList<DocumentReference<Object?>>? users;
  @override
  final String? type;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$AssotiationsRecord(
          [void Function(AssotiationsRecordBuilder)? updates]) =>
      (new AssotiationsRecordBuilder()..update(updates))._build();

  _$AssotiationsRecord._(
      {this.name,
      this.creator,
      this.logo,
      this.createdDate,
      this.place,
      this.website,
      this.career,
      this.users,
      this.type,
      this.ffRef})
      : super._();

  @override
  AssotiationsRecord rebuild(
          void Function(AssotiationsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssotiationsRecordBuilder toBuilder() =>
      new AssotiationsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssotiationsRecord &&
        name == other.name &&
        creator == other.creator &&
        logo == other.logo &&
        createdDate == other.createdDate &&
        place == other.place &&
        website == other.website &&
        career == other.career &&
        users == other.users &&
        type == other.type &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, creator.hashCode);
    _$hash = $jc(_$hash, logo.hashCode);
    _$hash = $jc(_$hash, createdDate.hashCode);
    _$hash = $jc(_$hash, place.hashCode);
    _$hash = $jc(_$hash, website.hashCode);
    _$hash = $jc(_$hash, career.hashCode);
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssotiationsRecord')
          ..add('name', name)
          ..add('creator', creator)
          ..add('logo', logo)
          ..add('createdDate', createdDate)
          ..add('place', place)
          ..add('website', website)
          ..add('career', career)
          ..add('users', users)
          ..add('type', type)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class AssotiationsRecordBuilder
    implements Builder<AssotiationsRecord, AssotiationsRecordBuilder> {
  _$AssotiationsRecord? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  DocumentReference<Object?>? _creator;
  DocumentReference<Object?>? get creator => _$this._creator;
  set creator(DocumentReference<Object?>? creator) => _$this._creator = creator;

  String? _logo;
  String? get logo => _$this._logo;
  set logo(String? logo) => _$this._logo = logo;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  String? _place;
  String? get place => _$this._place;
  set place(String? place) => _$this._place = place;

  String? _website;
  String? get website => _$this._website;
  set website(String? website) => _$this._website = website;

  String? _career;
  String? get career => _$this._career;
  set career(String? career) => _$this._career = career;

  ListBuilder<DocumentReference<Object?>>? _users;
  ListBuilder<DocumentReference<Object?>> get users =>
      _$this._users ??= new ListBuilder<DocumentReference<Object?>>();
  set users(ListBuilder<DocumentReference<Object?>>? users) =>
      _$this._users = users;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  AssotiationsRecordBuilder() {
    AssotiationsRecord._initializeBuilder(this);
  }

  AssotiationsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _creator = $v.creator;
      _logo = $v.logo;
      _createdDate = $v.createdDate;
      _place = $v.place;
      _website = $v.website;
      _career = $v.career;
      _users = $v.users?.toBuilder();
      _type = $v.type;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssotiationsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AssotiationsRecord;
  }

  @override
  void update(void Function(AssotiationsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssotiationsRecord build() => _build();

  _$AssotiationsRecord _build() {
    _$AssotiationsRecord _$result;
    try {
      _$result = _$v ??
          new _$AssotiationsRecord._(
              name: name,
              creator: creator,
              logo: logo,
              createdDate: createdDate,
              place: place,
              website: website,
              career: career,
              users: _users?.build(),
              type: type,
              ffRef: ffRef);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        _users?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AssotiationsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
