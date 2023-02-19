import 'package:chat_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  String chatRoom, myUserName;
  DateTime time;
  var chatsdata;
  bool forChat;

  UserTile(
      {this.chatRoom,
      this.myUserName,
      this.time,
      this.chatsdata,
      this.forChat});

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  var indeVidualuserInfo;

  doThisOnLaunch() async {
    indeVidualuserInfo = await DatabaseMethods()
        .getProfileInfo(widget.chatRoom, widget.myUserName);
    return indeVidualuserInfo;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
  }

  @override
  Widget build(BuildContext context) {
    doThisOnLaunch();
    return FutureBuilder(
      future: doThisOnLaunch(),
      builder: (context, snapshot) {
        if (widget.forChat) {
          return snapshot.hasData
              ? ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 35,
                  ),
                  title: Text(snapshot.data["name"]),
                  subtitle: Text(widget.chatsdata["lastMessage"]),
                  trailing: Column(
                    children: [
                      Text(
                          "${widget.time.hour > 12 ? widget.time.hour - 12 : widget.time.hour}:${widget.time.minute} ${widget.time.hour > 12 ? "PM" : "AM"}"),
                      // Container(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      //     child: Text(
                      //       "New",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      //   decoration: BoxDecoration(
                      //       color: Colors.red, borderRadius: BorderRadius.circular(30)),
                      // )
                    ],
                  ),
                )
              : ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 35,
                  ),
                  title: Text("Coming"),
                  subtitle: Text("Coming"),
                  trailing: Column(
                    children: [
                      Text("Wait"),
                    ],
                  ),
                );
        } else {
          return snapshot.hasData
              ? ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 35,
                  ),
                  title: Text(snapshot.data["name"]),
                  subtitle: Text("Friend"),
                  trailing: Icon(Icons.people_outline_rounded),
                )
              : ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 35,
                  ),
                  title: Text("Coming"),
                  subtitle: Text("Coming"),
                  trailing: Column(
                    children: [
                      Text("Wait"),
                    ],
                  ),
                );
        }
      },
    );
  }
}
