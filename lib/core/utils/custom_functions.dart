import 'dart:math';

import 'package:flutter/material.dart';
import 'package:text_search/text_search.dart';

import '../../backend/backend.dart';
import '../../backend/schema/models/search_item_model.dart';
import '../../domain/auth/auth_util.dart';
import '../app_export.dart';

List<String> createTags(
  String place,
  String firstName,
  String lastName,
  String father,
  List<String> hobbys,
) {
  List<String> tags2 = [];
  tags2.add(place.split(',').elementAt(0));
  tags2.add(firstName.split(',').elementAt(0));
  tags2.add(lastName.split(',').elementAt(0));
  tags2.add(father.split(',').elementAt(0));

  List<String> finishlist = hobbys + tags2;
  print(finishlist);
  return finishlist;
}

showOverlay({required Future<dynamic> Function() asyncFunction}) {
  return Get.showOverlay(
    asyncFunction: asyncFunction,
    loadingWidget: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: CircularProgressIndicator(color: ColorConstant.lime800)),
    ),
    opacity: 1.0,
  );
}

showSnackbar(String message) {
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      duration: Duration(seconds: 3),
    ),
  );
}

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

List<String> defaultlist(List<String> tags) {
  var tags2 = tags.map((tag) => tag.toLowerCase()).toList();
  print(tags2);
  return tags2;
}

String elementatlist(
  List<String>? elements,
  int? index,
) {
  return elements!.elementAt(index!);
}

List<DocumentReference?> fullEmblemsCount(
    List<DocumentReference?>? startEmblems) {
  if (startEmblems!.length < 3) {
    return startEmblems;
  } else if (startEmblems.length == 3) {
    startEmblems.removeAt(Random().nextInt(3));
    return startEmblems;
  } else {
    int i = 0;
    List<DocumentReference?> finalEmblems = [];
    while (i < 4) {
      DocumentReference? pickedReference;
      while (finalEmblems.contains(pickedReference) || finalEmblems.isEmpty) {
        pickedReference = startEmblems[Random().nextInt(startEmblems.length)];
      }
      finalEmblems.add(pickedReference);
      i++;
    }
    return finalEmblems;
  }
  // if ((startEmblems!.length <= 3)) {
  //   List<DocumentReference?> finishEmblems = startEmblems + startEmblems;
  //   return finishEmblems;
  // } else {
  //   return startEmblems;
  // }
}

Iterable<SearchItemModel> filterUsersList(
    List<UsersRecord> list, UsersRecord? currentUserRecord) {
  return list
      .where(
        (record) =>
            (record.displayName != null && record.displayName!.isNotEmpty),
      )
      .map(
        (userRecord) => mapUserRecord(userRecord, currentUserRecord),
      );
}

Iterable<SearchItemModel> filterAssociationsList(
    List<AssotiationsRecord> list, UsersRecord? currentUserRecord) {
  return list
      .where(
        (record) => (record.name != null && record.name!.isNotEmpty),
      )
      .map(
        (associationRecord) =>
            mapAssociationRecord(associationRecord, currentUserRecord),
      );
}

Iterable<SearchItemModel> filterUsersListWithSearch(
    List<UsersRecord> list, UsersRecord? currentUserRecord) {
  return list
      .where(
        (record) =>
            (record.displayName != null && record.displayName!.isNotEmpty),
      )
      .map(
        (userRecord) => mapUserRecord(userRecord, currentUserRecord),
      );
}

Iterable<SearchItemModel> filterAssociationsListWithSearch(
    List<AssotiationsRecord> list, UsersRecord? currentUserRecord) {
  return list
      .where(
        (record) => (record.name != null && record.name!.isNotEmpty),
      )
      .map(
        (associationRecord) =>
            mapAssociationRecord(associationRecord, currentUserRecord),
      );
}

sortItemsList(List<SearchItemModel> list) {
  list.sort(
    (a, b) => a.name!.compareTo(b.name!),
  );
}

SearchItemModel mapUserRecord(
  UsersRecord userRecord,
  UsersRecord? currentUserRecord,
) {
  return SearchItemModel.fromUsersRecord(
    userRecord,
    (currentUserRecord?.friends?.contains(userRecord.reference) ?? false),
  );
}

SearchItemModel mapAssociationRecord(
  AssotiationsRecord associationRecord,
  UsersRecord? currentUserRecord,
) {
  return SearchItemModel.fromAssociationRecord(
    associationRecord,
    associationRecord.users!.contains(currentUserRecord?.reference),
  );
}

Future<List<SearchItemModel>> getSearchItemList({
  required Future<List<dynamic>> queryFunction(),
}) async {
  List<SearchItemModel> searchItemsList = [];
  UsersRecord? currentUserRecord = await initCurrentUserDocument();

  await queryFunction().then(
    (value) {
      if (value is List<UsersRecord>)
        searchItemsList = filterUsersList(value, currentUserRecord).toList();
      else
        searchItemsList = filterAssociationsList(
                value.cast<AssotiationsRecord>(), currentUserRecord)
            .toList();

      sortItemsList(searchItemsList);
    },
  );
  return searchItemsList;
}

Future<List<SearchItemModel>> searchInItems({
  required List<SearchItemModel> searchItemsList,
  required Future<List<dynamic>> queryFunction(),
  required Future<void> initList(),
  required String text,
}) async {
  UsersRecord? currentUserRecord = await initCurrentUserDocument();
  if (text.isEmpty) {
    return await getSearchItemList(queryFunction: queryFunction);
  }
  await queryFunction()
      .then(
        (records) => searchItemsList = TextSearch(
          records
              .map(
                (record) => TextSearchItem(
                  record,
                  record is UsersRecord
                      ? [record.displayName!, record.firstName!, record.name!]
                      : [record.name!],
                ),
              )
              .toList(),
        )
            .search(text)
            .map((r) => r.object is UsersRecord
                ? mapUserRecord(r.object, currentUserRecord)
                : mapAssociationRecord(r.object, currentUserRecord))
            // .take(50)
            .toList(),
      )
      .onError((_, __) => searchItemsList = []);
  return searchItemsList;
}
