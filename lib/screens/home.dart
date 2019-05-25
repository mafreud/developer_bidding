import 'package:flutter/material.dart';
import 'package:easy_fund/screens/chat_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_fund/components/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/scholarship_card.dart';
import 'questions_screen.dart';
import 'package:easy_fund/data/user_info_data.dart';

FirebaseUser loggedInUser;
final _auth = FirebaseAuth.instance;
final _fireStore = Firestore.instance;
String chatCompanyName;
String chatPassId;
var userData;
UserInfoData userInfo;

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

  void initState() {
    super.initState();

    getCurrentUser();
    print("init State home");
    getChats();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);

        var documents = await Firestore.instance.collection('userInfo')
            .where('userEmail', isEqualTo: loggedInUser.email).getDocuments().then((QuerySnapshot docs){
            userData = docs.documents[0];
            UserInfoData(gpa: userData['GPA'], name: userData['firstName'], email:userData['userEmail'],
                major: userData['major'], gender: userData['gender'],graduationYear: userData['icuId'],
                chatIds: userData['chatId'], grade: userData['grade']);
        });
      }
    } catch (e) {
      print(e);
      print("error発生");
    }
  }


  void getChats() async {
    final chat = await _fireStore.collection('chatData').getDocuments();
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
    if (loggedInUser == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
    }

    return Scaffold(
      backgroundColor: easyFundLightColor,
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



  @override
  Widget build(BuildContext context) {
    if (loggedInUser == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('奨学金リスト'),
          backgroundColor: easyFundMainColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection('chatData').where(
                'studentEmail', isEqualTo: loggedInUser.email).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final chats = snapshot.data.documents;
              List<ChatListCard> chatsData = [];

              for (var chat in chats) {
                final companyName = chat.data['companyName'];
                final chatId = chat.documentID;
                final studentEmail = chat.data['studentEmail'];
                final chatData = ChatListCard(
                  companyName: companyName,
                  chatId: chatId,
                  studentEmail: studentEmail,
                );
                chatsData.add(chatData);
              }
              return ListView(
                children: chatsData,
              );
            })
    );
  }
}


class ChatListCard extends StatelessWidget {

  ChatListCard({this.companyName, this.studentEmail, this.chatId});

  String chatId;
  String companyName;
  String studentEmail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        chatCompanyName = this.companyName;
        chatPassId = this.chatId;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
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
                padding:
                const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      companyName,
                      style: kBoldTextStyle,
                      textAlign: TextAlign.left,
                    ),
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



class ChatScreen extends StatefulWidget {

  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
//ChatScreen -> ChatScreenState

  final messageTextController = TextEditingController();
  String messageText;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
      print("error発生");
    }
  }


  void messageStream() async {
    await for (var snapshot in _fireStore.collection('message').snapshots()) {
      snapshot.documents;
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text(chatCompanyName),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(chatCompanyName),
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      //Implement send functionality.
                      _fireStore.collection('message').add(
                          {'text': messageText, 'sender': loggedInUser.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('message').where(
          'sender', isEqualTo: loggedInUser.email).where(
          'reciever', isEqualTo: chatCompanyName).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final currentUser = loggedInUser.email;
          final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender);

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}


class MessageBubble extends StatelessWidget {

  MessageBubble({this.sender, this.text, this.isMe, this.bubbleColor});

  String sender;
  String text;
  bool isMe;
  Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment
            .start,
        children: <Widget>[
          Material(
            borderRadius: isMe ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)) :
            BorderRadius.only(topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.lightGreenAccent,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '$text',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0
                ),),
            ),
          ),
        ],
      ),
    );
  }
}


class ScholarshipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (loggedInUser.email == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(loggedInUser.email),
          backgroundColor: easyFundMainColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('応募可能な奨学金が５件見つかりました。',
                  style: kBoldTextStyle,
                  textAlign: TextAlign.center,)),


            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('Scholarships').where('gpa', isGreaterThanOrEqualTo: userInfo.gpa).where('graduationYear',arrayContains: userInfo.graduationYear)
                  .where('majors',arrayContains: userInfo.major).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),);
                }
                final scholarships = snapshot.data.documents.reversed;
                List<ScholarshipCard> scholarshipsCards = [];
                for (var scholarship in scholarships ) {
                  final scholarshipName = scholarship.data['name'];
                  final scholarshipDeadline = scholarship.data['deadline'];
                  final scholarshipBudged = scholarship.data['budged'];
                  final scholarshipCard = ScholarshipCard(
                    scholarshipName: scholarshipName,
                    budged: scholarshipBudged,
                    );

                  scholarshipsCards.add(scholarshipCard);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: scholarshipsCards,
                  ),
                );
              },
            ),
          ],
        )
    );
  }
}

