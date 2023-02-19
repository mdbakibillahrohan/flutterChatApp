import 'package:chat_app/screen/home_screen.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  DatabaseMethods db = DatabaseMethods();
  String password = "";
  AuthMethods auth = AuthMethods();
  Functions fn = Functions();

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController _fullNameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passWordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
              color: Theme.of(context).accentColor,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 45,
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1.6),
                      ),
                    ),
                    // Text(
                    //   "Welcome to Chat App",
                    //   style: TextStyle(fontSize: 25),
                    // ),
                    SizedBox(
                      height: 45,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextFormField(
                        controller: _fullNameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter Some Value";
                          }
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: "Full Name",
                            hintText: "Enter your Full Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter Some Text";
                          } else if (!value.contains("@")) {
                            return "Please Enter a valid Email";
                          } else if (!value.contains("@gmail.com")) {
                            return "Please enter a gmail address";
                          }
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: "Email",
                            hintText: "Enter Email Address",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextFormField(
                        controller: _passWordController,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter password";
                          } else if (value.length > 15) {
                            return "Password can't be more than 15 character";
                          } else if (value.length < 6) {
                            return "Password can't be less than 6 character";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: "Password",
                            hintText: "Enter New Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Enter password";
                          }
                          if (!(value == password)) {
                            return "Password doesn't match";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: "Confirm Password",
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            fn.pushNavigator(context, Loading());
                            auth
                                .signUpWithEmailandPassword(
                                    _emailController.text,
                                    _passWordController.text)
                                .then((value) {
                              db.addUserInfoToDB_Email({
                                "name": _fullNameController.text,
                                "email": _emailController.text,
                                "username": _emailController.text
                                    .replaceAll("@gmail.com", "")
                              }).then((value) =>
                                  {fn.pushNavigator(context, HomeScreen())});
                            });
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                letterSpacing: 1.2),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
