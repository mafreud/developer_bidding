import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/rounded_button.dart';
import 'package:easy_fund/components/reusable_card.dart';

class QuestionsScreen extends StatefulWidget {

  static String id = 'questions_screen';
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('基本情報', style: kBoldTextStyle,),
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
              '姓', style: TextStyle(color: Colors.black),
              textAlign: TextAlign.left,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: ''),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                '名', style: TextStyle(color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: ''),
            ),

            Text("性別"),
            ReusableCard(
              colour: Colors.lightBlueAccent,
              cardChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "男性",
                    textAlign: TextAlign.center,),
              )),
            ReusableCard(
                colour: Colors.lightBlueAccent,
                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "女性",
                    textAlign: TextAlign.center,),
                )),
            RoundedButton(buttonText: "奨学金を見つける", buttonColor: Colors.lightBlueAccent, buttonPressed: (){

            }),
          ],
        ),
      ),
    );
  }
}


