import 'package:flutter/material.dart';

class StartUpScreen extends StatefulWidget {
  @override
  _StartUpScreenState createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  bool isFinished = false;


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 500,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: CircleAvatar(
                maxRadius: 170,
                minRadius: 100,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 250),
              child: Text(
                "Developed by Rohan",
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
