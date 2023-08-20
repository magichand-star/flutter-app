import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monarchium/presentation/chats/controller/chats_controller.dart';

import '../../../backend/backend.dart';
import '../../../backend/schema/models/search_item_model.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/custom_functions.dart';
import '../../../core/utils/rating_controller.dart';
import '../../../core/utils/user_activity.dart';
import '../../../domain/auth/auth_util.dart';

class FriendSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<SearchItemModel> searchItemList = [];

  List<SearchItemModel> associationUsersList = [];

  late bool fromAssociation, fromGeneralArmses;

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FocusNode searchFocusNode = FocusNode();

  onButtonPressed(int index) async {
    if (fromAssociation) {
      SearchItemModel chosenUser = searchItemList[index];
      if (associationUsersList.contains(chosenUser)) {
        removeFromAssociation(chosenUser);
      } else {
        addToAssociation(chosenUser);
      }
    } else {
      await addFriendToUsersList(index);
    }
  }

  addToAssociation(SearchItemModel model) {
    associationUsersList.add(model);
    update();
  }

  Future<void> sendFriendRequest(String senderId, String receiverId) async {
    await Get.put(ChatsController());
    final chatsController = Get.find<ChatsController>();
    String chatRefId = await chatsController.createChat(
        senderId, receiverId, 'friend_request');
    chatsController.sendMessage(
      chatRefId,
      ChatMessage(
        user: ChatUser(id: senderId),
        createdAt: DateTime.now(),
        text: 'Привет! Давай дружить?',
      ),
    );

    String docId = senderId + receiverId;

    await _firebaseFirestore.collection('friend_requests').doc(docId).set(
      {
        'senderId': senderId,
        'receiverId': receiverId,
        'type': 'friend',
        'status': 'pending',
      },
    );
  }

  removeFromAssociation(SearchItemModel model) {
    associationUsersList.remove(model);
    update();
  }

  onAssociationButtonTapped() {
    return Get.back(
      result: associationUsersList
          .map(
            (item) => item.reference,
          )
          .toList(),
    );
  }

  addFriendToUsersList(int index) async {
    SearchItemModel model = searchItemList[index];
    bool isFriend = model.isIn;
    Map<String, FieldValue>? usersUpdateData;
    friendStatusChange(index, isFriend);
    if (isFriend) {
      usersUpdateData = await removeFriend(model.reference, isFriend, index);
    } else {
      // usersUpdateData = await addFriend(model.reference, isFriend, index);
      await sendFriendRequest(
        FirebaseAuth.instance.currentUser!.uid,
        model.reference.id,
      );
    }
    if (usersUpdateData != null) await updateUserData(usersUpdateData);
  }

  friendStatusChange(int index, bool isFriend) {
    searchItemList[index] = searchItemList[index].copyWith(isIn: !isFriend);
    update();
  }

  updateUserData(Map<String, FieldValue> usersUpdateData) async {
    // debugger();
    DocumentReference<Object?>? currentReference =
        currentUserDocument?.reference;
    await currentReference!.update(usersUpdateData);
    update();
  }

  addFriend(DocumentReference reference, bool isFriend, int index) async {
    final currentUser = await initCurrentUserDocument();
    final usersUpdateData = {
      'friends': FieldValue.arrayUnion([reference]),
    };
    if (currentUser?.friends != null &&
        !currentUser!.friendsHistory!.contains(reference)) {
      if (UserActivity.isFirstMonth) {
        await RatingController().updateRating(5);
        showSnackbar('+5 к рейтингу! Так держать!');
        usersUpdateData.addAll(
          {
            'rating': FieldValue.increment(5),
          },
        );
      }

      if (UserActivity.isSecondMonth) {
        await RatingController().updateRating(1);
        showSnackbar('+1 к рейтингу! Так держать!');
        usersUpdateData.addAll(
          {
            'rating': FieldValue.increment(1),
          },
        );
      }
      usersUpdateData.addAll({
        'friends_history': FieldValue.arrayUnion(
          [
            reference,
          ],
        )
      });
    }

    showSnackbar('Вы добавили пользователя в друзья!');

    return usersUpdateData;
    // update();
  }

  removeFriend(DocumentReference reference, bool isFriend, int index) async {
    final usersUpdateData = {
      'friends': FieldValue.arrayRemove([reference]),
    };

    showSnackbar('Вы удалил пользователя из друзей!');
    return usersUpdateData;
  }

  Future<void> init() async {
    if (Get.arguments != null && Get.arguments[0]?['from'] != null) {
      fromAssociation = await Get.arguments?[0]['from'] == 'createAssociation';
      fromGeneralArmses = await Get.arguments?[0]['from'] == 'generalArmses';
    } else {
      fromAssociation = false;
      fromGeneralArmses = false;
    }
    // printInfo(info: fromAssociation.toString());
    await initUsersList();
  }

  Future<void> initUsersList() async {
    searchItemList = await getSearchItemList(
      queryFunction: queryUsersRecordOnce,
    );
    update();
  }

  Future<void> search() async {
    searchItemList = await searchInItems(
      queryFunction: queryUsersRecordOnce,
      searchItemsList: searchItemList,
      text: searchController.text,
      initList: initUsersList,
    );
    update();
  }

  @override
  void onReady() async {
    await showOverlay(asyncFunction: init);
    if (fromGeneralArmses) searchFocusNode.requestFocus();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
