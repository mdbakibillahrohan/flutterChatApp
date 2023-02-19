import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/screen/home_screen.dart';
import 'package:chat_app/screen/sign_up.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Functions fn = Functions();

  AuthMethods auth = AuthMethods();

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  String email = "";

  String password = "";

  bool isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            color: Theme.of(context).accentColor,
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Chat App",
            //       style: TextStyle(
            //         fontSize: 35,
            //         color: Theme.of(context).primaryColor,
            //         letterSpacing: 1.5,
            //       ),
            //     ),
            //     Text(
            //       "Welcome to Chat App",
            //       style: TextStyle(
            //           fontSize: 25, color: Colors.blueGrey, letterSpacing: 1.2),
            //     ),
            //     SizedBox(
            //       height: 80,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         AuthMethods().signInWithGoogle(context);
            //       },
            //       child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //         decoration: BoxDecoration(
            //           color: Theme.of(context).primaryColor,
            //           borderRadius: BorderRadius.circular(30),
            //         ),
            //         child: Text(
            //           "Sign In with Google",
            //           style: TextStyle(
            //             color: Theme.of(context).accentColor,
            //             fontSize: 20,
            //             letterSpacing: 1.0,
            //           ),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chat App",
                  style: TextStyle(
                      fontSize: 45,
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 1.6),
                ),
                Text(
                  "Welcome to Chat App",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Email Address",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        floatingLabelBehavior: FloatingLabelBehavior.always),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async{
                    setState(() {
                      isSigningIn = true;
                    });
                    bool authValidation = await auth.signInWithEmailandPassword(email, password);
        // .then((value){
                    //   if(value){
                    //     debugPrint("Validated");
                    //     setState(() {
                    //       isSigningIn = false;
                    //     });
                    //   }else{
                    //     debugPrint("non validated");
                    //     setState(() {
                    //       isSigningIn = false;
                    //     });
                    //   }
                    // });
                    if(authValidation){
                      sharedPreferenceHelper.saveUserEmail(email);
                      sharedPreferenceHelper
                          .saveUserName(email.replaceAll("@gmail.com", ""));
                      sharedPreferenceHelper.saveUserPassword(password);
                      return fn.pushReplace(context, HomeScreen());
                    }else{
                      debugPrint("Something Went Wrong");
                      setState(() {
                        isSigningIn = false;
                      });
                    }
                    // if(authValidation){
                    //   sharedPreferenceHelper.saveUserEmail(email);
                    //   sharedPreferenceHelper
                    //       .saveUserName(email.replaceAll("@gmail.com", ""));
                    //   sharedPreferenceHelper.saveUserPassword(password);
                    //   return fn.pushReplace(context, HomeScreen());
                    // }else {
                    //   debugPrint("something Wrong");
                    //   setState(() {
                    //
                    //  });
                    // }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      isSigningIn?"Signing In":"Sign In",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          letterSpacing: 1.2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        fn.pushNavigator(context, SignUpScreen());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
