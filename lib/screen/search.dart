import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/screen/sign_in_screens.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool rohan = false;
  DatabaseMethods db = DatabaseMethods();
  var searchedData;
  String userName;
  String myUserName = "";

  getUserName()async{
    myUserName = await SharedPreferenceHelper().getUserName();
  }

  @override
  initState(){
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    Functions fn = Functions();
    TextEditingController usernameController = TextEditingController();
    Stream user;
    Future serchedData;


    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Column(
          children: [
            Center(
              child: Row(
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      onChanged: (value){
                        userName = value;
                      },
                      controller: usernameController,
                      decoration: InputDecoration(hintText: "Username"),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        setState(() {
                          searchedData = db.searchByUserName(userName);
                        });
                        // AuthMethods().signOut();
                        // SharedPreferenceHelper().clearDataFromSharedPref();
                        // fn.pushReplace(context, SignInScreen());
                      })
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              height: 300,
              child: FutureBuilder(
                future: searchedData,
                builder: (context, snapshot) {
                  return snapshot.hasData?ListView.builder(
                      itemCount: snapshot?.data?.length ?? 0,
                      itemBuilder: (context, index) {

                        if (snapshot.hasData) {
                          var data = snapshot.data[index];
                          if(data["username"]==myUserName){
                            return Center(child: Text("You can't message yourself", style: TextStyle(fontSize: 20),),);
                          }
                          return GestureDetector(
                            onTap: ()async{
                              String myUserName = await SharedPreferenceHelper().getUserName();
                              fn.pushNavigator(context, ChatScreen(userName: data["username"],myUserName: myUserName,));
                            },
                            child: ListTile(
                              title: Text(data["name"], style: TextStyle(fontSize: 20),),
                            ),
                          );
                        }
                        return Text("");
                      },
                    ):Center(child: CircularProgressIndicator(backgroundColor: Colors.black,));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
