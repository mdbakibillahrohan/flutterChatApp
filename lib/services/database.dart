import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_string/random_string.dart';

class DatabaseMethods {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  Functions fn = Functions();

  Future addUserInfoToDB(String userId, Map<String, dynamic> usersInfo) async {
    return await fb.collection("Users").doc(userId).set(usersInfo);
  }

  Future addUserInfoToDB_Email(Map<String, dynamic> userDetails) async {
    var db = await fb.collection("Users").add(userDetails);
    return db;
  }

  Future searchByUserName(String userName) async {
    QuerySnapshot qn = await fb
        .collection("Users")
        .where("username", isEqualTo: userName)
        .get();
    return qn.docs;
  }

  Future createChatRoom(
      {String myUserName,
      String sendUserName,
      String chatRoomId,
      Map<String, dynamic> chatRoomInfoMap}) async {
    final username1 = await fb
        .collection("chatrooms")
        .where("user1", isEqualTo: myUserName)
        .get();
    final username2 = await fb
        .collection("chatrooms")
        .where("user2", isEqualTo: sendUserName)
        .get();
    if (username1.docs.isEmpty) {
      debugPrint("It's working1");
      var username3 = await fb
          .collection("chatrooms")
          .where("user2", isEqualTo: myUserName)
          .get();
      if (username3.docs.isEmpty) {
        debugPrint("it's Woking2");
        var username4 = await fb
            .collection("chatrooms")
            .where("user1", isEqualTo: sendUserName)
            .get();
        if (username4.docs.isEmpty) {
          debugPrint("it' returning true");
          return await fb
              .collection("chatrooms")
              .doc(chatRoomId)
              .set(chatRoomInfoMap);
        } else {
          debugPrint("it's Working3");
          return true;
        }
      }
    } else {
      if (username2.docs.isEmpty) {
        return await fb
            .collection("chatrooms")
            .doc(chatRoomId)
            .set(chatRoomInfoMap);
      } else {
        return true;
      }
    }

    // if(username1!=null && username2!=null){
    //   return true;
    // }else{
    //   return fb.collection("chatrooms").add(chatRoomInfoMap);
    // }
    // if(chatroom.exists){
    //   return  await true;
    // }
    // else{
    //   return await fb.collection("chatrooms").doc(chatRoomId).set(chatRoomInfoMap);
    // }
  }

  Future sendMessage(
      {String myUserName,
      String senduserName,
      String chatRoomId,
      String messageText,
      var time,
      Map<String, dynamic> messageInfo}) async {
    String messageId = randomAlphaNumeric(12);
    final masterChatroom = await fb.collection("chatrooms");
    debugPrint("mesage is Adding");
    await fb
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("messages")
        .doc(messageId)
        .set(messageInfo);
    return await masterChatroom.doc(chatRoomId).update({
      "lastMessage": messageText,
      "lastMessageTs": time,
      "sendBy": myUserName
    });
  }

  Future<Stream<QuerySnapshot>> fetchMessage(String chatRoomId) async {
    return await fb
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> fetchrecentChats(String myUsername) async {
    debugPrint("Recent Chats is Working");
    return await fb
        .collection("chatrooms")
        .orderBy("lastMessageTs", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }

  Future getProfileInfo(String chatRoomId, String myUserName) async {
    QuerySnapshot qn = await fb
        .collection("Users")
        .where("username",
            isEqualTo:
                chatRoomId.replaceAll(myUserName, "").replaceAll("_", ""))
        .get();
    return qn.docs[0];
  }

  Future getPeople() async {
    QuerySnapshot qn = await fb.collection("Users").get();
    return qn.docs;
  }

  Future<Stream<QuerySnapshot>> friendsList() async {
    String myUserName = await SharedPreferenceHelper().getUserName();
    return await fb
        .collection("chatrooms")
        .where("users", arrayContains: myUserName)
        .snapshots();
  }

  Future namebyUserName(userName)async{
    QuerySnapshot qn = await fb.collection("Users").where("username", isEqualTo: userName).get();
    var data = qn.docs[0];
    return await data["name"];
  }
}
