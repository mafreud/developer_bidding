import 'package:flutter/material.dart';
import 'package:easy_fund/screens/home.dart';
import 'package:easy_fund/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_fund/components/colors.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = Firestore.instance;
int scholarshipBudged;

class ScholarshipDetail extends StatelessWidget {

  ScholarshipDetail({this.scholarshipName});
  String scholarshipName;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text(scholarshipName),
        backgroundColor: easyFundMainColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('Scholarships').where('name', isEqualTo: scholarshipName).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final scholarships = snapshot.data.documents;
          for (var scholarship in scholarships) {
            scholarshipBudged = scholarship.data['budged'];
//            final scholarshipDeadline = scholarship.data['deadline'];

          }
          return Container(
            child: Column(
              children: <Widget>[
                Text(scholarshipName),
                Text(scholarshipBudged.toString())
              ],
            ),
          );
        },
      ),
    );
  }
}
