import 'dart:io';

import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/screen/home.dart';
import 'package:chat_app/screen/people.dart';
import 'package:chat_app/screen/profile_screen.dart';
import 'package:chat_app/screen/search.dart';
import 'package:chat_app/screen/sign_in_screens.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/widgets/connectivity.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screen/friends.dart';
import 'package:chat_app/screen/people.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List groups = [Home(), Friends(), People(), SearchPage()];
  Functions fn = Functions();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List catgories = ['Messages', 'Friends', 'People'];
    return WillPopScope(
      onWillPop: () async => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: Text('Are you sure you want to quit?'),
                  actions: <Widget>[
                    RaisedButton(child: Text('Exit'), onPressed: () => exit(0)),
                    RaisedButton(
                        child: Text('cancel'),
                        onPressed: () => Navigator.of(context).pop(false)),
                  ])),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text(
              "Chats",
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            elevation: 0.0,
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(
                      () {
                        selectedIndex = 3;
                      },
                    );
                    // SharedPreferenceHelper().clearDataFromSharedPref();
                    // AuthMethods().signOut();
                    // fn.pushReplace(context, SignInScreen());
                  }),
              IconButton(icon: Icon(Icons.account_circle), onPressed: (){
                debugPrint("Account Profile Icon Clicked");
                fn.pushNavigator(context, ProfileScreen());
              }),
              IconButton(icon: Icon(Icons.logout, color: Colors.white,), onPressed: (){
                AuthMethods().signOut(context);
              })
            ],
          ),
          body: Connnectivity(
            child: Column(
              children: [
                Container(
                  height: 90,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: catgories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Text(
                              catgories[index],
                              style: TextStyle(
                                fontSize: 24,
                                color: index == selectedIndex
                                    ? Colors.white
                                    : Colors.white60,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                groups[selectedIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
