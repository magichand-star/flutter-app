import 'package:monarchium/backend/backend.dart';
import 'package:monarchium/backend/schema/models/search_item_model.dart';
import 'package:monarchium/core/app_export.dart';
import 'package:monarchium/core/utils/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/core/utils/rating_controller.dart';
import 'package:monarchium/core/utils/user_activity.dart';
import 'package:monarchium/domain/auth/auth_util.dart';

class AssociationsController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<SearchItemModel> searchItemList = [];

  UsersRecord? currentUser;

  // bool userInAssociation(int index) {
  //   if (currentUser?.association == null) return false;
  //   SearchItemModel model = searchItemList[index];
  //   DocumentReference? associationReference = model.reference;

  //   return currentUser?.association != associationReference;
  // }

  Future<void> init() async {
    await initAssociationsList();

    currentUser = await initCurrentUserDocument();
  }

  Future<void> initAssociationsList() async {
    searchItemList = await getSearchItemList(
      queryFunction: queryAssotiationsRecordOnce,
    );
    update();
  }

  Future<void> search() async {
    searchItemList = await searchInItems(
      queryFunction: queryAssotiationsRecordOnce,
      searchItemsList: searchItemList,
      text: searchController.text,
      initList: initAssociationsList,
    );
    update();
  }

  @override
  void onReady() {
    showOverlay(asyncFunction: init);
    super.onReady();
  }

  onButtonPressed(int index) {
    bool isInAssociation = searchItemList[index].isIn;
    associationStatusChange(index, isInAssociation);
    if (isInAssociation) {
      leaveAssociation(index);
    } else {
      joinAssociation(index);
    }
  }

  associationStatusChange(int index, bool isInAssociation) {
    searchItemList[index] =
        searchItemList[index].copyWith(isIn: !isInAssociation);
    update();
  }

  joinAssociation(int index) async {
    if (currentUser == null) return;

    associationStatusChange(index, false);
    SearchItemModel model = searchItemList[index];
    DocumentReference? associationReference = model.reference;

    Map<String, dynamic> usersUpdateData = {};

    usersUpdateData['associations'] = FieldValue.arrayUnion([
      model.reference,
    ]);

    associationReference.update(
      {
        'users': FieldValue.arrayUnion(
          [
            currentUserReference,
          ],
        )
      },
    );

    if (currentUserDocument!.joinedAssociation == null) {
      if (UserActivity.isFirstMonth) {
        showSnackbar('+10 к рейтингу! Так держать!');
        RatingController().updateRating(10);
        usersUpdateData['rating'] = FieldValue.increment(10);
      }
      if (UserActivity.isSecondMonth) {
        showSnackbar('+1 к рейтингу! Так держать!');
        RatingController().updateRating(1);
        usersUpdateData['rating'] = FieldValue.increment(1);
      }

      usersUpdateData['joined_association'] = true;
      maybeUpdateUser(
        currentUser!.reference,
        usersUpdateData,
      );
    }
  }

  leaveAssociation(int index) {
    if (currentUser == null) return;
    associationStatusChange(index, true);

    SearchItemModel model = searchItemList[index];
    DocumentReference? associationReference = model.reference;

    maybeUpdateUser(
      currentUser!.reference,
      {
        'associations': FieldValue.arrayRemove([associationReference]),
      },
    );
    associationReference.update({
      'users': FieldValue.arrayRemove(
        [
          currentUserReference,
        ],
      )
    });
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
