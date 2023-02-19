import 'package:chat_app/widgets/favourite_contacts.dart';
import 'package:chat_app/widgets/recent_chats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: Column(
          children: [
            // FavouriteContacts(),
            RecentChats(),
          ],
        ),
      ),
    );
  }
}
