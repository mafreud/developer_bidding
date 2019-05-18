import 'package:flutter/material.dart';
import 'package:easy_fund/screens/welcome_screen.dart';
import 'package:easy_fund/screens/login_screen.dart';
import 'package:easy_fund/screens/registration_screen.dart';
import 'package:easy_fund/screens/chat_screen.dart';
import 'package:easy_fund/screens/questions_screen.dart';
import 'screens/scholarships_screen.dart';

void main() => runApp(EasyFund());

class EasyFund extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: QuestionsScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        QuestionsScreen.id: (context) => QuestionsScreen(),
        ScholarshipsScreen.id:(context)=> ScholarshipsScreen(),

      },
    );
  }
}
