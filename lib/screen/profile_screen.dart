import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Card(
              elevation: 4.0,
              child: Container(
                height: 300,
                child: Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 300,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 7,),
                      Text("Seteve Jobs", style: TextStyle(fontSize: 20),),
                      IconButton(icon: Icon(Icons.edit), onPressed: (){})
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Email:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 7,),
                      Text("stevejobs@gmail.com", style: TextStyle(fontSize: 20),),
                      IconButton(icon: Icon(Icons.edit), onPressed: (){})
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Username:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 7,),
                      Text("stevejobs", style: TextStyle(fontSize: 20),),
                      IconButton(icon: Icon(Icons.edit), onPressed: (){
                        debugPrint("User Name Edit Button Clicked");
                      })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
