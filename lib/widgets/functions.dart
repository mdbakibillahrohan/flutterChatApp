import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Functions {
  int indexNo = 0;
  void pushNavigator(BuildContext context, Widget pageName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return pageName;
    }));
  }

  void popNavigator(BuildContext context) {
    Navigator.pop(context);

  }

  void pushReplace(BuildContext context, Widget pageWidget){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return pageWidget;
    }));
  }
  void removeAllRoute(BuildContext context, Widget pageWidget){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>pageWidget), (route) => false);
  }
  Widget buildMessage(
    BuildContext context,
    String message,
    bool isMe,
  ) {
    return Container(
      margin: isMe
          ? EdgeInsets.only(left: 100, top: 10, bottom: 10)
          : EdgeInsets.only(right: 100, top: 10, bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )
            : BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
      ),
      child: Text(
        message,
        style: TextStyle(fontSize: 20, color: isMe?Colors.white:Theme.of(context).primaryColor),
      ),
    );
  }


  getChatRoomIdByUsernames(String a, String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }
}
