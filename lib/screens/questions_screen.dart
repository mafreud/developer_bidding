import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/rounded_button.dart';
import 'package:easy_fund/data.dart';
import 'package:easy_fund/components/reusable_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_fund/screens/home.dart';


final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

enum Gender { Male, Female }

class QuestionsScreen extends StatefulWidget {
  static String id = 'questions_screen';
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  final _auth = FirebaseAuth.instance;
  double gpa = 3.0;
  int icuId;
  String major;
  String firstName;
  String lastName;
  Gender gender;
  Color genderButtonColor;

  @override
  void initState() {
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          '基本情報',
          style: kBoldTextStyle,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '姓',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.left,
            ),

            TextField(
              onChanged: (value) {
                //Do something with the user input.
                setState(() {
                  lastName = value;
                });
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Last Name'),
            ),

            SizedBox(
              height: 13.0,
            ),

            Text(
              '名',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.left,
            ),

            TextField(
              onChanged: (value) {
                //Do something with the user input.
                setState(() {
                  firstName = value;
                });
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'First Name'),
            ),

            Text(
              'GPA: $gpa',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.left,
            ),

            SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: Colors.grey,
                    activeTrackColor: Colors.pinkAccent,
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0)),
                child: Slider(
                    value: gpa,
                    min: 2.0,
                    max: 4.0,
                    onChanged: (double newValue) {
                      setState(() {
                        gpa = newValue;
                        print(gpa);
                      });
                    })),

            Text("専攻"),
            DropdownButton<String>(
                value: major,
                onChanged: (String newValueSelected) {
                  setState(() {
                    major = newValueSelected;
                    print(newValueSelected);
                  });
                },
                items: majors.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            ),
            Text("卒業年度"),
            DropdownButton(
                value:icuId,
                items: icuIds.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int newValueSelected) {
                  setState(() {
                    icuId = newValueSelected;
                  });
                }),
            Text("性別"),
            ReusableCard(
                onpress: () {
                  setState(() {
                    gender = Gender.Male;
                  });
                },
                colour: gender == Gender.Male ? Colors.red : Colors.grey,

                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "男性",
                    textAlign: TextAlign.center,
                  ),
                )),
            ReusableCard(
                onpress: () {
                  setState(() {
                    gender = Gender.Female;
                  });
                },
                colour: gender == Gender.Female ? Colors.red : Colors.grey,
                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "女性",
                    textAlign: TextAlign.center,
                  ),
                )),
            RoundedButton(
                buttonText: "奨学金を見つける",
                buttonColor: Colors.lightBlueAccent,
                buttonPressed: () {
                  _neverSatisfied(context);
                  try {
                    _fireStore.collection('userInfo').add({
                      'gender': gender.toString(),
                      'userEmail': loggedInUser.email,
                      'icuId': icuId,
                      'major': major,
                      'GPA': gpa,
                      'firstName': firstName,
                      'lastName': lastName
                    });
                    if (gender == null ||
                        icuId == null ||
                        major == null ||
                        gpa == null || firstName == null || loggedInUser.email == null) {
                      _neverSatisfied(context);
                      print(major);
                    } else {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
Future<void> _neverSatisfied(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('入力されていない項目があります'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('閉じる'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
