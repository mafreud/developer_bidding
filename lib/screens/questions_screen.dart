import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/rounded_button.dart';
import 'package:easy_fund/data.dart';
import 'package:easy_fund/components/reusable_card.dart';

class QuestionsScreen extends StatefulWidget {

  static String id = 'questions_screen';
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  double gpa = 3.0;

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

            Text(
              '名', style: TextStyle(color: Colors.black),
              textAlign: TextAlign.left,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: ''),
            ),
            Text(
              'GPA', style: TextStyle(color: Colors.black),
              textAlign: TextAlign.left,
            ),
          SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  inactiveTrackColor: Colors.grey,
                  activeTrackColor: Colors.pinkAccent,
                  thumbColor: Color(0xFFEB1555),
                  overlayColor: Color(0x29EB1555),
                  thumbShape:
                  RoundSliderThumbShape(enabledThumbRadius: 15.0),
                  overlayShape:
                  RoundSliderOverlayShape(overlayRadius: 30.0)),
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
            DropdownButton(items: majors
                    .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
      );
      })
          .toList(), onChanged: (String newValueSelected){
                setState(() {
                  print(newValueSelected);
                });
            }),


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


