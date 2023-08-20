import 'package:firebase_auth/firebase_auth.dart';
import 'package:monarchium/backend/backend.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/utils/custom_functions.dart';
import 'package:monarchium/domain/auth/auth_util.dart';
import 'package:monarchium/backend/schema/models/search_item_model.dart';

class FriendsController extends GetxController {
  TextEditingController inputiconleftController = TextEditingController();

  String? displayName;
  List<dynamic> friendsList = [];

  Future<void> initFriendsList() async {
    // debugger();
    UsersRecord? currentUserRecord = await initCurrentUserDocument();
    List<DocumentReference<Object?>>? friendsRefs =
        currentUserRecord?.friends?.toList();
    if (friendsRefs != null) {
      for (var friendRef in friendsRefs) {
        UsersRecord friendRecord = await UsersRecord.getDocumentOnce(friendRef);
        friendsList.add(friendRecord);
      }
    }

    if (friendsList.isNotEmpty) {
      friendsList = friendsList
          .map(
            (record) => SearchItemModel.fromUsersRecord(
              record,
              currentUserRecord?.friends?.contains(record.reference) ?? false,
            ),
          )
          .toList();
      friendsList.sort((a, b) => a.name!.compareTo(b.name!));
      update();
    }
  }

  onButtonPressed(int index) {
    removeFriend(friendsList[index].reference, index);
  }

  removeFriend(DocumentReference reference, int index) async {
    final usersUpdateData = {
      'friends': FieldValue.arrayRemove([reference]),
    };
    friendsList.removeAt(index);
    update();

    showSnackbar('Вы удалил пользователя из друзей!');

    await updateUserData(usersUpdateData);
  }

  updateUserData(Map<String, FieldValue> usersUpdateData) async {
    // debugger();
    DocumentReference<Object?>? currentReference =
        currentUserDocument?.reference;
    await currentReference!.update(usersUpdateData);
    update();
  }

  @override
  void onReady() async {
    displayName = FirebaseAuth.instance.currentUser!.displayName!;
    showOverlay(asyncFunction: initFriendsList);
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    inputiconleftController.dispose();
  }
}
