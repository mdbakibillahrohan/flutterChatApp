import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/screen/home_screen.dart';
import 'package:chat_app/screen/sign_in_screens.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future signUpWithEmailandPassword(String email, String password)async{
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    // User user =  auth.currentUser;
    // AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    // user.reauthenticateWithCredential(credential);
  }
  Future<bool> signInWithEmailandPassword(String email, String password)async{
    bool isValidated = false;
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
        isValidated = true;
      });
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        debugPrint("user not found");
        isValidated = false;
      }else if(e.code=="wrong-password"){
        isValidated = false;
        debugPrint("wrong password");
      }else{
        debugPrint("Succesful");
      }
    }
    return isValidated;
  }
  Future<User> getCurrentUser() async{
    return await auth.currentUser;
  }
  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount =
    await _googleSignIn.signIn();
    final GoogleSignInAuthentication gooogleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: gooogleSignInAuthentication.idToken,
        accessToken: gooogleSignInAuthentication.accessToken);
    UserCredential result =
    await _firebaseAuth.signInWithCredential(credential);
    User userDetails = result.user;

    if(result!=null){
      SharedPreferenceHelper().saveUserEmail(userDetails.email);
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper().saveUserDisplayName(userDetails.displayName);
      SharedPreferenceHelper().saveUserProfile(userDetails.photoURL);
      Map<String, dynamic> usersInfo = {
        "email":userDetails.email,
        "username":userDetails.email.replaceAll("@gmail.com", ""),
        "name": userDetails.displayName,
        "imageUrl":userDetails.photoURL,
      };
      DatabaseMethods().addUserInfoToDB(userDetails.uid, usersInfo).then((value){
        Functions().pushReplace(context, HomeScreen());
      });
    }
  }
  signOut(BuildContext context){
    auth.signOut();
    SharedPreferenceHelper().clearDataFromSharedPref();
    Functions().removeAllRoute(context, SignInScreen());
  }
}