import 'dart:convert';

import 'package:monarchium/backend/backend.dart';

class SearchItemModel {
  final String? name;
  final String? imgUrl;
  final bool? isPremium;
  final bool isIn;
  final DocumentReference reference;

  SearchItemModel({
    this.name,
    this.imgUrl,
    this.isPremium,
    required this.isIn,
    required this.reference,
  });

  SearchItemModel copyWith({
    String? name,
    String? imgUrl,
    bool? isPremium,
    bool? isIn,
    DocumentReference? reference,
  }) {
    return SearchItemModel(
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      isPremium: isPremium ?? this.isPremium,
      isIn: isIn ?? this.isIn,
      reference: reference ?? this.reference,
    );
  }

  factory SearchItemModel.fromUsersRecord(
      UsersRecord usersRecord, bool isInNew) {
    // bool isIn = false;

    // if (currentUserDocument?.friends
    //         ?.toList()
    //         .contains(usersRecord.reference) ??
    //     false) {
    //   isIn = true;
    // }

    return SearchItemModel(
      imgUrl: usersRecord.photoUrl,
      isIn: isInNew,
      isPremium: false,
      name: usersRecord.displayName,
      reference: usersRecord.reference,
    );
  }

  factory SearchItemModel.fromAssociationRecord(
      AssotiationsRecord associationsRecord, bool isInAssociation) {
    return SearchItemModel(
      imgUrl: associationsRecord.logo,
      isIn: isInAssociation,
      isPremium: false,
      name: associationsRecord.name,
      reference: associationsRecord.reference,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (imgUrl != null) {
      result.addAll({'imgUrl': imgUrl});
    }
    if (isPremium != null) {
      result.addAll({'isPremium': isPremium});
    }
    result.addAll({'isIn': isIn});
    result.addAll({'reference': reference});

    return result;
  }

  factory SearchItemModel.fromMap(Map<String, dynamic> map) {
    return SearchItemModel(
      name: map['name'],
      imgUrl: map['imgUrl'],
      isPremium: map['isPremium'],
      isIn: map['isIn'],
      reference: map['reference'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchItemModel.fromJson(String source) =>
      SearchItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FriendSearchItemModel(name: $name, imgUrl: $imgUrl, isPremium: $isPremium, isIn: $isIn, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchItemModel &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.isPremium == isPremium &&
        other.isIn == isIn &&
        other.reference == reference;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        imgUrl.hashCode ^
        isPremium.hashCode ^
        isIn.hashCode ^
        reference.hashCode;
  }
}
