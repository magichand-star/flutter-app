import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  String receiverId;
  String senderId;
  String type;
  DateTime lastMessage;

  ChatData({
    required this.receiverId,
    required this.senderId,
    required this.type,
    required this.lastMessage,
  });

  // A named constructor for creating a new instance from a Map
  ChatData.fromMap(Map<String, dynamic> map)
      : receiverId = map['receiverId'],
        senderId = map['senderId'],
        type = map['type'],
        lastMessage = map['lastMessage'].toDate();

  // A named constructor for creating a new instance from a Firestore DocumentSnapshot
  ChatData.fromDocumentSnapshot(DocumentSnapshot documentSnapshot)
      : this.fromMap(documentSnapshot.data() as Map<String, dynamic>);

  // A method for converting this instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'type': type,
      'lastMessage': Timestamp.fromDate(lastMessage),
    };
  }
}
