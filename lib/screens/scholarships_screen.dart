import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/scholarship_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_fund/components/colors.dart';
import 'package:easy_fund/data/user_info_data.dart';

final _fireStore = Firestore.instance;

class ScholarshipsScreen extends StatefulWidget {
  @override
  _ScholarshipsScreenState createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen> {

  final _auth = FirebaseAuth.instance;
  UserInfoData userInfo;
  FirebaseUser loggedInUser;
  String userEmail;


  @override
  void initState() {
    super.initState();
    getCurrentUser().then((user){loggedInUser = user;} );
    print('init done');
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      FirebaseUser user;
      user = await _auth.currentUser();
      if (user != null) {
        //CurrentUserを取得
        loggedInUser = user;
        setState(() {
          userEmail = loggedInUser.email;

        });
        print(loggedInUser);
        //CurrentUserを元にUserInfoを取得
        await for (var snapshot in _fireStore.collection('userInfo').where('userEmail', isEqualTo: loggedInUser.email).snapshots()){
          for (var Info in snapshot.documents) {
            print(Info.data);
            setState(() {
              userInfo = UserInfoData(gpa: Info.data['GPA'], major: Info.data['major'], grade: Info.data['grade'], graduationYear: Info.data['icdId']);
              print(userInfo.gpa);
            });
          }
        }
      return user;
      }
    } catch(e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    if (userEmail == null) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,


        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('応募可能な奨学金のリストです',
                  style: kBoldTextStyle,
                  textAlign: TextAlign.center,)),

            StreamBuilder<QuerySnapshot>(
              //ScholarshipsのStremaを取得、まだloggedInUserが取得していない場合全ての奨学金のstreamを取得
              stream: userInfo == null ? _fireStore.collection('Scholarships').snapshots() :_fireStore.collection('Scholarships').where('gpa', isLessThanOrEqualTo: userInfo.gpa).snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData || loggedInUser == null) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        Text(" ")
                      ],
                    ),);
                }
                //streamで取れたデータをScholarshipCardに入力する
                final scholarships = snapshot.data.documents;
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
//                  setState(() {
//                    scholarshipsCount = scholarshipsCards.length;
//                  });
                }
                return Expanded(
                  child: ListView(
                    reverse: false,
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

