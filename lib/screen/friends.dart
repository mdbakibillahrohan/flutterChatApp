import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:chat_app/widgets/user_tile.dart';
import 'package:flutter/material.dart';


class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  Functions fn = Functions();
  Stream friendList;
  String myUserName = "";
  var indevidualPersonInfo;

  onLaunch()async{
    friendList = await DatabaseMethods().friendsList();
    myUserName = await SharedPreferenceHelper().getUserName();
    setState(() {

    });
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
          stream: friendList,
          builder: (context, snapshot){
            return snapshot.hasData?ListView.builder(
              itemCount: snapshot?.data?.docs?.length??0,
              itemBuilder: (context, index) {
                var data = snapshot.data.docs[index];
                String chatRoomId = data.id;
                DateTime time = data["lastMessageTs"].toDate();
                return GestureDetector(
                  onTap: (){
                    fn.pushNavigator(context, ChatScreen(userName: chatRoomId.replaceAll(myUserName, "").replaceAll("_", ""),myUserName: myUserName,));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: UserTile(myUserName: myUserName,chatRoom: chatRoomId,chatsdata: data,time: time, forChat: false,),
                  ),
                );
              },
            ):Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),);
          },
        ),
      ),
    );
  }
}

