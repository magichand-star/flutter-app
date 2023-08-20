import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../backend/backend.dart';
import '../../backend/schema/message.dart';
import '../../backend/schema/models/chat_data.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_search_view.dart';
import 'chat_screen.dart';
import 'controller/chats_controller.dart';

class ChatsScreen extends GetWidget<ChatsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.deepOrange50,
      appBar: CustomAppBar(
        height: getVerticalSize(
          62.00,
        ),
        centerTitle: true,
        title: AppbarTitle(text: 'Уведомления и чаты'),
        leadingWidth: 40,
        leading: AppbarImage(
          height: getSize(40.00),
          width: getSize(40.00),
          margin: getMargin(
            left: 15,
            top: 14,
            bottom: 18,
          ),
          svgPath: ImageConstant.imgArrowleftGray900,
          onTap: () => Get.back(id: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CustomSearchView(
              width: 345,
              focusNode: FocusNode(),
              controller: controller.searchController,
              hintText: "lbl33".tr,
              margin: getMargin(
                left: 15,
                top: 10,
                right: 15,
              ),
              prefix: Container(
                margin: getMargin(
                  left: 20,
                  top: 12,
                  right: 10,
                  bottom: 13,
                ),
                child: CommonImageView(
                  svgPath: ImageConstant.imgSearchOrange200,
                ),
              ),
              prefixConstraints: BoxConstraints(
                minWidth: getSize(
                  25.00,
                ),
                minHeight: getSize(
                  25.00,
                ),
              ),
              onTap: () {},
            ),
            Padding(
              padding: getPadding(left: 15, top: 15, right: 15),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.chatsStream,
                builder: (context, snapshot) {
                  // debugger();
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Возникла какая-то ошибка...'),
                    );
                  } else if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>>
                        chatsQuery = snapshot.requireData.docs;
                    List<ChatData> chatDataList = [];

                    for (var chat in chatsQuery) {
                      ChatData chatData = ChatData.fromMap(chat.data());
                      chatDataList.add(chatData);
                    }

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: chatDataList.length,
                      itemBuilder: (context, index) {
                        ChatData chatData = chatDataList[index];
                        String chatId = chatsQuery[index].id;

                        DocumentReference receiverRef =
                            UsersRecord.collection.doc(chatData.receiverId);
                        DocumentReference senderRef =
                            UsersRecord.collection.doc(chatData.senderId);

                        return FutureBuilder<List<UsersRecord>>(
                          future: controller.getUsers([receiverRef, senderRef]),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            // debugger();
                            List<UsersRecord> users = snapshot.data!;
                            UsersRecord receiverRecord = users[0],
                                senderRecord = users[1];
                            bool isVisible = true;

                            String? uid =
                                FirebaseAuth.instance.currentUser?.uid;
                            isVisible = uid == receiverRecord.reference.id ||
                                uid == senderRecord.reference.id;

                            if (isVisible)
                              return InkWell(
                                onTap: () async {
                                  final ChatsController chatsController =
                                      Get.find<ChatsController>();
                                  await chatsController.openChat(
                                    chatId,
                                    chatsController
                                            .isCurrentUser(senderRecord.uid!)
                                        ? receiverRecord.uid!
                                        : senderRecord.uid!,
                                  );
                                  controller.setCurrentChatType(chatData.type);
                                  Get.to(
                                    () => ChatScreen(
                                      secondUserRecord: chatsController
                                              .isCurrentUser(senderRecord.uid!)
                                          ? receiverRecord
                                          : senderRecord,
                                      currentUserRecord: chatsController
                                              .isCurrentUser(senderRecord.uid!)
                                          ? senderRecord
                                          : receiverRecord,
                                      chatId: chatId,
                                      // type: chatData.type,
                                    ),
                                  );
                                },
                                child: StreamBuilder<Message?>(
                                  stream: controller.getLatestMessage(
                                    chatId,
                                  ),
                                  builder: (context, snapshot) {
                                    // if (chatData.type == 'friend_request')
                                    //   return Text('Friend Request');
                                    if (snapshot.hasData) {
                                      Message? latestMessage =
                                          snapshot.requireData;

                                      return ChatItem(
                                        receiver: receiverRecord,
                                        message: latestMessage!,
                                        sent: controller.isCurrentUser(
                                                senderRecord.reference.id)
                                            ? true
                                            : false,
                                      );
                                    } else
                                      return Container();
                                  },
                                ),
                              );

                            return Container();
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.receiver,
    required this.message,
    required this.sent,
  });

  final bool sent;
  final UsersRecord receiver;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * .1,
      child: Row(
        children: [
          CommonImageView(
            imagePath: ImageConstant.imgImage26,
            url: receiver.photoUrl,
            height: getHorizontalSize(
              52.00,
            ),
            width: getHorizontalSize(
              52.00,
            ),
            borderRadius: BorderRadius.circular(
              getHorizontalSize(50),
            ),
          ),
          Padding(
            padding: getPadding(
              left: 1,
              top: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: getHorizontalSize(
                    267.00,
                  ),
                  margin: getMargin(
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: getPadding(
                          bottom: 1,
                        ),
                        child: Text(
                          receiver.displayName ??
                              "${receiver.firstName} ${receiver.lastName}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtCormorantRomanRegular20,
                        ),
                      ),
                      Spacer(),
                      if (sent)
                        Icon(
                          message.isViewed == true
                              ? Icons.done_all
                              : Icons.done,
                          color: ColorConstant.brown40,
                          size: getFontSize(16),
                        ),
                      SizedBox(
                        width: getHorizontalSize(5),
                      ),
                      Text(
                        DateFormat("HH:mm a").format(
                          DateTime.fromMicrosecondsSinceEpoch(
                            message.timestamp.microsecondsSinceEpoch,
                          ),
                        ),
                        style: AppStyle.txtCormorantRomanRegular20.copyWith(
                          color: ColorConstant.brown60,
                          fontSize: getFontSize(16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: getHorizontalSize(280),
                  margin: getMargin(
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (message.medias != null && message.medias!.isNotEmpty)
                        Icon(
                          Icons.image,
                          size: getSize(25),
                          color: ColorConstant.brown40,
                        ),
                      if (message.medias != null &&
                          message.medias!.isNotEmpty &&
                          message.messageText.isEmpty) ...[
                        SizedBox(
                          width: getHorizontalSize(5),
                        ),
                        Text(
                          "Photo",
                          style: AppStyle.txtCormorantRomanMedium24.copyWith(
                            color: ColorConstant.brown60,
                            fontSize: 16,
                          ),
                        ),
                      ],
                      Text(
                        message.messageText,
                        style: AppStyle.txtCormorantRomanMedium24.copyWith(
                          color: ColorConstant.brown60,
                          fontSize: 16,
                        ),
                      ),
                      if (!sent) ...[
                        Spacer(),
                        Container(
                          height: getVerticalSize(
                            20.00,
                          ),
                          width: getHorizontalSize(
                            20.00,
                          ),
                          margin: getMargin(
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.brown10,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(50),
                            ),
                          ),
                          child: Center(
                              // child: Text(
                              //   '2',
                              //   style:
                              //       AppStyle.txtCormorantRomanRegular20.copyWith(
                              //     color: ColorConstant.brown40,
                              //     fontSize: 12,
                              //   ),
                              // ),
                              ),
                        ),
                      ]
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: getVerticalSize(
                      1.00,
                    ),
                    width: getHorizontalSize(
                      280.00,
                    ),
                    margin: getMargin(
                      top: 15,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.lime900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
