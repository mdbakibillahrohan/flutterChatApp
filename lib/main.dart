import 'package:chat_app/helper_functions/sharedpref_helper.dart';
import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/screen/home_screen.dart';
import 'package:chat_app/screen/sign_in_screens.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/widgets/functions.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/start_up_screen.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Future getUserData() async {
    String email = await SharedPreferenceHelper().getUserEmail();
    String passWord = await SharedPreferenceHelper().getUserProfilePassword();
    if (email != null && passWord != null) {
      return {"email": email, "password": passWord};
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            //color code #273c75
            //color code FFFEF9EB rgba(39, 60, 117,1.0)
            theme: ThemeData(
              primaryColor: Color.fromRGBO(25, 42, 86, 1.0),
              accentColor: Color(0xFFFEF9EB),
            ),
            debugShowCheckedModeBanner: false,
            title: "Chat",
            home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == false) {
                    return SignInScreen();
                  }
                  String email = snapshot.data["email"];
                  String pasword = snapshot.data["password"];
                  AuthMethods().signInWithEmailandPassword(email, pasword).then(
                      (value) =>
                          Functions().pushReplace(context, HomeScreen()));
                }
                return Material(
                  child: StartUpScreen(),
                );
              },
            ),
          );
        }
        return MaterialApp(home: StartUpScreen());
      },
    );
  }
}
