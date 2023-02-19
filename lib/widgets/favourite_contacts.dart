import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FavouriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favourite Contacts",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1.0),
                ),
                IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () {})
              ],
            ),
          ),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/564x/01/22/18/012218f4d43ade31f4e6146e2178f4be.jpg"),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        "John",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
