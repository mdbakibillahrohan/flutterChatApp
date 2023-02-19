import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Connnectivity extends StatefulWidget {
  Widget child;

  Connnectivity({this.child});

  @override
  _ConnnectivityState createState() => _ConnnectivityState();
}

class _ConnnectivityState extends State<Connnectivity> {
  offlineCallback() {
    debugPrint("Offline");
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      offlineCallback: offlineCallback,
      offlineBanner: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
        ),
        child: Text("Offline", style: TextStyle(color: Colors.white, fontSize: 18),),
      ),
      builder: (context, isOnline) {
        return widget.child;
      },
    );
  }
}
