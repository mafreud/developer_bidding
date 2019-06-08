

import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/rounded_button.dart';
import 'package:easy_fund/components/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:easy_fund/screens/questions_screen.dart';

//TODO:登録失敗した時にアラートを出す


class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpiner = false;

  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: easyFundMainColor,
        title: Text('新規登録'),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpiner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'メールアドレス'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'パスワード'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RoundedButton(
                    buttonTextColors: Colors.white,
                    buttonText: '登録',
                    buttonColor: easyFundMainColor,
                    buttonPressed: () async {
                      setState(() {
                        showSpiner = true;
                      });
                      try {
                        final newUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, QuestionsScreen.id);
                        }
                        setState(() {
                          showSpiner = false;
                        });
                      } catch (e) {
                        print(e);
                        setState(() {
                          showSpiner = false;
                        });
                      }
                      ;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
