import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:chat_app/widgets/user_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class RecentChats extends StatelessWidget {
//   Functions fn = Functions();
//   Stream chatsData;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
//
class RecentChats extends StatefulWidget {
  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  Functions fn = Functions();
  Stream chatsData;
  String myUserName = "";
  var indevidualPersonInfo;

  onLaunch() async {
    myUserName = await SharedPreferenceHelper().getUserName();
    chatsData = await DatabaseMethods().fetchrecentChats(myUserName);
    setState(() {

    });
  }

  getUserInfofromDB(String chatRoomId, String myUserName) async {
    indevidualPersonInfo =
        await DatabaseMethods().getProfileInfo(chatRoomId, myUserName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: StreamBuilder(
            stream: chatsData,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot?.data?.docs?.length ?? 0,
                      itemBuilder: (context, index) {
                        var chatsdata = snapshot.data.docs[index];
                        String chatRoomId = chatsdata.id;
                        DateTime time = chatsdata["lastMessageTs"].toDate();
                        getUserInfofromDB(chatRoomId, myUserName);
                        return GestureDetector(
                          onTap: () {
                            fn.pushNavigator(
                                context,
                                ChatScreen(
                                  userName: chatRoomId
                                      .replaceAll(myUserName, "")
                                      .replaceAll("_", ""),
                                  myUserName: myUserName,
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 8),
                            child: UserTile(
                              time: time,
                              chatRoom: chatRoomId,
                              chatsdata: chatsdata,
                              myUserName: myUserName,
                              forChat: true,
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),
                    );
            }),
      ),
    );
  }
}


