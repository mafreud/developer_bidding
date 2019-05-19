import 'package:flutter/material.dart';
import 'package:easy_fund/screens/chat_screen.dart';
import 'login_screen.dart';
import 'package:easy_fund/screens/chat_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_fund/screens/scholarships_screen.dart';


class HomeScreen extends StatefulWidget {
  static FirebaseUser loggedInUser;
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pageOptions = [ScholarshipsScreen(), ChatListScreen(), LoginScreen()];
  final _auth = FirebaseAuth.instance;


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
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        leading: null,
        title: Text('奨学金リスト'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: _pageOptions[_selectedIndex],
    );
  }
}
