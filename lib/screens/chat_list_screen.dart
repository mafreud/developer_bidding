import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/screens/chat_screen.dart';
import 'package:easy_fund/components/scholarship_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListScreen extends StatefulWidget {

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {


  @override
  Widget build(BuildContext context) {
    return
      ListView(
        children: <Widget>[
          ChatListCard(),
          Divider(height: 1.0,color: Colors.grey,),
          ChatListCard(),
          Divider(height: 1.0,color: Colors.grey,),
          ChatListCard(),

        ],
      );
  }
}

class ChatListCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        borderOnForeground: true,
        margin: EdgeInsets.all(0.0),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.email),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('企業名', style: kBoldTextStyle, textAlign: TextAlign.left,),
                    Text('ここにメッセージのテキストが入る')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void onTap(){
//  Navigator(onGenerateRoute: ChatScreen.id);
}