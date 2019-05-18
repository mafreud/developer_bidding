import 'package:flutter/material.dart';
import 'package:easy_fund/constants.dart';
import 'package:easy_fund/components/rounded_button.dart';
import 'package:easy_fund/data.dart';
import 'package:easy_fund/components/reusable_card.dart';

class ScholarshipsScreen extends StatefulWidget {

  static String id = 'scholarships_screen';
  @override
  _ScholarshipsScreenState createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 5.0,
        color: Colors.red,
      ),
    );
  }
}