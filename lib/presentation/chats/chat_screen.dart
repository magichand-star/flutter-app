import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../backend/backend.dart';
import '../../backend/schema/message.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/chats_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.secondUserRecord,
    required this.currentUserRecord,
    required this.chatId,
    // required this.type,
  });

  final UsersRecord secondUserRecord;
  final UsersRecord currentUserRecord;
  final String chatId;
  // final String type;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatsController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConstant.deepOrange50,
          appBar: CustomAppBar(
            height: getVerticalSize(62.00),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      getHorizontalSize(150),
                      getVerticalSize(70),
                      getHorizontalSize(150),
                      getVerticalSize(150),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: ColorConstant.brown10,
                    items: [
                      PopupMenuItem(
                        child: Text(
                          'Очистить историю',
                          style: TextStyle(
                            fontFamily: 'Cormorant',
                            fontSize: getFontSize(20),
                            color: ColorConstant.brown80,
                          ),
                        ),
                        onTap: () {
                          Future.delayed(Duration(milliseconds: 100), () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Очистить историю чата'),
                                  content: Text(
                                      'Вы действительно хотите очистить историю этого чата?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Нет'),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Да'),
                                      onPressed: () async {
                                        Get.back();
                                        await controller
                                            .deleteAllMessagesInChat(chatId);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                        },
                      ),
                    ],
                  );
                },
                color: ColorConstant.brown80,
                icon: Icon(
                  Icons.more_vert,
                ),
              ),
            ],
            title: Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: getHorizontalSize(15),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: secondUserRecord.photoUrl!,
                      height: getHorizontalSize(50),
                      width: getHorizontalSize(50),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(
                    width: getHorizontalSize(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getHorizontalSize(215),
                        child: Text(
                          secondUserRecord.displayName ??
                              '${secondUserRecord.firstName} ${secondUserRecord.lastName}',
                          style: TextStyle(
                            fontFamily: 'Cormorant',
                            fontSize: getFontSize(25),
                            color: ColorConstant.brown80,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller.getUserStream(secondUserRecord.uid!),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          UsersRecord user = UsersRecord.getDocumentFromData(
                            snapshot.requireData.data()!,
                            snapshot.requireData.reference,
                          );

                          DateTime? lastSeen = user.lastEntered;
                          bool? isOnline = user.isOnline;

                          String? lastSeenString;
                          if (lastSeen != null) {
                            DateTime now = DateTime.now();
                            if (lastSeen.year == now.year &&
                                lastSeen.month == now.month &&
                                lastSeen.day == now.day) {
                              lastSeenString =
                                  DateFormat('в HH:mm').format(lastSeen);
                            } else {
                              lastSeenString =
                                  DateFormat('dd.MM в HH:mm').format(lastSeen);
                            }
                          }

                          String statusText;
                          if (isOnline == true) {
                            statusText = "В сети";
                          } else {
                            statusText =
                                "Был в сети ${lastSeenString != null ? lastSeenString : 'недавно'}";
                          }

                          return Text(
                            statusText,
                            style: TextStyle(
                              fontFamily: 'Cormorant',
                              fontWeight: FontWeight.normal,
                              fontSize: getFontSize(18),
                              color: ColorConstant.brown70,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
              onTap: () => Get.back(),
            ),
          ),
          body: StreamBuilder<List<Message>>(
            stream: controller.getMessagesStream(chatId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Message> messages = snapshot.requireData;
              List<ChatMessage> chatMessage =
                  controller.getChatMessages(messages);
              ChatUser currentUser = ChatUser(
                id: controller.currentUserUid.toString(),
                firstName: currentUserRecord.firstName,
                lastName: currentUserRecord.lastName,
                profileImage: currentUserRecord.photoUrl,
              );

              return DashChat(
                scrollToBottomOptions: ScrollToBottomOptions(
                  scrollToBottomBuilder: (scrollController) {
                    bool mediaExists =
                        controller.currentMessage?.medias != null &&
                            controller.currentMessage!.medias!.isNotEmpty;
                    double scrollToBottom = 0;
                    if (controller.chatType == 'friend_request' &&
                        mediaExists) {
                      scrollToBottom = 230;
                    } else if (controller.chatType == 'friend_request' &&
                        !mediaExists) {
                      scrollToBottom = 150;
                    } else if (controller.chatType != 'friend_request' &&
                        mediaExists) {
                      scrollToBottom = 150;
                    } else if (controller.chatType != 'friend_request' &&
                        !mediaExists) {
                      scrollToBottom = 70;
                    }
                    return Positioned(
                      bottom: getVerticalSize(scrollToBottom),
                      right: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FloatingActionButton(
                          child: Center(
                            child: Icon(
                              Icons.arrow_downward_rounded,
                              color: ColorConstant.brown80,
                            ),
                          ),
                          backgroundColor: ColorConstant.deepOrange50,
                          onPressed: () {
                            scrollController.animateTo(
                              0.0,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          elevation: 0,
                        ),
                      ),
                    );
                  },
                ),
                messageOptions: MessageOptions(
                  showOtherUsersAvatar: false,
                  showOtherUsersName: false,
                  showTime: true,
                  containerColor: ColorConstant.brown10,
                  currentUserContainerColor: ColorConstant.brown80,
                  messageTextBuilder: (message, previousMessage, nextMessage) {
                    message.user.id == secondUserRecord.uid.toString();
                    bool isCurrentUser =
                        controller.isCurrentUser(message.user.id);
                    return Text(
                      message.text,
                      style: TextStyle(
                        fontFamily: 'Cormorant',
                        fontSize: getFontSize(20),
                        color: !isCurrentUser
                            ? ColorConstant.deepOrange50
                            : ColorConstant.brown80,
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  },
                  messageRowBuilder: (chatMessage, previousMessage, nextMessage,
                      isAfterDateSeparator, isBeforeDateSeparator) {
                    GlobalKey _messageGestureDetectorKey = GlobalKey();
                    GlobalKey _messageBubbleKey = GlobalKey();
                    bool isCurrentUser =
                        chatMessage.user.id == controller.currentUserUid;

                    return GestureDetector(
                      key: _messageGestureDetectorKey,
                      onLongPress: () {
                        // debugger();
                        String? messageId = messages
                            .firstWhere((message) =>
                                message.messageText == chatMessage.text &&
                                message.senderId == chatMessage.user.id &&
                                message.timestamp.microsecondsSinceEpoch ==
                                    chatMessage
                                        .createdAt.microsecondsSinceEpoch)
                            .id;

                        final RenderBox overlay = Overlay.of(context)
                            .context
                            .findRenderObject() as RenderBox;
                        final RenderBox box = _messageGestureDetectorKey
                            .currentContext!
                            .findRenderObject() as RenderBox;
                        final Offset position =
                            box.localToGlobal(Offset.zero, ancestor: overlay);

                        var messageBubbleWidth =
                            _messageBubbleKey.currentContext!.size!.width;

                        showMenu(
                          context: context,
                          position: isCurrentUser
                              ? RelativeRect.fromLTRB(
                                  position.dx + messageBubbleWidth * .2,
                                  position.dy,
                                  position.dx,
                                  position.dy + box.size.height,
                                )
                              : RelativeRect.fromLTRB(
                                  position.dx,
                                  position.dy,
                                  position.dx + messageBubbleWidth * .2,
                                  position.dy + box.size.height,
                                ),
                          items: [
                            PopupMenuItem(
                              child: Text("Удалить сообщение"),
                              value: "delete",
                              onTap: () async {
                                Future.delayed(Duration(milliseconds: 100), () {
                                  // Then after 100ms delay, show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Удалить сообщение?'),
                                        content: Text(
                                            'Вы действительно хотите удалить это сообщение?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Отмена'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Удалить'),
                                            onPressed: () {
                                              controller.deleteMessage(
                                                chatId,
                                                messageId!,
                                              );
                                              Get.back();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        );
                      },
                      child: MessageBubble(
                        message: chatMessage,
                        key: _messageBubbleKey,
                        isCurrentUser: isCurrentUser,
                        // other parameters
                      ),
                    );
                  },
                ),
                messageListOptions: MessageListOptions(
                  chatFooterBuilder: Column(
                    children: [
                      if (controller.chatType == 'friend_request' &&
                          !controller.isCurrentUser(messages.first.senderId))
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: getVerticalSize(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: getHorizontalSize(context.width * .8),
                                child: Text(
                                  "${secondUserRecord.name} хочет добавить вас в друзья",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poiret One',
                                    fontSize: getFontSize(20),
                                    fontWeight: FontWeight.normal,
                                    color: ColorConstant.brown80,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                height: getVerticalSize(20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await controller.addFriend(
                                        currentUserRecord,
                                        secondUserRecord,
                                        chatId,
                                      );
                                      // await controller.acceptFriendRequest(
                                      //   chatId,
                                      //   receiver.uid!,
                                      //   sender.uid!,
                                      // );
                                    },
                                    child: Text(
                                      'Принять',
                                      style: TextStyle(
                                        fontFamily: 'Cormorant',
                                        fontSize: getFontSize(20),
                                        fontWeight: FontWeight.normal,
                                        color: ColorConstant.whiteA700,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorConstant.lime800,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getHorizontalSize(35),
                                        vertical: getVerticalSize(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getHorizontalSize(20),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // await controller.declineFriendRequest(
                                      //   chatId,
                                      //   receiver.uid!,
                                      //   sender.uid!,
                                      // );
                                    },
                                    child: Text(
                                      'Отклонить',
                                      style: TextStyle(
                                        fontFamily: 'Cormorant',
                                        fontSize: getFontSize(20),
                                        fontWeight: FontWeight.normal,
                                        color: ColorConstant.brown80,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 253, 234, 213),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: ColorConstant.brown80,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getHorizontalSize(35),
                                        vertical: getVerticalSize(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (controller.currentMessage?.medias != null &&
                          controller.currentMessage!.medias!.isNotEmpty)
                        SizedBox(
                          height: getVerticalSize(80),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(
                              getVerticalSize(10),
                            ),
                            title: Text(
                              controller.currentMessage!.medias!.first.type ==
                                      MediaType.image
                                  ? 'Выбранное изображение'
                                  : 'Выбранное видео',
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                controller.removeMedia();
                              },
                              icon: Icon(
                                Icons.close,
                                color: ColorConstant.brown80,
                              ),
                            ),
                            tileColor: ColorConstant.brown10,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                controller.currentMessage!.medias!.first.url,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  dateSeparatorBuilder: (date) => Container(
                    constraints: BoxConstraints(
                      maxWidth: getHorizontalSize(140),
                      minWidth: getHorizontalSize(100),
                      maxHeight: getVerticalSize(40),
                      minHeight: getVerticalSize(40),
                    ),
                    margin: EdgeInsets.symmetric(vertical: getVerticalSize(20)),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: ColorConstant.brown10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        DateFormat('d MMMM', 'RU').format(date),
                        style: TextStyle(
                          fontFamily: 'Cormorant',
                          fontSize: getFontSize(25),
                          fontWeight: FontWeight.normal,
                          color: ColorConstant.brown70,
                        ),
                      ),
                    ),
                  ),
                ),
                inputOptions: InputOptions(
                  textCapitalization: TextCapitalization.sentences,
                  inputDecoration: _buildDecoration(),
                  alwaysShowSend: true,
                  sendButtonBuilder: (send) {
                    return IconButton(
                      onPressed: send,
                      color: ColorConstant.brown40,
                      icon: Icon(Icons.arrow_outward_outlined),
                    );
                  },
                  leading: [
                    IconButton(
                      onPressed: () {
                        controller.pickImage(
                          chatId: chatId,
                          currentUser: currentUser,
                        );
                      },
                      color: ColorConstant.lime800,
                      icon: Transform.rotate(
                        child: Icon(Icons.attach_file),
                        angle: pi / 4,
                      ),
                    ),
                  ],
                ),
                currentUser: currentUser,
                onSend: (chatMessage) async {
                  if (controller.currentMessage != null) {
                    await controller.sendMessage(
                      chatId,
                      controller.currentMessage!,
                      // messageId!,
                    );
                    controller.currentMessage = null;
                  } else {
                    await controller.sendMessage(
                      chatId,
                      chatMessage,
                      // messageId!,
                    );
                  }
                },
                messages: chatMessage,
              );
            },
          ),
        );
      },
    );
  }

  _buildDecoration() {
    return InputDecoration(
      filled: true,
      hintText: "Текст...",
      hintStyle: _setFontStyle(isHint: true),
      border: _setBorderStyle(),
      counterText: '',
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      fillColor: _setFillColor(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  TextStyle _setFontStyle({required bool isHint}) {
    return TextStyle(
      color: isHint ? ColorConstant.orange200 : ColorConstant.orangeSolid,
      fontSize: getFontSize(
        20,
      ),
      fontFamily: 'Cormorant',
      fontWeight: FontWeight.w400,
    );
  }

  _setOutlineBorderRadius() {
    return BorderRadius.circular(
      getHorizontalSize(
        12.00,
      ),
    );
  }

  _setBorderStyle() {
    return OutlineInputBorder(
      borderRadius: _setOutlineBorderRadius(),
      borderSide: BorderSide.none,
    );
  }

  _setFillColor() {
    return ColorConstant.whiteA700;
  }

  _setPadding() {
    return getPadding(
      all: 10,
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isCurrentUser;

  MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    var timeTextStyle = TextStyle(
      fontFamily: 'Cormorant',
      fontSize: getFontSize(14),
      color: ColorConstant.brown60,
      fontWeight: FontWeight.normal,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isCurrentUser)
          SizedBox(
            width: getHorizontalSize(12),
          ),
        if (isCurrentUser) ...[
          Text(
            DateFormat('HH:mm').format(message.createdAt),
            style: timeTextStyle,
          ),
          SizedBox(
            width: getHorizontalSize(10),
          ),
          Icon(
            message.status == MessageStatus.read ? Icons.done_all : Icons.done,
            color: ColorConstant.brown60,
            size: getHorizontalSize(20),
          ),
        ],
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(
            bottom: 10.0,
            left: isCurrentUser ? 10.0 : 0.0,
            right: isCurrentUser ? 0.0 : 10.0,
          ),
          decoration: BoxDecoration(
            color:
                isCurrentUser ? ColorConstant.brown80 : ColorConstant.brown10,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomLeft:
                  isCurrentUser ? Radius.circular(15.0) : Radius.circular(0.0),
              bottomRight:
                  isCurrentUser ? Radius.circular(0.0) : Radius.circular(15.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.medias != null && message.medias!.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    showImageViewer(
                      context,
                      swipeDismissible: true,
                      doubleTapZoomable: true,
                      NetworkImage(
                        message.medias!.first.url,
                      ),
                      onViewerDismissed: () {
                        print("dismissed");
                      },
                    );
                  },
                  child: Container(
                    width: getHorizontalSize(200),
                    height: getVerticalSize(200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        message.medias!.first.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (message.text.isNotEmpty)
                Text(
                  message.text,
                  style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: getFontSize(20),
                    color: isCurrentUser
                        ? ColorConstant.deepOrange50
                        : ColorConstant.brown80,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ],
          ),
        ),
        if (isCurrentUser)
          SizedBox(
            width: getHorizontalSize(12),
          ),
        if (!isCurrentUser) ...[
          Text(
            DateFormat('HH:mm').format(message.createdAt),
            style: timeTextStyle,
          ),
        ],
      ],
    );
  }
}
