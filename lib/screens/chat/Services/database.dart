


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sehetak2/screens/chat/helperfunctions/shardpref_helper.dart';
import 'package:sehetak2/screens/dshbord-home/dashboard_home.dart';

class DatabaseMethods{

  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .snapshots();
  }
  Future addMessageRoom(String chatRoomId, String messageId, Map messageInfoMap ,uid,did,uname,dname,upic,dpic,utoken,dtoken) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .set({
      "userid-docid" : [uid,did],
      "username-docname" : [uname,dname],
      "userpic-docpic" : [upic,dpic],
      "usertoken-doctoken" : [utoken,dtoken],
    });
  }

  Future addMessage(String chatRoomId, String messageId, Map messageInfoMap,uid,did,uname,dname,upic,dpic,utoken,dtoken) async {
    await addMessageRoom(chatRoomId, messageId, messageInfoMap, uid, did,uname,dname,upic,dpic,utoken,dtoken);
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("userid-docid", arrayContains: Dashboard.uid)
        .get();

    if (snapShot.docs.length > 0) {
      print("====================================room found================================");
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUsername = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("userid-docid", arrayContains: Dashboard.uid)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }
}
