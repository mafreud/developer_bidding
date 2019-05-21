import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:easy_fund/screens/chat_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_fund/screens/scholarships_screen.dart';
import 'package:easy_fund/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_fund/constants.dart';
import 'questions_screen.dart';

FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageOptions = [
    ScholarshipsScreen(),
    ChatListScreen(),
    QuestionsScreen(),
  ];
  final _auth = FirebaseAuth.instance;

  void initState() {
    super.initState();

    getCurrentUser();
    print("init State home");
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
      print("error発生");
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: 奨学金リスト',
      style: optionStyle,
    ),
    Text(
      'Index 1: インターン紹介',
      style: optionStyle,
    ),
    Text(
      'Index 2: 設定',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kEasyFundLightColor,
//      appBar: AppBar(
//        leading: null,
//        title: Text('奨学金リスト'),
//        backgroundColor: easyFundMainColor,
//      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('奨学金リスト'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('インターン紹介'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('設定'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: _pageOptions[_selectedIndex],
    );
  }
}

class ChatListScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('奨学金リスト'),
        backgroundColor: kEasyFundMainColor,
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
              if (chat.data['studentEmail'] == loggedInUser.email) {
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
                      onCellTapped: () {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }),

                  ChatListCard(
                      cName: 'c-mind',
                      studentId: 'チャット内容',
                      onCellTapped: () {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }),
                  ChatListCard(
                      cName: 'c-mind',
                      studentId: 'チャット内容',
                      onCellTapped: () {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }),
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
