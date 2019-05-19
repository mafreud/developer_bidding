import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_fund/components/chat_data.dart';
import 'package:easy_fund/components/colors.dart';

FirebaseUser User;
final _auth = FirebaseAuth.instance;
String userData;
List<dynamic> chatIdList;
String companyName;

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  CollectionReference collectionChatReference =
      Firestore.instance.collection('userInfo');
  final _auth = FirebaseAuth.instance;

  @override
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        User = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getChatId();
    print(_auth.currentUser());
  }

  @override
  Widget build(BuildContext context) {
    if (chatIdList != null) {
      for (var id in chatIdList) {
        return StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('chatData').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final chats = snapshot.data.documents;
              List<MessageBubble> messageBubbles = [];
              for (var chat in chats) {
                if (chat.data['studentEmail'] == User.email) {
                  ChatData(
                      companyName: chat.data['companyName'],
                      studentEmail: chat.data['companyName']);
                }
                return Column(
//                children: <Widget>[
//                  for (var cName in )
//                ],
                    );
              }
            });
      }
    } else {
      return ChatListCard();
    }
  }
}

class ChatListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('インターン紹介'),
        backgroundColor: easyFundMainColor,
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ChatScreen.id);
        },
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
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '企業名',
                        style: kBoldTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Text('ここにメッセージのテキストが入る')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void onTap(context) {
  Navigator.pushNamed(context, ChatScreen.id);
}

getChatId() {
  Firestore.instance
      .collection('userInfo')
      .where('userEmail', isEqualTo: User.email)
      .snapshots()
      .listen((data) => chatIdList = data.documents[0]['chatId']);
  print(chatIdList);
}
