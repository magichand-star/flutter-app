import 'dart:convert';

import 'package:flutter/foundation.dart';

class YandexAuthData {
  final String? id;
  final String? login;
  final String? clientId;
  final String? displayName;
  final String? realName;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final String? sex;
  final String? defaultEmail;
  final List<String>? emails;
  final String? birthday;
  final String? defaultAvatarId;
  final bool? isAvatarEmpty;
  final DefaultPhone? defaultPhone;
  final String? psuid;

  static const avatarUrlBase = "https://avatars.yandex.net/get-yapic";

  YandexAuthData({
    required this.id,
    required this.login,
    required this.clientId,
    required this.displayName,
    required this.realName,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
    required this.sex,
    required this.defaultEmail,
    required this.emails,
    required this.birthday,
    required this.defaultAvatarId,
    required this.isAvatarEmpty,
    required this.defaultPhone,
    required this.psuid,
  });

  YandexAuthData copyWith({
    String? id,
    String? login,
    String? clientId,
    String? displayName,
    String? realName,
    String? firstName,
    String? lastName,
    String? sex,
    String? defaultEmail,
    List<String>? emails,
    String? birthday,
    String? defaultAvatarId,
    bool? isAvatarEmpty,
    DefaultPhone? defaultPhone,
    String? psuid,
  }) {
    return YandexAuthData(
      id: id ?? this.id,
      login: login ?? this.login,
      clientId: clientId ?? this.clientId,
      displayName: displayName ?? this.displayName,
      realName: realName ?? this.realName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      sex: sex ?? this.sex,
      defaultEmail: defaultEmail ?? this.defaultEmail,
      emails: emails ?? this.emails,
      birthday: birthday ?? this.birthday,
      defaultAvatarId: defaultAvatarId ?? this.defaultAvatarId,
      isAvatarEmpty: isAvatarEmpty ?? this.isAvatarEmpty,
      defaultPhone: defaultPhone ?? this.defaultPhone,
      psuid: psuid ?? this.psuid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'login': login});
    result.addAll({'client_id': clientId});
    result.addAll({'display_name': displayName});
    result.addAll({'real_name': realName});
    result.addAll({'first_name': firstName});
    result.addAll({'last_name': lastName});
    result.addAll({'sex': sex});
    result.addAll({'default_email': defaultEmail});
    result.addAll({'emails': emails});
    result.addAll({'birthday': birthday});
    result.addAll({'default_avatar_id': defaultAvatarId});
    result.addAll({'is_avatar_empty': isAvatarEmpty});
    result.addAll({'default_phone': defaultPhone?.toMap()});
    result.addAll({'psuid': psuid});

    return result;
  }

  factory YandexAuthData.fromMap(Map<String, dynamic> map) {
    return YandexAuthData(
      id: map['id'] ?? '',
      login: map['login'] ?? '',
      clientId: map['client_id'] ?? '',
      displayName: map['display_name'] ?? '',
      realName: map['real_name'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      avatarUrl: "$avatarUrlBase/${map['default_avatar']}/islands-200",
      sex: map['sex'],
      defaultEmail: map['default_email'] ?? '',
      emails: List<String>.from(map['emails']),
      birthday: map['birthday'] ?? '',
      defaultAvatarId: map['default_avatar_id'] ?? '',
      isAvatarEmpty: map['is_avatar_empty'] ?? false,
      defaultPhone: DefaultPhone.fromMap(map['default_phone']),
      psuid: map['psuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory YandexAuthData.fromJson(String source) =>
      YandexAuthData.fromMap(json.decode(source));

  Map<String, dynamic> toUserData() {
    final result = <String, dynamic>{};

    result.addAll({'displayName': displayName});
    result.addAll({'name': realName});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    String? gender;
    switch (sex) {
      case 'male':
        gender = 'Мужской';
        break;
      case 'female':
        gender = 'Женский';
        break;
    }
    if (gender != null) result.addAll({'gender': gender});
    if (defaultEmail != null || (emails != null && emails!.isNotEmpty))
      result.addAll({'email': defaultEmail ?? emails!.first});
    result.addAll(
      {
        'birthday': birthday != null && birthday!.isNotEmpty
            ? DateTime.parse(birthday!)
            : null
      },
    );
    result.addAll({
      'photoUrl': (isAvatarEmpty ?? false) ? null : avatarUrl,
    });
    result.addAll({'phoneNumber': defaultPhone?.number});

    return result;
  }

  @override
  String toString() {
    return 'YandexAuthData(id: $id, login: $login, client_id: $clientId, display_name: $displayName, real_name: $realName, first_name: $firstName, last_name: $lastName, sex: $sex, default_email: $defaultEmail, emails: $emails, birthday: $birthday, default_avatar_id: $defaultAvatarId, is_avatar_empty: $isAvatarEmpty, defaultPhone: $defaultPhone, psuid: $psuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YandexAuthData &&
        other.id == id &&
        other.login == login &&
        other.clientId == clientId &&
        other.displayName == displayName &&
        other.realName == realName &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.sex == sex &&
        other.defaultEmail == defaultEmail &&
        listEquals(other.emails, emails) &&
        other.birthday == birthday &&
        other.defaultAvatarId == defaultAvatarId &&
        other.isAvatarEmpty == isAvatarEmpty &&
        other.defaultPhone == defaultPhone &&
        other.psuid == psuid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        login.hashCode ^
        clientId.hashCode ^
        displayName.hashCode ^
        realName.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        sex.hashCode ^
        defaultEmail.hashCode ^
        emails.hashCode ^
        birthday.hashCode ^
        defaultAvatarId.hashCode ^
        isAvatarEmpty.hashCode ^
        defaultPhone.hashCode ^
        psuid.hashCode;
  }
}

class DefaultPhone {
  final int id;
  final String number;
  DefaultPhone({
    required this.id,
    required this.number,
  });

  DefaultPhone copyWith({
    int? id,
    String? number,
  }) {
    return DefaultPhone(
      id: id ?? this.id,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'number': number});

    return result;
  }

  factory DefaultPhone.fromMap(Map<String, dynamic> map) {
    return DefaultPhone(
      id: map['id']?.toInt() ?? 0,
      number: map['number'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultPhone.fromJson(String source) =>
      DefaultPhone.fromMap(json.decode(source));

  @override
  String toString() => 'DefaultPhone(id: $id, number: $number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DefaultPhone && other.id == id && other.number == number;
  }

  @override
  int get hashCode => id.hashCode ^ number.hashCode;
}
