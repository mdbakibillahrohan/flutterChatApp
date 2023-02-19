import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  String userName;
  String myUserName;
  ChatScreen({this.userName, this.myUserName});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextController = TextEditingController();
  DatabaseMethods db = DatabaseMethods();
  Functions fn = Functions();
  String chatRoomId = "";
  var ts = DateTime.now();
  String messageText = "";
  Stream messageData;
  bool isMe;
  String name = "";
  doThisOnLaunch() async {
    String myUserName = await SharedPreferenceHelper().getUserName();
    chatRoomId = fn.getChatRoomIdByUsernames(widget.userName, myUserName);
    messageData = await DatabaseMethods().fetchMessage(chatRoomId);
    name = await DatabaseMethods().namebyUserName(widget.userName);
    DatabaseMethods().createChatRoom(
        chatRoomId: chatRoomId,
        myUserName: myUserName,
        sendUserName: widget.userName,
        chatRoomInfoMap: {
          "user1": myUserName,
          "user2": widget.userName,
          "users":[myUserName, widget.userName],
          "sendBy": myUserName,
          "lastMessageTs": ts,
          "lastMessage": ""
        });
    setState(() {

    });
  }

  void initState(){
    super.initState();
    doThisOnLaunch();
    getMessageStream();
  }

  getMessageStream()async{
    chatRoomId = fn.getChatRoomIdByUsernames(widget.userName, widget.myUserName);
    messageData = await DatabaseMethods().fetchMessage(chatRoomId);
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                fn.popNavigator(context);
              }),
          elevation: 0.0,
          title: Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          actions: [IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: StreamBuilder(
                    stream: messageData,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          reverse: true,
                          itemCount: snapshot?.data?.docs.length??0,
                          itemBuilder: (context, index) {
                            var singleMessage = snapshot.data.docs[index];
                            if(singleMessage["sendBy"]==widget.myUserName){
                              isMe = true;
                            }else{
                              isMe = false;
                            }
                            return fn.buildMessage(
                                context,
                                singleMessage["message"],
                                isMe);
                          },
                        );
                      }else{
                        return Center(child: Text("You have no Messages"),);
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Messages",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        setState(() {});
                        DatabaseMethods().sendMessage(
                            senduserName: widget.userName,
                            chatRoomId: chatRoomId,
                            messageText: messageTextController.text,
                            time: DateTime.now(),
                            myUserName:
                                await SharedPreferenceHelper().getUserName(),
                            messageInfo: {
                              "message": messageTextController.text,
                              "ts": DateTime.now(),
                              "sendBy":
                                  await SharedPreferenceHelper().getUserName()
                            });
                        messageTextController.text = "";
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
