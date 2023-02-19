import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:flutter/material.dart';

class People extends StatelessWidget {
  String myUserName = "";

  onLaunch() async {
    myUserName = await SharedPreferenceHelper().getUserName();
  }

  @override
  Widget build(BuildContext context) {
    onLaunch();
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: FutureBuilder(
          future: DatabaseMethods().getPeople(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data[index];
                      if (data["username"] != myUserName) {
                        debugPrint("UserName got");
                        return Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              Functions().pushNavigator(
                                  context,
                                  ChatScreen(
                                    userName: data["username"],
                                    myUserName: myUserName,
                                  ));
                            },
                            child: ListTile(
                              leading: Icon(Icons.person, size: 35,),
                              title: Text(data["name"]),),
                          ),
                        );
                      }
                      return SizedBox(height: 0,);
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
