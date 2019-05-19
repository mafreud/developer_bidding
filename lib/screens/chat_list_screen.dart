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
List<ChatData> chatDataList;
String screenNum;

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
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('奨学金リスト'),
            backgroundColor: easyFundMainColor,
          ),
          body: StreamBuilder<QuerySnapshot>(
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
                    print(chat.data['companyName']);
                    companyName = chat.data['companyName'];

//                  chatDataList.add(ChatData(
//                        companyName: chat.data['companyName'],
//                        studentEmail: chat.data['companyName']));

                  }
                  return Column(
                  children: <Widget>[
                    ChatListCard(
                      cName: 'c-mind',
                      studentId: 'チャット内容',
                      onCellTapped: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ChatScreen(screenNum: 'c-mind'),
                        ),
                        );}),

                    ChatListCard(
                        cName: 'スタック&ソリューションズ',
                        studentId: 'チャット内容',
                        onCellTapped: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ChatScreen(screenNum:'スタック&ソリューションズ'),
                          ),
                          );}),
                    ChatListCard(
                        cName: 'Tesla Motors',
                        studentId: 'チャット内容',
                        onCellTapped: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ChatScreen(screenNum:'Tesla Motors'),
                          ),
                          );}),
//                  for (var data in chatDataList){
//                      ChatListCard(cName: data.companyName, studentId: data.studentEmail),
//                Text(companyName)
//                  };
                  ],
                  );
                }
              }),
        );

      }
    } else {
      return ChatListCard();
    }
  }
}

class ChatListCard extends StatelessWidget {

  ChatListCard({this.cName, this.studentId, this.onCellTapped});

  String cName;
  String studentId;
  Function onCellTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCellTapped,
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
                padding:
                const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cName,
                      style: kBoldTextStyle,
                      textAlign: TextAlign.left,
                    ),
                    Text(studentId)
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

void onTap(context) {
//  Navigator.pushNamed(context, ChatScreen.id);
}

getChatId() {
  Firestore.instance
      .collection('userInfo')
      .where('userEmail', isEqualTo: User.email)
      .snapshots()
      .listen((data) => chatIdList = data.documents[0]['chatId']);
  print(chatIdList);
}
