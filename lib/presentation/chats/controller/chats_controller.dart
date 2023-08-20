import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../backend/firebase_storage/storage.dart';
import '../../../backend/schema/message.dart';
import '../../../backend/schema/users_record.dart';
import '../../../core/utils/custom_functions.dart';
import '../../../core/utils/rating_controller.dart';
import '../../../core/utils/user_activity.dart';

class ChatsController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String chatType = 'general';

  String? photoUrlLocal;

  File? photoFile;

  String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  ChatMessage? currentMessage;

  StreamSubscription<QuerySnapshot>?
      messageSubscription; // A subscription for the messages collection listener

  Stream<QuerySnapshot<Map<String, dynamic>>> get chatsStream =>
      _firebaseFirestore.collection('chats').snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> get requestsStream =>
      _firebaseFirestore.collection('friend_requests').snapshots();

  Future<List<UsersRecord>> getUsers(List<DocumentReference> users) async {
    List<UsersRecord> usersList = [];
    for (var user in users) {
      usersList.add(await getUser(user));
    }
    return usersList;
  }

  setCurrentChatType(String type) async {
    chatType = type;
    update();
  }

  bool isCurrentUser(String uid) {
    return uid == FirebaseAuth.instance.currentUser!.uid;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }

  Future<UsersRecord> getUser(DocumentReference ref) async {
    return await UsersRecord.getDocumentOnce(ref);
  }

  Future<void> openChat(String chatId, String receiverId) async {
    // When the chat is opened, start listening to the messages collection
    messageSubscription = _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('senderId', isEqualTo: receiverId)
        .where('isViewed', isEqualTo: false)
        .snapshots()
        .listen((snapshot) async {
      // Whenever a new message is added by the receiver, mark it as viewed
      if (snapshot.docs.isNotEmpty) {
        // Start a new batch
        var batch = _firebaseFirestore.batch();

        for (var doc in snapshot.docs) {
          // Instead of performing the update operation directly,
          // add it to the batch
          batch.update(doc.reference, {'isViewed': true});
        }

        // Commit the batch
        await batch.commit();
      }
    });
  }

  Future<void> deleteAllMessagesInChat(String chatId) async {
    // Get a QuerySnapshot of all messages in the chat
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .get();

    // Get a new WriteBatch
    WriteBatch batch = _firebaseFirestore.batch();

    // Add each message deletion to the WriteBatch
    querySnapshot.docs.forEach((doc) {
      batch.delete(doc.reference);
    });

    // Commit the WriteBatch
    return batch.commit();
  }

  Future<void> sendMessage(String chatId, ChatMessage chatMessage) async {
    var messageRef = _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();

    String messageId = messageRef.id; // get generated message id
    Message message = Message.fromChatMessage(chatMessage, messageId);
    await messageRef.set(message.toMap());

    var chatRef = _firebaseFirestore.collection('chats').doc(chatId);
    await chatRef.update(
      {
        'lastMessage': Timestamp.fromDate(
          DateTime.now(),
        ),
      },
    );
  }

  void closeChat() {
    // When the chat is closed, stop listening to the messages collection
    messageSubscription?.cancel();
    messageSubscription = null;
  }

  Stream<Message?> getLatestMessage(String chatId) {
    CollectionReference messagesRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages');
    Stream<QuerySnapshot> querySnapshot =
        messagesRef.orderBy('timestamp', descending: true).limit(1).snapshots();

    return querySnapshot.map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return Message.fromMap(
          snapshot.docs.first.data() as Map<String, dynamic>,
        );
      }
      return null;
    });
  }

  Stream<QuerySnapshot> getFriendRequests(String userId) {
    return _firebaseFirestore
        .collection('requests')
        .where('receiverId', isEqualTo: userId)
        .where('type', isEqualTo: 'friend')
        .snapshots();
  }

  setChatType(String chatId) async {
    await _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .update({'type': 'general'});
  }

  Future<void> acceptFriendRequest(String requestId, String chatId) async {
    await setChatType(chatId);

    await _firebaseFirestore.collection('requests').doc(requestId).update(
      {'status': 'accepted'},
    );
  }

  // addFriend(DocumentReference reference, int index, UsersRecord currentUser,
  //     UsersRecord secondUser) async {
  //   final usersUpdateData = {
  //     'friends': FieldValue.arrayUnion([reference]),
  //   };
  //   if (currentUser.friends != null &&
  //       !currentUser.friendsHistory!.contains(reference)) {
  //     if (UserActivity.isFirstMonth) {
  //       await RatingController().updateRating(5);
  //       showSnackbar('+5 к рейтингу! Так держать!');
  //       usersUpdateData.addAll(
  //         {
  //           'rating': FieldValue.increment(5),
  //         },
  //       );
  //     }

  //     if (UserActivity.isSecondMonth) {
  //       await RatingController().updateRating(1);
  //       showSnackbar('+1 к рейтингу! Так держать!');
  //       usersUpdateData.addAll(
  //         {
  //           'rating': FieldValue.increment(1),
  //         },
  //       );
  //     }
  //     usersUpdateData.addAll({
  //       'friends_history': FieldValue.arrayUnion(
  //         [
  //           reference,
  //         ],
  //       )
  //     });
  //   }

  //   showSnackbar('Вы добавили пользователя в друзья!');

  //   return usersUpdateData;
  //   // update();
  // }
  addFriend(
      UsersRecord currentUser, UsersRecord secondUser, String chatId) async {
    final UserActivity userActivity = UserActivity();

    Future<void> updateFriendRequestStatus(
        String requestId, String currentUserUid, String secondUserUid) async {
      final docSnapshot = await _firebaseFirestore
          .collection('friend_requests')
          .doc(requestId)
          .get();

      if (docSnapshot.exists) {
        // If the document exists, proceed as usual
        await docSnapshot.reference.update({'status': 'accepted'});
      } else {
        // If the document doesn't exist, search for a document where
        // the receiverId is the currentUser's uid and the senderId is the secondUser's uid
        final querySnapshot = await _firebaseFirestore
            .collection('friend_requests')
            .where('receiverId', isEqualTo: currentUserUid)
            .where('senderId', isEqualTo: secondUserUid)
            .get();

        if (!querySnapshot.docs.isEmpty) {
          // If such a document is found, update it
          await querySnapshot.docs.first.reference
              .update({'status': 'accepted'});
        } else {
          // Handle the case where no matching document is found
          print('No matching friend request found');
        }
      }
    }

    Map<String, dynamic> calculateRatingAndUpdateUserData(
        UsersRecord user, UsersRecord friend, int monthsSinceCreation) {
      int ratingIncrement = 0;

      if (user.friends != null &&
          !user.friendsHistory!.contains(friend.reference)) {
        if (monthsSinceCreation < 1) {
          ratingIncrement = 5;
        } else if (monthsSinceCreation >= 1 && monthsSinceCreation < 2) {
          ratingIncrement = 1;
        }
      }

      return {
        'ratingIncrement': ratingIncrement,
        'friends': FieldValue.arrayUnion([friend.reference]),
        'friends_history': FieldValue.arrayUnion([friend.reference])
      };
    }

    int currentUserMonths =
        userActivity.getMonthsSinceCreation(currentUser.createdTime!);
    int secondUserMonths =
        userActivity.getMonthsSinceCreation(secondUser.createdTime!);

    Map<String, dynamic> currentUserUpdateData =
        calculateRatingAndUpdateUserData(
            currentUser, secondUser, currentUserMonths);

    Map<String, dynamic> secondUserUpdateData =
        calculateRatingAndUpdateUserData(
            secondUser, currentUser, secondUserMonths);

    await RatingController()
        .updateRating(currentUserUpdateData['ratingIncrement'], currentUser);
    await RatingController()
        .updateRating(secondUserUpdateData['ratingIncrement'], secondUser);

    if (currentUserUpdateData['ratingIncrement'] > 0) {
      showSnackbar(
          '+${currentUserUpdateData['ratingIncrement']} к рейтингу! Так держать!');
    }

    showSnackbar('Вы добавили пользователя в друзья!');

    String requestId = secondUser.uid! + currentUser.uid!;
    await updateFriendRequestStatus(
        requestId, currentUser.uid!, secondUser.uid!);

    await setChatType(chatId);
    update();
    // You can return both updated data or apply changes here
    return {
      'currentUser': currentUserUpdateData,
      'secondUser': secondUserUpdateData,
    };
  }

  Future<void> rejectFriendRequest(String requestId, String chatId) async {
    await setChatType(chatId);
    await _firebaseFirestore
        .collection('requests')
        .doc(requestId)
        .update({'status': 'rejected'});
  }

  pickImage({required String chatId, required ChatUser currentUser}) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      photoUrlLocal = image.path;
      photoFile = File(image.path);
      update();
    }

    if (FirebaseAuth.instance.currentUser != null) {
      String? photoUrl = await uploadDataFromFile(
        'media/${FirebaseAuth.instance.currentUser!.uid}/sent/${photoFile!.path.split('/').last}',
        photoFile!,
      );

      if (photoUrl != null && photoUrl.isNotEmpty) {
        currentMessage = ChatMessage(
          text: '',
          user: currentUser,
          medias: [
            ChatMedia(
              url: photoUrl,
              fileName: photoFile!.path.split('/').last,
              type: MediaType.image,
            ),
          ],
          createdAt: DateTime.now(),
        );
      }
    }
    update();
  }

  removeMedia() {
    photoUrlLocal = null;
    photoFile = null;
    currentMessage = null;
    update();
  }

  Stream<List<Message>> getMessagesStream(String chatId) {
    return _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (doc) => Message.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> deleteMessage(String chatId, String messageId) async {
    await _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  getChatMessages(List<Message> messages) {
    return messages
        .map(
          (message) => message.toChatMessage(
            ChatUser(
              id: message.senderId,
            ),
          ),
        )
        .toList()
        .reversed
        .toList();
  }

  Future<String> createChat(String senderId, String receiverId,
      [String? type]) async {
    final chatRef = _firebaseFirestore.collection('chats').doc();
    await chatRef.set(
      {
        'senderId': senderId,
        'receiverId': receiverId,
        'type': type ?? 'general',
      },
    );

    // await chatRef.collection('messages').
    [senderId, receiverId].forEach((id) {
      _firebaseFirestore.collection('users').doc(id).update(
        {
          'chats': FieldValue.arrayUnion(
            [chatRef],
          ),
        },
      );
    });
    return chatRef.id;
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    closeChat();
    super.onClose();
  }
}
